From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] i2c-core: fix for dep-lock validator
Date: Fri, 07 Sep 2012 15:58:22 +0200
Message-ID: <5049FD7E.9080709@gmx.de>
References: <50473FC9.6000203@gmx.de> <5049F005.2040300@gmx.de> <20120907152840.4de537b3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120907152840.4de537b3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Am 07.09.2012 15:28, schrieb Jean Delvare:
> I do have one too, based on the depth level of each adapter:
> 
> --- linux-3.6-rc4.orig/drivers/i2c/i2c-core.c	2012-09-06 17:24:17.449441802 +0200
> +++ linux-3.6-rc4/drivers/i2c/i2c-core.c	2012-09-07 10:44:11.339368610 +0200
> @@ -636,6 +636,16 @@ static void i2c_adapter_dev_release(stru
>  	complete(&adap->dev_released);
>  }
>  
> +static unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
> +{
> +	unsigned int depth = 0;
> +
> +	while ((adapter = i2c_parent_is_i2c_adapter(adapter)))
> +		depth++;
> +
> +	return depth;
> +}
> +
>  /*
>   * Let users instantiate I2C devices through sysfs. This can be used when
>   * platform initialization code doesn't contain the proper data for
> @@ -726,7 +736,8 @@ i2c_sysfs_delete_device(struct device *d
>  
>  	/* Make sure the device was added through sysfs */
>  	res = -ENOENT;
> -	mutex_lock(&adap->userspace_clients_lock);
> +	mutex_lock_nested(&adap->userspace_clients_lock,
> +			  i2c_adapter_depth(adap));
>  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
>  				 detected) {
>  		if (client->addr == addr) {
> @@ -869,7 +880,8 @@ static int i2c_register_adapter(struct i
>  	if (res)
>  		goto out_list;
>  
> -	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
> +	dev_dbg(&adap->dev, "adapter [%s] registered, depth %u\n", adap->name,
> +		i2c_adapter_depth(adap));
>  
>  #ifdef CONFIG_I2C_COMPAT
>  	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
> @@ -1073,7 +1085,8 @@ int i2c_del_adapter(struct i2c_adapter *
>  		return res;
>  
>  	/* Remove devices instantiated from sysfs */
> -	mutex_lock(&adap->userspace_clients_lock);
> +	mutex_lock_nested(&adap->userspace_clients_lock,
> +			  i2c_adapter_depth(adap));
>  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
>  				 detected) {
>  		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,
> 
> I was about to test it but was side-tracked by a different issue.
> 

I did not test yet, but thought already in same direction. The draw back
of this is that there is still maximum tree depth, but we could say 8
should be enough and the performance issue. May be introducing the depth
into struct i2c_adapter and setting it to parent->depth + 1?

-- 
KR
Michael
