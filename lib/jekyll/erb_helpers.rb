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
      content_blocks[key] << block
    end

    def yield_content(key, *args)
      @old_content||=""
      pos=@old_content.length
      result=content_blocks[key].map do |c|
	c.call(*args)
      end.join
      data=result[pos..-1]
      @old_content=result
      data
    end

    private

    def content_blocks
      @content_blocks ||= Hash.new {|h,k| h[k] = [] }
    end 

  end
end
