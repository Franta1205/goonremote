module ApplicationHelper
  include Pagy::Frontend

  def custom_pagy_nav(pagy)
    pages = pagy.pages

    nav = content_tag(:nav, class: "flex justify-center mt-4") do
      content_tag(:ul, class: "flex flex-wrap space-x-1") do
        (1..pages).map do |page|
          if page == pagy.page
            # Active page
            content_tag(:li) do
              content_tag(:span, page, class: "px-4 py-2 mx-1 border border-blue-500 bg-blue-600 text-white rounded text-sm md:text-base")
            end
          else
            # Inactive pages
            content_tag(:li) do
              link_to(page, url_for(page: page), class: "px-4 py-2 mx-1 border border-gray-700 bg-gray-800 text-white rounded hover:bg-blue-500 hover:text-white transition duration-200 text-sm md:text-base")
            end
          end
        end.join.html_safe
      end
    end

    content_tag(:div, nav, class: "mt-6 pb-8") # Wrap nav in a div for margin
  end
end
