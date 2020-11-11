#!/bin/bash
ps ax | grep -oh -e "\(gnome-\|xfce-\|lx\)session" | uniq 
