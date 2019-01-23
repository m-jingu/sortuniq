#!/usr/bin/env perl

use strict;
use warnings;

my @tmpfiles;
my %check;
my $count = 0;
while(<STDIN>){
    if($check{$_}){
        $check{$_}++;
    }else{
        $check{$_} = 1;
    }
    $count++;
    if($count > 10000000){
        my $tmpfile = "tmp_$#tmpfiles";
        push (@tmpfiles, $tmpfile);
        print $tmpfile, "\n";
        open(TMP,">$tmpfile");
        for my $key (sort keys %check){
            print TMP $check{$key}."\t".$key;
        }
        close(TMP);
        %check = ();
        $count = 0;
    }
}

open(RESULT,">result");
for my $key(sort keys %check){
    print RESULT $check{$key}."\t".$key;
}
close(RESULT);
foreach my $tmpfile(@tmpfiles){
    open(RESULT,"<result");
    open(TMP,"<$tmpfile");
    open(RESULT2,">result2");
    my $s1 = <RESULT>;
    my $s2 = <TMP>;
    while($s1 && $s2){
        my @m1 = split(/\t/, $s1);
        my @m2 = split(/\t/, $s2);
        if($m1[1] lt $m2[1]){
            print RESULT2 $s1;
            $s1 = <RESULT>;
        }
        elsif($m1[1] gt $m2[1]){
            print RESULT2 $s2;
            $s2 = <TMP>;
        }
        else{
            my $sum = $m1[0] + $m2[0];
            print RESULT2 $sum."\t".$m1[1];
            $s1 = <RESULT>;
            $s2 = <TMP>;
        }
    }
    while($s1){
        print RESULT2 $s1;
        $s1 = <RESULT>;
    }
    while($s2){
        print RESULT2 $s2;
        $s2 = <TMP>;
    }
    close(RESULT);
    close(RESULT2);
    close(TMP);
    rename "result2", "result";
    unlink $tmpfile;
}
