/** @type { import("tailwindcss").Config } */

module.exports = {
    content: ["./**/*.{html, js}"],
    theme: {
        extend: {
            colors: {
                primary: "var(--primary-color)",
                secondary: "var(--secondary-color)",
            },
            fontFamily: {
                body: ["SourceCodePro-VariableFont"],
            },
        },
    },
    plugins: [],
}
