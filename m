From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: Mark i2c_adapter.id as deprecated
Date: Sat, 13 Nov 2010 15:40:06 +0100
Message-ID: <201011131540.06705.hverkuil@xs4all.nl>
References: <20101105211001.1cc93ac7@endymion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101105211001.1cc93ac7-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LMML <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, November 05, 2010 21:10:01 Jean Delvare wrote:
> It's about time to make it clear that i2c_adapter.id is deprecated.
> Hopefully this will remind the last user to move over to a different
> strategy.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> Cc: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>

> ---
>  drivers/i2c/i2c-mux.c |    1 -
>  include/linux/i2c.h   |    2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-2.6.37-rc1.orig/include/linux/i2c.h	2010-11-05 13:55:17.000000000 +0100
> +++ linux-2.6.37-rc1/include/linux/i2c.h	2010-11-05 15:41:20.000000000 +0100
> @@ -353,7 +353,7 @@ struct i2c_algorithm {
>   */
>  struct i2c_adapter {
>  	struct module *owner;
> -	unsigned int id;
> +	unsigned int id __deprecated;
>  	unsigned int class;		  /* classes to allow probing for */
>  	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
>  	void *algo_data;
> --- linux-2.6.37-rc1.orig/drivers/i2c/i2c-mux.c	2010-11-05 16:06:18.000000000 +0100
> +++ linux-2.6.37-rc1/drivers/i2c/i2c-mux.c	2010-11-05 16:06:33.000000000 +0100
> @@ -120,7 +120,6 @@ struct i2c_adapter *i2c_add_mux_adapter(
>  	snprintf(priv->adap.name, sizeof(priv->adap.name),
>  		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
>  	priv->adap.owner = THIS_MODULE;
> -	priv->adap.id = parent->id;
>  	priv->adap.algo = &priv->algo;
>  	priv->adap.algo_data = priv;
>  	priv->adap.dev.parent = &parent->dev;
> 
> 
> 

-- 
Hans Verkuil - video4linux developer - sponsored by Cisco
