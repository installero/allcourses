# encoding: utf-8

# Заводим две переменные с числами 
a = 128.34
b = 71

# выводим числа на экран
puts a
puts b

if (a > b) 
	puts "Наибольшее число: " + a.to_s 
end

if (b > a) 
	puts "Наибольшее число: " + b.to_s 
end

if (b == a) 
	puts "Оба числа равны"
end

