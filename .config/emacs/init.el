;;; Code:
(require 'package) ; activate packages
(package-initialize) ; activate all the packages (in particular autoloads)
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; --- configure user-package - end -------------------------------------------------------


;; === configure general emacs variables - start ==========================================

; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq
 visible-bell t ; Visible signal (instead of sound) for non allow operations.
 use-dialog-box nil) ; Don't pop up UI dialogs when prompting.
;; --- configure general emacs variables - end --------------------------------------------


;; === configure ninor modes - start ======================================================
;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(hl-line-mode 1)
(blink-cursor-mode 1)
(recentf-mode 1)
;; --- configure minor modes - end --------------------------------------------------------


;; === configure emacs theme - start ======================================================
(setq modus-themes-mode-line '(accented borderless))
(load-theme 'modus-vivendi t)
;; --- Configure emacs theme - end --------------------------------------------------------

;; === configure which-key theme - start ==================================================
(use-package which-key
  :ensure t
  :config
  (which-key-mode))
;; --- configure which-key theme - end ----------------------------------------------------

(use-package lsp-mode
  :ensure t
  :bind(:map lsp-mode-map
	     ("C-c d" . lsp-describe-thing-at-point)
	     ("C-c a" . lsp-executepcode-action)
	     ("C-c l" . lsp-command-map))
  :config
  (lsp-enable-which-key-integration t))

(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (setq-local company-backends '(company-elisp))))
	 (emacs-lisp-mode . company-mode))
  :config
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

;; === configure lsp for golang - start ===================================================
;; It requires installed golang installed and next dependencies:
;;   $ go install golang.org/x/tools/gopls@latest
;;   $ go install golang.org/x/tools/cmd/goimports@latest
;;; Go
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>"  . gofmt))
  :config
  (require 'lsp-go)
  (setq lsp-go-analyses ;; for more details visit: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
	'((fieldalignment . t)
	  (nilness        . t)
	  (unusedwrite    . t)
	  (unusedparams   . t)))
  ;; GOPATH/bin
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimports"))
;; --- configure lsp for golang - end -----------------------------------------------------

(provide 'init)
;;; init.el ends here
