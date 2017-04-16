;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     ;; better-defaults
     emacs-lisp
     ;; git
     markdown
     ;; org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control

     ;intero
     (haskell :variables
              haskell-completion-backend 'intero)
     syntax-checking
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Iosevka Expanded"
                               :size 16 ;13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (add-to-list 'display-buffer-alist
   '("*Flycheck errors*"
     (display-buffer-pop-up-window
      display-buffer-reuse-window
      display-buffer-in-side-window)
     (side          . right)
     (window-height . 0.25)
     ))

  (setq avy-keys '(?u ?i ?a ?e ?n ?r ?t ?d))

  (mmm-add-classes '((markdown-haskell
                      :submode haskell-mode
                      :face mmm-declaration-submode-face
                      :front "^```haskell[\n\r]+"
                      :back "^```$")))
  (mmm-add-mode-ext-class 'markdown-mode nil 'markdown-haskell)

  (setq prettify-symbols-unprettify-at-point 'right-edge)
  (defun setup-iosevka-ligatures ()
    (setq prettify-symbols-alist
          (append prettify-symbols-alist '(
                                           ;; Double-ended hyphen arrows ----------------
                                           ("<->" . #Xe100)
                                           ("<-->" . #Xe101)
                                           ("<--->" . #Xe102)
                                           ("<---->" . #Xe103)
                                           ("<----->" . #Xe104)

                                           ;; Double-ended equals arrows ----------------
                                           ("<=>" . #Xe105)
                                           ("<==>" . #Xe106)
                                           ("<===>" . #Xe107)
                                           ("<====>" . #Xe108)
                                           ("<=====>" . #Xe109)

                                           ;; Double-ended asterisk operators ----------------
                                           ("<**>" . #Xe10a)
                                           ("<***>" . #Xe10b)
                                           ("<****>" . #Xe10c)
                                           ("<*****>" . #Xe10d)

                                           ;; HTML comments ----------------
                                           ("<!--" . #Xe10e)
                                           ("<!---" . #Xe10f)

                                           ;; Three-char ops with discards ----------------
                                           ("<$" . #Xe110)
                                           ("<$>" . #Xe111)
                                           ("$>" . #Xe112)
                                           ("<." . #Xe113)
                                           ("<.>" . #Xe114)
                                           (".>" . #Xe115)
                                           ("<*" . #Xe116)
                                           ("<*>" . #Xe117)
                                           ("*>" . #Xe118)
                                           ("<\\" . #Xe119)
                                           ("<\\>" . #Xe11a)
                                           ("\\>" . #Xe11b)
                                           ("</" . #Xe11c)
                                           ("</>" . #Xe11d)
                                           ("/>" . #Xe11e)
                                           ("<\"" . #Xe11f)
                                           ("<\">" . #Xe120)
                                           ("\">" . #Xe121)
                                           ("<'" . #Xe122)
                                           ("<'>" . #Xe123)
                                           ("'>" . #Xe124)
                                           ("<^" . #Xe125)
                                           ("<^>" . #Xe126)
                                           ("^>" . #Xe127)
                                           ("<&" . #Xe128)
                                           ("<&>" . #Xe129)
                                           ("&>" . #Xe12a)
                                           ("<%" . #Xe12b)
                                           ("<%>" . #Xe12c)
                                           ("%>" . #Xe12d)
                                           ("<@" . #Xe12e)
                                           ("<@>" . #Xe12f)
                                           ("@>" . #Xe130)
                                           ("<#" . #Xe131)
                                           ("<#>" . #Xe132)
                                           ("#>" . #Xe133)
                                           ("<+" . #Xe134)
                                           ("<+>" . #Xe135)
                                           ("+>" . #Xe136)
                                           ("<-" . #Xe137)
                                           ("<->" . #Xe138)
                                           ("->" . #Xe139)
                                           ("<!" . #Xe13a)
                                           ("<!>" . #Xe13b)
                                           ("!>" . #Xe13c)
                                           ("<?" . #Xe13d)
                                           ("<?>" . #Xe13e)
                                           ("?>" . #Xe13f)
                                           ("<|" . #Xe140)
                                           ("<|>" . #Xe141)
                                           ("|>" . #Xe142)
                                           ("<:" . #Xe143)
                                           ("<:>" . #Xe144)
                                           (":>" . #Xe145)

                                           ;; Colons ----------------
                                           ("::" . #Xe146)
                                           (":::" . #Xe147)
                                           ("::::" . #Xe148)

                                           ;; Arrow-like operators ----------------
                                           ("->" . #Xe149)
                                           ("->-" . #Xe14a)
                                           ("->--" . #Xe14b)
                                           ("->>" . #Xe14c)
                                           ("->>-" . #Xe14d)
                                           ("->>--" . #Xe14e)
                                           ("->>>" . #Xe14f)
                                           ("->>>-" . #Xe150)
                                           ("->>>--" . #Xe151)
                                           ("-->" . #Xe152)
                                           ("-->-" . #Xe153)
                                           ("-->--" . #Xe154)
                                           ("-->>" . #Xe155)
                                           ("-->>-" . #Xe156)
                                           ("-->>--" . #Xe157)
                                           ("-->>>" . #Xe158)
                                           ("-->>>-" . #Xe159)
                                           ("-->>>--" . #Xe15a)
                                           (">-" . #Xe15b)
                                           (">--" . #Xe15c)
                                           (">>-" . #Xe15d)
                                           (">>--" . #Xe15e)
                                           (">>>-" . #Xe15f)
                                           (">>>--" . #Xe160)
                                           ("=>" . #Xe161)
                                           ("=>=" . #Xe162)
                                           ("=>==" . #Xe163)
                                           ("=>>" . #Xe164)
                                           ("=>>=" . #Xe165)
                                           ("=>>==" . #Xe166)
                                           ("=>>>" . #Xe167)
                                           ("=>>>=" . #Xe168)
                                           ("=>>>==" . #Xe169)
                                           ("==>" . #Xe16a)
                                           ("==>=" . #Xe16b)
                                           ("==>==" . #Xe16c)
                                           ("==>>" . #Xe16d)
                                           ("==>>=" . #Xe16e)
                                           ("==>>==" . #Xe16f)
                                           ("==>>>" . #Xe170)
                                           ("==>>>=" . #Xe171)
                                           ("==>>>==" . #Xe172)
                                           (">=" . #Xe173)
                                           (">==" . #Xe174)
                                           (">>=" . #Xe175)
                                           (">>==" . #Xe176)
                                           (">>>=" . #Xe177)
                                           (">>>==" . #Xe178)
                                           ("<-" . #Xe179)
                                           ("-<-" . #Xe17a)
                                           ("--<-" . #Xe17b)
                                           ("<<-" . #Xe17c)
                                           ("-<<-" . #Xe17d)
                                           ("--<<-" . #Xe17e)
                                           ("<<<-" . #Xe17f)
                                           ("-<<<-" . #Xe180)
                                           ("--<<<-" . #Xe181)
                                           ("<--" . #Xe182)
                                           ("-<--" . #Xe183)
                                           ("--<--" . #Xe184)
                                           ("<<--" . #Xe185)
                                           ("-<<--" . #Xe186)
                                           ("--<<--" . #Xe187)
                                           ("<<<--" . #Xe188)
                                           ("-<<<--" . #Xe189)
                                           ("--<<<--" . #Xe18a)
                                           ("-<" . #Xe18b)
                                           ("--<" . #Xe18c)
                                           ("-<<" . #Xe18d)
                                           ("--<<" . #Xe18e)
                                           ("-<<<" . #Xe18f)
                                           ("--<<<" . #Xe190)
                                           ("<=" . #Xe191)
                                           ("=<=" . #Xe192)
                                           ("==<=" . #Xe193)
                                           ("<<=" . #Xe194)
                                           ("=<<=" . #Xe195)
                                           ("==<<=" . #Xe196)
                                           ("<<<=" . #Xe197)
                                           ("=<<<=" . #Xe198)
                                           ("==<<<=" . #Xe199)
                                           ("<==" . #Xe19a)
                                           ("=<==" . #Xe19b)
                                           ("==<==" . #Xe19c)
                                           ("<<==" . #Xe19d)
                                           ("=<<==" . #Xe19e)
                                           ("==<<==" . #Xe19f)
                                           ("<<<==" . #Xe1a0)
                                           ("=<<<==" . #Xe1a1)
                                           ("==<<<==" . #Xe1a2)
                                           ("=<" . #Xe1a3)
                                           ("==<" . #Xe1a4)
                                           ("=<<" . #Xe1a5)
                                           ("==<<" . #Xe1a6)
                                           ("=<<<" . #Xe1a7)
                                           ("==<<<" . #Xe1a8)

                                           ;; Monadic operators ----------------
                                           (">=>" . #Xe1a9)
                                           (">->" . #Xe1aa)
                                           (">-->" . #Xe1ab)
                                           (">==>" . #Xe1ac)
                                           ("<=<" . #Xe1ad)
                                           ("<-<" . #Xe1ae)
                                           ("<--<" . #Xe1af)
                                           ("<==<" . #Xe1b0)

                                           ;; Composition operators ----------------
                                           (">>" . #Xe1b1)
                                           (">>>" . #Xe1b2)
                                           ("<<" . #Xe1b3)
                                           ("<<<" . #Xe1b4)

                                           ;; Lens operators ----------------
                                           (":+" . #Xe1b5)
                                           (":-" . #Xe1b6)
                                           (":=" . #Xe1b7)
                                           ("+:" . #Xe1b8)
                                           ("-:" . #Xe1b9)
                                           ("=:" . #Xe1ba)
                                           ("=^" . #Xe1bb)
                                           ("=+" . #Xe1bc)
                                           ("=-" . #Xe1bd)
                                           ("=*" . #Xe1be)
                                           ("=/" . #Xe1bf)
                                           ("=%" . #Xe1c0)
                                           ("^=" . #Xe1c1)
                                           ("+=" . #Xe1c2)
                                           ("-=" . #Xe1c3)
                                           ("*=" . #Xe1c4)
                                           ("/=" . #Xe1c5)
                                           ("%=" . #Xe1c6)

                                           ;; Logical ----------------
                                           ("/\\" . #Xe1c7)
                                           ("\\/" . #Xe1c8)

                                           ;; Semigroup/monoid operators ----------------
                                           ("<>" . #Xe1c9)
                                           ("<+" . #Xe1ca)
                                           ("<+>" . #Xe1cb)
                                           ("+>" . #Xe1cc)

                                           ;; Lambda ----------------
                                           ("\\" . "λ")
                                           ))))

  (defun refresh-pretty ()
    (prettify-symbols-mode -1)
    (prettify-symbols-mode +1))

  ;; Hooks for modes in which to install the Iosevka ligatures
  (mapc (lambda (hook)
          (add-hook hook (lambda () (setup-iosevka-ligatures) (refresh-pretty))))
        '(text-mode-hook
          prog-mode-hook
          haskell-mode-hook))
  (global-prettify-symbols-mode +1)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-company helm-c-yasnippet company-statistics company-cabal auto-yasnippet ac-ispell auto-complete hlint-refactor helm-hoogle yasnippet flycheck-haskell company-ghci company-ghc ghc uuidgen toc-org request org-plus-contrib org-bullets link-hint hide-comnt eyebrowse evil-visual-mark-mode evil-unimpaired evil-ediff dumb-jump f column-enforce-mode zenburn-theme ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe use-package spacemacs-theme spaceline solarized-theme smooth-scrolling shm restart-emacs rainbow-delimiters quelpa popwin persp-mode pcre2el paradox page-break-lines open-junk-file neotree move-text monokai-theme mmm-mode markdown-toc macrostep lorem-ipsum linum-relative leuven-theme intero info+ indent-guide ido-vertical-mode hungry-delete hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag haskell-snippets google-translate golden-ratio gh-md flycheck-pos-tip flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu elisp-slime-nav define-word cmm-mode clean-aindent-mode buffer-move bracketed-paste auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
