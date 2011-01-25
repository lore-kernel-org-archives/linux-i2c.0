From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/9] i2c-designware: move i2c functionality bit field to be
 adapter specific
Date: Tue, 25 Jan 2011 11:07:03 +0900
Message-ID: <4D3E3047.8000209@renesas.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
 <1295033256-30077-6-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1295033256-30077-6-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/15/2011 4:27 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The functionality of the adapter depends on the configuration of the
> IP block at silicon compile time and is adapter specific.

Good point.

> diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
> index 00717df..5d131ce 100644
> --- a/drivers/i2c/busses/i2c-designware-pci.c
> +++ b/drivers/i2c/busses/i2c-designware-pci.c
> @@ -199,6 +199,12 @@ const struct pci_device_id *id)
>  	dev->clk_khz = controller->clk_khz;
>  	dev->base = base;
>  	dev->dev = get_device(&pdev->dev);
> +	dev->functionality = I2C_FUNC_I2C |
> +		I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_I2C_BLOCK;
> +
>  	pci_set_drvdata(pdev, dev);
>  
>  	dev->tx_fifo_depth = controller->tx_fifo_depth;

I'd prefer to have them aligned.

> diff --git a/drivers/i2c/busses/i2c-designware-plat.c b/drivers/i2c/busses/i2c-designware-plat.c
> index b8e5aa4..cf157a4 100644
> --- a/drivers/i2c/busses/i2c-designware-plat.c
> +++ b/drivers/i2c/busses/i2c-designware-plat.c
> @@ -91,6 +91,13 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
>  	}
>  	clk_enable(dev->clk);
>  
> +	dev->functionality = I2C_FUNC_I2C |
> +		I2C_FUNC_10BIT_ADDR |
> +		I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_I2C_BLOCK;
> +
>  	dev->base = ioremap(mem->start, resource_size(mem));
>  	if (dev->base == NULL) {
>  		dev_err(&pdev->dev, "failure mapping io resources\n");

Ditto.
-- 
Shinya Kuribayashi
Renesas Electronics
