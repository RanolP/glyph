import { svg, unocss } from '@penxle/vite';
import { sveltekit } from '@sveltejs/kit/vite';
import browserslist from 'browserslist';
import { browserslistToTargets } from 'lightningcss';
import { defineConfig } from 'vite';

// eslint-disable-next-line import/no-default-export
export default defineConfig({
  build: {
    cssMinify: 'lightningcss',
  },
  css: {
    transformer: 'lightningcss',
    lightningcss: {
      drafts: { nesting: true },
      targets: browserslistToTargets(
        browserslist('> 0.25%, last 2 versions, not dead'),
      ),
    },
  },
  plugins: [svg(), unocss(), sveltekit()],
  server: {
    host: '127.0.0.1',
    port: 4020,
    strictPort: true,
  },
});
