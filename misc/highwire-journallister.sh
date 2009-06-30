#!/bin/sh

cd `dirname $0`

./highwire-journallister.pl | sort -u > out.txt

diff out.txt highwire-journal-list.txt

