;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Enable transient mark mode
(transient-mark-mode 1)

;; org mode time stamps
(setq org-log-done t)
(custom-set-variables '(org-log-done (quote time)))
(custom-set-faces)

;; I like Emacs to take up about half of the screen, but this depends
;; on the screen in use so might need to be adjusted depending on the
;; computer.
(setq initial-frame-alist
          '((width . 84) (height . 40)))

;; For installing packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Override some colors that the MATE theme sets
(set-face-attribute 'region nil :background "#eeeeee")
(set-face-attribute 'default nil
                    :height 110
                    :background "#ffffff"
                    :foreground "#333333")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(magit-diff-refine-hunk (quote all))
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-capture-templates
   (quote
    (("t" "TODO item" entry
      (file+headline "~/org/todo.org" "Tasks")
      "* TODO %?
  %i"))))
 '(org-startup-truncated nil)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "DONE(d)"))))
 '(package-selected-packages (quote (intero magit)))
 '(require-final-newline t)
 '(save-interprogram-paste-before-kill t)
 '(scroll-conservatively 1000)
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t))

(setq org-default-notes-file "~/org/todo.org")
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(defun stage-and-commit-snapshot ()
  "Use Git to stage and commit the current file"
  (interactive)
  (shell-command
    (concat "git add "
            buffer-file-name
            "&& git commit -m 'snapshot'")))

(when (fboundp 'magit-diff-buffer-file)
  ;; This is like ":Git diff %" in fugitive.vim
  (global-set-key (kbd "C-x C-d")
                  '(lambda () (interactive)
                     (magit-diff-buffer-file)
                     (setq truncate-lines nil)
                     (diff-refine-hunk)
                     (delete-other-windows))))

(when (fboundp 'magit-stage-file)
  ;; This is like ":Gwrite | Gcommit" in fugitive.vim
  (global-set-key (kbd "C-x s")
                  '(lambda () (interactive)
                     (magit-stage-file buffer-file-name)
                     (magit-commit))))

