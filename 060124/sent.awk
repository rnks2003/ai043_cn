BEGIN{
    countS = countR = 0;
}
{
    if($1=="s" && ($3=="_2_" || $3=="_0_") && $4=="AGT"){
	countS++;
        }
        else if($1=="r" && ($3=="_1_" || $3=="_3_") && $4="AGT"){
        countR++;
        }
}
END{
    printf("Packets received : %d\nPackets sent : %d\n",countR,countS);
}
