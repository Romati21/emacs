;;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; Это файл конфигурации для Spacemacs. Он должен находиться в домашней директории.

(defun dotspacemacs/layers ()
  "Конфигурация слоев.
Эта функция должна модифицировать только настройки слоев."
  (setq-default
   ;; Базовая дистрибутива, которая будет использоваться
   dotspacemacs-distribution 'spacemacs

   ;; Ленивая установка слоев. Возможные значения: 'all', 'unused' и 'nil'
   ;; 'all' - ленивая установка всех слоев, поддерживающих эту функцию
   ;; 'unused' - ленивая установка только неиспользуемых слоев
   ;; 'nil' - отключение ленивой установки
   dotspacemacs-enable-lazy-installation 'unused

   ;; Список дополнительных путей для поиска слоев конфигурации
   dotspacemacs-configuration-layer-path '()

   ;; Список слоев для загрузки
   dotspacemacs-configuration-layers
   '(php
     windows-scripts
     yaml
     javascript
     ;; --- Языки программирования ---
     (python :variables
             python-backend 'lsp
             python-fill-column 99
             python-formatter 'yapf
             python-format-on-save t
             python-sort-imports-on-save t
             python-pipenv-activate t)
     lsp
     dap                   ; Новый отладчик для слоя python
     elixir
     (scheme :variables scheme-implementations '(gambit guile racket))
     haskell
     clojure
     ;; (latex :variables latex-view-with-pdf-tools nil)
     (typography :variables
                 typography-enable-cm-super t)
     (latex :variables
            latex-enable-auto-fill nil
            latex-enable-folding t
            latex-enable-magic t
            latex-enable-recursive-edit t
            latex-view-with-pdf-tools t)
     c-c++
     ;; (auto-save :variables
     ;;            auto-save-mode t
     ;;            auto-save-interval 1)

     ;; --- Редактирование ---
     pdf
     syntax-checking
     auto-completion
     multiple-cursors
     (org :variables
          org-enable-roam-protocol t
          org-enable-roam-support t
          org-enable-roam-ui t
          org-protocol t
          org-enable-notifications t
          org-start-notification-daemon-on-startup t)
     pandoc
     graphviz
     evil-snipe

     ;; --- Утилиты ---

     (ranger :variables
             ranger-show-preview t
             ranger-show-hidden t
             ranger-cleanup-eagerly t
             ranger-cleanup-on-disable t
             ranger-ignored-extensions '("mkv" "flv" "iso" "mp4"))
     dash
     docker
     systemd
     csv
     html
     (shell :variables
            shell-default-shell 'vterm)
     (ipython-notebook :variables ein-backend 'jupyter)
     major-modes
     command-log
     erc
     treemacs

     ;; --- Прочее ---
     emacs-lisp
     sql
     (git :variables
          ;; открывает статус Магита ( SPC g s) в полнокадровом окне,
          ;; q восстанавливает предыдущую компоновку окна
          git-magit-status-fullscreen t
          ;; Настройки различий показывают конкретные изменения слов, когда
          ;; кусок активен, что упрощает обнаружение точных изменений
          magit-diff-refine-hunk t
          ;; перечисляет соответствующие строки TODO из текущего проекта в
          ;; буфере состояния Magit, помогая отслеживать работу и проблемы
          git-enable-magit-todos-plugin t)


     ;; Слой выделяет изменения на границе буфера и переходное состояние vcs для
     ;; быстрой навигации по изменениям (кускам)
     (version-control :variables
                      ;; использует diff-hl для выделения изменений файла при
                      ;; локальных коммитах, при этом маркеры появляются по
                      ;; краям
                      version-control-diff-tool 'diff-hl
                      ;; позволяет автоматически выделять изменения во всех буферах
                      version-control-global-margin t)
     )

   ;; Список дополнительных пакетов для установки
   dotspacemacs-additional-packages
   '(
     (telega)
     (setq telega-directory "~/.telega"
           telega-options-plist '(:online t :localization_target "tdesktop" :use_storage_optimizer nil :ignore_file_names nil)
           telega-proxies nil
           telega-my-location nil)
     (add-hook 'telega-load-hook
               (lambda ()
                 (define-key global-map (kbd "C-c t") telega-prefix-map)))
     (setq telega-server-libs-prefix "/opt/tdlib-tg/lib/libtdjson.so")

     (ob-async :location built-in)
     (ob-go :location built-in)
     (ob-rust :location built-in)
     (ob-python :location built-in)
     (ob-shell :location built-in)
     (ob-sql :location built-in)
     (ob-org :location built-in))

   ;; Список пакетов, которые не могут быть обновлены.
   dotspacemacs-frozen-packages '()

   ;; Список пакетов, которые не будут установлены и загружены.
   dotspacemacs-excluded-packages '()

   ;; Определяет поведение Spacemacs при установке пакетов.
   ;; Возможные значения: `used-only', `used-but-keep-unused' и `all'.
   ;; `used-only' устанавливает только явно используемые пакеты и удаляет неиспользуемые
   ;; пакеты, а также их неиспользуемые зависимости. `used-but-keep-unused'
   ;; устанавливает только используемые пакеты, но не удаляет неиспользуемые. `all'
   ;; устанавливает *все* пакеты, поддерживаемые Spacemacs, и никогда их не удаляет.
   ;; (по умолчанию `used-only')
   dotspacemacs-install-packages 'used-only))


;; Включить уведомления для org
(setq alert-default-style 'notifications)


(defun dotspacemacs/init ()
  "Инициализация:
Эта функция вызывается в самом начале запуска Spacemacs,
перед конфигурацией слоев.
Она должна изменять только значения настроек Spacemacs."
  ;; Этот setq-default sexp является исчерпывающим списком всех поддерживаемых
  ;; настроек spacemacs.
  (setq-default
   ;; Если не nil, то включить поддержку портативного дампера. Вам нужно будет
   ;; скомпилировать Emacs 27 из исходного кода, следуя инструкциям в файле
   ;; EXPERIMENTAL.org в корневом каталоге git-репозитория.
   ;;
   ;; ПРЕДУПРЕЖДЕНИЕ: pdumper не работает с Native Compilation, поэтому он отключен
   ;; независимо от следующей настройки, когда используется нативная компиляция.
   ;;
   ;; (по умолчанию nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Имя исполняемого файла, указывающего на emacs 27+. Этот исполняемый файл должен
   ;; находиться в вашей PATH.
   ;; (по умолчанию "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Имя дампового файла Spacemacs. Это файл будет создан
   ;; портативным дампером в кэш-директории в поддиректории dumps.
   ;; Чтобы загрузить его при запуске Emacs, добавьте параметр `--dump-file'
   ;; при вызове исполняемого файла Emacs 27.1 в командной строке, например:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (по умолчанию (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; Если не nil, репозитории ELPA контактируют через HTTPS, когда это возможно.
   ;; Установите значение nil, если у вас нет возможности использовать HTTPS в вашей
   ;; среде, в противном случае настоятельно рекомендуется оставить значение t.
   ;; Эта переменная не имеет эффекта, если Emacs запущен с параметром
   ;; `--insecure', который принудительно устанавливает значение этой переменной в nil.
   ;; (по умолчанию t)
   dotspacemacs-elpa-https t

   ;; Максимальное допустимое время в секундах для контакта с репозиторием ELPA.
   ;; (по умолчанию 5)
   dotspacemacs-elpa-timeout 5

   ;; Установить `gc-cons-threshold' и `gc-cons-percentage' после завершения запуска.
   ;; Это продвинутая опция и не должна изменяться, если вы не подозреваете
   ;; проблем с производительностью из-за операций сборки мусора.
   ;; (по умолчанию '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Установить `read-process-output-max' после завершения запуска.
   ;; Это определяет, сколько данных считывается из внешнего процесса.
   ;; (по умолчанию (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; Если не nil, тогда репозиторий Spacelpa является основным источником для установки
   ;; зафиксированной версии пакетов. Если nil, тогда Spacemacs будет устанавливать
   ;; последнюю версию пакетов из MELPA. Spacelpa в настоящее время находится в
   ;; экспериментальном состоянии, пожалуйста, используйте только для тестирования.
   ;; (по умолчанию nil)
   dotspacemacs-use-spacelpa nil

   ;; Если не nil, тогда проверять подпись для скачанных архивов Spacelpa.
   ;; (по умолчанию t)
   dotspacemacs-verify-spacelpa-archives t

   ;; Если не nil, тогда spacemacs будет проверять наличие обновлений при запуске,
   ;; когда текущая ветка не является `develop'. Обратите внимание, что проверка
   ;; новых версий работает через git команды, таким образом, она вызывает
   ;; службы GitHub каждый раз, когда вы запускаете Emacs. (по умолчанию nil)
   dotspacemacs-check-for-update nil

   ;; Если не nil, форма, которая вычисляется в директорию пакетов. Например, чтобы
   ;; использовать разные директории пакетов для разных версий Emacs, установите это
   ;; значение в `emacs-version'. (по умолчанию 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; Один из `vim', `emacs' или `hybrid'.
   ;; `hybrid' - это как `vim', но состояние `insert' заменено
   ;; на состояние `hybrid' с комбинациями клавиш `emacs'. Значение также может быть списком
   ;; с ключевым словом `:variables' (похожим на слои). Проверьте раздел о стилях редактирования
   ;; в документации для получения информации о доступных переменных.
   ;; (по умолчанию 'vim)
   dotspacemacs-editing-style 'vim

   ;; Если не равно nil, показывать строку версии в буфере Spacemacs. Она будет
   ;; отображаться как (версия spacemacs)@(версия emacs)
   ;; (по умолчанию t)
   dotspacemacs-startup-buffer-show-version t

   ;; Указать стартовый баннер. Значение по умолчанию - `official', отображает
   ;; официальный логотип spacemacs. Целочисленное значение - это индекс текстового
   ;; баннера, `random' выбирает случайный текстовый баннер из каталога `core/banners'.
   ;; Строковое значение должно быть путем к изображению в поддерживаемом вашей сборкой Emacs формате.
   ;; Если значение равно nil, баннер не отображается. (по умолчанию 'official)
   dotspacemacs-startup-banner 'official

   ;; Масштабный коэффициент управляет масштабированием (размером) стартового баннера. Значение
   ;; по умолчанию - `auto' для автоматического масштабирования логотипа, чтобы он соответствовал всему
   ;; содержимому буфера, с максимальной высотой полного изображения и минимумом в 3 строки.
   ;; Если задано числом (целым или вещественным), оно используется как постоянный
   ;; масштабный коэффициент для размера логотипа по умолчанию.
   dotspacemacs-startup-banner-scale 'auto

   ;; Список элементов для отображения в стартовом буфере или ассоциативный список
   ;; вида `(тип-списка . размер-списка)`. Если nil, то отключено.
   ;; Возможные значения для тип-списка:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; Размеры списков могут быть nil, в этом случае
   ;; будет использовано значение `spacemacs-buffer-startup-lists-length'.
   ;; Исключение - `recents-by-project', где тип-списка должен быть парой чисел,
   ;; например `(recents-by-project . (7 .  5))`, где первое число - это лимит
   ;; проектов, а второе - лимит недавних файлов в пределах проекта.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True, если домашний буфер должен реагировать на события изменения размера. (по умолчанию t)
   dotspacemacs-startup-buffer-responsive t

   ;; Показывать номера перед строками в стартовом списке. (по умолчанию t)
   dotspacemacs-show-startup-list-numbers t

   ;; Минимальная задержка в секундах между нажатиями цифровых клавиш. (по умолчанию 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; Если не равно nil, показывать иконки файлов для записей и заголовков в домашнем буфере Spacemacs.
   ;; Не работает в терминале или если пакет "all-the-icons" или шрифт
   ;; не установлены. (по умолчанию nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Основной режим для нового пустого буфера. Возможные значения - имена режимов,
   ;; такие как `text-mode'; и `nil' для использования Фундаментального режима.
   ;; (по умолчанию `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Основной режим буфера *scratch* (по умолчанию `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Если не равно nil, буфер *scratch* будет сохраняться. То, что вы пишете в
   ;; буфере *scratch*, будет автоматически сохраняться и восстанавливаться.
   dotspacemacs-scratch-buffer-persistent nil

   ;; Если не равно nil, `kill-buffer' на буфере *scratch*
   ;; будет прятать его вместо удаления.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Начальное сообщение в буфере *scratch*, такое как "Добро пожаловать в Spacemacs!"
   ;; (по умолчанию nil)
   dotspacemacs-initial-scratch-message nil

   ;; Список тем, первая из списка загружается при запуске spacemacs.
   ;; Нажмите `SPC T n' для переключения на следующую тему в списке (отлично работает
   ;; с 2 вариантами тем, одной темной и одной светлой)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Установить тему для Spaceline. Поддерживаемые темы: `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' и `vanilla'. Первые три -
   ;; темы spaceline. `doom' - строка состояния doom-emacs.
   ;; `vanilla' - стандартная строка состояния Emacs. `custom' - пользовательская тема,
   ;; смотрите DOCUMENTATION.org для дополнительной информации о создании собственной
   ;; темы spaceline. Значение может быть символом или списком с дополнительными свойствами.
   ;; (по умолчанию '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; Если не равно nil, цвет курсора соответствует цвету состояния в GUI Emacs.
   ;; (по умолчанию t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Шрифт по умолчанию или приоритетный список шрифтов. `:size' может быть указан как
   ;; неотрицательное целое число (размер в пикселях) или вещественное число (размер в пунктах).
   ;; Рекомендуется использовать размер в пунктах, так как он не зависит от устройства. (по умолчанию 10.0)
   dotspacemacs-default-font '("Source Code Pro"
                               :size 16.0
                               :weight normal
                               :width normal)

   ;; Лидирующая клавиша (по умолчанию "SPC")
   dotspacemacs-leader-key "SPC"

   ;; Клавиша, используемая для команд Emacs `M-x' (после нажатия лидирующей клавиши).
   ;; (по умолчанию "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; Клавиша, используемая для команд Vim Ex (по умолчанию ":")
   dotspacemacs-ex-command-key ":"

   ;; Лидирующая клавиша, доступная в состояниях `emacs` и `insert`
   ;; (по умолчанию "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Клавиша лидера для основного режима - это комбинация клавиш, эквивалентная
   ;; нажатию `<leader> m`. Установите её в `nil`, чтобы отключить. (по умолчанию ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Клавиша лидера для основного режима, доступная в состояниях `emacs` и `insert`.
   ;; (по умолчанию "C-M-m" для терминального режима, "<M-return>" для GUI режима).
   ;; Таким образом, M-RET должна работать как клавиша лидера в обоих режимах GUI и терминала.
   ;; C-M-m также должна работать в терминальном режиме, но не в режиме GUI.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; Эти переменные управляют, привязаны ли отдельные команды в GUI к парам клавиш
   ;; `C-i', `TAB' и `C-m', `RET'.
   ;; При установке в ненулевое значение, это позволяет использовать отдельные команды под `C -i'
   ;; и TAB или `C-m' и `RET'.
   ;; В терминале эти пары обычно неразличимы, поэтому это работает только в GUI. (по умолчанию nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Имя раскладки по умолчанию (по умолчанию "Default")
   dotspacemacs-default-layout-name "Default"

   ;; Если не равно nil, имя раскладки по умолчанию отображается в строке режима.
   ;; (по умолчанию nil)
   dotspacemacs-display-default-layout nil

   ;; Если не равно nil, то последние автосохраненные раскладки будут автоматически восстановлены при запуске.
   ;; (по умолчанию nil)
   dotspacemacs-auto-resume-layouts nil

   ;; Если не равно nil, то при создании новых раскладок будут автоматически генерироваться их имена.
   ;; Действует только при использовании команд "перейти к раскладке по номеру". (по умолчанию nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Размер (в МБ), после которого Spacemacs будет предлагать открыть большой файл буквально,
   ;; чтобы избежать проблем с производительностью. Буквальное открытие файла означает, что
   ;; основной режим или дополнительные режимы не активны. (по умолчанию 1)
   dotspacemacs-large-file-size 1

   ;; Место, где автоматически сохранять файлы. Возможные значения: `original' - сохранять файл на месте,
   ;; `cache' - сохранять файл в другой файл, хранящийся в каталоге кэша, и `nil' - отключить автосохранение.
   ;; (по умолчанию 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Максимальное количество слотов откатов, которые следует хранить в кэше. (по умолчанию 5)
   dotspacemacs-max-rollback-slots 5

   ;; Если не равно nil, будет включено транзитное состояние вставки. В этом состоянии, после вставки
   ;; чего-либо, нажатие `C-j` и `C-k' несколько раз циклически переключает элементы в `kill-ring`.
   ;; (по умолчанию nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Задержка which-key в секундах. Буфер which-key - это всплывающее окно,
   ;; перечисляющее команды, привязанные к текущей последовательности клавиш. (по умолчанию 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Позиция фрейма which-key. Возможные значения: `right', `bottom' и
   ;; `right-then-bottom'. right-then-bottom сначала пытается отобразить фрейм справа;
   ;; если там недостаточно места, он отображается внизу.
   ;; (по умолчанию 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Управляет, где `switch-to-buffer' отображает буфер. Если nil,
   ;; `switch-to-buffer' отображает буфер в текущем окне, даже если
   ;; доступно другое окно с тем же назначением. Если не равно nil, `switch-to-buffer'
   ;; отображает буфер в окне с тем же назначением, даже если буфер может быть
   ;; отображен в текущем окне. (по умолчанию nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; Если не равно nil, при загрузке Spacemacs отображается индикатор прогресса. В некоторых
   ;; системах и сборках Emacs это может увеличить время загрузки, установите в
   ;; nil для ускорения загрузки. (по умолчанию t)
   dotspacemacs-loading-progress-bar t

   ;; Если не равно nil, фрейм будет во весь экран при запуске Emacs. (по умолчанию nil)
   ;; (Только для Emacs 24.4 и новее)
   dotspacemacs-fullscreen-at-startup nil

   ;; Если не равно nil, `spacemacs/toggle-fullscreen' не будет использовать нативный полноэкранный режим.
   ;; Используйте для отключения анимации полноэкранного режима в OSX. (по умолчанию nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; Если не равно nil, фрейм будет развернут при запуске Emacs.
   ;; Действует только если `dotspacemacs-fullscreen-at-startup' равно nil.
   ;; (по умолчанию t) (Только для Emacs 24.4 и новее)
   dotspacemacs-maximized-at-startup t

   ;; Если не nil, то фрейм будет без декораций при запуске Emacs.
   ;; Комбинируйте это переменную с `dotspacemacs-maximized-at-startup', чтобы получить полноэкранный режим без внешних рамок.
   ;; Также отключает внутреннюю границу. (по умолчанию nil)
   dotspacemacs-undecorated-at-startup nil

   ;; Значение из диапазона (0..100), которое описывает уровень прозрачности фрейма, когда он активен или выбран.
   ;; Прозрачность может быть переключена через `toggle-transparency'. (по умолчанию 90)
   dotspacemacs-active-transparency 90

   ;; Значение из диапазона (0..100), которое описывает уровень прозрачности фрейма, когда он неактивен или не выбран.
   ;; Прозрачность может быть переключена через `toggle-transparency'. (по умолчанию 90)
   dotspacemacs-inactive-transparency 90

   ;; Значение из диапазона (0..100), которое описывает уровень прозрачности фона фрейма, когда он активен или выбран.
   ;; Прозрачность может быть переключена через `toggle-background-transparency'. (по умолчанию 90)
   dotspacemacs-background-transparency 90

   ;; Если не nil, то отображаются заголовки временных состояний. (по умолчанию t)
   dotspacemacs-show-transient-state-title t

   ;; Если не nil, то отображается цветовой гид для временных состояний. (по умолчанию t)
   dotspacemacs-show-transient-state-color-guide t

   ;; Если не nil, то отображаются символы Unicode в строке состояния.
   ;; Если вы используете Emacs как демон и хотите отображать символы Unicode только в GUI, установите значение quoted `display-graphic-p'. (по умолчанию t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; Если не nil, то включается плавная прокрутка (native-scrolling). Плавная прокрутка переопределяет стандартное поведение Emacs, которое центрирует точку, когда она достигает верхнего или нижнего края экрана. (по умолчанию t)
   dotspacemacs-smooth-scrolling t

   ;; Показывать полосу прокрутки при прокрутке. Время автоматического скрытия может быть настроено, установив это значение в число. (по умолчанию t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Управление активацией номеров строк.
   ;; Если установлено в `t', `relative' или `visual', то номера строк включены в所有 производных режимов `prog-mode' и `text-mode'. Если установлено в `relative', то номера строк относительные. Если установлено в `visual', то номера строк также относительные, но только визуальные строки считаются.
   ;; Это переменная также может быть установлена в список свойств для более тонкого контроля:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; Когда используется в списке свойств, `visual' имеет приоритет над `relative'.
   ;; (по умолчанию nil)
   dotspacemacs-line-numbers 'relative

   ;; Метод сворачивания кода. Возможные значения - `evil', `origami' и `vimish'. (по умолчанию 'evil)
   dotspacemacs-folding-method 'evil

   ;; Если не nil и `dotspacemacs-activate-smartparens-mode' также не nil, то `smartparens-strict-mode' будет включен в режимах программирования.
   ;; (по умолчанию nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; Если не nil, то smartparens-mode будет включен в режимах программирования.
   ;; (по умолчанию t)
   dotspacemacs-activate-smartparens-mode t

   ;; Если не nil, то при нажатии клавиши закрывающей скобки `)' в режиме вставки проходит через автоматически добавленные закрывающие скобки, квадратные скобки, кавычки и т.д.
   ;; Это может быть временно отключено, нажав `C-q' перед `)'. (по умолчанию nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Выберите область для выделения разделителей. Возможные значения - `any', `current', `all' или `nil'. По умолчанию `all' (выделить любую область и подчеркнуть текущую).
   ;; (по умолчанию 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; Если не nil, то запустить сервер Emacs, если он не запущен.
   ;; (по умолчанию nil)
   dotspacemacs-enable-server nil

   ;; Установите расположение сокета сервера Emacs.
   ;; Если nil, то используется стандартное расположение Emacs, иначе - путь к директории, например, \"~/.emacs.d/server\". Это не имеет эффекта, если `dotspacemacs-enable-server' равен nil.
   ;; (по умолчанию nil)
   dotspacemacs-server-socket-dir nil

   ;; Если не nil, то советовать функциям quit оставаться на сервере при выходе.
   ;; (по умолчанию nil)
   dotspacemacs-persistent-server nil

   ;; Список имен исполняемых файлов инструментов поиска. Spacemacs использует первый установленный инструмент из списка. Поддерживаемые инструменты - `rg', `ag', `pt', `ack' и `grep'.
   ;; (по умолчанию '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Формат спецификации для установки заголовка фрейма.
   ;; %a - сокращенное имя файла, или имя буфера
   ;; %t - имя проекта
   ;; %I - имя вызова
   ;; %S - имя системы
   ;; %U - содержимое $USER
   ;; %b - имя буфера
   ;; %f - имя посещенного файла
   ;; %F - имя фрейма
   ;; %s - статус процесса
   ;; %p - процент буфера выше верхнего края окна, или Top, Bot или All
   ;; %P - процент буфера выше нижнего края окна, или Top, Bot или All
   ;; %m - имя режима
   ;; %n - Narrow, если соответствует
   ;; %z - мнемоники буфера, терминала и кодировки клавиатуры
   ;; %Z - как %z, но включая формат конца строки
   ;; Если nil, то Spacemacs использует стандартный `frame-title-format', чтобы避ать performance issues, вместо расчета заголовка фрейма с помощью `spacemacs/title-prepare' каждый раз.
   ;; (по умолчанию "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Формат спецификации для установки заголовка иконки
   ;; (по умолчанию nil - то же, что и frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Подсветка хвостовых пробелов в всех производных режимах `prog-mode' и `text-mode', таких как c++-mode, python-mode, emacs-lisp, html-mode, rst-mode и т.д.
   ;; (по умолчанию t)
   dotspacemacs-show-trailing-whitespace t

   ;; Удаление пробелов при сохранении буфера. Возможные значения - `all', чтобы агрессивно удалять пустые строки и длинные последовательности пробелов, `trailing', чтобы удалять только пробелы в конце строк, `changed', чтобы удалять только пробелы для измененных строк, или `nil', чтобы отключить очистку.
   ;; (по умолчанию nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; Если не nil, то активировать `clean-aindent-mode', который пытается исправить виртуальную отступку простых режимов. Это может конфликтовать с режимом-специфичной обработкой отступки, как было сообщено для `go-mode'.
   ;; Если это происходит, деактивируйте его здесь.
   ;; (по умолчанию t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Если не nil, то принимать SPC как y для запросов. (по умолчанию nil)
   dotspacemacs-use-SPC-as-y nil

   ;; Если не nil, то сдвигать строку чисел, чтобы соответствовать введенной раскладке клавиатуры (только в режиме вставки). В настоящее время поддерживаются раскладки `qwerty-us', `qwertz-de' и `querty-ca-fr'. Новые раскладки могут быть добавлены в слой `spacemacs-editing'.
   ;; (по умолчанию nil)
   dotspacemacs-swap-number-row nil

   ;; Либо nil, либо число секунд. Если не nil, то зонировать после указанного числа секунд. (по умолчанию nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Запустить `spacemacs/prettify-org-buffer', когда посещается файл README.org Spacemacs.
   ;; (по умолчанию nil)
   dotspacemacs-pretty-docs nil

   ;; Если nil, то домашний буфер показывает полный путь элементов агенды и задач. Если не nil, то показывается только имя файла.
   dotspacemacs-home-shorten-agenda-source nil

   ;; Если не nil, то байт-компилировать некоторые файлы Spacemacs.
   dotspacemacs-byte-compile nil))




(defun dotspacemacs/user-env ()
  "Настройка переменных окружения.
Эта функция определяет переменные окружения для вашей сессии Emacs."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Инициализация для пользовательского кода.
Эта функция вызывается сразу после `dotspacemacs/init', перед конфигурацией слоев.
Здесь следует размещать переменные, которые должны быть установлены до загрузки пакетов."
  )


(defun dotspacemacs/user-load ()
  "Библиотеки для загрузки при создании дампа.
Эта функция вызывается только при создании дампа конфигурации Spacemacs.
Здесь можно 'require' или 'load' необходимые библиотеки.")

(defun dotspacemacs/user-config ()
  "Конфигурация для пользовательского кода.
Эта функция вызывается в самом конце запуска Spacemacs, после конфигурации слоев.
Здесь следует размещать ваши настройки конфигурации."

  ;; Включение встроенного профилировщика для
  ;; выявления узких мест и дальнейшей оптимизации конфигурации
  ;; (require 'profiler)
  ;; (profiler-start)
  ;; (profiler-report)

  ;; Настройка шрифта для vterm
  (add-hook 'vterm-mode-hook
            (lambda ()
              (set-face-attribute 'vterm nil
                                  :family "Source Code Pro"
                                  :size 16.0
                                  :weight normal
                                  :width normal)))

  ;; Настройка автодополнения для eshell
  (add-hook 'eshell-mode-hook
            (lambda ()
              (define-key eshell-mode-map (kbd "TAB") 'completion-at-point)))

  ;; Включение автодополнения в eshell
  (with-eval-after-load 'esh-opt
    (setq eshell-hist-ignoredups t
          eshell-save-history-on-exit t
          eshell-history-size 1024
          eshell-prompt-regexp "^[^#$\n]*[#$] "
          eshell-prompt-function
          (lambda ()
            (concat
             (abbreviate-file-name (eshell/pwd))
             (if (= (user-uid) 0) " # " " $ ")))))

  ;; Параметры подключения к Postgres
  (setq sql-postgres-options '("-h" "localhost" "-p" "5432" "-U" "romancnc" "-d" "vendordatabase"))


  ;; (setq telega-server-libs-prefix "/home/roman/td/tdlib/lib")
  (add-hook 'telega-load-hook
            (lambda ()
              (define-key global-map (kbd "C-c t") telega-prefix-map)))
  (setq-default tab-width 4)

  ;; Настройки AUCTeX
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-master nil)
  (setq-default TeX-master nil)
  (customize-set-variable 'auctex-latexmk-encoding-alist '(alist :tag "Encoding alist"))
  (customize-set-variable 'auctex-latexmk-inherit-TeX-PDF-mode 'boolean)

  (setq pdf-sync-backward-display-action t)
  (setq pdf-sync-forward-display-action t)

  (add-hook 'LaTeX-mode-hook 'latex-electric-mode)
  (setq LaTeX-math-abbrev-prefix "§")
  (add-hook 'LaTeX-mode-hook 'cdlatex-mode)
  (setq reftex-plug-into-AUCTeX t)
  (add-hook 'LaTeX-mode-hook 'reftex-mode)
  ;; (define-key latex-mode-map (kbd "C-c C-e") 'latex-environment)
  ;; (define-key latex-mode-map (kbd "C-c C-s") 'latex-section)
  ;; (define-key latex-mode-map (kbd "C-c C-f") 'latex-font)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-PDF-mode t)
  (setq TeX-view-program-selection '((output-pdf "pdf-tools")))
  (setq texlive-full t)

  ;; Просмоторщик pdf
  ;; (setq TeX-view-program-selection '((output-pdf "Evince")))
  (setq lsp-texlab-executable "texlab")

  ;; Настройки преамбулы LaTeX по умолчанию для всех файлов .org
  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))

  (add-to-list 'org-latex-classes
               '("article"
                 "\\documentclass{article}
                \\usepackage[utf8]{inputenc}
                \\usepackage[russian]{babel}
                \\usepackage[T2A]{fontenc}
                \\usepackage{cmap}
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


  ;; Задайте файлы, которые будут искаться для записи токенов
  ;; по умолчанию будет использоваться ~/.authinfo
  (setq auth-sources '("~/.authinfo.gpg"))

  ;; Использовать TexLab в качестве сервера LSP для LaTeX
  (setq lsp-tex-server 'texlab)

  ;; Telega
  (telega :variables
          telega-use-docker t)

  ;; Включить предварительный просмотр PDF в реальном времени с пакетом TexLab
  (add-hook 'TeX-mode-hook 'lsp)
  (add-hook 'TeX-mode-hook
            (lambda ()
              (if (f-ext? buffer-file-name "tex")
                  (add-hook 'after-save-hook
                            'lsp-tex-tex-sync-server-cursor nil t))))

  ;; Настройки org-protocol
  (add-to-list 'load-path "~/.local/share/applications/org-protocol.desktop")
  (require 'org-protocol)

  ;; Включить автоматический перенос строк в text-mode
  (add-hook 'text-mode-hook 'turn-on-auto-fill)

  ;; Использовать texlab в качестве сервера LSP для LaTeX
  (setq lsp-tex-server 'texlab)

  ;; Добавить слои latex и dvipng
  (dotspacemacs/layers '(latex dvipng)))

  ;; Предоставляет функциональность для расширенных шаблонов в режиме Org
  (require 'org-tempo)

;; Не писать ничего ниже этого комментария. Здесь Emacs будет автоматически
;; генерировать определения пользовательских переменных.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-and-diary-frame-parameters
   '((name . "Calendar")
     (title . "Calendar")
     (height . 28)
     (width . 70)
     (minibuffer)))
 '(magit-repository-directories '(("~/" . 2) ("/media/D" . 6)))
 '(org-agenda-files '("/home/roman/org"))
 '(package-selected-packages
   '(company-php ac-php-core company-phpactor drupal-mode geben php-auto-yasnippets php-extras php-mode phpactor composer php-runtime phpunit bmx-mode powershell ejc-sql yaml-mode import-js grizzl js-doc js2-refactor multiple-cursors livid-mode nodejs-repl npm-mode skewer-mode js2-mode tern rainbow-mode visual-fill terminal-focus-reporting rainbow-identifiers telega pdf-view-restore pdf-tools add-node-modules-path company-web web-completion-data counsel-css emmet-mode helm-css-scss impatient-mode pug-mode sass-mode haml-mode scss-mode slim-mode tagedit web-mode blacken code-cells company-anaconda anaconda-mode counsel-gtags counsel swiper ivy cython-mode ggtags helm-cscope helm-pydoc importmagic epc ctable concurrent live-py-mode lsp-pyright lsp-python-ms nose pip-requirements pipenv load-env-vars pippel poetry py-isort pydoc pyenv-mode pythonic pylookup pytest pyvenv sphinx-doc stickyfunc-enhance xcscope yapfify magit zeal-at-point yasnippet-snippets ws-butler writeroom-mode wolfram-mode winum which-key web-beautify volatile-highlights vim-powerline vi-tilde-fringe vala-snippets vala-mode uuidgen undo-tree treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil toc-org thrift term-cursor symon symbol-overlay string-inflection string-edit-at-point stan-mode spacemacs-whitespace-cleanup spacemacs-purpose-popwin spaceline space-doc smeargle scad-mode restart-emacs rainbow-delimiters quickrun qml-mode prettier-js popwin pkgbuild-mode pcre2el password-generator paradox pandoc-mode ox-pandoc overseer orgit-forge org-wild-notifier org-superstar org-roam-ui org-rich-yank org-projectile org-present org-pomodoro org-mime org-download org-contrib org-cliplink open-junk-file nameless multi-line matlab-mode macrostep lsp-ui lsp-origami lsp-latex lorem-ipsum logcat link-hint keycast inspector info+ indent-guide hybrid-mode hungry-delete htmlize hoon-mode holy-mode hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt helm-xref helm-themes helm-swoop helm-rtags helm-purpose helm-projectile helm-org-rifle helm-org helm-mode-manager helm-make helm-lsp helm-ls-git helm-git-grep helm-descbinds helm-dash helm-company helm-comint helm-c-yasnippet helm-ag google-translate google-c-style golden-ratio gnuplot gitignore-templates git-timemachine git-modes git-messenger git-link git-commit gendoxy gemini-mode geiser-racket geiser-guile geiser-gambit flycheck-ycmd flycheck-rtags flycheck-pos-tip flycheck-package flycheck-elsa flx-ido fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-tex evil-surround evil-snipe evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-evilified-state evil-escape evil-easymotion evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks emr elisp-slime-nav elisp-def ein editorconfig ebuild-mode dumb-jump drag-stuff dotenv-mode dockerfile-mode docker disaster dired-quick-sort diminish diff-hl devdocs define-word dap-mode cpp-auto-include company-ycmd company-rtags company-reftex company-math company-c-headers company-auctex command-log-mode column-enforce-mode clean-aindent-mode centered-cursor-mode ccls browse-at-remote auto-yasnippet auto-highlight-symbol auto-compile arduino-mode all-the-icons aggressive-indent ace-link ace-jump-helm-line)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
