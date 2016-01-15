From: "David.Wu" <wdc@rock-chips.com>
Subject: Re: [PATCH v3 3/4] i2c: rk3x: new method to calculate i2c clocks
Date: Fri, 15 Jan 2016 17:39:13 +0800
Message-ID: <5698BE41.30005@rock-chips.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
 <1452774699-57455-4-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=UXMzEQiKcMa7VjDx+arcbRo1e-0HPHBnG8GP7k6uFt1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:36217 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601AbcAOJjN (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Jan 2016 04:39:13 -0500
In-Reply-To: <CAD=FV=UXMzEQiKcMa7VjDx+arcbRo1e-0HPHBnG8GP7k6uFt1g@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, andy.shevchenko@gmail.com, Tao Huang <huangtao@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Lin Huang <hl@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug=EF=BC=8C

=E5=9C=A8 2016/1/15 0:12, Doug Anderson =E5=86=99=E9=81=93:
> Hi,
>
> On Thu, Jan 14, 2016 at 4:31 AM, David Wu <david.wu@rock-chips.com> w=
rote:
>> There was an timing issue about "repeated start" time at the I2C
>> controller of version0, controller appears to drop SDA at .875x (7/8=
)
>> programmed clk high. The rule(.875x) isn't enough to meet tSU;STA
>> requirements on 100k's Standard-mode. To resolve this issue,
>> data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
>> timing information are added, new rules are designed to calculate
>> the timing information at new v1.
> I'm curious: does new hardware behave differently and that's why you
> need v1?
Yes , i didn't describe clearly about difference between old and new.
Old and new hardware behave the same except some timing rules.

v0 is the same with the v1 for tHigh and tLow :
  tHigh =3D 8 * divh * pclk_cycle;
  tLow =3D 8 * divl * pclk_cycle;

v0 rules' difference:
     start setup=EF=BC=9A 7/8 * tHigh + 1 pclk cycle
     start hold :    2 * =EF=BC=887/8 * tHigh=EF=BC=89 - 1 pclk cycle
     stop setup :   7/8 * tHigh + 1 pclk cycle

     data setup:    1/2 tLow - 1 pclk cycle
     data hold :    1/2  tLow + 1  pclk cycle

=46or 100k's example:
     spec_min_low_ns =3D 4700;
     spec_min_high_ns =3D 4000;
     spec_min_setup_start_ns =3D 4700;

We could calculate the timing info by the rules of v0, and ignore effec=
t=20
of the pclk cycle here.
     tSU;sta >=3D4700;
     tHigh_min =3D tSU;sta * 8/7 >=3D 5372ns;
     tHigh_min  =3D max(tHigh_min, spec_min_high_ns) =3D 5372ns;

We get the final scl clk rate is 99k(1000000000 / (5372ns + 4700ns)), =20
it looks ok for the 100k
Standard mode. But the timing point of repeat start and low time is ver=
y=20
critical, it is dangerous
to some slave devices which are perhaps not so specified.
So need to give some time margin for them, that would increase the cycl=
e=20
time and reduce
the clk rate, the final rate we get may be 97k or 96k.

In fact, we must think about scl rise time and scl fall time, and get=20
final clk may be 93k or less.
After that, we get about 7 percent lost at clk rate, it would reduce th=
e=20
efficiency of i2c transfer.

In other words, we could say there is a timing issue about "repeat=20
start" time when we want
accurate 100k's rate, it is short to meet I2C spec requirements.
3.4M clk rate also has the same issue.

The start_setup count is added to fix this issue, tHigh is not need to=20
considered of "repeat start" time.
After divs calculated, the count would be calculated to meet i2c spec.
v1 rule:
start setup=EF=BC=9A tHigh + 1 pclk cycle
start hold:  [8h * (u + 1) - 1] * T;
  tSU;sto =3D (8h * p + 1) * T;
-----------------------------------------------------------------------=
----------------------------------------

The data_upd_st is added for the Data set-up time and Data hold time on=
=20
Highspeed mode.
=46or 1.7M's example on v0:
     tHD;DAT =3D 1/2 tLow=EF=BC=9B
     tHD;DAT <=3D spec_max_data_hold_ns =3D 150ns
     tLow <=3D 2 * tHD;DAT <=3D 300ns;
     tLow >=3D spec_min_low_ns =3D 320ns;
According to these, we could not get a value for tLow, need changes for=
=20
the rule: tHD;DAT =3D 1/2 tLow.

Cut the tLow into eight euqal parts=EF=BC=8Cthe range of data_upd_st is=
 1 ~ 7.
It seems that v1 rule could resolve the issue.
v1 rule:
     tHD;sda =3D n/8 * tLow;
     tSU;sda =3D [(8 - n)/8 * tLow;

3.4M clk rate also has the same issue.

>   ...or does old and new hardware behave the same and you're
> just introducing v1 so you don't mess with how old boards are working=
?
The registers of counts added would not effect old boards.
No matter what values of count was written in regs, that old i2c=20
controller didn't care,
it worked by original timing rule.

After picking this patch, pmic-rk818 and touchscreen-gt911 worked well=20
on the rk3368 sdk
board which use old method.

>
> >From the description it sounds as if the old code had problems as 10=
0k too...
>
> If the new controller is different, I'd probably reword like the
> following (you'd have to re-wordwrap):
>
> There was an timing issue about "repeated start" time at the I2C
> controller of version0, controller appears to drop SDA at .875x (7/8)
> programmed clk high. On version 1 of the controller, the rule(.875x)
> isn't enough to meet tSU;STA
> requirements on 100k's Standard-mode. To resolve this issue,
> data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
> timing information are added, new rules are designed to calculate
> the timing information at new v1.

There was an timing issue about "repeated start" time at the I2C
controller of version0, controller appears to drop SDA at .875x (7/8)
programmed clk high. On version 1 of the controller, the rule(.875x)
isn't enough to meet tSU;STA requirements on 100k's Standard-mode.

To resolve this issue,data_upd_st, start_setup_cnt and stop_setup_cnt
configs for I2C timing information are added, new rules are designed
to calculate the timing information at new v1.

> -Doug
>
>
>
