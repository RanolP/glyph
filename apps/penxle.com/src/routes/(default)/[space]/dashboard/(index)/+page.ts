import type { PageLoadEvent } from './$types';

export const _SpaceDashboardPage_QueryVariables = (event: PageLoadEvent) => {
  return { slug: event.params.space };
};
