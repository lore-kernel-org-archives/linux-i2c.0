From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
Date: Fri, 30 Dec 2016 10:07:01 +0100
Message-ID: <CACRpkdaNyL2iV+risLudW=O55w81-AuEZhMwRu9NLdXpnC2r1w@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
 <20161222191103.vzmfhnrtrzw2ivwa@pengutronix.de> <CAOAejn1zHMFNiGc-wVbbkC1-JFzG3sjnnUJogtCp9EeAkWsV5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOAejn1zHMFNiGc-wVbbkC1-JFzG3sjnnUJogtCp9EeAkWsV5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 23, 2016 at 2:09 PM, M'boumba Cedric Madianga
<cedric.madianga@gmail.com> wrote:
> 2016-12-22 20:11 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de>:
>> On Thu, Dec 22, 2016 at 02:35:02PM +0100, M'boumba Cedric Madianga wrote=
:
>>> @@ -337,6 +350,16 @@
>>>                                       slew-rate =3D <2>;
>>>                               };
>>>                       };
>>> +
>>> +                     i2c1_pins_b: i2c1@0 {
>>> +                             pins1 {
>>> +                                     pinmux =3D <STM32F429_PB9_FUNC_I2=
C1_SDA>;
>>> +                                     drive-open-drain;
>>> +                             };
>>> +                             pins2 {
>>> +                                     pinmux =3D <STM32F429_PB6_FUNC_I2=
C1_SCL>;
>>> +                             };
>>
>> the second doesn't need the open-drain property? Why?
>
> I thought that open-drain was only needed for SDA line.
> But after double-checking I2C specification, it seems that SDA and SCL
> lines need open-drain or open-collector to perform the wired-AND
> function.

I think I2C SDA/SCL must be open drain by definition.

It also requires pull-up resistors, I guess you have these mounted on the b=
oard
so you do not need pull-up from the pin controller?

Yours,
Linus Walleij
