From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [EXT] Re: [PATCH] i2c: imx: Defer probing if EDMA not available
Date: Thu, 12 Dec 2019 10:58:57 +0000
Message-ID: <20191212105857.GE25745@shell.armlinux.org.uk>
References: <20191127071136.5240-1-peng.ma@nxp.com>
 <20191128100613.GI25745@shell.armlinux.org.uk>
 <VI1PR04MB4431CF7F051F9439C84F84FAED5A0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191211104347.GA25745@shell.armlinux.org.uk>
 <VI1PR04MB44313AA19A4F81BA1AD9BC5CED5A0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191211114230.GC25745@shell.armlinux.org.uk>
 <VI1PR04MB4431DF2E270FC45A6CC878A9ED550@VI1PR04MB4431.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4431DF2E270FC45A6CC878A9ED550@VI1PR04MB4431.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@rempel-privat.de" <linux@rempel-privat.de>, Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>, Bogdan Florin Vlad <bogdan.vlad@nxp.com>, BOUGH CHEN <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Fancy Fang <chen.fang@nxp.com>, Han Xu <han.xu@nxp.com>, Horia Geanta <horia.geanta@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Jun Li <jun.li@nxp.com>, Leo Zhang <leo.zhang@nxp.com>, Leonard Crestez <leonard.crestez@nxp>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 12, 2019 at 03:09:32AM +0000, Peng Ma wrote:
> Hello Russell,
> 
> Thanks very much for your strict guidance and comments.
> I realized it is hard to us that we want to i2c used edma when edma
> probe after i2c probe.

I have no problem with that aim.  I'm just very concerned by the
proposed implementation, especially when it has already been proven
to cause regressions in the kernel. I seem to remember that the
infinite loop caused other issues, such as the system being unable
to complete booting.

> I look forward to discussing with you as below, if you like.
> Thanks.
> 
> You say I could do this:
> "So, if you want to do this (and yes, I'd also encourage it to be
> conditional on EDMA being built-in, as I2C is commonly used as a way
> to get at RTCs, which are read before kernel modules can be loaded)
> then you MUST move
> i2c_imx_dma_request() before
> i2c_add_numbered_adapter() to avoid the infinite loop."
> 
> Even if I do this, It's hard to avoid the infinite loop of i2c probe caused by EDMA(build-in) initialization failure.

It isn't clear what you mean here.

If EDMA fails to probe (because fsl_edma_probe() returns an error other
than EPROBE_DEFER) then of_dma_find_controller() will return NULL. That
will be propagated down through i2c_imx_dma_request(). This is no
different from the case where EDMA is built as a module. It is also no
different from the case where EDMA hasn't yet been probed.

If i2c_imx_dma_request() is placed after i2c_add_numbered_adapter(),
and EPROBE_DEFER is propagated out of i2c_imx_probe(), then _yes_, it
will cause an infinite loop, because you are replicating the exact
conditions that caused the attempt to propagate i2c_imx_dma_request()'s
return value to be reverted last time - which brought the kernel to a
grinding halt.

If i2c_imx_dma_request() is placed before i2c_add_numbered_adapter(),
then there is no infinite deferred probing loop - yes, i2c_imx_probe()
will be called as a result of other drivers successfully probing, and
each time it will return EPROBE_DEFER, but the _key_ point is that
the action of i2c_imx_probe() will not _self trigger_ the deferred
probing _and_ place itself onto the deferred probe list.

Please, rather than continuing to send emails arguing over this point,
investigate the stated issue with some practical tests:

1. Make i2c_imx_probe() propagate i2c_imx_dma_request()'s return value,
   as it did in the original patch.
2. Build i2c-imx into the kernel.
3. Build edma as a module.
4. Build and test boot the kernel and check what happens.
5. Move i2c_imx_dma_request() before i2c_add_numbered_adapter()
6. Build and test boot the resulting kernel and note any differences.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
