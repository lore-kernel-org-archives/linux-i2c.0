From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC,PATCH] i2c: fix device_init_wakeup place
Date: Sat, 9 Aug 2008 18:56:19 +0200
Message-ID: <20080809185619.6211fbf3@hyperion.delvare>
References: <200807291535.45689.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753334AbYHIQ4k@vger.kernel.org>
In-Reply-To: <200807291535.45689.marc.pignat@hevs.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Pignat <marc.pignat@hevs.ch>
Cc: David Brownell <david-b@pacbell.net>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Marc,

On Tue, 29 Jul 2008 15:35:44 +0200, Marc Pignat wrote:
> Move device_init_wakeup. At it's current place this is a noop (will be reset in
> device_initialize).
> 
> Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
> ---
> 
> Hi all!
> 
> The current code calls device_init_wakeup() before device_register, but
> device_register will disable device wakeup.
> 
> This patch (against 2.6.27-rc1) move the device_init_wakeup() call in the bus
> probe function,just before the probe call.

David, can you please help? This part of the code is yours and I have
no idea how it works. I am surprised that according to Marc the code
simply doesn't work at the moment. Didn't you test it?

> This will fix 3bbb835d4c53faf0bca62f0e39835926bef40b1f ('New style devices can
> support driver modle wakeup flags')which in fact has no effect. I think there
> is no need to fix -stable, because there is no in-tree users of the
> I2C_CLIENT_WAKE flag.

Interesting point... David, what are you using this code for then? Same
question for you Marc.

> This patch also include a small functionnal change: the I2C_CLIENT_WAKE is no
> more removed from the client flags, but this should't hurt.

Why do you want to change this?

> 
> 
> Best regards
> 
> Marc
> 
> 
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 7bf38c4..99c6a13 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -108,6 +108,7 @@ static int i2c_device_probe(struct device *dev)
>  	if (!driver->probe || !driver->id_table)
>  		return -ENODEV;
>  	client->driver = driver;
> +	device_init_wakeup(&client->dev, client->flags & I2C_CLIENT_WAKE);
>  	dev_dbg(dev, "probe\n");
>  
>  	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> @@ -262,9 +263,8 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>  	client->adapter = adap;
>  
>  	client->dev.platform_data = info->platform_data;
> -	device_init_wakeup(&client->dev, info->flags & I2C_CLIENT_WAKE);
>  
> -	client->flags = info->flags & ~I2C_CLIENT_WAKE;
> +	client->flags = info->flags;
>  	client->addr = info->addr;
>  	client->irq = info->irq;
>  


-- 
Jean Delvare
