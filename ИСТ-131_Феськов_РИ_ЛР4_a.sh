#!/bin/bash

# Cоздаем файлы
touch raw1.txt
touch raw2.txt
touch 866to1251.txt
touch 1251to866.txt
touch 1251.txt
touch 866.txt
touch tmp.txt
# Функция для генерации строк
generate_lines() {
    local end="$1"
    local filename="$2"
    for ((i=1; i<=end; i++)); do
        echo "Феськов Ростислав Игоревич, 07.04.2003, г. Северодвинск, МАОУ Северодвинская гимназия 14, Дизайн графических и пользовательских интерфейсов информационных систем" >> $filename
    done
}

copy_file() {
    local end="$1"
    local filein="$2"
    local fileout="$3"
    for ((i=1; i<=end; i++)); do
        cat $filein >> $fileout
   done
}

# Генерируем сырой файл
generate_lines 5000 raw1.txt
copy_file 100 raw1.txt raw2.txt


# Переводим файлы в свои кодировки
iconv -f UTF-8 -t CP866 raw2.txt -o 866to1251.txt
iconv -f UTF-8 -t CP1251 raw2.txt -o 1251to866.txt

# Удаляем сырой файл
rm raw1.txt raw2.txt

# Капитализируем текст в файлах с использованием perl
cat 866to1251.txt | tr "[��������������������������������]" "[A�B��E����K�MHO�PCTY�X����������]" > tmp.txt
mv tmp.txt 866to1251.txt
cat 1251to866.txt | tr "[��������������������������������]" "[A�B��E����K�MHO�PCTY�X����������]" > tmp.txt
mv tmp.txt 1251to866.txt

# Меняем кириллицу на латиницу
cat 866to1251.txt | tr "[������������]" "[ABEKMHOPCTYX]" > tmp.txt
mv tmp.txt 866to1251.txt
cat 1251to866.txt | tr "[������������]" "[ABEKMHOPCTYX]" > tmp.txt
mv tmp.txt 1251to866.txt

# Меняем кодировки файлов
iconv -f CP866 -t CP1251 866to1251.txt -o 1251.txt
iconv -f CP1251 -t CP866 1251to866.txt -o 866.txt

#Удаляем лишние файлы
rm 866to1251.txt 1251to866.txt

# Формируем Zip-архивы
zip 866.zip 866.txt
zip 1251.zip 1251.txt
