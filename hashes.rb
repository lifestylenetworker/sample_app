class Hashes

	attr_accessor :person1, :person2, :person3

	def initialize()

		@person1 = {first: "Tom", last: "Hansen"}
		@person2 = {first: "Lise", last: "Hansen"}
		@person3 = {first: "Signe", last: "Hansen"}

		@params = {father: @person1, mother: @person2, daughter: @person3}
	end

	def print()
		@params
	end

	def print_father()
		@params[:father][:first]
	end
end