BEGIN{
    count = pack = time = 0;
}
{
    if($1=="s" && $3=="_3_" && $4=="AGT"){
        count++;
        pack+=$8;
        time=$2;
        }
}
END{
    printf("Throughput from n0 to n3 : %f Mbps\n",(count*pack*8)/(time*1000000));
}
