import type { Config } from "tailwindcss";
import typography from "@tailwindcss/typography";

export default {
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    extend: {
      fontFamily: {
        mono: [
          "SourceCodePro",
          "SF Mono",
          "Monaco",
          "Andale Mono",
          "monospace",
        ],
      },
      maxWidth: {
        content: "800px",
        container: "1200px",
      },
      colors: {
        bg: "var(--color-bg)",
        "bg-secondary": "var(--color-bg-secondary)",
        accent: "var(--color-accent)",
        text: "var(--color-text)",
        "text-muted": "var(--color-text-muted)",
        border: "var(--color-border)",
        icon: "var(--color-icon)",
        "icon-hover": "var(--color-icon-hover)",
      },
    },
  },
  plugins: [typography],
} satisfies Config;
