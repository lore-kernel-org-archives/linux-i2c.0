From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 15 Dec 2016 20:33:07 +0100
Message-ID: <20161215193307.436sggu4zy4zezoe@pengutronix.de>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
 <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
 <CAOAejn0Ej90amOZUC2wGNBsTAZVmcqEaViV1-TeoaspiADBkkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52615 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752305AbcLOTdm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Dec 2016 14:33:42 -0500
Content-Disposition: inline
In-Reply-To: <CAOAejn0Ej90amOZUC2wGNBsTAZVmcqEaViV1-TeoaspiADBkkg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello Cedric,

On Thu, Dec 15, 2016 at 04:26:25PM +0100, M'boumba Cedric Madianga wrote:
> >> +static struct platform_driver stm32f4_i2c_driver = {
> >> +     .driver = {
> >> +             .name = "stm32f4-i2c",
> >> +             .of_match_table = stm32f4_i2c_match,
> >
> > Is this needed?
> Without of_match_table, I could not match an I2C device instance from
> DT with this driver.
> So maybe, there is a misunderstanding.
> Could you please clarify your question ?

I thought (but I could be wrong) that if the driver is called
"stm32f4-i2c", it is used to match "st,stm32f4-i2c" even without
.of_match_table. If this doesn't work, please disregard my question.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
