BEGIN{
    countR = countD = 0;
}
{
    if($1=="d"){
        countD++;
    }
    else if($1=="r"){
        countR++;
    }
}
END{
    printf("Packets received: %d\nPackets dropped:%d\n\n",countR,countD);
}
