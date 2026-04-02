import { createHighlighter, type Highlighter } from "shiki";

let instance: Highlighter | null = null;

export async function getHighlighter(): Promise<Highlighter> {
  if (!instance) {
    instance = await createHighlighter({
      themes: ["github-dark"],
      langs: ["lean4"],
    });
  }
  return instance;
}
