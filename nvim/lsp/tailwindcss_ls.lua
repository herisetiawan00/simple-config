return {
	cmd = { 'tailwindcss-language-server', '--stdio' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
	},
	root_markers = {
		'tailwind.config.js',
		'tsconfig.json',
		'jsconfig.json',
		'package.json',
		'.git'
	},
	single_file_support = true,
}
