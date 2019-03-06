#!/usr/bin/env bash

# Expect the first input argument to be divisble by 4. Returns a comma
# separated sequence of the numbers 0 to the given argument sorted in a certain
# fashion.

# check for non-empty positive input that is divisible by 4
n="$1"
[ -z "$n" ] && exit 1
m=$(($n % 4))
[ "$n" -lt 1 ] && exit 1
[ ! "$m" -eq 0 ] && exit 1

# limit for the sequence index
seqlim=$((($n - 4) / 2))

for x in $(seq 0 2 "$seqlim"); do
  m1=$(($n - $x))
  m2=$(($x + 1))
  m3=$(($m2 + 1)) # $x + 2
  m4=$(($m1 - 1)) # $n - $x - 1
  if [ --$2-- == --rotate-back-page-- ]; then
    echo "$m1,$m2,$m4,$m3"
  else
    echo "$m1,$m2,$m3,$m4"
  fi
done | paste -sd "," -
