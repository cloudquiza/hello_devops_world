// playwright.config.js
import { defineConfig } from "@playwright/test";

export default defineConfig({
  // The directory where your tests are located
  testDir: "./tests",

  // Maximum time one test can run for
  timeout: 30 * 1000, // 30 seconds

  // Retry on CI only
  retries: process.env.CI ? 2 : 0,

  // Reporter to use
  reporter: process.env.CI ? "github" : "list",

  // Use a prepared base URL for tests
  use: {
    baseURL: "http://localhost:8000", // Set this to your local server or deployed service
    headless: true, // Run tests in headless mode
    browserName: "chromium", // Choose between 'chromium', 'firefox', 'webkit'

    // Options for all the browsers
    launchOptions: {
      slowMo: 50, // Slows down Playwright operations by 50ms
    },
  },

  // Configurations for the browsers
  projects: [
    {
      name: "Chromium",
      use: { browserName: "chromium" },
    },
    {
      name: "Firefox",
      use: { browserName: "firefox" },
    },
    {
      name: "Webkit",
      use: { browserName: "webkit" },
    },
  ],
});
