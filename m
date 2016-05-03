From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7 18/24] i2c-mux: relax locking of the top i2c adapter
 during mux-locked muxing
Date: Tue, 3 May 2016 23:38:45 +0200
Message-ID: <20160503213844.GB2018@tetsubishi>
References: <1461165484-2314-1-git-send-email-peda@axentia.se>
 <1461165484-2314-19-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461165484-2314-19-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt Ranostay <matt.ranostay-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlo>
List-Id: linux-i2c@vger.kernel.org

> +static int i2c_mux_trylock_bus(struct i2c_adapter *adapter, int flags)
> +{
> +	struct i2c_mux_priv *priv = adapter->algo_data;
> +	struct i2c_adapter *parent = priv->muxc->parent;
> +
> +	if (!rt_mutex_trylock(&parent->mux_lock))
> +		return 0;
> +	if (!(flags & I2C_LOCK_ADAPTER))
> +		return 1;
> +	if (parent->trylock_bus(parent, flags))
> +		return 1;
> +	rt_mutex_unlock(&parent->mux_lock);
> +	return 0;
> +}

This function needs a few short comments why we can leave in this or
that state. Not everyone knows the exit values of trylock by heart and
then it can look a little confusing.

>  static int i2c_parent_trylock_bus(struct i2c_adapter *adapter, int flags)
> @@ -111,7 +189,12 @@ static int i2c_parent_trylock_bus(struct i2c_adapter *adapter, int flags)
>  	struct i2c_mux_priv *priv = adapter->algo_data;
>  	struct i2c_adapter *parent = priv->muxc->parent;
>  
> -	return parent->trylock_bus(parent, flags);
> +	if (!rt_mutex_trylock(&parent->mux_lock))
> +		return 0;
> +	if (parent->trylock_bus(parent, flags))
> +		return 1;
> +	rt_mutex_unlock(&parent->mux_lock);
> +	return 0;
>  }

Same comment as i2c_mux_trylock_bus.

>  struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>  				   struct device *dev, int max_adapters,
> @@ -140,6 +250,8 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>  
>  	muxc->parent = parent;
>  	muxc->dev = dev;
> +	if (flags & I2C_MUX_LOCKED)
> +		muxc->mux_locked = 1;

s/1/true/;
