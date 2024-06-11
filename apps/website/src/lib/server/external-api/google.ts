import { GoogleAuth, OAuth2Client } from 'google-auth-library';
import { google } from 'googleapis';
import { building } from '$app/environment';
import { env } from '$env/dynamic/private';
import type { RequestEvent } from '@sveltejs/kit';
import type { ExternalUser } from './types';

const androidPublisher = google.androidpublisher({
  version: 'v3',
  auth: new GoogleAuth({
    credentials: building ? undefined : JSON.parse(env.PRIVATE_GOOGLE_SERVICE_ACCOUNT),
    scopes: ['https://www.googleapis.com/auth/androidpublisher'],
  }),
});

const createOAuthClient = (event: RequestEvent) => {
  return new OAuth2Client({
    clientId: env.PRIVATE_GOOGLE_CLIENT_ID,
    clientSecret: env.PRIVATE_GOOGLE_CLIENT_SECRET,
    redirectUri: `${event.url.origin}/api/sso/google`,
  });
};

export const generateAuthorizationUrl = (event: RequestEvent, type: string) => {
  const client = createOAuthClient(event);
  return client.generateAuthUrl({
    scope: ['email', 'profile'],
    state: Buffer.from(JSON.stringify({ type })).toString('base64'),
  });
};

export const authorizeUser = async (event: RequestEvent, code: string): Promise<ExternalUser> => {
  const client = createOAuthClient(event);

  const { tokens } = await client.getToken({ code });
  if (!tokens.access_token) {
    throw new Error('Token validation failed');
  }

  const { aud } = await client.getTokenInfo(tokens.access_token);
  if (aud !== env.PRIVATE_GOOGLE_CLIENT_ID) {
    throw new Error('Token validation failed');
  }

  client.setCredentials(tokens);

  type R = { sub: string; email: string; name: string; picture: string };
  const userinfo = await client.request<R>({
    url: 'https://www.googleapis.com/oauth2/v3/userinfo',
  });

  return {
    provider: 'GOOGLE',
    id: userinfo.data.sub,
    email: userinfo.data.email,
    name: userinfo.data.name,
    avatarUrl: userinfo.data.picture,
  };
};

type GetInAppPurchaseParams = { productId: string; token: string };
export const getInAppPurchase = async ({ productId, token }: GetInAppPurchaseParams) => {
  const resp = await androidPublisher.purchases.products.get({
    packageName: 'com.withglyph.app',
    productId,
    token,
  });

  return resp.data;
};
