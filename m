From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
Date: Fri, 15 Apr 2016 20:10:16 +0800
Message-ID: <5710DA28.6010104@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:51448 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbcDOMKW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Apr 2016 08:10:22 -0400
In-Reply-To: <20160414184848.GB2338@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: heiko@sntech.de, dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <wdc@rock-chips.com>

Hi Wolfram,

=E5=9C=A8 2016/4/15 2:48, Wolfram Sang =E5=86=99=E9=81=93:
>> + - input-clk-rate : frequency rate of function clock used(in Hz). I=
f omitted,
>> +	the default clock rate is used. It is just used at rk3399 soc.
> Why is this needed? Why don't we simply use the default or calculate =
the
> best value somehow?
The default frequency rate of function clock is 50M Hz, it can match F/=
S=20
mode,
but HS mode not. If use default rate 50M to get 1.7M scl-frequency rate=
=20
, we could not
get accurately 1.7M frequecy rate. The input-clk-rate is more higher, w=
e=20
get more
accurately scl-frequency rate,  as 200M is a suitable input-clk-rate.

If 200M was used for F/S mode, it would increase power consumption, so=20
add a option that
could be configured from DT.

>> + * @t_calc: Caculated rk3x private timings  that would
>> + * be written into regs
> double space
>
