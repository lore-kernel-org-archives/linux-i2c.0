From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH 1/2] i2c: imx: I2C Driver doesn't consider
 I2C_IPGCLK_SEL RCW bit when using ls1046a SoC
Date: Thu, 9 May 2019 09:48:51 +0200
Message-ID: <20190509074851.czcjlpfm2iooqjv4@pengutronix.de>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
 <20190430125043.weqwzim4gpsvtkfe@pengutronix.de>
 <AM6PR04MB43571B8D52C1FE9ED20DBA1D97360@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20190506073735.ctzybytamu44pbvv@pengutronix.de>
 <AM0PR04MB43534A9B1A146DEFA929844C97320@AM0PR04MB4353.eurprd04.prod.outlook.com>
 <AM6PR04MB4629DEDAAA6559EBBD20E974EF330@AM6PR04MB4629.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4629DEDAAA6559EBBD20E974EF330@AM6PR04MB4629.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sumit Batra <sumit.batra@nxp.com>
Cc: Chuanhua Han <chuanhua.han@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "eha@deif.com" <eha@deif.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, l.stach@pe
List-Id: linux-i2c@vger.kernel.org

On Thu, May 09, 2019 at 04:35:33AM +0000, Sumit Batra wrote:
> > > > So the clock driver reports the wrong clock. Please fix the clock driver then.
> > > No, this is a problem with the i2c driver. It is not a problem with 
> > > the clock driver, so the i2c driver needs to be modified.
> > 
> > So how does this RCW bit get evaluated? 
> According to the reference manual
> > only one clock goes to the i2c module (described as 1/2 Platform
> > Clock) and the i2c module only takes one clock. So it seems there must 
> > be a /2 divider somewhere, either in each i2c module or somewhere 
> > outside. Can your IC guys tell you where it is?
> I need to confirm this with the IC team

[Reformated a bit to make it readable]:

> There are 2 places where clock division takes place -
> 
> 1) There is a clock divider outside of I2C block, which makes the clock reaching
>    I2C module as - Platform Clock/2
> 2) There is another clock divider which specifically divides the clock to the I2C block,
>    based on RCW bit 424 (if 424th bit is 0 then the baud clock source is Platform Clock/4,
>    if 424th bit is 1 then it remains Platform Clock/2)

So there is a clock divider which based on RCW bit 424 divides the clock
*to* the i2c module. This suggests the divider is outside of the i2c
module itself and thus part of the clock module.

We could argue that this divider sits between the clock module and the
i2c module, but for sure it's not in the i2c module. I really suggest to
put this SoC specific into the SoC specific clock driver rather than
littering the i2c driver with it.

Sascha

> 
> Now based on the what is the desired SCL value (100KHz etc) and the clock which is
> received by I2C block, there is a calculation that goes on inside the I2C driver
> module which is used to map a value in this imx_i2c_clk_div table. This value is used
> to program the IMX_I2C_IFDR register of the I2C block. Now if we don't consider the
> RCW bit 424 in our I2C driver calculation then the IMX_I2C_IFDR value that gets set
> makes SCL half of what is desired by the user. This is because if you make the RCW
> 424th bit as 0 then anyhow I2C block (hardware) will receive Platform Clock/4, but
> the driver (since it has not considered this bit) will consider it as Platform Clock/2
> so it'll program a bigger divider from the imx_i2c_clk_div table

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
