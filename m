From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 12 Jan 2017 17:17:47 +0100
Message-ID: <CAOAejn1MWjW5h+EvCtt3aLPAQfndro6PhLTZTRs95VTOfRBJxQ@mail.gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de> <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de> <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36121 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdALQRu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Jan 2017 11:17:50 -0500
In-Reply-To: <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

>>> > I don't understand scl_period =3D 1 =C2=B5s for Fast Mode. For a bus =
freqency
>>> > of 400 kHz we need low + high =3D 2.5 =C2=B5s. Is there a factor 10 m=
issing
>>> > somewhere?
>>>
>>> As CCR =3D SCL_period * I2C parent clk frequency with minimal freq =3D
>>> 2Mhz and SCL_period =3D 1 we have:
>>> CCR =3D 1 * 2Mhz =3D 2.
>>> But to compute, scl_low and scl_high in Fast mode, we have to do the
>>> following thing as Duty=3D1:
>>> scl_high =3D 9 * CCR * I2C parent clk period
>>> scl_low =3D 16 * CCR * I2C parent clk period
>>> In our example:
>>> scl_high =3D 9 * 2 * 0,0000005 =3D 0,000009 sec =3D 9 =C2=B5s
>>> scl_low =3D 16 * 2 * 0.0000005 =3D 0,000016 sec =3D 16 =C2=B5s
>>> So low + high =3D 27 =C2=B5s > 2,5 =C2=B5s
>>
>> For me 9 =C2=B5s + 16 =C2=B5s is 25 =C2=B5s, resulting in 40 kHz. That's=
 why I wondered
>> if there is a factor 10 missing somewhere.
>
> Hum ok. I am going to double-check what is wrong because when I check
> with the scope I always reach 400Khz for SCL.
> I will let you know.

There is one point I miss here that is described in the reference manual:
To reach the 400 kHz maximum I=C2=B2C fast mode clock, the I2C parent rate
must be a multiple of 10 MHz.
So, contrary to what we said in a previous thread, 400 kHz could not
be reached with low frequencies.
In that way, we could compute CCR with duty =3D 0 by default.
So, I find another formula very close to the first one I pushed in the
first version:

In fast mode, we compute CCR with duty =3D 0:
t_scl_high =3D CCR * I2C parent clk period
t_scl_low =3D 2 *CCR * I2C parent clk period
So, CCR =3D I2C parent rate / 400 kHz / 3

For example with parent rate =3D 40 MHz:
CCR =3D 40000000 / 400000 / 3 =3D 33.333333333 =3D 33
t_scl_high =3D 33 * (1 / 2000000) =3D 825 ns > 600 ns
t_scl_low =3D 2 * 16 * (1 / 2000000) =3D 1650 ns > 1300 ns

It seems ok now.

Best regards,

Cedric
