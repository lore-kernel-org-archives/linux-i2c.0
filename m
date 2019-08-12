From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [EXT] Re: i2c: imx: support slave mode for imx I2C driver
Date: Mon, 12 Aug 2019 04:22:03 +0000
Message-ID: <DB7PR04MB44909B080A8C8D53416F34058FD30@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190808035343.34120-1-biwen.li@nxp.com>
 <20190808200202.GA6609@ninjato>
 <VI1PR04MB4495EA1A44120654B494EB3D8FD60@VI1PR04MB4495.eurprd04.prod.outlook.com>
 <20190809151035.GB5099@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809151035.GB5099@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Leo Li <leoyang.li@nxp.com>
Cc: Joshua Frkuska <joshua_frkuska@mentor.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

> On Fri, Aug 09, 2019 at 03:18:01AM +0000, Biwen Li wrote:
> > > > The patch supports slave mode for imx I2C driver
> > > >
> > > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > >
> > > Wow, this is much simpler than the other approach flying around:
> > >
> > > http://patchwork.ozlabs.org/patch/1124048/
> > >
> > > Can this one be master and slave on the same bus, too?
> > At the same time, the same bus is in master mode or slave mode.
>=20
> So, can someone kindly point out the key differences to me?
The I2C module cannot be a master and a slave simultaneously.
Such as: if the i2c module is used in slave mode with command
'echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-0/new_device',
At the mean time, you cannot do master operations(i2cset/i2cget).=20
You can switch mode from slave to master with command 'echo 0x64
 > /sys/bus/i2c/devices/i2c-0/delete_device', then you can do master
operations.

Adding Leo to this version too.
