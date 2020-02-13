From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware-pci: Fix BUG_ON during device removal
Date: Thu, 13 Feb 2020 19:10:29 +0200
Message-ID: <20200213171029.GB10400@smile.fi.intel.com>
References: <20200213151503.545269-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200213151503.545269-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 13, 2020 at 05:15:03PM +0200, Jarkko Nikula wrote:
> Function i2c_dw_pci_remove() -> pci_free_irq_vectors() ->
> pci_disable_msi() -> free_msi_irqs() will throw a BUG_ON() for MSI
> enabled device since the driver has not released the requested IRQ before
> calling the pci_free_irq_vectors().
> 
> Here driver requests an IRQ using devm_request_irq() but automatic
> release happens only after remove callback. Fix this by explicitly
> freeing the IRQ before calling pci_free_irq_vectors().
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 21aa3983d619 ("i2c: designware-pci: Switch over to MSI interrupts")
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 050adda7c1bd..05b35ac33ce3 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -313,6 +313,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
>  	pm_runtime_get_noresume(&pdev->dev);
>  
>  	i2c_del_adapter(&dev->adapter);
> +	devm_free_irq(&pdev->dev, dev->irq, dev);
>  	pci_free_irq_vectors(pdev);
>  }
>  
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko
