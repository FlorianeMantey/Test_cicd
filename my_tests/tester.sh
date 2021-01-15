#!/bin/bash

rm -f output


#mv ex$1/*.cpp ./           // for directory ex00 ex01....
#mv ex$1/*.hpp ./


mv my_tests/$1/main.cpp ./main.cpp
`cat my_tests/$1/compil`
if [ $? -ne 0 ]
then
    echo -e "\e[91m# BUILD FAILED.\e[0m"
    exit 1
fi
./test$1 > output
return_value=0
diff output my_tests/$1/except > diff.txt
if [ $? -eq 0 ]
then
    echo -e "\e[92mSUCCESS\e[0m"
else
    echo -e "\e[91m# Got:\e[0m"
    cat output
    echo -e "\e[91m# But excepted:\e[0m"
    cat my_tests/$1/except
    echo -e "\e[91m# Differences:\e[0m"
    cat diff.txt
    return_value=1
fi
rm -f diff.txt output
exit $return_value
