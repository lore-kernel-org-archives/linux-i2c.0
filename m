From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [EXT] Re: [PATCH] i2c: imx: Defer probing if EDMA not available
Date: Wed, 11 Dec 2019 10:43:47 +0000
Message-ID: <20191211104347.GA25745@shell.armlinux.org.uk>
References: <20191127071136.5240-1-peng.ma@nxp.com>
 <20191128100613.GI25745@shell.armlinux.org.uk>
 <VI1PR04MB4431CF7F051F9439C84F84FAED5A0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4431CF7F051F9439C84F84FAED5A0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@rempel-privat.de" <linux@rempel-privat.de>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 11, 2019 at 10:25:26AM +0000, Peng Ma wrote:
> Hi Russell,
> 
> I am sorry to reply late, thanks for your patient reminding,
> Please see my comments inline.
> 
> Best Regards,
> Peng
> >-----Original Message-----
> >From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> >Sent: 2019年11月28日 18:06
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: linux@rempel-privat.de; kernel@pengutronix.de; shawnguo@kernel.org;
> >s.hauer@pengutronix.de; linux-kernel@vger.kernel.org; dl-linux-imx
> ><linux-imx@nxp.com>; festevam@gmail.com;
> >linux-arm-kernel@lists.infradead.org; linux-i2c@vger.kernel.org
> >Subject: [EXT] Re: [PATCH] i2c: imx: Defer probing if EDMA not available
> >
> >Caution: EXT Email
> >
> >On Wed, Nov 27, 2019 at 07:12:09AM +0000, Peng Ma wrote:
> >> EDMA may be not available or defered due to dependencies on other
> >> modules, If these scenarios is encountered, we should defer probing.
> >
> >This has been tried before in this form, and it causes regressions.
> >
> >> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> >> ---
> >>  drivers/i2c/busses/i2c-imx.c | 16 +++++++++++-----
> >>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-imx.c
> >> b/drivers/i2c/busses/i2c-imx.c index 40111a3..c2b0693 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -369,8 +369,8 @@ static void i2c_imx_reset_regs(struct
> >> imx_i2c_struct *i2c_imx)  }
> >>
> >>  /* Functions for DMA support */
> >> -static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> >> -                                             dma_addr_t
> >phy_addr)
> >> +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> >> +                            dma_addr_t phy_addr)
> >>  {
> >>       struct imx_i2c_dma *dma;
> >>       struct dma_slave_config dma_sconfig; @@ -379,7 +379,7 @@ static
> >> void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> >>
> >>       dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
> >>       if (!dma)
> >> -             return;
> >> +             return -ENOMEM;
> >>
> >>       dma->chan_tx = dma_request_chan(dev, "tx");
> >>       if (IS_ERR(dma->chan_tx)) {
> >> @@ -424,7 +424,7 @@ static void i2c_imx_dma_request(struct
> >imx_i2c_struct *i2c_imx,
> >>       dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
> >>               dma_chan_name(dma->chan_tx),
> >> dma_chan_name(dma->chan_rx));
> >>
> >> -     return;
> >> +     return 0;
> >>
> >>  fail_rx:
> >>       dma_release_channel(dma->chan_rx);
> >> @@ -432,6 +432,8 @@ static void i2c_imx_dma_request(struct
> >imx_i2c_struct *i2c_imx,
> >>       dma_release_channel(dma->chan_tx);
> >>  fail_al:
> >>       devm_kfree(dev, dma);
> >> +
> >> +     return ret;
> >
> >Some platforms don't have EDMA.  Doesn't this force everyone who wants
> >I2C to have DMA?  The last attempt at this had:
> >
> >        /* return successfully if there is no dma support */
> >        return ret == -ENODEV ? 0 : ret;
> >
> >here because of exactly this.
> >
> >>  }
> >>
> >>  static void i2c_imx_dma_callback(void *arg) @@ -1605,10 +1607,14 @@
> >> static int i2c_imx_probe(struct platform_device *pdev)
> >>       dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> >>
> >>       /* Init DMA config if supported */
> >> -     i2c_imx_dma_request(i2c_imx, phy_addr);
> >> +     ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> >> +     if (ret == -EPROBE_DEFER)
> >> +             goto i2c_adapter_remove;
> >
> >This happens _after_ the adapter has been published to the rest of the kernel.
> >Claiming resources after publication is racy - the adapter may be in use by a
> >request at this point.  Secondly, there's been problems with this causing
> >regressions when EDMA is built as a module and i2c-imx is built-in.
> >
> >See e8c220fac415 ("Revert "i2c: imx: improve the error handling in
> >i2c_imx_dma_request()"") when exactly what you're proposing was tried and
> >ended up having to be reverted.
> >
> >AFAIK nothing has changed since, so merely reinstating the known to be broken
> >code, thereby reintroducing the same (and more) problems, isn't going to be
> >acceptable.
> >
> >Sorry, but this gets a big NAK from me.
> >
> [Peng Ma] I saw the revert commit e8c220fac415 and understand your concerns.
> I scan the i2c-imx.c driver, All platforms that use i2c driver and support dma use an eDMA engine,
> So I change the code(compare with last patch) as follows, please review and give me your precious comments.
> Thanks very much.
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 12f7934fddb4..6cafee52dd67 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1605,8 +1605,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  
>         /* Init DMA config if supported */
>         ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> -       if (ret == -EPROBE_DEFER)
> +       if (ret == -EPROBE_DEFER) {
> +#if    IS_BUILTIN(CONFIG_FSL_EDMA)
>                 goto i2c_adapter_remove;
> +#endif
> +       }

You haven't understood _why_ the problem occurs, you're just attempting
to patch around it. You're hacking the code, rather than engineering
the code.

The infinite deferred probe occurs because:

- i2c-imx is attempted to be probed.
- i2c-imx sets up the hardware, and then calls
  i2c_add_numbered_adapter()
- i2c_add_numbered_adapter() publishes the bus to the world, and then
  searches DT for any children to create - and it finds some and
  creates them.
- the children devices are matched to their drivers, which bind.  This
  triggers a deferred probe to be scheduled.
- back in the i2c-imx driver, we get to i2c_imx_dma_request(), which
  fails, and you return -EPROBE_DEFER.
- the i2c-imx driver probe actions are unwound, and probe exits.
- the driver core processes the deferred probe request, finds the 
  i2c-imx device(s) on the deferred probe list, and attempts to
  probe them.  Goto the top of this list.

If, for whatever reason, i2c_imx_dma_request() ever returns
-EPROBE_DEFER, the above loop WILL happen.
  
The FUNDAMENTAL rule of kernel programming is that you do NOT publish
before you have completed setup.  i2c-imx violates that rule as the
probe function is ordered at present.

i2c-imx has been written for i2c_imx_dma_request() to be safe to call
after the device has been published, but with the current probe function
order, it is unsafe to propagate the EPROBE_DEFER return value for the
reason above.  For the reason the original attempt got reverted.

So, if you want to do this (and yes, I'd also encourage it to be
conditional on EDMA being built-in, as I2C is commonly used as a way
to get at RTCs, which are read before kernel modules can be loaded)
then you MUST move i2c_imx_dma_request() before
i2c_add_numbered_adapter() to avoid the infinite loop.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
