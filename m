From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: powermac: fix return path on error
Date: Tue, 27 Aug 2013 17:42:05 +1000
Message-ID: <1377589325.3819.118.camel@pasglop>
References: <1376918295-6961-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376918295-6961-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2013-08-19 at 15:18 +0200, Wolfram Sang wrote:
> We want to bail out immediately if i2c_add_adapter failed and not try to
> register child nodes with a nilled adapter structure.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-powermac.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> index 8dc90da..bb81773 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -446,6 +446,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
>  		       "failed\n", adapter->name);
>  		memset(adapter, 0, sizeof(*adapter));
> +		return rc;
>  	}
>  
>  	printk(KERN_INFO "PowerMac i2c bus %s registered\n", adapter->name);
> @@ -455,7 +456,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  	 */
>  	i2c_powermac_register_devices(adapter, bus);
>  
> -	return rc;
> +	return 0;
>  }
>  
>  static struct platform_driver i2c_powermac_driver = {
