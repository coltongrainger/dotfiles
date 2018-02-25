;; no start up screens
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; screen size
(setq initial-frame-alist
          '((width . 80) (height . 24)))

;; install packages (esp magit)
(require 'package)
(add-to-list 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; only one instance of custom-set-variables please
;; sourced from <https://github.com/riceissa/dotfiles>
(custom-set-variables

 ;; matching parens
 '(show-paren-mode t)
 ;; hide clickable toolbar
 '(tool-bar-mode nil)
 ;; moving around
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
 '(scroll-conservatively 1000)
 ;; prevent extraneous tabs
 '(indent-tabs-mode nil)
 ;; add newline to files before saving
 '(require-final-newline t)
 ;; keep clipboard when copying from outside
 '(save-interprogram-paste-before-kill t)
 ;; don't double space
 '(sentence-end-double-space nil)

 ;; magit (for git)
 '(package-selected-packages (quote (magit)))
 '(magit-diff-refine-hink (quote all))
 ;; no back ups 
 '(make-backup-files nil)
 ;; go to the most recent file under vc 
 '(vc-follow-symlinks t)

 ;; wrap lines in org mode 
 '(org-startup-truncated nil)
 ;; time stamp
 '(org-log-done (quote time))
 ;; where's the agenda?
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-default-notes-file (quote ("~/todo.org")))
 ;; adding items
 '(org-capture-templates
   (quote
    (("t" "TODO item" entry
      (file+headline "~/todo.org" "Tasks")
      "* TODO %?
  %i"))))
 ;; cycling options
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "DONE(d)"))))
)

;; org key maps
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; git interactions
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
