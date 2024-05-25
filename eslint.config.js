const eslintPlugin = require('@typescript-eslint/eslint-plugin');

module.exports = [
  {
    files: ["src/**/*.ts", "src/main.cts", "src/main.mts"],
    ignores: ["**/*.d.*", "**/*.map.*", "**/*.js", "**/*.mjs", "**/*.cjs"],
    plugins: { eslintPlugin },
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      parser: "eslintPlugin/parser",
    },
    rules: {
      semi: "error",
      quotes: ["error", "single"],
      indent: [
        "error",
        2,
        {
          SwitchCase: 1,
          VariableDeclarator: "first",
          ImportDeclaration: "first",
          ArrayExpression: "first",
          ObjectExpression: "first",
          CallExpression: { arguments: "first" },
          FunctionDeclaration: { body: 1, parameters: 4 },
          FunctionExpression: { body: 1, parameters: 4 },
        },
      ],
    },
  },
];
