From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] drm: don't link DP aux i2c adapter to the hardware
 device node
Date: Mon, 05 Feb 2018 18:39:05 +0100
Message-ID: <1517852345.3175.17.camel@pengutronix.de>
References: <20170113173630.22138-1-l.stach@pengutronix.de>
         <20170123163347.GC2043@ulmo.ba.sec>
         <CAL_JsqKKywq3NdJO60SPWoE7+mR6CPwN3Dx62z6pyQYuEv4kSA@mail.gmail.com>
         <1491382352.2904.9.camel@pengutronix.de>
         <20170405120431.GA9162@ulmo.ba.sec> <20180205161130.GA3493@ulmo>
         <20180205173352.GA7159@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35605 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeBERjM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Feb 2018 12:39:12 -0500
In-Reply-To: <20180205173352.GA7159@ulmo>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Wolfram Sang <wsa@the-dreams.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-i2c@vger.kernel.org, patchwork-lst@pengutronix.de

Am Montag, den 05.02.2018, 18:33 +0100 schrieb Thierry Reding:
> On Mon, Feb 05, 2018 at 05:11:30PM +0100, Thierry Reding wrote:
> > On Wed, Apr 05, 2017 at 02:04:31PM +0200, Thierry Reding wrote:
> > > On Wed, Apr 05, 2017 at 10:52:32AM +0200, Lucas Stach wrote:
> > > > Hi Rob,
> > > > 
> > > > Am Mittwoch, den 29.03.2017, 08:56 -0500 schrieb Rob Herring:
> > > > > On Mon, Jan 23, 2017 at 10:33 AM, Thierry Reding
> > > > > > > > > > <thierry.reding@gmail.com> wrote:
> > > > > > On Fri, Jan 13, 2017 at 06:36:30PM +0100, Lucas Stach wrote:
> > > > > > > The i2c adapter on DP AUX is purely a software construct. Linking
> > > > > > > it to the device node of the parent device is wrong, as it leads to
> > > > > > > 2 devices sharing the same device node, which is bad practice, as
> > > > > > 
> > > > > > Who says that two devices can't share the same device node? It's done
> > > > > > all the time.
> > > > > 
> > > > > It's done *some of the time* and I would not consider it best practice.
> > > > > 
> > > > > > > well as the i2c trying to populate children of the i2c adapter by
> > > > > > > looking at the child device nodes of the parent device.
> > > > > > 
> > > > > > A set of patches landed in v4.9 to work around this issue in a better
> > > > > > way. See:
> > > > > > 
> > > > > >         98b00488459e dt-bindings: i2c: Add support for 'i2c-bus' subnode
> > > > > >         7e4c224abfe8 i2c: core: Add support for 'i2c-bus' subnode
> > > > > 
> > > > > What does this buy us? I don't see why this needs to be in DT either.
> > > > > Contrary to popular belief, DT is not the only way to instantiate
> > > > > devices, C code can still do it.
> > > > > 
> > > > > Also, if this one line removal has no side effects, then how was it
> > > > > even needed? We can always add it back if there's some argument for
> > > > > why it is needed.
> > > > 
> > > > Okay, so I take this as you mostly agreeing with the rationale of this
> > > > patch.
> > > 
> > > For some general background on this: I was originally using this for DP
> > > support on Tegra (though that ended up never getting merged because of a
> > > particularily frustrating episode of trying to get better link training
> > > support into the core helpers) and use it as a means to obtain the I2C
> > > controller used for DDC. On Tegra, and I suspect other devices as well,
> > > the DP AUX controller is separate from the encoder, so the idea was to
> > > link them together using a standard ddc-i2c-bus phandle.
> > > 
> > > I ended up not needing that because the encoder and DP AUX controller
> > > are so tightly linked on Tegra that I need direct access to the DP AUX
> > > anyway and can therefore directly get the I2C controller from that.
> > > 
> > > If there aren't any other users of this, I suppose we could simply
> > > remove the line. Should someone turn up in the future and require the
> > > I2C controller to be looked up from a phandle we could add it again,
> > > at which point we'd have to investigate again how to get rid of the
> > > errors.
> > > 
> > > Acked-by: Thierry Reding <treding@nvidia.com>
> > 
> > I'm going to have to retract that: I just noticed that this patch breaks
> > eDP for Venice2 (and presumably all Tegra124 Nyan boards as well, though
> > I don't have those to test with).
> > 
> > My description above isn't quite correct. For eDP device we do use the
> > ddc-i2c-bus property in DT to denote which I2C bus to use for probing
> > the EDID. So the reason why eDP now breaks is because the simple-panel
> > driver will look for the I2C adapter, not find a matching one and defer
> > probe (indefinitely).
> > 
> > A, perhaps nicer, alternative I found to make it work is the below
> > patch. Would that be more reasonable? Looping in Wolfram.
> > 
> > Thierry
> > --- >8 ---
> > diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> > index 8d474bb1dc15..f88527a61cd1 100644
> > --- a/drivers/i2c/i2c-core-of.c
> > +++ b/drivers/i2c/i2c-core-of.c
> > @@ -118,6 +118,14 @@ static int of_dev_node_match(struct device *dev, void *data)
> > > >  	return dev->of_node == data;
> >  }
> >  
> > +static int of_parent_node_match(struct device *dev, void *data)
> > +{
> > > > +	if (dev->parent)
> > > > +		return dev->parent->of_node == data;
> > +
> > > > +	return 0;
> > +}
> > +
> >  /* must call put_device() when done with returned i2c_client device */
> >  struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
> >  {
> > @@ -143,6 +151,9 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
> > > >  	struct i2c_adapter *adapter;
> >  
> > > >  	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
> > > > +	if (!dev)
> > > > +		dev = bus_find_device(&i2c_bus_type, NULL, node, of_parent_node_match);
> > +
> > > >  	if (!dev)
> > > >  		return NULL;
> >  
> 
> I'd like to point out that a lot of I2C bus drivers actually do the same
> thing as the DRM AUX helpers used to do:
> 
> 	$ git grep -n 'dev.of_node.*=' -- drivers/i2c/busses/
> > 	drivers/i2c/busses/i2c-altera.c:467:	idev->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-aspeed.c:882:	bus->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-at91.c:1120:	dev->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-axxia.c:561:	idev->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-bcm-iproc.c:489:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-bcm-kona.c:858:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-bcm2835.c:367:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-brcmstb.c:664:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-cadence.c:912:	id->adap.dev.of_node = pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-cbus-gpio.c:248:	adapter->dev.of_node	= pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-cpm.c:654:	cpm->adap.dev.of_node = of_node_get(ofdev->dev.of_node);
> > 	drivers/i2c/busses/i2c-cros-ec-tunnel.c:280:	bus->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-davinci.c:864:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-designware-platdrv.c:351:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-digicolor.c:337:	i2c->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-dln2.c:215:	dln2->adapter.dev.of_node = dev->of_node;
> > 	drivers/i2c/busses/i2c-efm32.c:332:	ddata->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-eg20t.c:791:		pch_adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-emev2.c:387:	priv->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-exynos5.c:743:	i2c->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-gpio.c:322:	adap->dev.of_node = np;
> > 	drivers/i2c/busses/i2c-hix5hd2.c:456:	priv->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-ibm_iic.c:748:	adap->dev.of_node = of_node_get(np);
> > 	drivers/i2c/busses/i2c-img-scb.c:1383:	i2c->adap.dev.of_node = node;
> > > 	drivers/i2c/busses/i2c-imx-lpi2c.c:583:	lpi2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-imx.c:1086:	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-jz4780.c:751:	i2c->adap.dev.of_node	= pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-lpc2k.c:432:	i2c->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-meson.c:423:	i2c->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-mpc.c:742:	i2c->adap.dev.of_node = of_node_get(op->dev.of_node);
> > 	drivers/i2c/busses/i2c-mt65xx.c:769:	i2c->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-mv64xxx.c:935:	drv_data->adapter.dev.of_node = pd->dev.of_node;
> > 	drivers/i2c/busses/i2c-mxs.c:867:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-nomadik.c:1033:	adap->dev.of_node = np;
> > 	drivers/i2c/busses/i2c-ocores.c:493:	i2c->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-octeon-platdrv.c:244:	i2c->adap.dev.of_node = node;
> > 	drivers/i2c/busses/i2c-omap.c:1457:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-opal.c:236:	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
> > 	drivers/i2c/busses/i2c-pca-platform.c:174:	i2c->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-pnx.c:643:	alg_data->adapter.dev.of_node = of_node_get(pdev->dev.of_node);
> > 	drivers/i2c/busses/i2c-powermac.c:435:	adapter->dev.of_node = NULL;
> > 	drivers/i2c/busses/i2c-powermac.c:447:	adapter->dev.of_node = dev->dev.of_node;
> > 	drivers/i2c/busses/i2c-pxa-pci.c:80:	pdev->dev.of_node = child;
> > 	drivers/i2c/busses/i2c-pxa.c:1313:	i2c->adap.dev.of_node = dev->dev.of_node;
> > 	drivers/i2c/busses/i2c-qup.c:1608:	qup->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-rcar.c:902:	adap->dev.of_node = dev->of_node;
> > 	drivers/i2c/busses/i2c-riic.c:440:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-rk3x.c:1220:	i2c->adap.dev.of_node = np;
> > 	drivers/i2c/busses/i2c-s3c2410.c:1210:	i2c->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-sh_mobile.c:942:	adap->dev.of_node = dev->dev.of_node;
> > 	drivers/i2c/busses/i2c-sirf.c:335:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-sprd.c:516:	i2c_dev->adap.dev.of_node = dev->of_node;
> > 	drivers/i2c/busses/i2c-st.c:871:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-stm32f4.c:843:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-stm32f7.c:918:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-stu300.c:918:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-sun6i-p2wi.c:278:	p2wi->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-tegra-bpmp.c:311:	i2c->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-tegra.c:1006:	i2c_dev->adapter.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-thunderx-pcidrv.c:210:	i2c->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-uniphier-f.c:538:	priv->adap.dev.of_node = dev->of_node;
> > 	drivers/i2c/busses/i2c-uniphier.c:385:	priv->adap.dev.of_node = dev->of_node;
> > 	drivers/i2c/busses/i2c-versatile.c:88:	i2c->adap.dev.of_node = dev->dev.of_node;
> > 	drivers/i2c/busses/i2c-wmt.c:424:	adap->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-xgene-slimpro.c:564:	adapter->dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-xiic.c:761:	i2c->adap.dev.of_node = pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-xlp9xx.c:434:	priv->adapter.dev.of_node = pdev->dev.of_node;
> > > 	drivers/i2c/busses/i2c-xlr.c:426:	priv->adap.dev.of_node	= pdev->dev.of_node;
> > 	drivers/i2c/busses/i2c-zx2967.c:573:	i2c->adap.dev.of_node = pdev->dev.of_node;
> 
> This is very much standard procedure, at least in I2C land. The above
> patch would allow us to remove all of the above and instead rely on
> matching on the parent device's ->of_node. The more I think about it,
> the more I'm convinced that that's actually the correct thing to do.
> i2c_adapter.dev.of_node should only be used to override the parent's
> device tree node.

I agree. Thinking about it a bit more your proposed patch is actually a
quite neat solution for the problem at hand and would allow us drop
this standard, yet bad, practice of i2c adapters sharing the device
node with their parent.

Regards,
Lucas
