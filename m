From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH] i2c: Prevent endless uevent loop with dev_dbg
Date: Wed, 23 Mar 2016 18:29:05 +0100
Message-ID: <20160323172905.GB1712@hardcore>
References: <1458748247-9219-1-git-send-email-jglauber@cavium.com>
 <20160323165033.GB1385@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160323165033.GB1385@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2016 at 05:50:33PM +0100, Wolfram Sang wrote:
> On Wed, Mar 23, 2016 at 04:50:47PM +0100, Jan Glauber wrote:
> > After enabling CONFIG_I2C_DEBUG_CORE my system was broken
> > (no network, console login not possible). System log was
> > flooded with the this message:
> > 
> >  ...
> > [  608.052077] rtc-ds1307 0-0068: uevent
> > [  608.052500] rtc-ds1307 0-0068: uevent
> > [  608.052925] rtc-ds1307 0-0068: uevent
> >  ...
> > 
> > The culprit is the dev_dbg printk in the i2c uevent handler.
> > If this is activated (for instance by CONFIG_I2C_DEBUG_CORE)
> > it results in an endless loop with systemd-journald.
> > 
> > This happens if user-space scans the system log and reads the uevent
> > file to get information about a newly created device, which seems fair
> > use to me. Unfortunately reading the "uevent" file uses the same
> > function that runs for creating the uevent for a new device,
> > generating the next syslog entry.
> > 
> > Ideally user-space would implement a recursion detection and
> > after reading the same device file for the 1000th time call it a
> > day, but nevertheless I think we should avoid this problem by
> > removing the debug print completly or using another print variant.
> 
> Thanks for pointing out this problem. I think this debug can go. I also
> think the function can be cleaned up some more. Can you test this patch?

Works for me!

Thanks, Jan

> Thanks,
> 
>    Wolfram
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 0f2f8484e8ec1f..e584d88ee337f6 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -525,22 +525,16 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>  
> -
> -/* uevent helps with hotplug: modprobe -q $(MODALIAS) */
>  static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct i2c_client	*client = to_i2c_client(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
>  	int rc;
>  
>  	rc = acpi_device_uevent_modalias(dev, env);
>  	if (rc != -ENODEV)
>  		return rc;
>  
> -	if (add_uevent_var(env, "MODALIAS=%s%s",
> -			   I2C_MODULE_PREFIX, client->name))
> -		return -ENOMEM;
> -	dev_dbg(dev, "uevent\n");
> -	return 0;
> +	return add_uevent_var(env, "MODALIAS=%s%s", I2C_MODULE_PREFIX, client->name);
>  }
>  
>  /* i2c bus recovery routines */
> 
