;;; packages.el --- Language Server Protocol Layer packages file for Spacemacs
;;
;; Copyright (c) 2012-2021 Sylvain Benner & Contributors
;;
;; Author: Fangrui Song <i@maskray.me>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


(defconst lsp-packages
  '(
    lsp-mode
    (lsp-ui :toggle lsp-use-lsp-ui)
    (helm-lsp :requires helm)
    (lsp-ivy :requires ivy)
    (lsp-treemacs :requires treemacs)
    (lsp-origami :requires lsp-mode)
    popwin))

(defun lsp/init-lsp-mode ()
  "lsp mode"
  (use-package lsp-mode
    :commands lsp
    :ensure t
    :bind ("C-c f" . man-follow)
    ("C-c r" . lsp-ui-peek-find-references)
    ("M-. " . lsp-ui-peek-find-definitions)
    ("M-[" . lsp-ui-peek-jump-backward)
    ("M-]" . lsp-ui-peek-jump-forward)
    ("M-o" . xref-find-definitions-other-window)
    :hook ((python-mode c-mode c++-mode) . lsp)
    ))

(defun lsp/init-lsp-ui ()
  "lsp mode"
  (use-package lsp-ui
    ;; :ensure t
                                        ;    :quelpa (lsp-ui :fetcher github :repo "Jimx-/lsp-ui")
    :defer t
    :after lsp
    :commands lsp-ui-mode
    :hook (lsp-mode . lsp-ui-mode)
    :bind (:map lsp-ui-mode-map
                ([remap xref-find-definitions] . lsp-ui-peek-find-definitions) ; [M-.]
                ([remap xref-find-references] . lsp-ui-peek-find-references)   ; [M-?]
                ("C-c C-j" . lsp-ui-imenu))
    :init (setq lsp-ui-doc-enable nil
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-position 'at-point)
    ;; for "Jimx-/lsp-ui" fork has xwebkit support.
    (if (featurep 'xwidget)
        (setq lsp-ui-doc-use-webkit t))
    ;; (add-to-list 'lsp-ui-doc-frame-parameters )
    ))

(defun lsp/init-helm-lsp ()
  (use-package helm-lsp :defer t))

(defun lsp/init-lsp-ivy ()
  (use-package lsp-ivy :defer t))

(defun lsp/init-lsp-treemacs ()
  (use-package lsp-treemacs :defer t))

(defun lsp/init-lsp-origami ()
  (use-package lsp-origami
    :defer t
    :init
    (add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)))

(defun lsp/pre-init-popwin ()
  (spacemacs|use-package-add-hook popwin
    :post-config
    (push '("*lsp-help*" :dedicated t :position bottom :stick t :noselect t :height 0.4)
          popwin:special-display-config)))
