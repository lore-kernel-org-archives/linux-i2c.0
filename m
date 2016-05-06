From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v7 2/9] i2c: rk3x: use struct "rk3x_i2c_calced_timings"
Date: Fri, 6 May 2016 10:19:13 +0800
Message-ID: <572BFF21.6060500@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462371194-5809-3-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=WAbedAB78shifxwjmZ-od8rhOiNz80rpdqfwzRsdX6WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:58965 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbcEFCS7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 22:18:59 -0400
In-Reply-To: <CAD=FV=WAbedAB78shifxwjmZ-od8rhOiNz80rpdqfwzRsdX6WQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug,

=E5=9C=A8 2016/5/6 6:55, Doug Anderson =E5=86=99=E9=81=93:
> David,
>
> On Wed, May 4, 2016 at 7:13 AM, David Wu <david.wu@rock-chips.com> wr=
ote:
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>
> Usually folks like a description and not just a subject line.  I'd ad=
d
> a description like:
>
> The "div_high" and "div_low" values are always used together.  Group =
them
> into a structure to make it easier to pass them both around.  This
> structure also provides a place for future calculated timings.
>

Okay, i will add it in next version, thanks.

>> ---
>> Change in v7:
>> - none
>>
>>   drivers/i2c/busses/i2c-rk3x.c | 55 +++++++++++++++++++++++++------=
------------
>>   1 file changed, 32 insertions(+), 23 deletions(-)
>
> Other than the description, I think this looks fine.
>
> IMHO this can be applied any time independent of any earlier patches.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
>
>
