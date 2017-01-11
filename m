From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Wed, 11 Jan 2017 16:42:00 +0100
Message-ID: <20170111154200.xcxdlnnakyttumzw@pengutronix.de>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <CAOAejn2cDzPgqvWZf7ASvtST+aDeaAebf=1aMWA9Zd8CDg4pmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOAejn2cDzPgqvWZf7ASvtST+aDeaAebf=1aMWA9Zd8CDg4pmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Cedric,

On Wed, Jan 11, 2017 at 03:20:41PM +0100, M'boumba Cedric Madianga wrote:
> >
> >> +              */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
> >
> > You could get rid of this, when caching the value of CR1. Would save two
> > register reads here. This doesn't work for all registers, but it should
> > be possible to apply for most of them, maybe enough to get rid of the
> > clr_bits and set_bits function.
> 
> I agree at many places I could save registers read by not using
> clr_bits and set_bits function when the registers in question has been
> already read.
> But it is not enough to get rid of the clr_bits and set_bits function.
> For example when calling stm32f4_i2c_terminate_xfer(), the CR1
> register is never read before so set_bits function is useful.

I didn't double check the manual, but I would expect that CR1 isn't
modified by hardware. So you can cache the result in the driver data
structure and do the necessary modifications with that one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
