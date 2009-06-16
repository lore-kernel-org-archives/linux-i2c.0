From: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH, RFC] Freescale STMP: i2c driver
Date: Tue, 16 Jun 2009 20:25:39 +0400
Message-ID: <1245169539.32549.12.camel@hp.diimka.lan>
References: <1244059155.4074.19.camel@hp.diimka.lan>
	 <20090608225034.GA20446@fluff.org.uk>
Reply-To: dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090608225034.GA20446-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Ben,

I am sending the updated patch in next message, and this message is just
to answer your questions/concerns.\

[...]
> > +#include <mach/regs-apbx.h>
> > +
> > +static const u32 I2C_READ = 1,
> > +		 I2C_WRITE = 0;
> 
> do you really want to be defining things with a prefix of I2C, thatB
> might end up clashing with the i2c core?
Fixed, changed to I2C_SMBUS_READ/WRITE as Jean Delvare proposed.
> 
> > +static const struct stmp3xxx_dma_command cmd_i2c_select = {
> > +	.cmd =	BF(1, APBX_CHn_CMD_XFER_COUNT)	|
> > +		BF(1, APBX_CHn_CMD_CMDWORDS)	|
> > +		BM_APBX_CHn_CMD_WAIT4ENDCMD	|
> > +		BM_APBX_CHn_CMD_CHAIN		|
> > +		BF(BV_APBX_CHn_CMD_COMMAND__DMA_READ, APBX_CHn_CMD_COMMAND),
> 
> what is BF() ?
it is the macro from arch/arm/plat-stmp3xxx/include/mach/platform.h,
abbreviated "bitfield" :) For example, BF(1, APBX_CHn_CMD_CMDWORDS) is
expanded like 
((1 << BP_APBX_CHn_CMD_CMDWORDS) & BM_APBX_CHn_CMD_CMDWORDS).
BP_xxx stuff means bitfield position, BM_xxx - bitfield mask. 

>> +     dev->bufv = dma_alloc_coherent(dev->dev, PAGE_SIZE,
>> +                                    &dev->bufp, GFP_KERNEL);>
>> +     if (dma_mapping_error(dev->dev, dev->bufp))
>> +             goto out_dma;
> hmm, doesn't dma_alloc_coherent() fail with an NULL buffer return?
Fixed; but using dma_mapping_error seems to be more accurate method to
me. 0 might be valid dma address on some architecture. Again, for the
time being there is no difference to check dma_mapping_error or plain
compare with NULL...

[skipped]
> > +	adap = &dev->adapter;
> > +	i2c_set_adapdata(adap, dev);
> > +	adap->owner = THIS_MODULE;
> > +	adap->class = I2C_CLASS_HWMON;
> 
> is this the correct class?
Mmm.. I changed this to I2C_CLASS_TV_DIGITAL since the only I2C user is
digital radio daughterboard. Any objections?
> 
> > +	strncpy(adap->name, "378x I2C adapter", sizeof(adap->name));
> > +	adap->algo = &stmp378x_i2c_algo;
> > +	adap->dev.parent = &pdev->dev;
> > +
> > +	adap->nr = pdev->id;
> > +	err = i2c_add_numbered_adapter(adap);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to add adapter\n");
> > +		goto no_i2c_adapter;
> > +
> > +	}
> > +
> > +	return 0;
> > +
> > +no_i2c_adapter:
> > +	stmp378x_i2c_release(dev);
> > +init_failed:
> > +	free_irq(dev->irq, dev);
> > +no_err_irq:
> > +	iounmap(dev->io);
> > +nores:
> > +	kfree(dev);
> > +	return err;
> > +}
> > +
> > +static int __devexit
> > +stmp378x_i2c_remove(struct platform_device *pdev)
> > +{
> > +	struct stmp378x_i2c_dev	*dev = platform_get_drvdata(pdev);
> > +	int res;
> > +
> > +	res = i2c_del_adapter(&dev->adapter);
> > +	if (res)
> > +		return -EBUSY;
> > +
> > +	stmp378x_i2c_release(dev);
> > +
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	free_irq(dev->irq, dev);
> > +	iounmap(dev->io);
> > +
> > +	kfree(dev);
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver stmp378x_i2c_driver = {
> > +	.probe		= stmp378x_i2c_probe,
> > +	.remove		= __devexit_p(stmp378x_i2c_remove),
> > +	.driver		= {
> > +		.name	= "i2c_stmp",
> > +		.owner	= THIS_MODULE,
> > +	},
> > +};
> > +
> > +static int __init stmp378x_i2c_init_driver(void)
> > +{
> > +	return platform_driver_register(&stmp378x_i2c_driver);
> > +}
> > +module_init(stmp378x_i2c_init_driver);
> > +
> > +static void __exit stmp378x_i2c_exit_driver(void)
> > +{
> > +	platform_driver_unregister(&stmp378x_i2c_driver);
> > +}
> > +module_exit(stmp378x_i2c_exit_driver);
> > +
> > +MODULE_AUTHOR("d.frasenyak-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org");
> > +MODULE_DESCRIPTION("I2C for Freescale STMP378x");
> > +MODULE_LICENSE("GPL");
> 
> no module alias for autoloading?
Added.
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
	
