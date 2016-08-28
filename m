From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] i2c: move locking operations to their own struct
Date: Sun, 28 Aug 2016 18:06:21 +0200
Message-ID: <20160828160621.GX10980@phenom.ffwll.local>
References: <1472159221-10807-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbcH1QG0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 28 Aug 2016 12:06:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so6389970wmg.2
        for <linux-i2c@vger.kernel.org>; Sun, 28 Aug 2016 09:06:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1472159221-10807-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, Wolfram Sang <wsa@the-dreams.de>

On Thu, Aug 25, 2016 at 11:07:01PM +0200, Peter Rosin wrote:
> This makes it trivial to constify them, so do that.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Feel free to merge through i2c tree.
-Daniel

> ---
>  drivers/gpu/drm/drm_dp_helper.c | 10 +++++++---
>  drivers/i2c/i2c-core.c          | 13 ++++++++-----
>  drivers/i2c/i2c-mux.c           | 25 ++++++++++++++++---------
>  include/linux/i2c.h             | 25 ++++++++++++++++++-------
>  4 files changed, 49 insertions(+), 24 deletions(-)
> 
> Changes since v1:
> 
> - Also fix the user in drivers/gpu (only compile-tested, but
>   it's simple enough...)
> 
> This takes care of the 0-day splat reported in:
> http://marc.info/?l=linux-i2c&m=147215193023544&w=2
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index eae5ef963cb7..2bd064493ae7 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -790,6 +790,12 @@ static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
>  	mutex_unlock(&i2c_to_aux(i2c)->hw_mutex);
>  }
>  
> +static const struct i2c_lock_operations drm_dp_i2c_lock_ops = {
> +	.lock_bus = lock_bus,
> +	.trylock_bus = trylock_bus,
> +	.unlock_bus = unlock_bus,
> +};
> +
>  /**
>   * drm_dp_aux_init() - minimally initialise an aux channel
>   * @aux: DisplayPort AUX channel
> @@ -807,9 +813,7 @@ void drm_dp_aux_init(struct drm_dp_aux *aux)
>  	aux->ddc.algo_data = aux;
>  	aux->ddc.retries = 3;
>  
> -	aux->ddc.lock_bus = lock_bus;
> -	aux->ddc.trylock_bus = trylock_bus;
> -	aux->ddc.unlock_bus = unlock_bus;
> +	aux->ddc.lock_ops = &drm_dp_i2c_lock_ops;
>  }
>  EXPORT_SYMBOL(drm_dp_aux_init);
>  
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 56e50ca905ba..0bdda24a10b2 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1691,6 +1691,12 @@ static int __process_new_adapter(struct device_driver *d, void *data)
>  	return i2c_do_add_adapter(to_i2c_driver(d), data);
>  }
>  
> +static const struct i2c_lock_operations i2c_adapter_lock_ops = {
> +	.lock_bus =    i2c_adapter_lock_bus,
> +	.trylock_bus = i2c_adapter_trylock_bus,
> +	.unlock_bus =  i2c_adapter_unlock_bus,
> +};
> +
>  static int i2c_register_adapter(struct i2c_adapter *adap)
>  {
>  	int res = -EINVAL;
> @@ -1710,11 +1716,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  		goto out_list;
>  	}
>  
> -	if (!adap->lock_bus) {
> -		adap->lock_bus = i2c_adapter_lock_bus;
> -		adap->trylock_bus = i2c_adapter_trylock_bus;
> -		adap->unlock_bus = i2c_adapter_unlock_bus;
> -	}
> +	if (!adap->lock_ops)
> +		adap->lock_ops = &i2c_adapter_lock_ops;
>  
>  	rt_mutex_init(&adap->bus_lock);
>  	rt_mutex_init(&adap->mux_lock);
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 764f195795e4..14741ff31041 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -263,6 +263,18 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>  }
>  EXPORT_SYMBOL_GPL(i2c_mux_alloc);
>  
> +static const struct i2c_lock_operations i2c_mux_lock_ops = {
> +	.lock_bus =    i2c_mux_lock_bus,
> +	.trylock_bus = i2c_mux_trylock_bus,
> +	.unlock_bus =  i2c_mux_unlock_bus,
> +};
> +
> +static const struct i2c_lock_operations i2c_parent_lock_ops = {
> +	.lock_bus =    i2c_parent_lock_bus,
> +	.trylock_bus = i2c_parent_trylock_bus,
> +	.unlock_bus =  i2c_parent_unlock_bus,
> +};
> +
>  int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  			u32 force_nr, u32 chan_id,
>  			unsigned int class)
> @@ -312,15 +324,10 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	priv->adap.retries = parent->retries;
>  	priv->adap.timeout = parent->timeout;
>  	priv->adap.quirks = parent->quirks;
> -	if (muxc->mux_locked) {
> -		priv->adap.lock_bus = i2c_mux_lock_bus;
> -		priv->adap.trylock_bus = i2c_mux_trylock_bus;
> -		priv->adap.unlock_bus = i2c_mux_unlock_bus;
> -	} else {
> -		priv->adap.lock_bus = i2c_parent_lock_bus;
> -		priv->adap.trylock_bus = i2c_parent_trylock_bus;
> -		priv->adap.unlock_bus = i2c_parent_unlock_bus;
> -	}
> +	if (muxc->mux_locked)
> +		priv->adap.lock_ops = &i2c_mux_lock_ops;
> +	else
> +		priv->adap.lock_ops = &i2c_parent_lock_ops;
>  
>  	/* Sanity check on class */
>  	if (i2c_mux_parent_classes(parent) & class)
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index c1f60a345db7..616f67635734 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -427,6 +427,20 @@ struct i2c_algorithm {
>  };
>  
>  /**
> + * struct i2c_lock_operations - represent I2C locking operations
> + * @lock_bus: Get exclusive access to an I2C bus segment
> + * @trylock_bus: Try to get exclusive access to an I2C bus segment
> + * @unlock_bus: Release exclusive access to an I2C bus segment
> + *
> + * The main operations are wrapped by i2c_lock_bus and i2c_unlock_bus.
> + */
> +struct i2c_lock_operations {
> +	void (*lock_bus)(struct i2c_adapter *, unsigned int flags);
> +	int (*trylock_bus)(struct i2c_adapter *, unsigned int flags);
> +	void (*unlock_bus)(struct i2c_adapter *, unsigned int flags);
> +};
> +
> +/**
>   * struct i2c_timings - I2C timing information
>   * @bus_freq_hz: the bus frequency in Hz
>   * @scl_rise_ns: time SCL signal takes to rise in ns; t(r) in the I2C specification
> @@ -536,6 +550,7 @@ struct i2c_adapter {
>  	void *algo_data;
>  
>  	/* data fields that are valid for all devices	*/
> +	const struct i2c_lock_operations *lock_ops;
>  	struct rt_mutex bus_lock;
>  	struct rt_mutex mux_lock;
>  
> @@ -552,10 +567,6 @@ struct i2c_adapter {
>  
>  	struct i2c_bus_recovery_info *bus_recovery_info;
>  	const struct i2c_adapter_quirks *quirks;
> -
> -	void (*lock_bus)(struct i2c_adapter *, unsigned int flags);
> -	int (*trylock_bus)(struct i2c_adapter *, unsigned int flags);
> -	void (*unlock_bus)(struct i2c_adapter *, unsigned int flags);
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
>  
> @@ -597,7 +608,7 @@ int i2c_for_each_dev(void *data, int (*fn)(struct device *, void *));
>  static inline void
>  i2c_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  {
> -	adapter->lock_bus(adapter, flags);
> +	adapter->lock_ops->lock_bus(adapter, flags);
>  }
>  
>  /**
> @@ -611,7 +622,7 @@ i2c_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  static inline int
>  i2c_trylock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  {
> -	return adapter->trylock_bus(adapter, flags);
> +	return adapter->lock_ops->trylock_bus(adapter, flags);
>  }
>  
>  /**
> @@ -623,7 +634,7 @@ i2c_trylock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  static inline void
>  i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  {
> -	adapter->unlock_bus(adapter, flags);
> +	adapter->lock_ops->unlock_bus(adapter, flags);
>  }
>  
>  static inline void
> -- 
> 2.1.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
