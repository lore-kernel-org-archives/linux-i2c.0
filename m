From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: dev_pm_ops conversion.
Date: Mon, 20 Jul 2009 22:06:17 +0100
Message-ID: <20090720210617.GA28218@fluff.org.uk>
References: <1248115661-20189-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1248115661-20189-1-git-send-email-manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 20, 2009 at 08:47:41PM +0200, Manuel Lauss wrote:
> Signed-off-by: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Run-tested on Au1200.
> 
>  drivers/i2c/busses/i2c-au1550.c |   23 ++++++++++-------------
>  1 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
> index 532828b..6565012 100644
> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -440,40 +440,37 @@ i2c_au1550_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
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
> -#else
> -#define i2c_au1550_suspend	NULL
> -#define i2c_au1550_resume	NULL
> -#endif
> +
> +static struct dev_pm_ops au1xpsc_smbus_pmops = {
> +	.resume		= i2c_au1550_resume,
> +	.suspend	= i2c_au1550_suspend,
> +};
>  
>  static struct platform_driver au1xpsc_smbus_driver = {
>  	.driver = {
>  		.name	= "au1xpsc_smbus",
>  		.owner	= THIS_MODULE,
> +		.pm	= &au1xpsc_smbus_pmops,

hmm, why not
		.pm	= (struct dev_pm_ops &) {
			.suspend	= ...,
			.resume		= ...,
		},

?

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
