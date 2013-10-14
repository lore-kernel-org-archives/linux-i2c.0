From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Mon, 14 Oct 2013 17:23:45 +0800
Message-ID: <1381742625.2034.25.camel@rzhang1-mobl4>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381414669-26115-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, 2013-10-10 at 17:17 +0300, Jarkko Nikula wrote:
> There is a minor fault about ACPI enumerated I2C devices with their modalias
> attribute. Now modalias is set by device instance not by hardware ID.
> For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.
> 
> This means each device instance gets different modalias which does match
> with generated modules.alias. Currently this is not problem as matching can
> happen also with "acpi:INTABCD" modalias.
> 
IMO, this is not the proper fix for the modalias problem because ACPI
enumerated I2C device may have compatible ids.
Instead, we should export all the compatible ids as the modules alias of
the ACPI enumerated I2C device.

can you please take a look at the patch I sent out earlier?
https://patchwork.kernel.org/patch/3034991/
https://patchwork.kernel.org/patch/3035041/
https://patchwork.kernel.org/patch/3035021/

thanks,
rui

> Fix this by using ACPI hardware ID.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>


> ---
> Generated on top of v3.12-rc4-29-g0e7a3ed.
> ---
>  drivers/i2c/i2c-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 29d3f04..6dd0c53 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1111,7 +1111,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>  	if (ret < 0 || !info.addr)
>  		return AE_OK;
>  
> -	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
> +	strlcpy(info.type, acpi_device_hid(adev), sizeof(info.type));
>  	if (!i2c_new_device(adapter, &info)) {
>  		dev_err(&adapter->dev,
>  			"failed to add I2C device %s from ACPI\n",
