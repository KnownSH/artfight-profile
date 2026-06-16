// @ts-check
import { defineConfig } from 'astro/config';
import gleam from "vite-gleam";

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [gleam()]
  },
  server: {
    port: 3456
  }
});
