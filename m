From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 8/9] i2c-designware-pci: Add runtime power management
 support
Date: Tue, 25 Jan 2011 12:00:00 +0900
Message-ID: <4D3E3CB0.8020006@renesas.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
 <1295033256-30077-9-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1295033256-30077-9-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/15/2011 4:27 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 746b4bb..e8b354b 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -580,3 +583,31 @@ tx_aborted:
>  }
>  EXPORT_SYMBOL(i2c_dw_isr);
>  
> +void i2c_dw_enable(struct dw_i2c_dev *dev)
> +{
> +	/* Enable the adapter */
> +	writel(1, dev->base + DW_IC_ENABLE);
> +}
> +EXPORT_SYMBOL(i2c_dw_enable);

Having enable/disable wrapper functions is good and promissing, as
that helps us to avoid direct references to the IC_ENABLE register
from -pci.c and -plat.c.

> +void i2c_dw_disable(struct dw_i2c_dev *i2c)
> +{
> +	/* Disable controller */
> +	writel(0, i2c->base + DW_IC_ENABLE);
> +
> +	/* Disable all interupts */
> +	writel(0x0000, i2c->base + DW_IC_INTR_MASK);
> +
> +	/* Clear all interrupts */
> +	readl(i2c->base + DW_IC_CLR_INTR);
> +	readl(i2c->base + DW_IC_CLR_STOP_DET);
> +	readl(i2c->base + DW_IC_CLR_START_DET);
> +	readl(i2c->base + DW_IC_CLR_ACTIVITY);
> +	readl(i2c->base + DW_IC_CLR_TX_ABRT);
> +	readl(i2c->base + DW_IC_CLR_RX_OVER);
> +	readl(i2c->base + DW_IC_CLR_RX_UNDER);
> +	readl(i2c->base + DW_IC_CLR_TX_OVER);
> +	readl(i2c->base + DW_IC_CLR_RX_DONE);
> +	readl(i2c->base + DW_IC_CLR_GEN_CALL);
> +}
> +EXPORT_SYMBOL(i2c_dw_disable);

Note that when you read the IC_CLR_INTR register, all interrupt status
bits asserted at that time will be cleared, so no need to read
remaining the IC_CLR_STOP_DET..IC_CLER_GEN_CALL registers.

By the way, I have one patch regarding safely shutdown the controller.
Will send a patch to Dirk later.

> diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
> index 1d57761..bea467e 100644
> --- a/drivers/i2c/busses/i2c-designware-pci.c
> +++ b/drivers/i2c/busses/i2c-designware-pci.c
[...]
> +static int i2c_dw_pci_resume(struct pci_dev *pdev)
> +{
> +	struct dw_i2c_dev *i2c = pci_get_drvdata(pdev);
> +	int err;
> +	u32 enabled;
> +
> +	enabled = dw_readl(i2c, DW_IC_ENABLE);
> +	if (enabled)
> +		return 0;

Hmm, we still have a direct reference to IC_ENABLE here.

> @@ -219,27 +300,28 @@ const struct pci_device_id *id)
>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
> -	adap->class = I2C_CLASS_HWMON;
> -	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
> -			sizeof(adap->name));
> +	adap->class = 0;
>  	adap->algo = &i2c_dw_algo;
>  	adap->dev.parent = &pdev->dev;
> -
>  	adap->nr = controller->bus_num;
> +	snprintf(adap->name, sizeof(adap->name), "i2c-dw-pci-%d",
> +		adap->nr);
>  
> -	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
>  	r = request_irq(pdev->irq, i2c_dw_isr, IRQF_SHARED, adap->name, dev);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
>  		goto err_iounmap;
>  	}
>  
> +	dw_readl(dev, DW_IC_CLR_INTR);
> +	dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */

Replacing with i2c_dw_disable()?

>  	r = i2c_add_numbered_adapter(adap);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure adding adapter\n");
>  		goto err_free_irq;
>  	}
>  
> +	pm_runtime_enable(&pdev->dev);
>  	return 0;
>  
>  err_free_irq:
-- 
Shinya Kuribayashi
Renesas Electronics
