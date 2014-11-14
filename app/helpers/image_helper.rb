module ImageHelper
  def self.resized(url, width, height=nil)
    api_params = {
      :url   => url,
      :width => width,
      :key   => '3b8da2efff024d37856e11ab0878dfa9'
    }

    api_params[:height] = height unless height.nil?

    return ("https://i.embed.ly/1/image/resize?%s" % [api_params.to_query(nil)]).html_safe
  end

  def self.transparent_gif
    return 'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=='
  end
end
