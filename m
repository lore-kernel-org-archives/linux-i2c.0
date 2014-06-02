From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: Make I2C ID tables non-mandatory for DT'ed
 and/or ACPI'ed devices
Date: Mon, 2 Jun 2014 15:34:17 +0100
Message-ID: <20140602153417.2065c1a5@alan.etchedpixels.co.uk>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
	<1401716463-23457-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401716463-23457-4-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon,  2 Jun 2014 14:41:03 +0100
Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Currently the I2C framework insists on devices supplying an I2C ID
> table.  Many of the devices which do so unnecessarily adding quite a
> few wasted lines to kernel code.  This patch allows drivers a means
> to 'not' supply the aforementioned table and match on either DT
> and/or ACPI match tables instead.
> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index d0c7180..811b78f 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -271,7 +271,18 @@ static int i2c_device_probe(struct device *dev)
>  		return 0;
>  
>  	driver = to_i2c_driver(dev->driver);
> -	if (!driver->probe || !driver->id_table)
> +	if (!driver->probe)
> +		return -EINVAL;
> +
> +	/*
> +	 * An I2C ID table is not madatory, if and only if, a suitable Device

typo "madatory"..

> +	 * Tree and/or ACPI match table entry is supplied for the probing
> +	 * device.
> +	 *
> +	 * TODO: Provide 'device type' to 'ACPI node' call and match here.
> +	 */
> +	if (!driver->id_table &&
> +	    !of_match_device(dev->driver->of_match_table, dev))
>  		return -ENODEV;
>  

Looks sensible to me other than that.

>  	if (!device_can_wakeup(&client->dev))
