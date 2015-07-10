(require 'ox-publish)

(setq org-publish-project-alist
      '(
	("org-pages"
	 :base-directory "~/homepage/org/page/"
	 :base-extension "org"
	 :publishing-directory "~/homepage/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
         :body-only t ;; Only export section between <body> </body>
	 )
	("org-posts"
	 :base-directory "~/homepage/org/post/"
	 :base-extension "org"
	 :publishing-directory "~/homepage/_posts"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
         :body-only t ;; Only export section between <body> </body>
	 )
	("org-static"
	 :base-directory "~/homepage/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|pdf\\|m"
	 :publishing-directory "~/homepage/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("org" :components ("org-pages" "org-posts" "org-static"))
	))
