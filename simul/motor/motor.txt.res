Got 1 devices.
Added device: spice2poly
Got 0 udns.
Got 17 devices.
Added device: climit
Added device: divide
Added device: d_dt
Added device: gain
Added device: hyst
Added device: ilimit
Added device: int
Added device: limit
Added device: mult
Added device: oneshot
Added device: pwl
Added device: sine
Added device: slew
Added device: square
Added device: summer
Added device: s_xfer
Added device: triangle
Got 0 udns.
Got 26 devices.
Added device: adc_bridge
Added device: dac_bridge
Added device: d_and
Added device: d_buffer
Added device: d_dff
Added device: d_dlatch
Added device: d_fdiv
Added device: d_inverter
Added device: d_jkff
Added device: d_nand
Added device: d_nor
Added device: d_open_c
Added device: d_open_e
Added device: d_or
Added device: d_osc
Added device: d_pulldown
Added device: d_pullup
Added device: d_ram
Added device: d_source
Added device: d_srff
Added device: d_srlatch
Added device: d_state
Added device: d_tff
Added device: d_tristate
Added device: d_xnor
Added device: d_xor
Got 0 udns.
Got 9 devices.
Added device: aswitch
Added device: capacitor
Added device: cmeter
Added device: core
Added device: inductor
Added device: lcouple
Added device: lmeter
Added device: potentiometer
Added device: zener
Got 0 udns.
Got 4 devices.
Added device: d_to_real
Added device: real_delay
Added device: real_gain
Added device: real_to_v
Got 2 udns.
Added udn: int
Added udn: real

Circuit: * simulation of motor

Warning -- Level not specified on line "is=2.83372e-13 bf=255 nf=1.02154 vaf=10 ikf=1.49182 ise=2.38053e-11 ne=2.07043 br=2.35039 nr=1.06482 var=100 ikr=4.67427 isc=9.29191e-13 nc=3.99655 rb=4.8102 irb=0.1 rbm=0.1 re=0.0853195 rc=0.426598 xtb=0.770827 xti=1 eg=1.19761 cje=4.23873e-11 vje=0.4 mje=0.337119 tf=7.10643e-10 xtf=1.15136 vtf=1.55902 itf=0.169013 cjc=1.55039e-11 vjc=0.786451 mjc=0.23 xcjc=0.1 fc=0.8 cjs=0 vjs=0.75 mjs=0.5 tr=1e-07 ptf=0 kf=0 af=1"
Using level 1.
Warning -- Level not specified on line "(is=1e-14 vaf=100    bf=200 ikf=0.3 xtb=1.5 br=3    cjc=8e-12 cje=25e-12 tr=100e-9 tf=400e-12    itf=1 vtf=2 xtf=3 rb=10 rc=3 re=1 vceo=30 icrating=800m  mfg=philips)"
Using level 1.
Error on line 61 : .model 2n2222 npn(is=1e-14 vaf=100    bf=200 ikf=0.3 xtb=1.5 br=3    cjc=8e-12 cje=25e-12 tr=100e-9 tf=400e-12    itf=1 vtf=2 xtf=3 rb=10 rc=3 re=1 vceo=30 icrating=800m  mfg=philips)
	unrecognized parameter (vceo) - ignored
	
	unrecognized parameter (30) - ignored
	
	unrecognized parameter (icrating) - ignored
	
	unrecognized parameter (800m) - ignored
	
	unrecognized parameter (mfg) - ignored
	
	unrecognized parameter (philips) - ignored
Doing analysis at TEMP = 300.150000 and TNOM = 300.150000

Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
in                                           0
vbasebc                            8.59148e-09
2                                      10.8856
1                                           12
out                                    7.22223
vbase                                 0.855815
3                                    0.0480363
v_motor#branch                      -0.0488921
v2#branch                          8.59148e-13

