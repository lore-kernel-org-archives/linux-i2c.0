From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [EXT] Re: [RESEND v2] i2c: imx: support slave mode for imx I2C
 driver
Date: Mon, 28 Oct 2019 14:41:31 +0100
Message-ID: <20191028134131.5pq2vaqojx4gpfth@pengutronix.de>
References: <20191009101802.19309-1-biwen.li@nxp.com>
 <113865e9-e846-1079-6f58-7fddb245398c@pengutronix.de>
 <DB7PR04MB449066A02FB9FD0A795CFAFB8F650@DB7PR04MB4490.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB7PR04MB449066A02FB9FD0A795CFAFB8F650@DB7PR04MB4490.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Leo Li <leoyang.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jiafei Pan <jiafei.pan@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Oct 25, 2019 at 04:02:11AM +0000, Biwen Li wrote:
> > I'm trying to test you patch on i.MX6S RIoTBoard. So far I fail to get it
> > working with following setup:
> > 1. register i2c-gpio
> > 2. connect i2c-gpio SCL to i2c-imx SCL pin and i2c-gpio SDA to i2c-imx SDA
> > pin 3. run this command to register i2c slave eeprom on i2c-imx:
> > echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device
> > 4. run "i2cdetect 4" on i2c-gpio to detect eeprom on i2c-imx slave.
> > 
> > So far, nothing was detected and even irq counter of i2c-imx didn't
> > increased.
> > 
> > Do I'm missing some thing? Please, help me to test you patch.
> You not miss anything, but the i2c-gpio driver from upstream is not
> workable on imx(I have tested the i2c-gpio driver with oscilloscope
> on imx8mm-evk, I cannot get any signal from the i2c-gpio bus).

In general the GPIOs are known to work, so I wonder what the problem is.
If it relies on being able to read the state of an output it might help
to set the SION bit on the related pins.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
