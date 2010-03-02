module InheritedResources
  # Holds all default actions for InheritedResouces.
  module Actions

    # GET /resources
    def index(options={}, &block)
      respond_with(*(with_chain(collection) << options), &block)
    end
    alias :index! :index

    # GET /resources/1
    def show(options={}, &block)
      respond_with(*(with_chain(resource) << options), &block)
    end
    alias :show! :show

    # GET /resources/new
    def new(options={}, &block)
      respond_with(*(with_chain(build_resource) << options), &block)
    end
    alias :new! :new

    # GET /resources/1/edit
    def edit(options={}, &block)
      respond_with(*(with_chain(resource) << options), &block)
    end
    alias :edit! :edit

    # POST /resources
    def create(options={}, &block)
      object = build_resource

      if create_resource(object)
        options[:location] ||= resource_url rescue nil
      end

      respond_with_dual_blocks(object, options, &block)
    end
    alias :create! :create

    # PUT /resources/1
    def update(options={}, &block)
      object = resource
      attributes = params[resource_instance_name] or params
      
      if update_resource(object, attributes)
        options[:location] ||= resource_url rescue nil
      end

      respond_with_dual_blocks(object, options, &block)
    end
    alias :update! :update

    # DELETE /resources/1
    def destroy(options={}, &block)
      object = resource
      options[:location] ||= collection_url rescue nil

      destroy_resource(object)
      respond_with_dual_blocks(object, options, &block)
    end
    alias :destroy! :destroy

    # Make aliases protected
    protected :index!, :show!, :new!, :create!, :edit!, :update!, :destroy!
  end
end

