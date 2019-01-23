#!/usr/bin/env perl

use strict;
use warnings;

my @tmpfiles;
my %check;
my $count = 0;
while(<STDIN>){
    if($check{$_}){
        next;
    }
    $check{$_} = 1;
    $count++;
    if($count > 10000000){
        my $tmpfile = "tmp_$#tmpfiles";
        push (@tmpfiles, $tmpfile);
        print $tmpfile, "\n";
        open(TMP,">$tmpfile");
        print TMP sort(keys(%check));
        close(TMP);
        %check = ();
        $count = 0;
    }
}

open(RESULT,"> result");
print RESULT sort(keys(%check));
close(RESULT);
foreach my $tmpfile(@tmpfiles){
    open(RESULT,"< result");
    open(TMP,"<$tmpfile");
    open(RESULT2,"> result2");
    my $s1 = <RESULT>;
    my $s2 = <TMP>;
    while($s1 && $s2){
        if($s1 lt $s2){
            print RESULT2 $s1;
            $s1 = <RESULT>;
        }
        elsif($s1 gt $s2){
            print RESULT2 $s2;
            $s2 = <TMP>;
        }
        else {
            print RESULT2 $s1;
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
