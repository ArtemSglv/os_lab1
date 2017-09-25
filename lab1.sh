#! /bin/bash
awk '{if($11 != "\"-\"") print $7,$11 > "log.unordered"}' log.txt
awk '{
    url_list[$1]+=1; print $1,url_list[$1] > "url_list.txt"
}' log.unordered