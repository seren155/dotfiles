-- ========================================================================== --
--                           CONFIGURACIÓN BÁSICA                             --
-- ========================================================================== --

local opt = vim.opt

-- Apariencia y UI
opt.number = true           -- Números de línea
opt.relativenumber = true   -- Números relativos
opt.mouse = 'a'             -- Habilitar ratón
opt.termguicolors = true    -- Colores reales
opt.cursorline = true       -- Resaltar línea actual
opt.signcolumn = "yes"      -- Columna lateral para avisos

-- Portapapeles (Sincronización con el sistema)
opt.clipboard = "unnamedplus"

-- Comportamiento de edición
opt.expandtab = true        -- Tabs a espacios
opt.shiftwidth = 4          -- Indentación de 4 espacios
opt.tabstop = 4             -- Tamaño de un tab
opt.smartindent = true      -- Indentación inteligente
opt.ignorecase = true       -- Ignorar mayúsculas al buscar
opt.smartcase = true        -- Sensible si usas mayúsculas en la búsqueda

-- Gestión de archivos y Undo
opt.undofile = true         -- Guardar historial de deshacer en disco
opt.backup = false          -- No crear backups temporales

-- ========================================================================== --
--                         FUNCIONES DE "IDE" NATIVAS                         --
-- ========================================================================== --

-- 1. Explorador de archivos (Netrw)
vim.g.netrw_banner = 0       -- Sin banner de ayuda
vim.g.netrw_liststyle = 3    -- Vista de árbol
vim.g.netrw_winsize = 25     -- Ancho lateral

-- 2. Autocompletado nativo
opt.completeopt = {'menuone', 'noselect', 'noinsert'}

-- 3. Recordar la última posición del cursor
-- Esta función hace que al abrir un archivo vuelvas a donde estabas.
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ========================================================================== --
--                                ATAJOS (MAPS)                               --
-- ========================================================================== --

local keymap = vim.keymap.set
vim.g.mapleader = " " -- Tecla Espacio como líder

keymap('n', '<leader>w', ':w<CR>') -- Espacio + w: Guardar

-- Espacio + q para cerrar (equivale a :q)
keymap('n', '<leader>q', ':q<CR>', { desc = 'Salir de la ventana' })

-- Abrir explorador de archivos lateral
keymap("n", "<leader>e", ":Lexplore<CR>", { desc = "Explorador" })

-- Navegación rápida entre ventanas (Splits)
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Gestión de Buffers (Archivos abiertos)
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "Siguiente archivo" })
keymap("n", "<leader>bp", ":bprev<CR>", { desc = "Archivo anterior" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Cerrar archivo" })

-- Terminal integrada
keymap('t', '<Esc>', [[<C-\><C-n>]]) -- Salir de modo terminal con Esc
