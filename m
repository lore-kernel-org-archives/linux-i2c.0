From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429
 SoC
Date: Thu, 22 Dec 2016 20:11:04 +0100
Message-ID: <20161222191103.vzmfhnrtrzw2ivwa@pengutronix.de>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49399 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941305AbcLVTLj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Dec 2016 14:11:39 -0500
Content-Disposition: inline
In-Reply-To: <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 22, 2016 at 02:35:02PM +0100, M'boumba Cedric Madianga wrote:
> @@ -337,6 +350,16 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			i2c1_pins_b: i2c1@0 {
> +				pins1 {
> +					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
> +					drive-open-drain;
> +				};
> +				pins2 {
> +					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
> +				};

the second doesn't need the open-drain property? Why?

> +			};
>  		};

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
