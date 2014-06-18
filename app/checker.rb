# encoding: utf-8
require 'hunspell-ffi'
require 'singleton'

class Dictionary
  include Singleton

    def initialize()
        @dict = Hunspell.new("./slownik/pl_PL.aff", "./slownik/pl_PL.dic")
    end

    def checkWords(query)
        checkvalue = true
        checklist = query.delete('^ aąbcćdeęfghijklłmnńoóprsśtuwyzźżAĄBCĆDEĘFGHIJKLŁMNŃOÓPRSŚTUWYZŹŻ').split
			 	if @dict.check(checklist[0]) == false
	          checkvalue = false
	          suggestions = @dict.suggest(checklist[0])
	          if (suggestions.size)
	              @correction = suggestions.first
	              return return_messages = "Wydaje mi się, że miałeś na myśli słowo #{@correction}."
	          end
	      end
        if !checkvalue
            return "Coś jest nie tak, ale nie wiem o co Ci chodziło :p"
        else
            return checkvalue
        end
    end
end