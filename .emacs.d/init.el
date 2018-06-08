;; see also <https://github.com/riceissa/dotfiles>
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

;; evil mode as defuault
(require 'evil)
(evil-mode 1)

;; treat wrapped line scrolling as single lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

;; only one instance of custom-set-variables please
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(magit-diff-refine-hink (quote all))
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
 '(org-agenda-custom-commands
   '(("c" "agenda/todo"
      ((tags "PRIORITY=\"A\""
        ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
         (org-agenda-overriding-header "High-priority unfinished tasks:")))
       (agenda "" ((org-agenda-span 3)))
       (alltodo ""
        ((org-agenda-skip-function
          '(or (air-org-skip-subtree-if-priority ?A)
               (org-agenda-skip-if nil '(scheduled deadline)))))))
      ((org-agenda-compact-blocks t)))
     ("X" "hard-copy"
      ((tags "PRIORITY=\"A\""
        ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
         (org-agenda-overriding-header "High-priority unfinished tasks:")))
       (agenda "" ((org-agenda-span 3)))
       (alltodo ""
        ((org-agenda-skip-function
          '(or (air-org-skip-subtree-if-priority ?A)
               (org-agenda-skip-if nil '(scheduled deadline)))))))
      ((org-agenda-compact-blocks t)
       (org-agenda-add-entry-text-maxlines 5)
       (org-agenda-prefix-format "  ")
       (org-agenda-with-colors nil)
       (ps-left-header
        (list "(goals shit yeah)" "(Colton Grainger)"))
       (htmlize-output-type 'font))
      ("~/pprints/agenda.html" "~/pprints/agenda.pdf"))))
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-agenda-start-on-weekday nil)
 '(org-capture-templates
   (quote
    (("t" "TODO item" entry
      (file+headline "~/todo.org" "unsorted tasks")
      "* TODO %?
  %i"))))
 '(org-default-notes-file (quote ("~/todo.org")))
 '(org-log-done (quote time))
 '(org-startup-truncated nil)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "DONE(d)"))))
 '(org-archive-location "~/archive.org::")
 '(package-selected-packages (quote (htmlize magit)))
 '(require-final-newline t)
 '(save-interprogram-paste-before-kill t)
 '(scroll-conservatively 1000)
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t)
 '(ps-header-lines 2)
 '(ps-header-font-size 9)
 '(ps-header-title-font-size 11)
 '(ps-header-font-family 'Courier)
 '(ps-right-header
   (list 'ps-time-stamp-yyyy-mm-dd "/pagenumberstring load"))
 '(ps-print-header-frame nil)
 '(ps-header-line-pad 0)
 ;;'(ps-footer-lines 1)
 ;;'(ps-footer-font-size 11)
 ;;'(ps-footer-font-family 'Courier)
 '(ps-print-footer nil)
 ;;'(ps-left-footer nil)
 ;;'(ps-right-footer (list "/pagenumberstring load"))
 ;;'(ps-footer-offset .50)
 ;;'(ps-footer-line-pad .50)
 ;;'(ps-print-footer-frame nil)        ; no box bottom
 '(ps-left-margin 10)
 '(ps-right-margin 10)
 '(ps-top-margin 20)
 '(ps-bottom-margin 20)
 '(ps-number-of-columns 1)
 '(ps-inter-column 0)
 '(ps-landscape-mode nil)
 '(ps-font-family 'Courier)
 '(ps-font-size 7))

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
