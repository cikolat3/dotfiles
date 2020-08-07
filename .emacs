(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(buffers-menu-show-status t)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "1fbd63256477789327fe429bd318fb90a8a42e5f2756dd1a94805fc810ae1b62" default)))
 '(display-line-numbers t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(neo-theme (quote nerd))
 '(package-selected-packages
   (quote
    (ascii-table neotree spacemacs-theme flycheck iedit auto-complete-c-headers yasnippet-snippets yasnippet auto-complete undo-tree)))
 '(ps-font-size (quote (7 . 8.5)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; flycheck hooks
(add-hook 'after-init-hook #'global-flycheck-mode)

;;fix iedit
(define-key global-map (kbd "C-;") 'iedit-mode)

;;some undo-tree things
(require 'undo-tree)
(global-undo-tree-mode)

;;add nerdtree and toggle
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)


; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete() 
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode 
(global-ede-mode 1)
