#!/bin/bash

for ((i=1; i<=4000; i++)); do
    echo "Антипенко Дарья Денисовна, Дизайн графических и пользовательских интерфейсов информационных систем" >> 4k_utf8.txt

for ((i=1; i<=125; i++)); do
    cat 4k_utf8.txt >> 500k_utf8.txt

iconv -f UTF-8 -t CP866 500k_utf8.txt -o 500k_866.txt
iconv -f UTF-8 -t CP1251 500k_utf8.txt -o 500k_1251.txt

cat 500k_866.txt | tr "[��������������������������������]" "[A�B��E����K�MHO�PCTY�X����������]" > 500k_866_upper.txt
cat 500k_1251.txt | tr "[��������������������������������]" "[A�B��E����K�MHO�PCTY�X����������]" > 500k_1251_upper.txt

cat 500k_866_upper.txt | tr "[������������]" "[ABEKMHOPCTYX]" > 500k_866_upper_latin.txt
cat 500k_1251_upper.txt | tr "[������������]" "[ABEKMHOPCTYX]" > 500k_1251_upper_latin.txt

iconv -f CP866 -t CP1251 500k_866_upper_latin.txt -o ИСТ-133_Антипенко_ДД_ЛР4_a_1251.txt
iconv -f CP1251 -t CP866 500k_1251_upper_latin.txt -o ИСТ-133_Антипенко_ДД_ЛР4_a_866.txt

rm 4k_utf8.txt 500k_utf8.txt 500k_866.txt 500k_1251.txt 500k_866_upper.txt 500k_1251_upper.txt 500k_1251_upper_latin.txt 500k_866_upper_latin.txt

zip ИСТ-133_Антипенко_ДД_ЛР4_a_1251.zip ИСТ-133_Антипенко_ДД_ЛР4_a_1251.txt
zip ИСТ-133_Антипенко_ДД_ЛР4_a_866.zip ИСТ-133_Антипенко_ДД_ЛР4_a_866.txt
