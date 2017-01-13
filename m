From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Fri, 13 Jan 2017 10:36:01 +0100
Message-ID: <CAOAejn0c+G7LeZS-_Yq3yM=Y7LG=_vr+0-UYqmCZTyM1q4GmRA@mail.gmail.com>
References: <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de> <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
 <20170112174902.j52foglkdouyz36n@pengutronix.de> <CAOAejn3tPi0fjy+t-UhMTvAq7LfdKJJdbcLw2su1-YAGDZMxew@mail.gmail.com>
 <20170112211004.z3wylc7vrubulc3x@pengutronix.de> <CAOAejn1HAU5spQeXmYPH4XH0L5bGuoFgguozwMp=uLKcXDEPEw@mail.gmail.com>
 <20170113072650.orx6vl2orqfakcuk@pengutronix.de> <20170113082903.GA1446@katana>
 <20170113084513.wvuxkanrlmgz3ang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34560 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdAMJgE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Jan 2017 04:36:04 -0500
In-Reply-To: <20170113084513.wvuxkanrlmgz3ang@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Ok so I am going to send the v9 asap.
Thanks

2017-01-13 9:45 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutroni=
x.de>:
> On Fri, Jan 13, 2017 at 09:29:03AM +0100, Wolfram Sang wrote:
>>
>> > (But note that this is irrelevant for the patch as the driver doesn't
>> > claim to support this kind of transfer.)
>>
>> Yes, I wanted to mention that, too.
>>
>> I'd think the series is good to go in?
>
> AFAICT there are some unaddressed comments that Cedrics claimed to fix
> before our discussion was dominated by block transfers.
>
> Best regards
> Uwe
>
>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
