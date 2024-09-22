// tests/test.spec.js

const { test, expect } = require("@playwright/test");

test("Portfolio page should load and display the correct title", async ({
  page,
}) => {
  // Go to your portfolio page
  await page.goto("http://localhost:8000"); // Replace with your local server address

  // Check if the title is correct
  await expect(page).toHaveTitle(/Front End Testing/);

  // Check if the GitHub link is present
  const githubLink = await page.locator(
    'a[href="https://github.com/cloudquiza/hello_devops_world"]'
  );
  await expect(githubLink).toBeVisible();
});

test("Clicking on GitHub link should navigate to GitHub profile", async ({
  page,
}) => {
  await page.goto("http://localhost:8000");

  const githubLink = await page.locator(
    'a[href="https://github.com/cloudquiza/hello_devops_world"]'
  );
  await githubLink.click();

  // Check if the page URL is correct after clicking
  await expect(page).toHaveURL(
    "https://github.com/cloudquiza/hello_devops_world"
  );
});
