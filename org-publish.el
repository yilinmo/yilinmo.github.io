(require 'ox-publish)

(setq org-publish-project-alist
      '(
	("org-pages"
	 :base-directory "~/homepage/"
	 :base-extension "org"
	 :publishing-directory "~/homepage/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
         :body-only t ;; Only export section between <body> </body>
	 )
	("org-static"
	 :base-directory "~/homepage/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|pdf"
	 :publishing-directory "~/homepage/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("org" :components ("org-pages" "org-static"))
	))
