# encoding: utf-8
require 'hunspell-ffi'
require 'singleton'

class Dictionary
  include Singleton

    def initialize()
        @dict = Hunspell.new("./slownik/pl_PL.aff", "./slownik/pl_PL.dic")
        @dict.add("Pomoc")
    end

    def checkWords(query)
        checkvalue = true
        checklist = query.delete('^ aąbcćdeęfghijklłmnńoóprsśtuwyzźżAĄBCĆDEĘFGHIJKLŁMNŃOÓPRSŚTUWYZŹŻ').split
			 	if @dict.check(checklist[0]) == false
	          checkvalue = false
	          suggestions = @dict.suggest(word)
	          if (suggestions.size)
	              @correction = suggestions.first
	              return_messages = Array.new()
	              return_messages[0] = "Chyba coś źle napisałeś, nie chodziło ci przypadkiem o słowo #{@correction}."
	              return_messages[1] = "Wydaje mi się, że miałeś na myśli słowo #{@correction}."
	              return_messages[2] = "A nie powinno być #{@correction} zamiast #{word}."
	              return return_messages[Random.rand(3)]
	          end
	      end
        if !checkvalue
            return "Coś jest nie tak, ale nie wiem o co Ci chodziło :p"
        else
            return checkvalue
        end
    end
end