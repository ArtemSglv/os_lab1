#! /bin/bash
# поиск топовой url
awk '{if($11 != "\"-\"")
    {
        print $7,$11 > "url_ref.txt";
        url_list[$7]+=1;
        print $7,url_list[$7];
    }}' log.txt | sort -nrk 2 | awk '{if(NR==1) print > "top_url.txt"}'
# составление топ 10 рефереров
awk '{
        if(NR==1)
           turl=$1
        else
        if($1==turl)
        {
            output[$2]+=1;
            print $2,output[$2]
        }
}' top_url.txt url_ref.txt | sort -nrk 2 | awk '{if(NR<11) print}' | sed s/\"//g > top_ref.txt
# сумма запросов с топовых рефереров
awk '{sum+=$2} END {print sum > "sum"}' top_ref.txt
# итоговый вывод
awk '{
    if(NR==1)
        sum=$1
    else    
    {
        ORS="%\n"
        print $1,"-",$2,"-",$2/sum*100
    }
}' sum top_ref.txt