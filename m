From: "naveen krishna ch" <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2c 2 issue in 2.6.24 kernel
Date: Wed, 27 Aug 2008 21:26:58 +0530
Message-ID: <ef0d8a250808270856w4675062cibf85435d20fdecfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8249522807731675928=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============8249522807731675928==
Content-Type: multipart/alternative;
	boundary="----=_Part_19843_19406422.1219852618747"

------=_Part_19843_19406422.1219852618747
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I am porting a touchscreen driver from 2.6.23 to 2.6.24. during porting.
I found issues with i2C2 of omap3EVM.

During kernel it detects the touchscreen and it will create a node also.

The issues are like when i run a touchscreen command line application test
The so called evtest.c

The test gives output even if i dont touch the screen
It will show the previous touched values like this.

The out put catch looks like

Event: time 946684851.131195, -------------- Report Sync ------------
Event: time 946684851.224975, -------------- Report Sync ------------
Event: time 946684851.318756, -------------- Report Sync ------------
Event: time 946684851.412475, -------------- Report Sync ------------
Event: time 946684851.506256, -------------- Report Sync ------------
Event: time 946684851.599975, -------------- Report Sync ------------
Event: time 946684851.693756, -------------- Report Sync ------------
Event: time 946684851.787475, -------------- Report Sync ------------
Event: time 946684851.881256, -------------- Report Sync ------------
Event: time 946684851.974975, -------------- Report Sync ------------
Event: time 946684852.068756, -------------- Report Sync ------------
Event: time 946684852.162475, -------------- Report Sync ------------
Event: time 946684852.256195, type 3 (Absolute), code 45 (?), value 1
Event: time 946684852.256195, type 3 (Absolute), code 0 (X), value 1281
Event: time 946684852.256195, type 3 (Absolute), code 1 (Y), value 3074
Event: time 946684852.256195, type 3 (Absolute), code 28 (Tool Width), value
14
Event: time 946684852.256195, type 3 (Absolute), code 24 (Pressure), value
137
Event: time 946684852.256225, -------------- Report Sync ------------
Event: time 946684852.279663, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 946684852.279663, -------------- Report Sync ------------
Event: time 946684852.304260, type 3 (Absolute), code 45 (?), value 3
Event: time 946684852.304260, type 3 (Absolute), code 42 (?), value 5364
Event: time 946684852.304260, type 3 (Absolute), code 43 (?), value 923
Event: time 946684852.304260, type 3 (Absolute), code 44 (?), value 2846
Event: time 946684852.304290, type 3 (Absolute), code 28 (Tool Width), value
15
Event: time 946684852.304290, type 3 (Absolute), code 24 (Pressure), value
54
Event: time 946684852.304290, -------------- Report Sync ------------
Event: time 946684852.327728, type 3 (Absolute), code 43 (?), value 517
Event: time 946684852.327728, type 3 (Absolute), code 44 (?), value 2827
Event: time 946684852.327758, -------------- Report Sync ------------
Event: time 946684852.351135, type 3 (Absolute), code 43 (?), value 325
Event: time 946684852.351135, type 3 (Absolute), code 44 (?), value 2839
Event: time 946684852.351165, -------------- Report Sync ------------
Event: time 946684852.374603, type 3 (Absolute), code 43 (?), value 309
Event: time 946684852.374603, type 3 (Absolute), code 44 (?), value 2848
Event: time 946684852.374603, -------------- Report Sync ------------
Event: time 946684852.398040, type 3 (Absolute), code 43 (?), value 241
Event: time 946684852.398040, type 3 (Absolute), code 44 (?), value 2839
Event: time 946684852.398071, -------------- Report Sync ------------
Event: time 946684852.421386, type 3 (Absolute), code 43 (?), value 261
Event: time 946684852.421417, type 3 (Absolute), code 44 (?), value 2845
Event: time 946684852.421417, -------------- Report Sync ------------
Event: time 946684852.444885, type 3 (Absolute), code 43 (?), value 293
Event: time 946684852.444915, type 3 (Absolute), code 44 (?), value 2848
Event: time 946684852.444915, -------------- Report Sync ------------
Event: time 946684852.468322, type 3 (Absolute), code 43 (?), value 247
Event: time 946684852.468322, type 3 (Absolute), code 44 (?), value 2853
Event: time 946684852.468353, -------------- Report Sync ------------
Event: time 946684852.491760, type 3 (Absolute), code 43 (?), value 275
Event: time 946684852.491760, type 3 (Absolute), code 44 (?), value 2845
Event: time 946684852.491790, -------------- Report Sync ------------
Event: time 946684852.515197, type 3 (Absolute), code 43 (?), value 214
Event: time 946684852.515228, -------------- Report Sync ------------
Event: time 946684852.537506, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 946684852.537506, -------------- Report Sync ------------
Event: time 946684852.560943, -------------- Report Sync ------------
Event: time 946684852.584350, -------------- Report Sync ------------
Event: time 946684852.608947, type 3 (Absolute), code 45 (?), value 2
Event: time 946684852.608947, type 3 (Absolute), code 41 (?), value 277
Event: time 946684852.608947, type 3 (Absolute), code 42 (?), value 5265
Event: time 946684852.608947, type 3 (Absolute), code 43 (?), value 331
Event: time 946684852.608978, type 3 (Absolute), code 44 (?), value 2884
Event: time 946684852.608978, type 3 (Absolute), code 24 (Pressure), value
132
Event: time 946684852.608978, -------------- Report Sync ------------
Event: time 946684852.631195, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 946684852.631195, -------------- Report Sync ------------
Event: time 946684852.654663, type 3 (Absolute), code 45 (?), value 1
Event: time 946684852.654663, type 3 (Absolute), code 0 (X), value 295
Event: time 946684852.654663, type 3 (Absolute), code 1 (Y), value 2895
Event: time 946684852.654663, type 3 (Absolute), code 24 (Pressure), value
140
Event: time 946684852.654663, -------------- Report Sync ------------
Event: time 946684852.678100, type 3 (Absolute), code 0 (X), value 309
Event: time 946684852.678100, type 3 (Absolute), code 1 (Y), value 2899
Event: time 946684852.678131, type 3 (Absolute), code 28 (Tool Width), value
13
Event: time 946684852.678131, -------------- Report Sync ------------
Event: time 946684852.701538, type 3 (Absolute), code 0 (X), value 327
Event: time 946684852.701538, type 3 (Absolute), code 1 (Y), value 2901
Event: time 946684852.701538, type 3 (Absolute), code 28 (Tool Width), value
15
Event: time 946684852.701538, -------------- Report Sync ------------
Event: time 946684852.724975, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 946684852.724975, -------------- Report Sync ------------
Event: time 946684852.748443, -------------- Report Sync ------------
Event: time 946684852.771881, -------------- Report Sync ------------
Event: time 946684852.795288, -------------- Report Sync ------------
Event: time 946684852.818725, -------------- Report Sync ------------
Event: time 946684852.842102, -------------- Report Sync ------------
Event: time 946684852.865600, -------------- Report Sync ------------
Event: time 946684852.959350, -------------- Report Sync ------------
Event: time 946684853.053436, type 3 (Absolute), code 0 (X), value 1825
Event: time 946684853.053466, type 3 (Absolute), code 1 (Y), value 3334
Event: time 946684853.053466, type 3 (Absolute), code 28 (Tool Width), value
1
Event: time 946684853.053466, type 3 (Absolute), code 24 (Pressure), value
106
Event: time 946684853.053466, -------------- Report Sync ------------
Event: time 946684853.076538, type 3 (Absolute), code 0 (X), value 1828
Event: time 946684853.076538, type 3 (Absolute), code 1 (Y), value 3329
Event: time 946684853.076538, -------------- Report Sync ------------
Event: time 946684853.100006, type 3 (Absolute), code 0 (X), value 1833
Event: time 946684853.100006, type 3 (Absolute), code 1 (Y), value 3320
Event: time 946684853.100006, -------------- Report Sync ------------
Event: time 946684853.123413, type 3 (Absolute), code 0 (X), value 1826
Event: time 946684853.123413, type 3 (Absolute), code 1 (Y), value 3273
Event: time 946684853.123413, -------------- Report Sync ------------
Event: time 946684853.146850, type 3 (Absolute), code 0 (X), value 1785
Event: time 946684853.146850, type 3 (Absolute), code 1 (Y), value 3161
Event: time 946684853.146850, type 3 (Absolute), code 28 (Tool Width), value
5
Event: time 946684853.146850, -------------- Report Sync ------------
Event: time 946684853.170288, type 3 (Absolute), code 0 (X), value 1711
Event: time 946684853.170288, type 3 (Absolute), code 1 (Y), value 2856
Event: time 946684853.170288, type 3 (Absolute), code 28 (Tool Width), value
15
Event: time 946684853.170288, type 3 (Absolute), code 24 (Pressure), value
28
Event: time 946684853.170288, -------------- Report Sync ------------
Event: time 946684853.193725, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 946684853.193725, -------------- Report Sync ------------
Event: time 946684853.217132, -------------- Report Sync ------------
Event: time 946684853.240631, -------------- Report Sync ------------
Event: time 946684853.264038, -------------- Report Sync ------------
Event: time 946684853.287475, -------------- Report Sync ------------

It starts with some value and it retains the previous touch values even if i
remove my thumb.

I tried with same driver and same evtest.c in the latest git tree and
 there its working straight away.

Can any one suggest me a debugging solution.

-- 
Thanks,
keep smiling...
keep winning...

(: Naveen Krishna Ch :)

------=_Part_19843_19406422.1219852618747
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all, <br>I am porting a touchscreen driver from 2.6.23 to <a href="http://2.6.24.">2.6.24.</a> during porting.<br>I found issues with i2C2 of omap3EVM. <br><br>During kernel it detects the touchscreen and it will create a node also.<br>
<br>The issues are like when i run a touchscreen command line application test<br>The so called evtest.c<br><br>The test gives output even if i dont touch the screen<br>It will show the previous touched values like this. <br>
<br>The out put catch looks like<br><br>Event: time 946684851.131195, -------------- Report Sync ------------<br>Event: time 946684851.224975, -------------- Report Sync ------------<br>Event: time 946684851.318756, -------------- Report Sync ------------<br>
Event: time 946684851.412475, -------------- Report Sync ------------<br>Event: time 946684851.506256, -------------- Report Sync ------------<br>Event: time 946684851.599975, -------------- Report Sync ------------<br>Event: time 946684851.693756, -------------- Report Sync ------------<br>
Event: time 946684851.787475, -------------- Report Sync ------------<br>Event: time 946684851.881256, -------------- Report Sync ------------<br>Event: time 946684851.974975, -------------- Report Sync ------------<br>Event: time 946684852.068756, -------------- Report Sync ------------<br>
Event: time 946684852.162475, -------------- Report Sync ------------<br>Event: time 946684852.256195, type 3 (Absolute), code 45 (?), value 1<br>Event: time 946684852.256195, type 3 (Absolute), code 0 (X), value 1281<br>
Event: time 946684852.256195, type 3 (Absolute), code 1 (Y), value 3074<br>Event: time 946684852.256195, type 3 (Absolute), code 28 (Tool Width), value 14<br>Event: time 946684852.256195, type 3 (Absolute), code 24 (Pressure), value 137<br>
Event: time 946684852.256225, -------------- Report Sync ------------<br>Event: time 946684852.279663, type 3 (Absolute), code 24 (Pressure), value 0<br>Event: time 946684852.279663, -------------- Report Sync ------------<br>
Event: time 946684852.304260, type 3 (Absolute), code 45 (?), value 3<br>Event: time 946684852.304260, type 3 (Absolute), code 42 (?), value 5364<br>Event: time 946684852.304260, type 3 (Absolute), code 43 (?), value 923<br>
Event: time 946684852.304260, type 3 (Absolute), code 44 (?), value 2846<br>Event: time 946684852.304290, type 3 (Absolute), code 28 (Tool Width), value 15<br>Event: time 946684852.304290, type 3 (Absolute), code 24 (Pressure), value 54<br>
Event: time 946684852.304290, -------------- Report Sync ------------<br>Event: time 946684852.327728, type 3 (Absolute), code 43 (?), value 517<br>Event: time 946684852.327728, type 3 (Absolute), code 44 (?), value 2827<br>
Event: time 946684852.327758, -------------- Report Sync ------------<br>Event: time 946684852.351135, type 3 (Absolute), code 43 (?), value 325<br>Event: time 946684852.351135, type 3 (Absolute), code 44 (?), value 2839<br>
Event: time 946684852.351165, -------------- Report Sync ------------<br>Event: time 946684852.374603, type 3 (Absolute), code 43 (?), value 309<br>Event: time 946684852.374603, type 3 (Absolute), code 44 (?), value 2848<br>
Event: time 946684852.374603, -------------- Report Sync ------------<br>Event: time 946684852.398040, type 3 (Absolute), code 43 (?), value 241<br>Event: time 946684852.398040, type 3 (Absolute), code 44 (?), value 2839<br>
Event: time 946684852.398071, -------------- Report Sync ------------<br>Event: time 946684852.421386, type 3 (Absolute), code 43 (?), value 261<br>Event: time 946684852.421417, type 3 (Absolute), code 44 (?), value 2845<br>
Event: time 946684852.421417, -------------- Report Sync ------------<br>Event: time 946684852.444885, type 3 (Absolute), code 43 (?), value 293<br>Event: time 946684852.444915, type 3 (Absolute), code 44 (?), value 2848<br>
Event: time 946684852.444915, -------------- Report Sync ------------<br>Event: time 946684852.468322, type 3 (Absolute), code 43 (?), value 247<br>Event: time 946684852.468322, type 3 (Absolute), code 44 (?), value 2853<br>
Event: time 946684852.468353, -------------- Report Sync ------------<br>Event: time 946684852.491760, type 3 (Absolute), code 43 (?), value 275<br>Event: time 946684852.491760, type 3 (Absolute), code 44 (?), value 2845<br>
Event: time 946684852.491790, -------------- Report Sync ------------<br>Event: time 946684852.515197, type 3 (Absolute), code 43 (?), value 214<br>Event: time 946684852.515228, -------------- Report Sync ------------<br>
Event: time 946684852.537506, type 3 (Absolute), code 24 (Pressure), value 0<br>Event: time 946684852.537506, -------------- Report Sync ------------<br>Event: time 946684852.560943, -------------- Report Sync ------------<br>
Event: time 946684852.584350, -------------- Report Sync ------------<br>Event: time 946684852.608947, type 3 (Absolute), code 45 (?), value 2<br>Event: time 946684852.608947, type 3 (Absolute), code 41 (?), value 277<br>
Event: time 946684852.608947, type 3 (Absolute), code 42 (?), value 5265<br>Event: time 946684852.608947, type 3 (Absolute), code 43 (?), value 331<br>Event: time 946684852.608978, type 3 (Absolute), code 44 (?), value 2884<br>
Event: time 946684852.608978, type 3 (Absolute), code 24 (Pressure), value 132<br>Event: time 946684852.608978, -------------- Report Sync ------------<br>Event: time 946684852.631195, type 3 (Absolute), code 24 (Pressure), value 0<br>
Event: time 946684852.631195, -------------- Report Sync ------------<br>Event: time 946684852.654663, type 3 (Absolute), code 45 (?), value 1<br>Event: time 946684852.654663, type 3 (Absolute), code 0 (X), value 295<br>Event: time 946684852.654663, type 3 (Absolute), code 1 (Y), value 2895<br>
Event: time 946684852.654663, type 3 (Absolute), code 24 (Pressure), value 140<br>Event: time 946684852.654663, -------------- Report Sync ------------<br>Event: time 946684852.678100, type 3 (Absolute), code 0 (X), value 309<br>
Event: time 946684852.678100, type 3 (Absolute), code 1 (Y), value 2899<br>Event: time 946684852.678131, type 3 (Absolute), code 28 (Tool Width), value 13<br>Event: time 946684852.678131, -------------- Report Sync ------------<br>
Event: time 946684852.701538, type 3 (Absolute), code 0 (X), value 327<br>Event: time 946684852.701538, type 3 (Absolute), code 1 (Y), value 2901<br>Event: time 946684852.701538, type 3 (Absolute), code 28 (Tool Width), value 15<br>
Event: time 946684852.701538, -------------- Report Sync ------------<br>Event: time 946684852.724975, type 3 (Absolute), code 24 (Pressure), value 0<br>Event: time 946684852.724975, -------------- Report Sync ------------<br>
Event: time 946684852.748443, -------------- Report Sync ------------<br>Event: time 946684852.771881, -------------- Report Sync ------------<br>Event: time 946684852.795288, -------------- Report Sync ------------<br>Event: time 946684852.818725, -------------- Report Sync ------------<br>
Event: time 946684852.842102, -------------- Report Sync ------------<br>Event: time 946684852.865600, -------------- Report Sync ------------<br>Event: time 946684852.959350, -------------- Report Sync ------------<br>Event: time 946684853.053436, type 3 (Absolute), code 0 (X), value 1825<br>
Event: time 946684853.053466, type 3 (Absolute), code 1 (Y), value 3334<br>Event: time 946684853.053466, type 3 (Absolute), code 28 (Tool Width), value 1<br>Event: time 946684853.053466, type 3 (Absolute), code 24 (Pressure), value 106<br>
Event: time 946684853.053466, -------------- Report Sync ------------<br>Event: time 946684853.076538, type 3 (Absolute), code 0 (X), value 1828<br>Event: time 946684853.076538, type 3 (Absolute), code 1 (Y), value 3329<br>
Event: time 946684853.076538, -------------- Report Sync ------------<br>Event: time 946684853.100006, type 3 (Absolute), code 0 (X), value 1833<br>Event: time 946684853.100006, type 3 (Absolute), code 1 (Y), value 3320<br>
Event: time 946684853.100006, -------------- Report Sync ------------<br>Event: time 946684853.123413, type 3 (Absolute), code 0 (X), value 1826<br>Event: time 946684853.123413, type 3 (Absolute), code 1 (Y), value 3273<br>
Event: time 946684853.123413, -------------- Report Sync ------------<br>Event: time 946684853.146850, type 3 (Absolute), code 0 (X), value 1785<br>Event: time 946684853.146850, type 3 (Absolute), code 1 (Y), value 3161<br>
Event: time 946684853.146850, type 3 (Absolute), code 28 (Tool Width), value 5<br>Event: time 946684853.146850, -------------- Report Sync ------------<br>Event: time 946684853.170288, type 3 (Absolute), code 0 (X), value 1711<br>
Event: time 946684853.170288, type 3 (Absolute), code 1 (Y), value 2856<br>Event: time 946684853.170288, type 3 (Absolute), code 28 (Tool Width), value 15<br>Event: time 946684853.170288, type 3 (Absolute), code 24 (Pressure), value 28<br>
Event: time 946684853.170288, -------------- Report Sync ------------<br>Event: time 946684853.193725, type 3 (Absolute), code 24 (Pressure), value 0<br>Event: time 946684853.193725, -------------- Report Sync ------------<br>
Event: time 946684853.217132, -------------- Report Sync ------------<br>Event: time 946684853.240631, -------------- Report Sync ------------<br>Event: time 946684853.264038, -------------- Report Sync ------------<br>Event: time 946684853.287475, -------------- Report Sync ------------<br>
<br>It starts with some value and it retains the previous touch values even if i remove my thumb.<br><br>I tried with same driver and same evtest.c in the latest git tree and<br>&nbsp;there its working straight away. <br><br>Can any one suggest me a debugging solution.<br clear="all">
<br>-- <br>Thanks, <br>keep smiling...<br>keep winning...<br><br>(: Naveen Krishna Ch :)<br>
</div>

------=_Part_19843_19406422.1219852618747--


--===============8249522807731675928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8249522807731675928==--
