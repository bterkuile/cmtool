class Page
  include Cmtool::Includes::Page
  view :by_locale, key: :locale
end
