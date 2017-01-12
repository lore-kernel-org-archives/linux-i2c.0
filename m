From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 12 Jan 2017 12:25:31 +0100
Message-ID: <CAOAejn1OfcHpj7s4VOrv3wHEBGuShXzJcu3OEgwi8k3_HAjqvQ@mail.gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de> <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <CAOAejn2cDzPgqvWZf7ASvtST+aDeaAebf=1aMWA9Zd8CDg4pmA@mail.gmail.com> <20170111154200.xcxdlnnakyttumzw@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170111154200.xcxdlnnakyttumzw@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

2017-01-11 16:42 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> Hello Cedric,
>
> On Wed, Jan 11, 2017 at 03:20:41PM +0100, M'boumba Cedric Madianga wrote:
>> >
>> >> +              */
>> >> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
>> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
>> >
>> > You could get rid of this, when caching the value of CR1. Would save t=
wo
>> > register reads here. This doesn't work for all registers, but it shoul=
d
>> > be possible to apply for most of them, maybe enough to get rid of the
>> > clr_bits and set_bits function.
>>
>> I agree at many places I could save registers read by not using
>> clr_bits and set_bits function when the registers in question has been
>> already read.
>> But it is not enough to get rid of the clr_bits and set_bits function.
>> For example when calling stm32f4_i2c_terminate_xfer(), the CR1
>> register is never read before so set_bits function is useful.
>
> I didn't double check the manual, but I would expect that CR1 isn't
> modified by hardware. So you can cache the result in the driver data
> structure and do the necessary modifications with that one.

CR1 is modified by hardware to clear some bits set by software during
the communication.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|

Best regards,

Cedric
