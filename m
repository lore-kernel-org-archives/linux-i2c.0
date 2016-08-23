From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v10 3/8] i2c: thunderx: Add i2c driver for ThunderX SOC
Date: Tue, 23 Aug 2016 23:22:09 +0200
Message-ID: <20160823212209.GB28936@hardcore>
References: <cover.1465997603.git.jglauber@cavium.com>
 <1ead8831e4dd879d452e8bc1a2a33ccba3a74b3d.1465997604.git.jglauber@cavium.com>
 <20160823203628.GB20872@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:34112
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755008AbcHWV5g (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 Aug 2016 17:57:36 -0400
Content-Disposition: inline
In-Reply-To: <20160823203628.GB20872@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com

On Tue, Aug 23, 2016 at 10:36:29PM +0200, Wolfram Sang wrote:
> 
> >  i2c-octeon-objs := i2c-cavium.o i2c-octeon-core.o
> >  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
> > +i2c-thunderx-objs := i2c-cavium.o i2c-thunderx-core.o
> > +obj-$(CONFIG_I2C_THUNDERX)	+= i2c-thunderx.o
> 
> Shouldn't that rather be "i2c-cavium-core.o", "i2c-octeon-platdrv.o",
> and "i2c-thunderx-pcidrv.o" for the -objs? I mean, the cavium part is
> the core-part...
> 
> > +skip:
> > +	if (!i2c->sys_freq)
> > +		i2c->sys_freq = SYS_FREQ_DEFAULT;
> > +
> > +	dev_info(dev, "Set system clock to %u\n", i2c->sys_freq);
> 
> Too many dev_info IMO, see later.

OK. I was working on an update where I dropped most of the messages.

> > +	i2c->adap.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> 
> Do you really need that?

Not sure, just copy'n paste from what most of the other bus drivers do.
Looking at i2c-core.c it might be a legacy thing, so I can probably
remove it.

> > +	ret = i2c_add_adapter(&i2c->adap);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add i2c adapter\n");
> 
> I2C core does error reporting for you meanwhile.

OK.

> > +		goto out_irq;
> > +	}
> > +
> > +	dev_info(i2c->dev, "probed\n");
> 
> I'd think all nice to know dev_info should go here in condensed form.
> 
> > +out_irq:
> > +	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);
> 
> If you need to free irq manually here anyhow, then you don't need the
> devm variant.

Yes. I paid attention to the devm documentation in the meantime and
switched all probing to the managed fucntions and got rid of the goto's
completely.

> > +out_msix:
> > +	pci_disable_msix(pdev);
> > +out_unmap:
> > +	iounmap(i2c->twsi_base);
> > +	thunder_i2c_clock_disable(dev, i2c->clk);
> > +out_release_regions:
> > +	pci_release_regions(pdev);
> > +out_disable_device:
> > +	pci_disable_device(pdev);
> > +out_free_i2c:
> > +	pci_set_drvdata(pdev, NULL);
> 
> Similar to devm_*, there is also pcim_* for PCI devices. You might want
> to have a look for those.

See above.

> > +	devm_kfree(dev, i2c);
> 
> Not needed.

Yes.

> > +	return ret;
> > +}
> > +
> > +static void thunder_i2c_remove_pci(struct pci_dev *pdev)
> > +{
> > +	struct octeon_i2c *i2c = pci_get_drvdata(pdev);
> > +	struct device *dev;
> > +
> > +	if (!i2c)
> > +		return;
> 
> How should that happen?

Just a safety net, can be removed.

> > +
> > +module_pci_driver(thunder_i2c_pci_driver);
> > +
> > +MODULE_LICENSE("GPL");
> 
> Please add a minimal GPL header at the top of the file, so it is clear
> if you mean "v2" or "v2 or later".

OK.

> > +MODULE_AUTHOR("Fred Martin <fmartin@caviumnetworks.com>");
> > +MODULE_DESCRIPTION("I2C-Bus adapter for Cavium ThunderX SOC");
> > -- 
> > 1.9.1
> > 
