#!/bin/bash

#  _                    _             _  
# | |    __ _ _ __ ___ | |__       _-(")-
# | |   / _` | '_ ` _ \| '_ \    `%%%%%  
# | |__| (_| | | | |_| | |_) | _  // \\  
# |_____\__,_|_| |_| |_|_.__/_| |__  ___ 
#                  | |   / _` | '_ \/ __|
#                  | |__| (_| | |_) \__ \
#  2023-11-18      |_____\__,_|_.__/|___/
#
#-------------------------------------
# Title:        LittleLamb Bash
# Version:      1.0
# Release Date: 2023-11-18
# Author:       Krzysztof Wegner (Owieczka)
#-------------------------------------

initANSI() {
	e=$(printf "\033") # \e \033
	m="▄" # \u2580"
	u="[48;2;" #upper color
	d="[38;2;" #down color
	c0="36;38;54m" # "1a1c2cm"
	c1="93;39;93m" # "5d275dm"
	c2="177;62;83m" # "b13e53m"
	c3="239;125;87m" # "ef7d57m"
	c4="255;205;117m" #	"ffcd75m"
	c5="167;240;112m" # "a7f070m"
	c6="56;183;100m" # 38b764m
	c7="37;113;121m" # 257179m
	c8="41;54;111m" # 29366fm
	c9="59;93;201m" # 3b5dc9m
	ca="65;166;246m" # 41a6f6m
	cb="115;239;247m" # 73eff7m
	cc="244;244;244m" # f4f4f4m
	cd="148;176;194m" # 94b0c2m
	ce="86;108;134m" # 566c86m
	cf="51;60;87m" # 333c57m
	uc0="${e}${u}${c0}"
	uc1="${e}${u}${c1}"
	uc2="${e}${u}${c2}"
	uc3="${e}${u}${c3}"
	uc4="${e}${u}${c4}"
	uc5="${e}${u}${c5}"
	uc6="${e}${u}${c6}"
	uc7="${e}${u}${c7}"
	uc8="${e}${u}${c8}"
	uc9="${e}${u}${c9}"
	uca="${e}${u}${ca}"
	ucb="${e}${u}${cb}"
	ucc="${e}${u}${cc}"
	ucd="${e}${u}${cd}"
	uce="${e}${u}${ce}"
	ucf="${e}${u}${cf}"
	dc0="${e}${d}${c0}"
	dc1="${e}${d}${c1}"
	dc2="${e}${d}${c2}"
	dc3="${e}${d}${c3}"
	dc4="${e}${d}${c4}"
	dc5="${e}${d}${c5}"
	dc6="${e}${d}${c6}"
	dc7="${e}${d}${c7}"
	dc8="${e}${d}${c8}"
	dc9="${e}${d}${c9}"
	dca="${e}${d}${ca}"
	dcb="${e}${d}${cb}"
	dcc="${e}${d}${cc}"
	dcd="${e}${d}${cd}"
	dce="${e}${d}${ce}"
	dcf="${e}${d}${cf}"
	longPallete
	shortPallete
	r="${e}[0m"
	is="${e}[7m"
	ie="${e}[27m"

	idx=( 0 1 2 3 4 5 6 7 8 9 a b c d e f )
  for j in "${idx[@]}"
  do
  	for i in "${idx[@]}"
  	do
  		uci="uc$i";
  		dcj="dc$j";
			eval "m${i}${j}='${!uci}${!dcj}${m}'";
		done
	done

	for i in "${idx[@]}"
	do
		uci="uc$i";
  	dci="dc$i";
		eval "m${i}r='${r}${!dci}${is}${m}${ie}'";
		eval "mr${i}='${r}${!dci}${m}'";
	done
}

longPallete(){
  p1="${uc0}${m}${uc1}${m}${uc2}${m}${uc3}${m}${uc4}${m}${uc5}${m}${uc6}${m}${uc7}${m}${uc8}${m}${uc9}${m}${uca}${m}${ucb}${m}${ucc}${m}${ucd}${m}${uce}${m}${ucf}${m}"
}

shortPallete(){
	p2="${uc0}${dc8}${m}${uc1}${dc9}${m}${uc2}${dca}${m}${uc3}${dcb}${m}${uc4}${dcc}${m}${uc5}${dcd}${m}${uc6}${dce}${m}${uc7}${dcf}${m}"
}

initANSI

cat << EOF
${p2}${r}     Welcome ${USER}
             IP: $(hostname -I)
   ${mrd}${mdc}${mdc}${mdc}${mrd}${r} ${dce}®${r}   Shell: ${SHELL}
  ${mb0}${mbb}${m00}${mcc}${m00}${mdd}${r}
${mr3}${m34}${m04}${mb4}${m00}${mcc}${m00}${mdd}${r}
${m03}${m44}${m44}${m44}${m44}${m0c}${mcd}${mdr}${mrc}${mrc}${r}
 ${m3r}${m3r}${m3c}${mcc}${mcc}${mcc}${mdc}${mcc}${mcr}${r}
   ${mr0}${mc0}${mcc}${mcc}${mc0}${mr0}${r}
  ${m00}${m00}${m00}${m00}${m00}${m00}${m00}${m00}${r}
EOF
