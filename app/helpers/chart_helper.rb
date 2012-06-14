module ChartHelper
	def statistics(from_users)
		@names=[]
		from_users.each do |x|
			unless x==current_user 
				@names<<x.name
			end
		end
		@counts=[]
		@names_stat=@names.uniq
		@names_stat.each do |x| 
			@counts<<@names.count(x)
		end
		@statistics_data=@names_stat.zip(@counts).to_json	
	end
end