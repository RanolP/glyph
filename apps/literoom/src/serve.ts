import {
  GetObjectCommand,
  S3Client,
  WriteGetObjectResponseCommand,
} from '@aws-sdk/client-s3';
import { SIZES } from './const';

type Event = {
  getObjectContext: {
    inputS3Url: string;
    outputRoute: string;
    outputToken: string;
  };
  userRequest: {
    url: string;
  };
};

const S3 = new S3Client();

export const handler = async (event: Event) => {
  const url = new URL(event.userRequest.url);

  const key = url.pathname.slice(1);
  const size = Number(url.searchParams.get('s'));

  if (!SIZES.includes(size)) {
    await S3.send(
      new WriteGetObjectResponseCommand({
        RequestRoute: event.getObjectContext.outputRoute,
        RequestToken: event.getObjectContext.outputToken,
        StatusCode: 400,
        ErrorCode: 'InvalidRequest',
      }),
    );

    return { statusCode: 400 };
  }

  let object;

  try {
    object = await S3.send(
      new GetObjectCommand({
        Bucket: 'penxle-data',
        Key: `shrink/${key}/${size}.avif`,
      }),
    );

    await S3.send(
      new WriteGetObjectResponseCommand({
        RequestRoute: event.getObjectContext.outputRoute,
        RequestToken: event.getObjectContext.outputToken,
        Body: object.Body,
        CacheControl: 'public, max-age=31536000, immutable',
      }),
    );

    return { statusCode: 200 };
  } catch {
    try {
      object = await S3.send(
        new GetObjectCommand({
          Bucket: 'penxle-data',
          Key: key,
        }),
      );

      await S3.send(
        new WriteGetObjectResponseCommand({
          RequestRoute: event.getObjectContext.outputRoute,
          RequestToken: event.getObjectContext.outputToken,
          Body: object.Body,
          CacheControl: 'public, max-age=0, must-revalidate',
        }),
      );

      return { statusCode: 200 };
    } catch (err) {
      await S3.send(
        new WriteGetObjectResponseCommand({
          RequestRoute: event.getObjectContext.outputRoute,
          RequestToken: event.getObjectContext.outputToken,
          StatusCode: 500,
          ErrorCode: 'RequestFailed',
          ErrorMessage: `Request failed with '${err}'`,
        }),
      );

      return { statusCode: 500 };
    }
  }
};
