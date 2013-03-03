module Cmtool
  module Includes
    module Page
      def self.included(klass)
        klass.send :include, SimplyStored::Couch
        klass.send :include, InstanceMethods
        klass.send :extend, ClassMethods

        # PROPERTIES
        klass.property :name
        klass.property :menu_text
        klass.property :title
        klass.property :body
        klass.property :footer
        klass.property :sidebar
        klass.property :priority, type: Float, default: 0.5
        klass.property :active, type: :boolean, default: true
        klass.property :layout
        klass.property :in_menu, type: :boolean, default: true

        klass.has_ancestry :by_property => :locale

        klass.validates :name, presence: true
        klass.validates :locale, presence: true
        klass.validate :parent_locale_match

        # RELATIONS
        klass.has_and_belongs_to_many :keywords, storing_keys: true, class_name: 'Cmtool::Keyword'

        # DEFAULT ORDER
        klass.view :all_documents, key: [:position, :name, :title]
        klass.view :by_name_and_locale, key: [:name, :locale]
      end

      module InstanceMethods

        def generate_name
          name = self.class.generate_name(title)
        end
      private
        def parent_locale_match
          if parent.present?
            errors.add(:locale, 'must be the same as the parent') unless parent.locale == locale
          end
        end
      end

      module ClassMethods
        def generate_name(name)
          name.to_s.downcase.gsub(/^\W+/, '').gsub(/\W+$/,'').gsub(/\W+/, '-')
        end
        def active(*args)
          all(*args)
        end

        def layouts
          [:application, :home, :contact]
        end

        def flag_locales
          [:ad, :ae, :af, :ag, :ai, :al, :am, :an, :ao, :aq, :ar, :as, :at, :au, :aw, :az, :ba, :bb, :bd, :be, :bf, :bg, :bh, :bi, :bj, :bm, :bn, :bo, :br, :bs, :bt, :bw, :by, :bz, :ca, :cd, :cf, :cg, :ch, :ci, :ck, :cl, :cm, :cn, :co, :cr, :cu, :cv, :cy, :cz, :de, :dj, :dk, :dm, :do, :dz, :ec, :ee, :eg, :eh, :en, :er, :es, :et, :fi, :fj, :fm, :fo, :fr, :ga, :gb, :gd, :ge, :gg, :gh, :gi, :gl, :gm, :gn, :gp, :gq, :gr, :gt, :gu, :gw, :gy, :hk, :hn, :hr, :ht, :hu, :id, :ie, :il, :im, :in, :iq, :ir, :is, :it, :je, :jm, :jo, :jp, :ke, :kg, :kh, :ki, :km, :kn, :kp, :kr, :kw, :ky, :kz, :la, :lb, :lc, :li, :lk, :lr, :ls, :lt, :lu, :lv, :ly, :ma, :mc, :md, :me, :mg, :mh, :mk, :ml, :mm, :mn, :mo, :mq, :mr, :ms, :mt, :mu, :mv, :mw, :mx, :my, :mz, :na, :nc, :ne, :ng, :ni, :nl, :no, :np, :nr, :nz, :om, :pa, :pe, :pf, :pg, :ph, :pk, :pl, :pr, :ps, :pt, :pw, :py, :qa, :re, :ro, :rs, :ru, :rw, :sa, :sb, :sc, :sd, :se, :sg, :si, :sk, :sl, :sm, :sn, :so, :sr, :st, :sv, :sy, :sz, :tc, :td, :tg, :th, :tj, :tl, :tm, :tn, :to, :tr, :tt, :tv, :tw, :tz, :ua, :ug, :us, :uy, :uz, :va, :vc, :ve, :vg, :vi, :vn, :vu, :ws, :ye, :za, :zm, :zw]
        end
        def locales
          [:en, :nl, :de, :es]
        end
        def default_locale
          :en
        end

        def top_menu
          ::Page.roots(I18n.locale).select(&:in_menu?)
        end
      end
    end
  end
end
