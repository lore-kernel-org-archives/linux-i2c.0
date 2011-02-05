From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 04/10] i2c-designware: Add support for Designware core
	behind PCI devices.
Date: Sat, 5 Feb 2011 17:50:10 +0000
Message-ID: <20110205175010.GJ15795@trinity.fluff.org>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com> <1296699608-13227-5-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1296699608-13227-5-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 02, 2011 at 06:20:02PM -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Modify the driver to be a PCI driver from the platform template
> created in the inital split of the driver.  Add controller config
> options attached to PCI ID's. Add for the Moorsetown
> and Medfield SOC's
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> +	dev->clk = NULL;
> +	dev->clk_khz = controller->clk_khz;
> +	dev->base = base;
>  	dev->dev = get_device(&pdev->dev);
> -	dev->irq = irq;
> -	platform_set_drvdata(pdev, dev);
> -
> -	dev->clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(dev->clk)) {
> -		r = -ENODEV;
> -		goto err_free_mem;
> -	}
> -	clk_enable(dev->clk);

hmm, what where these calls doing in here in the first place if they're
not available?

>  /* work with hotplug and coldplug */
> -MODULE_ALIAS("platform:i2c_designware");
> +MODULE_ALIAS("i2c_designware-pci");

hmm, why did this get copied in here in the first place?
  
> -static struct platform_driver dw_i2c_driver = {
> -	.remove		= __devexit_p(dw_i2c_remove),
> -	.driver		= {
> -		.name	= "i2c_designware",
> -		.owner	= THIS_MODULE,
> -	},
> +DEFINE_PCI_DEVICE_TABLE(i2_designware_pci_ids) = {
> +	/* Moorestown */
> +	{ PCI_VDEVICE(INTEL, 0x0802), moorestown_0 },
> +	{ PCI_VDEVICE(INTEL, 0x0803), moorestown_1 },
> +	{ PCI_VDEVICE(INTEL, 0x0804), moorestown_2 },
> +	/* Medfield */
> +	{ PCI_VDEVICE(INTEL, 0x0817), medfield_3,},
> +	{ PCI_VDEVICE(INTEL, 0x0818), medfield_4 },
> +	{ PCI_VDEVICE(INTEL, 0x0819), medfield_5 },
> +	{ PCI_VDEVICE(INTEL, 0x082C), medfield_0 },
> +	{ PCI_VDEVICE(INTEL, 0x082D), medfield_1 },
> +	{ PCI_VDEVICE(INTEL, 0x082E), medfield_2 },
> +	{ 0,}
> +};
> +MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
> +
> +static struct pci_driver dw_i2c_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= i2_designware_pci_ids,
> +	.probe		= i2c_dw_pci_probe,
> +	.remove		= __devexit_p(i2c_dw_pci_remove),
>  };
>  
>  static int __init dw_i2c_init_driver(void)
>  {
> -	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
> +	return  pci_register_driver(&dw_i2c_driver);
>  }
>  module_init(dw_i2c_init_driver);
>  
>  static void __exit dw_i2c_exit_driver(void)
>  {
> -	platform_driver_unregister(&dw_i2c_driver);
> +	pci_unregister_driver(&dw_i2c_driver);
>  }
>  module_exit(dw_i2c_exit_driver);
>  
> -MODULE_AUTHOR("Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>");
> -MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
> +MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org");
> +MODULE_DESCRIPTION("Synopsys DesignWare PCI I2C bus adapter");
>  MODULE_LICENSE("GPL");

Why change the authour information?
