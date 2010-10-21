From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/muxes: (pca954x) Remove __devinit and __devexit
 from probe and remove functions
Date: Thu, 21 Oct 2010 17:36:13 +0200
Message-ID: <20101021173613.66df5fb7@endymion.delvare>
References: <1287589413-1003-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287589413-1003-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 20 Oct 2010 08:43:33 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>

Next time I would appreciate an explanation why the change is needed.
I've added it myself this time...

> ---
>  drivers/i2c/muxes/pca954x.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> index 6f9accf..54e1ce7 100644
> --- a/drivers/i2c/muxes/pca954x.c
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -181,8 +181,8 @@ static int pca954x_deselect_mux(struct i2c_adapter *adap,
>  /*
>   * I2C init/probing/exit functions
>   */
> -static int __devinit pca954x_probe(struct i2c_client *client,
> -				   const struct i2c_device_id *id)
> +static int pca954x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
>  {
>  	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
>  	struct pca954x_platform_data *pdata = client->dev.platform_data;
> @@ -255,7 +255,7 @@ err:
>  	return ret;
>  }
>  
> -static int __devexit pca954x_remove(struct i2c_client *client)
> +static int pca954x_remove(struct i2c_client *client)
>  {
>  	struct pca954x *data = i2c_get_clientdata(client);
>  	const struct chip_desc *chip = &chips[data->type];
> @@ -279,7 +279,7 @@ static struct i2c_driver pca954x_driver = {
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe		= pca954x_probe,
> -	.remove		= __devexit_p(pca954x_remove),
> +	.remove		= pca954x_remove,
>  	.id_table	= pca954x_id,
>  };
>  

Applied, thanks.


-- 
Jean Delvare
