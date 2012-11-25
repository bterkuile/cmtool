Cmtool::Menu.register do
  group label: :site do
    title t('cmtool.menu.site.title')
    resource_link Page, scope: Cmtool
    resource_link Cmtool::Keyword
  end
  group label: :publications do
    title t('cmtool.menu.publications.title')
    resource_link Cmtool::News
    resource_link Cmtool::Faq
    resource_link Cmtool::Quote
  end
  group label: :forms do
    title t('cmtool.menu.forms.title')
    resource_link Cmtool::ContactForm
    resource_link Cmtool::NewsletterSubscription
  end
  group label: :files do
    title t('cmtool.menu.files.title')
    resource_link Cmtool::Image
    resource_link Cmtool::Directory
  end

  resource_link User, label: :users, scope: Cmtool
end
Cmtool::Menu.register do
end
