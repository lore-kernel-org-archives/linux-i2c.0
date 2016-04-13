From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: Re: [PATCH v6 01/24] i2c-mux: add common data for every i2c-mux
 instance
Date: Wed, 13 Apr 2016 15:37:50 +0200
Message-ID: <570E4BAE.7060108@lysator.liu.se>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
 <1459673574-11440-2-git-send-email-peda@lysator.liu.se>
 <20160411204630.GA10401@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160411204630.GA10401@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt
List-Id: linux-i2c@vger.kernel.org

Hi!

On 2016-04-11 22:46, Wolfram Sang wrote:
> Hi Peter,
> 
> first high-level review:
> 
>> +int i2c_mux_reserve_adapters(struct i2c_mux_core *muxc, int adapters)
> 
> I'd suggest to rename 'adapters' into 'num_adapters' throughout this
> patch. I think it makes the code a lot easier to understand.

Hmm, you mean just the variable names, right? And not function names
such as i2c_mux_reserve_(num_)adapters?

>> +{
>> +	struct i2c_adapter **adapter;
>> +
>> +	if (adapters <= muxc->max_adapters)
>> +		return 0;
>> +
>> +	adapter = devm_kmalloc_array(muxc->dev,
>> +				     adapters, sizeof(*adapter),
>> +				     GFP_KERNEL);
>> +	if (!adapter)
>> +		return -ENOMEM;
>> +
>> +	if (muxc->adapter) {
>> +		memcpy(adapter, muxc->adapter,
>> +		       muxc->max_adapters * sizeof(*adapter));
>> +		devm_kfree(muxc->dev, muxc->adapter);
>> +	}
>> +
>> +	muxc->adapter = adapter;
>> +	muxc->max_adapters = adapters;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_mux_reserve_adapters);
> 
> Despite that I wonder why not using some of the realloc functions, I

When I wrote it, I found no devm_ version of realloc. I'm not finding
anything now either...

> wonder even more if we couldn't supply num_adapters to i2c_mux_alloc()
> and reserve the memory statically. i2c busses are not
> dynamic/hot-pluggable so that should be good enough?

Yes, that would work, but it would take some restructuring in some of
the drivers that currently don't know how many child adapters they
are going to need when they call i2c_mux_alloc.

Because you thought about removing i2c_mux_reserve_adapters completely,
and not provide any means of adding more adapters than specified in
the i2c_mux_alloc call, right?

>> -	WARN(sysfs_create_link(&priv->adap.dev.kobj, &mux_dev->kobj, "mux_device"),
>> -			       "can't create symlink to mux device\n");
>> +	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
>> +			       "mux_device"),
> 
> Ignoring the 80 char limit here makes the code more readable.

That is only true if you actually have more than 80 characters, so I don't
agree. Are you adamant about it? (I'm not)

>> +	     "can't create symlink to mux device\n");
>>  
>>  	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", chan_id);
>> -	WARN(sysfs_create_link(&mux_dev->kobj, &priv->adap.dev.kobj, symlink_name),
>> -			       "can't create symlink for channel %u\n", chan_id);
>> +	WARN(sysfs_create_link(&muxc->dev->kobj, &priv->adap.dev.kobj,
>> +			       symlink_name),
> 
> ditto.
> 
>> +	     "can't create symlink for channel %u\n", chan_id);
>>  	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
>>  		 i2c_adapter_id(&priv->adap));
>>  
>> -	return &priv->adap;
>> +	muxc->adapter[muxc->adapters++] = &priv->adap;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_mux_add_adapter);
>> +
>> +struct i2c_mux_core *i2c_mux_one_adapter(struct i2c_adapter *parent,
>> +					 struct device *dev, int sizeof_priv,
>> +					 u32 flags, u32 force_nr,
>> +					 u32 chan_id, unsigned int class,
>> +					 int (*select)(struct i2c_mux_core *,
>> +						       u32),
> 
> ditto
> 
>> +					 int (*deselect)(struct i2c_mux_core *,
>> +							 u32))
> 
> ditto
> 
>> +{
>> +	struct i2c_mux_core *muxc;
>> +	int ret;
>> +
>> +	muxc = i2c_mux_alloc(parent, dev, sizeof_priv, flags, select, deselect);
>> +	if (!muxc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = i2c_mux_add_adapter(muxc, force_nr, chan_id, class);
>> +	if (ret) {
>> +		devm_kfree(dev, muxc);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return muxc;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_mux_one_adapter);
> 
> Are you sure the above function pays off? Its argument list is very
> complex and it doesn't save a lot of code. Having seperate calls is
> probably more understandable in drivers? Then again, I assume it makes
> the conversion of existing drivers easier.

I added it in v4, you can check earlier versions if you like. Without
it most gate-muxes (i.e. typically the muxes in drivers/media) grew
since the i2c_add_mux_adapter call got replaced by two calls, i.e.
i2c_mux_alloc followed by i2c_max_add_adapter, and coupled with
error checks made it look more complex than before. So, this wasn't
much of a cleanup from the point of those drivers.

> So much for now. Thanks!

Yeah, thanks!

Cheers,
Peter
