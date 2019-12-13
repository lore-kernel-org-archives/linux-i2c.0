From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [EXT] Re: [PATCH] i2c: imx: Defer probing if EDMA not available
Date: Fri, 13 Dec 2019 10:50:46 +0000
Message-ID: <20191213105046.GQ25745@shell.armlinux.org.uk>
References: <20191127071136.5240-1-peng.ma@nxp.com>
 <20191128100613.GI25745@shell.armlinux.org.uk>
 <VI1PR04MB4431CF7F051F9439C84F84FAED5A0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191211104347.GA25745@shell.armlinux.org.uk>
 <VI1PR04MB44313AA19A4F81BA1AD9BC5CED5A0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191211114230.GC25745@shell.armlinux.org.uk>
 <VI1PR04MB4431DF2E270FC45A6CC878A9ED550@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191212105857.GE25745@shell.armlinux.org.uk>
 <VI1PR04MB44318D7C92B6A29D04840B0DED540@VI1PR04MB4431.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44318D7C92B6A29D04840B0DED540@VI1PR04MB4431.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@rempel-privat.de" <linux@rempel-privat.de>, Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>, Bogdan Florin Vlad <bogdan.vlad@nxp.com>, BOUGH CHEN <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Fancy Fang <chen.fang@nxp.com>, Han Xu <han.xu@nxp.com>, Horia Geanta <horia.geanta@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Jun Li <jun.li@nxp.com>, Leo Zhang <leo.zhang@nxp.com>, Leonard Crestez <leonard.crestez@nxp>
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 13, 2019 at 10:33:51AM +0000, Peng Ma wrote:
> 
> 
> >-----Original Message-----
> >From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> >Sent: 2019年12月12日 18:59
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: shawnguo@kernel.org; s.hauer@pengutronix.de;
> >linux-kernel@vger.kernel.org; linux@rempel-privat.de; Abel Vesa
> ><abel.vesa@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Anson Huang
> ><anson.huang@nxp.com>; Bogdan Florin Vlad <bogdan.vlad@nxp.com>;
> >BOUGH CHEN <haibo.chen@nxp.com>; Clark Wang
> ><xiaoning.wang@nxp.com>; Daniel Baluta <daniel.baluta@nxp.com>; Fancy
> >Fang <chen.fang@nxp.com>; Han Xu <han.xu@nxp.com>; Horia Geanta
> ><horia.geanta@nxp.com>; Iuliana Prodan <iuliana.prodan@nxp.com>; Jacky
> >Bai <ping.bai@nxp.com>; Joakim Zhang <qiangqing.zhang@nxp.com>; Jun Li
> ><jun.li@nxp.com>; Leo Zhang <leo.zhang@nxp.com>; Leonard Crestez
> ><leonard.crestez@nxp.com>; Mircea Pop <mircea.pop@nxp.com>; Mirela
> >Rabulea <mirela.rabulea@nxp.com>; Peng Fan <peng.fan@nxp.com>; Peter
> >Chen <peter.chen@nxp.com>; Ranjani Vaidyanathan
> ><ranjani.vaidyanathan@nxp.com>; Robert Chiras <robert.chiras@nxp.com>;
> >Robin Gong <yibin.gong@nxp.com>; Shenwei Wang
> ><shenwei.wang@nxp.com>; Viorel Suman <viorel.suman@nxp.com>; Ying Liu
> ><victor.liu@nxp.com>; Zening Wang <zening.wang@nxp.com>;
> >kernel@pengutronix.de; festevam@gmail.com;
> >linux-arm-kernel@lists.infradead.org; linux-i2c@vger.kernel.org
> >Subject: Re: [EXT] Re: [PATCH] i2c: imx: Defer probing if EDMA not available
> >
> >Caution: EXT Email
> >
> >On Thu, Dec 12, 2019 at 03:09:32AM +0000, Peng Ma wrote:
> >> Hello Russell,
> >>
> >> Thanks very much for your strict guidance and comments.
> >> I realized it is hard to us that we want to i2c used edma when edma
> >> probe after i2c probe.
> >
> >I have no problem with that aim.  I'm just very concerned by the proposed
> >implementation, especially when it has already been proven to cause
> >regressions in the kernel. I seem to remember that the infinite loop caused
> >other issues, such as the system being unable to complete booting.
> >
> >> I look forward to discussing with you as below, if you like.
> >> Thanks.
> >>
> >> You say I could do this:
> >> "So, if you want to do this (and yes, I'd also encourage it to be
> >> conditional on EDMA being built-in, as I2C is commonly used as a way
> >> to get at RTCs, which are read before kernel modules can be loaded)
> >> then you MUST move
> >> i2c_imx_dma_request() before
> >> i2c_add_numbered_adapter() to avoid the infinite loop."
> >>
> >> Even if I do this, It's hard to avoid the infinite loop of i2c probe caused by
> >EDMA(build-in) initialization failure.
> >
> >It isn't clear what you mean here.
> >
> >If EDMA fails to probe (because fsl_edma_probe() returns an error other than
> >EPROBE_DEFER) then of_dma_find_controller() will return NULL. That will be
> >propagated down through i2c_imx_dma_request(). This is no different from the
> >case where EDMA is built as a module. It is also no different from the case
> >where EDMA hasn't yet been probed.
> >
> Hello Russell,
> 
> The result of my test is not like that, It is still with probe loop, the test config as follows:

So you haven't tested the scenario that causes the problem.  How
convenient for you.

> 1.EDMA build-in
> 2.return -EINVAL top of fsl_edma_probe when edma probe
> 3.i2c probe with original patch, I put the i2c_imx_dma_request in front of i2c_add_numbered_adapter or used original patch.
> 
> I send you the function of_dma_request_slave_channel could explain it last mail,
> "Return -EPROBE_DEFER" depends on:
> 1. edma not probe or probe failed
> 2. There is edma node in DTS and I2C with edma property

Correct.

I'm sorry, but my patience is wearing very thin. I've explained the
problem in detail, I've explained how you can reproduce it, but it
seems I'm not being listened to. So, I don't have anything further to
add to this discussion that hasn't already been said.

Consider any patch that adds *any* path that can return -EPROBE_DEFER
after a successful call to i2c_add_numbered_adapter() or its similar
functions to be NAK'd by myself on account of this infinite probe loop
that has been proven in previous kernels to occur.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
