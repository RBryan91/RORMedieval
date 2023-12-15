class InventorysController < ApplicationController
    before_action :require_login_player

    def show
      @inventory = Inventory.find(params[:id])
    end

    def move_items
      item_ids = params[:item_ids]

      if move_to_stuff?(params) && violating_identical_category_rule?(item_ids)
        flash[:alert] = "You cannot have 2 items with same category equiped"
      else
  
      active_inventory_categories = Inventory
        .where(character_id: session[:character_id], active: true)
        .joins(:item)
        .pluck('items.category')


      categories_count = active_inventory_categories.group_by(&:itself).transform_values(&:count)


      if move_to_stuff?(params) && violating_one_item_per_category_rule?(categories_count, item_ids)
        flash[:alert] = "You can only have one item of each category equipped."
      else
        move_items_based_on_action(params, item_ids)
      end
    end
  
      redirect_to character_path(id: session[:character_id])
    end
  
    def new
      @inventory = Inventory.new
    end
  
    def create
      @inventory = Inventory.new(inventory_params)
      @inventory.character_id = session[:character_id]
      @inventory.save
   end
        
   private
     def inventory_params 
       params.require(:inventory).permit(:item_id, :active, :character_id)
     end

     def move_to_stuff?(params)
      params[:move_to_stuff].present?
    end

    def move_to_inventory?(params)
      params[:move_to_inventory].present?
    end

    def violating_identical_category_rule?(item_ids)
      selected_categories = Inventory.where(id: item_ids).joins(:item).pluck('items.category')
      selected_categories.count > selected_categories.uniq.length
    end
  
    def violating_one_item_per_category_rule?(categories_count, item_ids)
      item_categories = Item.joins(:inventorys).where(inventorys: { id: item_ids }).pluck(:category)
      item_categories.any? { |category| categories_count[category].to_i > 0 }
    end
  
    def move_items_based_on_action(params, item_ids)
      if move_to_stuff?(params)
        Inventory.where(id: item_ids).update_all(active: true)
        inventory_ids = Inventory.where(id: item_ids)
        items = Item.where(id:inventory_ids.pluck(:item_id))
        total_force = items.sum(:force)
        total_pv = items.sum(:pv)
        total_xp = items.sum(:xp)
        character = current_character
        character.update(
        force: character.force + total_force,
        pv: character.pv + total_pv,
        bonus_xp: character.bonus_xp + total_xp
      )
      elsif move_to_inventory?(params)
        Inventory.where(id: item_ids).update_all(active: false)
        inventory_ids = Inventory.where(id: item_ids)
        items = Item.where(id:inventory_ids.pluck(:item_id))
        total_force = items.sum(:force)
        total_pv = items.sum(:pv)
        total_xp = items.sum(:xp)
        character = current_character
        character.update(
        force: character.force - total_force,
        pv: character.pv - total_pv,
        bonus_xp: character.bonus_xp - total_xp
      )
      end
    end
  end
