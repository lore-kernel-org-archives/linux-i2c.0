From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC,PATCH v2] i2c: fix device_init_wakeup place
Date: Mon, 11 Aug 2008 14:01:58 +0200
Message-ID: <20080811140158.160f3649@hyperion.delvare>
References: <200808111031.35722.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752517AbYHKMCU@vger.kernel.org>
In-Reply-To: <200808111031.35722.marc.pignat@hevs.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Pignat <marc.pignat@hevs.ch>
Cc: David Brownell <david-b@pacbell.net>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 11 Aug 2008 10:31:35 +0200, Marc Pignat wrote:
> device_init_wakeup must be called after device_register.
> 
> Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
> ---
> 
> Hi all!
> 
> The current i2c code calls device_init_wakeup() before device_register, but
> device_register (by calling device_initialize) will disable device wakeup.
> 
> This patch (against 2.6.27-rc2) move the device_init_wakeup() call in the bus
> probe function, just before the probe call.
> 
> This patch also include a small functionnal change: the I2C_CLIENT_WAKE is no
> more removed from the client flags, but this should't hurt.
> 
> Changes from v1:
>  - patch against 2.6.24-rc2
>  - call to device_init_wakeup depends on !device_can_wakeup (suggested by David
>    Brownell)
> 
> Best regards
> 
> Marc
> 
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 7bf38c4..0039bd9 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -108,6 +108,9 @@ static int i2c_device_probe(struct device *dev)
>  	if (!driver->probe || !driver->id_table)
>  		return -ENODEV;
>  	client->driver = driver;
> +	if (!device_can_wakeup(&client->dev))
> +		device_init_wakeup(&client->dev,
> +					client->flags & I2C_CLIENT_WAKE);
>  	dev_dbg(dev, "probe\n");
>  
>  	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> @@ -262,9 +265,8 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
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

Applied, thanks.

-- 
Jean Delvare
