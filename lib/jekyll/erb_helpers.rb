require 'cgi'

module Jekyll
  module ERBHelpers
    def erb(path,params={})
      result="dunce"
      @context||=OpenStruct.new({:site=>site,:page=>page}.merge(params[:locals]||{}))
      @context.extend(Jekyll::ERBHelpers)
      @context.extend(::Helpers) if defined?(::Helpers)
      template=ERB.new(File.read(File.join(site.source,"_partials","#{path.to_s}.erb")))
      result=template.result(@context.get_binding)
      result
    end

    def content_for(key, &block)

      @old_content||=""
      pos=@old_content.length
      result=block.call(*args)
      data=result[pos..-1]
      @old_content=result
      data


      content_blocks[key] << data
    end

    def yield_content(key, *args)
      content_blocks[key].join
    end

    private

    def content_blocks
      @content_blocks ||= Hash.new {|h,k| h[k] = [] }
    end 

  end
end
