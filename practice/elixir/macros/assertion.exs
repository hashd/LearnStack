defmodule Assertion do
	defmacro assert({operator, _, [lhs, rhs]}) do
		quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
			# if lhs == rhs do
			# 	true
			# else
			# 	raise "AssertionError: #{lhs} is not equal to #{rhs}"
			# end
			Assertion.Test.assert(operator, lhs, rhs)
		end
	end

	defmodule Test do
		def assert(:==, lhs, rhs) when lhs == rhs do
			IO.write "."
		end
		def assert(:==, lhs, rhs) do
			IO.puts """
			FAILURE:
				Expected:				#{lhs}
				to be equal to: #{rhs}
			"""
		end
		def assert(:>, lhs, rhs) when lhs > rhs do
			IO.write "."
		end
		def assert(:>, lhs, rhs) do
			IO.puts """
			FAILURE:
				Expected:					#{lhs}
				to be less than: 	#{rhs}
			"""
		end
	end
end

import Assertion

assert 5 == 6