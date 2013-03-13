From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [5/6] i2c: Ignore the return value of i2c_del_mux_adapter()
Date: Tue, 12 Mar 2013 23:05:47 -0700
Message-ID: <20130313060547.GA8607@roeck-us.net>
References: <1362853009-20789-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1362853009-20789-6-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 09, 2013 at 06:16:48PM -0000, Lars-Peter Clausen wrote:
> i2c_del_mux_adapter() always returns 0. So all checks testing whether it will be
> non zero will always evaluate to false and the conditional code is dead code.
> This patch updates all callers of i2c_del_mux_adapter() to ignore its return
> value and assume that it will always succeed (which it will). A subsequent
> patch will make the return type of i2c_del_mux_adapter() void.
> 
> Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>

Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> 
> ---
> drivers/i2c/muxes/i2c-mux-pca954x.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 8e43872..a531d80 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -262,13 +262,11 @@ static int pca954x_remove(struct i2c_client *client)
>  {
>  	struct pca954x *data = i2c_get_clientdata(client);
>  	const struct chip_desc *chip = &chips[data->type];
> -	int i, err;
> +	int i;
>  
>  	for (i = 0; i < chip->nchans; ++i)
>  		if (data->virt_adaps[i]) {
> -			err = i2c_del_mux_adapter(data->virt_adaps[i]);
> -			if (err)
> -				return err;
> +			i2c_del_mux_adapter(data->virt_adaps[i]);
>  			data->virt_adaps[i] = NULL;
>  		}
>  
