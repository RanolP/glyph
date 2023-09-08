import * as penxle from '@penxle/pulumi/components';

const site = new penxle.Site('help.penxle.com', {
  name: 'help-penxle-com',

  dns: {
    name: 'help.penxle.com',
    zone: 'penxle.com',
  },
});

export const SITE_DOMAIN = site.siteDomain;
