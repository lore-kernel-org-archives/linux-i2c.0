From: Abhijeet Dharmapurikar <adharmap-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from PM operations
Date: Tue, 04 Jan 2011 15:07:37 -0800
Message-ID: <4D23A839.6030205@codeaurora.org>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1293712813-4090-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Mark Brown wrote:
> When devices use dev_pm_ops the I2C API is implementing standard functionality
> for integration with runtime PM and for checking for the presence of a per
> device op. The PM core provides pm_generic_ functions implementing this
> behaviour - use them to reduce coupling with future PM updates.
> 
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   68 ++++++++++++++---------------------------------
>  1 files changed, 20 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6b4cc56..6793c51 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -196,88 +196,60 @@ static int i2c_device_pm_suspend(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm) {
> -		if (pm_runtime_suspended(dev))
> -			return 0;
> -		else
> -			return pm->suspend ? pm->suspend(dev) : 0;
> -	}
> -
> -	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> +	if (pm)
> +		return pm_generic_suspend(dev);


pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?

--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
