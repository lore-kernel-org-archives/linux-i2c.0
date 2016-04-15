From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
Date: Fri, 15 Apr 2016 20:12:03 +0800
Message-ID: <5710DA93.1020708@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana> <2530516.Iqqf6HUmr5@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:54894 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcDOMME (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Apr 2016 08:12:04 -0400
In-Reply-To: <2530516.Iqqf6HUmr5@diego>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <wdc@rock-chips.com>

Hi Heiko,

=E5=9C=A8 2016/4/15 15:31, Heiko St=C3=BCbner =E5=86=99=E9=81=93:
> David,
>
> Am Donnerstag, 14. April 2016, 20:48:48 schrieb Wolfram Sang:
>>> + - input-clk-rate : frequency rate of function clock used(in Hz). =
If
>>> omitted, +	the default clock rate is used. It is just used at rk339=
9 soc.
>> Why is this needed? Why don't we simply use the default or calculate=
 the
>> best value somehow?
> if you need to _get_ the clock-rate, clk_get_rate is the abvious choi=
ce and if
> you need to _set_ some specific rate, I guess it should be done via t=
he
> assigned-clocks mechanism in the devicetree - see veyron dts files th=
at already
> do this for some other parts.

Okay, i will try it, thank you.

>
>
>
>
