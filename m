From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] I2C: runtime: Fix checks which make legacy suspend to never get called
Date: Tue, 28 Sep 2010 23:45:26 +0200
Message-ID: <201009282345.26363.rjw@sisk.pl>
References: <1285602360-21180-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285602360-21180-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, September 27, 2010, Rajendra Nayak wrote:
> For devices which are not adapted to runtime PM a call to
> pm_runtime_suspended always returns true.
> 
> Hence the pm_runtime_suspended checks below prevent legacy
> suspend from getting called.
> 
> So do a pm_runtime_suspended check only for devices with a
> dev_pm_ops populated (which hence do not rely on the legacy
> suspend)

Makes sense.

> Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>

Acked-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>

> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   44 ++++++++++++++++++++++++--------------------
>  1 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6649176..712086f 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -197,11 +197,12 @@ static int i2c_device_pm_suspend(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->suspend ? pm->suspend(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->suspend ? pm->suspend(dev) : 0;
> +	}
>  
>  	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
>  }
> @@ -229,11 +230,12 @@ static int i2c_device_pm_freeze(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->freeze ? pm->freeze(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->freeze ? pm->freeze(dev) : 0;
> +	}
>  
>  	return i2c_legacy_suspend(dev, PMSG_FREEZE);
>  }
> @@ -242,11 +244,12 @@ static int i2c_device_pm_thaw(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->thaw ? pm->thaw(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->thaw ? pm->thaw(dev) : 0;
> +	}
>  
>  	return i2c_legacy_resume(dev);
>  }
> @@ -255,11 +258,12 @@ static int i2c_device_pm_poweroff(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->poweroff ? pm->poweroff(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->poweroff ? pm->poweroff(dev) : 0;
> +	}
>  
>  	return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
>  }
> 
