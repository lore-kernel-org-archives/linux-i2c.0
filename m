From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH V2] i2c-au1550: dev_pm_ops conversion.
Date: Thu, 30 Jul 2009 00:49:32 +0100
Message-ID: <20090729234932.GC8850@fluff.org.uk>
References: <1248275868-3245-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1248275868-3245-1-git-send-email-manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 22, 2009 at 05:17:48PM +0200, Manuel Lauss wrote:

As a note, in future, a meaningful description is welcomed here.

For example, if this fixes a warning, put a copy of the warning in
the message with a description of what you did to remove the warning
to make it easier for other people to search.

> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Signed-off-by: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> V1->V2: don't remove CONFIG_PM
> 
>  drivers/i2c/busses/i2c-au1550.c |   24 ++++++++++++++----------
>  1 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
> index 532828b..1ae82db 100644
> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -441,39 +441,43 @@ i2c_au1550_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM
> -static int
> -i2c_au1550_suspend(struct platform_device *pdev, pm_message_t state)
> +static int i2c_au1550_suspend(struct device *dev)
>  {
> -	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> +	struct i2c_au1550_data *priv = dev_get_drvdata(dev);
>  
>  	i2c_au1550_disable(priv);
>  
>  	return 0;
>  }
>  
> -static int
> -i2c_au1550_resume(struct platform_device *pdev)
> +static int i2c_au1550_resume(struct device *dev)
>  {
> -	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> +	struct i2c_au1550_data *priv = dev_get_drvdata(dev);
>  
>  	i2c_au1550_setup(priv);
>  
>  	return 0;
>  }
> +
> +static struct dev_pm_ops au1xpsc_smbus_pmops = {
> +	.resume		= i2c_au1550_resume,
> +	.suspend	= i2c_au1550_suspend,
> +};
> +
> +#define AU1XPSC_SMBUS_PMOPS &au1xpsc_smbus_pmops
> +
>  #else
> -#define i2c_au1550_suspend	NULL
> -#define i2c_au1550_resume	NULL
> +#define AU1XPSC_SMBUS_PMOPS NULL
>  #endif
>  
>  static struct platform_driver au1xpsc_smbus_driver = {
>  	.driver = {
>  		.name	= "au1xpsc_smbus",
>  		.owner	= THIS_MODULE,
> +		.pm	= AU1XPSC_SMBUS_PMOPS,
>  	},
>  	.probe		= i2c_au1550_probe,
>  	.remove		= __devexit_p(i2c_au1550_remove),
> -	.suspend	= i2c_au1550_suspend,
> -	.resume		= i2c_au1550_resume,
>  };
>  
>  static int __init
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
