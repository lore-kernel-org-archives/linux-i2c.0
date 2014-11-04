From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Tue, 04 Nov 2014 06:46:49 -0800
Message-ID: <5458E6D9.1090607@roeck-us.net>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de> <20141103205534.GA18937@roeck-us.net> <20141103210200.GA6242@katana> <20141103224908.GA18594@roeck-us.net> <20141104143309.GA12933@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141104143309.GA12933@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/04/2014 06:33 AM, Wolfram Sang wrote:
>
>> Ok, I think I know the problem. In my case, the parent adapter
>> and the mux device are the same (since both are on the same chip
>> and the mux is really merged into the i2c controller).
>>
>> I'll have to figure out how to fix that.
>
> Maybe something like this on top helps already? It skips link creation
> if the parent device is the parent i2c adapter. We should have this
> anyway...
>

I'll test tonight ... I'll be in meetings all day :-(.

Guenter

> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -184,8 +184,11 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>   		return NULL;
>   	}
>
> -	WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj, priv->adap.dev.kobj.name),
> -				"can't create compatibility link for old mux name scheme\n");
> +	/* If necessary, create symlink to match old mux name scheme */
> +	if (mux_dev != &parent->dev)
> +		WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj,
> +					dev_name(&priv->adap.dev)),
> +					"can't create compatibility link for old mux name scheme\n");
>
>   	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
>   		 i2c_adapter_id(&priv->adap));
> @@ -198,7 +201,8 @@ void i2c_del_mux_adapter(struct i2c_adapter *adap)
>   {
>   	struct i2c_mux_priv *priv = adap->algo_data;
>
> -	sysfs_remove_link(&priv->parent->dev.kobj, adap->dev.kobj.name);
> +	if (priv->adap.dev.parent != &priv->parent->dev)
> +		sysfs_remove_link(&priv->parent->dev.kobj, dev_name(&adap->dev));
>   	i2c_del_adapter(adap);
>   	kfree(priv);
>   }
>
