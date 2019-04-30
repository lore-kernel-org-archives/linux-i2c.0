From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] i2c: imx: I2C Driver doesn't consider I2C_IPGCLK_SEL
 RCW bit when using ls1046a SoC
Date: Tue, 30 Apr 2019 14:50:43 +0200
Message-ID: <20190430125043.weqwzim4gpsvtkfe@pengutronix.de>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430044719.30720-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuanhua Han <chuanhua.han@nxp.com>
Cc: shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com, wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de, eha@deif.com, linux@rempel-privat.de, l.stach@pengutronix.de, peda@axentia.se, sumit.batra@nxp.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 30, 2019 at 12:47:18PM +0800, Chuanhua Han wrote:
> The current kernel driver does not consider I2C_IPGCLK_SEL (424 bit
> of RCW) in deciding  i2c_clk_rate in function i2c_imx_set_clk()
> { 0 Platform clock/4, 1 Platform clock/2}.
> 
> When using ls1046a SoC, this populates incorrect value in IBFD register
> if I2C_IPGCLK_SEL = 0, which generates half of the desired Clock.
> 
> Therefore, if ls1046a SoC is used, we need to set the i2c clock
> according to the corresponding RCW.

So the clock driver reports the wrong clock. Please fix the clock driver
then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
