#!/bin/bash

# CÐ¾Ð·Ð´Ð°ÐµÐ¼ Ñ„Ð°Ð¹Ð»Ñ‹
touch raw1.txt
touch raw2.txt
touch 866to1251.txt
touch 1251to866.txt
touch 1251.txt
touch 866.txt
touch tmp.txt
# Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð´Ð»Ñ Ð³ÐµÐ½ÐµÑ€Ð°Ñ†Ð¸Ð¸ ÑÑ‚Ñ€Ð¾Ðº
generate_lines() {
    local end="$1"
    local filename="$2"
    for ((i=1; i<=end; i++)); do
        echo "Ð¤ÐµÑÑŒÐºÐ¾Ð² Ð Ð¾ÑÑ‚Ð¸ÑÐ»Ð°Ð² Ð˜Ð³Ð¾Ñ€ÐµÐ²Ð¸Ñ‡, 07.04.2003, Ð³. Ð¡ÐµÐ²ÐµÑ€Ð¾Ð´Ð²Ð¸Ð½ÑÐº, ÐœÐÐžÐ£ Ð¡ÐµÐ²ÐµÑ€Ð¾Ð´Ð²Ð¸Ð½ÑÐºÐ°Ñ Ð³Ð¸Ð¼Ð½Ð°Ð·Ð¸Ñ 14, Ð”Ð¸Ð·Ð°Ð¹Ð½ Ð³Ñ€Ð°Ñ„Ð¸Ñ‡ÐµÑÐºÐ¸Ñ… Ð¸ Ð¿Ð¾Ð»ÑŒÐ·Ð¾Ð²Ð°Ñ‚ÐµÐ»ÑŒÑÐºÐ¸Ñ… Ð¸Ð½Ñ‚ÐµÑ€Ñ„ÐµÐ¹ÑÐ¾Ð² Ð¸Ð½Ñ„Ð¾Ñ€Ð¼Ð°Ñ†Ð¸Ð¾Ð½Ð½Ñ‹Ñ… ÑÐ¸ÑÑ‚ÐµÐ¼" >> $filename
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

# Ð“ÐµÐ½ÐµÑ€Ð¸Ñ€ÑƒÐµÐ¼ ÑÑ‹Ñ€Ð¾Ð¹ Ñ„Ð°Ð¹Ð»
generate_lines 5000 raw1.txt
copy_file 200 raw1.txt raw2.txt


# ÐŸÐµÑ€ÐµÐ²Ð¾Ð´Ð¸Ð¼ Ñ„Ð°Ð¹Ð»Ñ‹ Ð² ÑÐ²Ð¾Ð¸ ÐºÐ¾Ð´Ð¸Ñ€Ð¾Ð²ÐºÐ¸
iconv -f UTF-8 -t CP866 raw2.txt -o 866to1251.txt
iconv -f UTF-8 -t CP1251 raw2.txt -o 1251to866.txt

# Ð£Ð´Ð°Ð»ÑÐµÐ¼ ÑÑ‹Ñ€Ð¾Ð¹ Ñ„Ð°Ð¹Ð»
rm raw1.txt raw2.txt

# ÐšÐ°Ð¿Ð¸Ñ‚Ð°Ð»Ð¸Ð·Ð¸Ñ€ÑƒÐµÐ¼ Ñ‚ÐµÐºÑÑ‚ Ð² Ñ„Ð°Ð¹Ð»Ð°Ñ… Ñ Ð¸ÑÐ¿Ð¾Ð»ÑŒÐ·Ð¾Ð²Ð°Ð½Ð¸ÐµÐ¼ perl
cat 866to1251.txt | tr "[ ¡¢£¤¥¦§¨©ª«¬­®¯àáâãäåæçèéêëìíîï]" "[ABƒ„E†‡ˆ‰K‹MHOPCTY”X–—˜™š›œžŸ]" > tmp.txt
mv tmp.txt 866to1251.txt
cat 1251to866.txt | tr "[àáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ]" "[AÁBÃÄEÆÇÈÉKËMHOÏPCTYÔXÖ×ØÙÚÛÜÝÞß]" > tmp.txt
mv tmp.txt 1251to866.txt

# ÐœÐµÐ½ÑÐµÐ¼ ÐºÐ¸Ñ€Ð¸Ð»Ð»Ð¸Ñ†Ñƒ Ð½Ð° Ð»Ð°Ñ‚Ð¸Ð½Ð¸Ñ†Ñƒ
cat 866to1251.txt | tr "[€‚…ŠŒŽ‘’“•]" "[ABEKMHOPCTYX]" > tmp.txt
mv tmp.txt 866to1251.txt
cat 1251to866.txt | tr "[ÀÂÅÊÌÍÎÐÑÒÓÕ]" "[ABEKMHOPCTYX]" > tmp.txt
mv tmp.txt 1251to866.txt

# ÐœÐµÐ½ÑÐµÐ¼ ÐºÐ¾Ð´Ð¸Ñ€Ð¾Ð²ÐºÐ¸ Ñ„Ð°Ð¹Ð»Ð¾Ð²
iconv -f CP866 -t CP1251 866to1251.txt -o 1251.txt
iconv -f CP1251 -t CP866 1251to866.txt -o 866.txt

#Ð£Ð´Ð°Ð»ÑÐµÐ¼ Ð»Ð¸ÑˆÐ½Ð¸Ðµ Ñ„Ð°Ð¹Ð»Ñ‹
rm 866to1251.txt 1251to866.txt

# Ð¤Ð¾Ñ€Ð¼Ð¸Ñ€ÑƒÐµÐ¼ Zip-Ð°Ñ€Ñ…Ð¸Ð²Ñ‹
zip 866.zip 866.txt
zip 1251.zip 1251.txt
