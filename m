From: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: mux: create symlink to actual mux device
Date: Fri, 14 Nov 2014 11:01:47 +0100 (CET)
Message-ID: <468558661.38819776.1415959307717.JavaMail.root@telenet.be>
References: <1415885996-14770-1-git-send-email-wsa@the-dreams.de> <54657D41.5010006@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54657D41.5010006-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey guys,

It's been a while since I contacted you about this issue and I know I haven't been helping to solve it (because there were/are more pressing issues, as usual).

We're working with an older kernel here and have found a way of working around this issue (there's only one application adding muxes, so I'm scanning the i2c busses before and after adding the mux to figure out which busses were added by the new mux). Our solution works for the moment (although it's not as clean, obviously), so I don't think we'll be backporting the changes, but it's nice to know it's being solved. If we ever switch to a kernel that has these changes, we can do a better job with our application :-)

I justed wanted to say thank you for keeping me in the loop :-)

Regards,
Jeroen


----- Original Message -----
From: "Guenter Roeck" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: "Wolfram Sang" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Jean Delvare" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "Martin Belanger" <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, "Rodolfo Giometti" <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "Michael Lawnick" <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, "Jeroen De Wachter" <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>, "Gerlando Falauto" <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sent: Friday, November 14, 2014 4:55:45 AM
Subject: Re: [PATCH v3 1/2] i2c: mux: create symlink to actual mux device

On 11/13/2014 05:39 AM, Wolfram Sang wrote:
> The current implementation creates muxed i2c-<n> busses as immediate
> children of their i2c-<n> parent bus. In case of multiple muxes on one
> bus, it is impossible to determine which muxed bus comes from which mux.
>
> It could be argued that the parent device should be changed from the
> parent adapter to the mux device. This has pros and cons. To improve the
> topology, simply add a "muxed_device" symlink pointing to the actual
> muxing device, so we can distinguish muxed busses. Doing it this way, we
> don't break the ABI.
>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> Cc: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

This version works for me and passes testing with our application code.

Tested-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

> ---
>   drivers/i2c/i2c-mux.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 2d0847b6be62..f246a9f7dd22 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -183,6 +183,9 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>   		return NULL;
>   	}
>
> +	WARN(sysfs_create_link(&priv->adap.dev.kobj, &mux_dev->kobj, "mux_device"),
> +			       "can't create symlink to mux device\n");
> +
>   	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
>   		 i2c_adapter_id(&priv->adap));
>
> @@ -194,6 +197,7 @@ void i2c_del_mux_adapter(struct i2c_adapter *adap)
>   {
>   	struct i2c_mux_priv *priv = adap->algo_data;
>
> +	sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
>   	i2c_del_adapter(adap);
>   	kfree(priv);
>   }
>
