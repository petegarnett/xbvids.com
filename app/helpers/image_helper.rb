module ImageHelper
  def self.resized(url, width, height=nil)
    api_params = {
      :image => url,
      :width => width
    }

    api_params[:height] = height unless height.nil?

    return ("https://imgrszr.herokuapp.com/?%s" % [api_params.to_query(nil)]).html_safe
  end

  def self.transparent_gif
    return 'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=='
  end
end
