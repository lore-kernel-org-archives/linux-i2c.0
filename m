From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
Date: Mon, 18 Apr 2016 21:15:46 +0800
Message-ID: <5714DE02.3040304@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana> <5710DA28.6010104@rock-chips.com>
 <20160415175846.GA1533@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:56818 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbcDRNPt (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Apr 2016 09:15:49 -0400
In-Reply-To: <20160415175846.GA1533@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: heiko@sntech.de, dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <wdc@rock-chips.com>

Hi Wolfram=EF=BC=8C

=E5=9C=A8 2016/4/16 1:58, Wolfram Sang =E5=86=99=E9=81=93:
>> The default frequency rate of function clock is 50M Hz, it can match
>> F/S mode, but HS mode not. If use default rate 50M to get 1.7M
>> scl-frequency rate , we could not get accurately 1.7M frequecy rate.
>> The input-clk-rate is more higher, we get more accurately
>> scl-frequency rate,  as 200M is a suitable input-clk-rate.
>>
>> If 200M was used for F/S mode, it would increase power consumption, =
so
>> add a option that could be configured from DT.
> If I understand you correctly, couldn't you use clk_set_rate() depend=
ing
> on the desired scl frequency which is already described in DT as
> clock-frequency?

Yeap, the default input clock rate is too low for HS mode, and it 's=20
flexible that
we get it from DT.
