;; no start up screens
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)


;; default split behavior, show more lines
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; install packages (esp magit)
(require 'package)
(add-to-list 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Evil mode as defuault
(require 'evil)
(evil-mode 1)

;; Treat wrapped line scrolling as single lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; only one instance of custom-set-variables please
;; sourced from <https://github.com/riceissa/dotfiles>
(custom-set-variables

 ;; font size
 '(set-default-font -*-*-medium-*-*-*-14-*-*-*-*-*-*-*)
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

 ;; no back ups 
 '(make-backup-files nil)
 ;; go to the most recent file under vc 
 '(vc-follow-symlinks t)

 ;; magit (for git)
 '(package-selected-packages (quote (magit)))
 '(magit-diff-refine-hink (quote all))

 ;; wrap lines in org mode 
 '(org-startup-truncated nil)
 ;; time stamp
 '(org-log-done (quote time))
 ;; where's the agenda?
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-default-notes-file (quote ("~/todo.org")))
 '(org-agenda-custom-commands
    (quote
     (("c" "Simple agenda view"
       ((agenda "")
        (alltodo ""))))))
 '(org-agenda-start-on-weekday nil)
 ;; adding items
 '(org-capture-templates
   (quote
    (("t" "TODO item" entry
      (file+headline "~/todo.org" "unsorted tasks")
      "* TODO %?
  %i"))))
 ;; cycling options
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "DONE(d)"))))
)

;; archive file
(setq org-archive-location "~/archive.org::")

;; org key maps
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(eval-after-load 'org-agenda
 '(progn
    (define-key org-agenda-mode-map "j" 'org-agenda-next-line)
    (define-key org-agenda-mode-map "k" 'org-agenda-previous-line
)))

;; magit commands
(when (fboundp 'magit-status)
  (global-set-key (kbd "C-x g") 'magit-status))

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
