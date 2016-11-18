From: Peter Rosin <peda@axentia.se>
Subject: Re: [v1] i2c: mux: pca954x : Supports ACPI
Date: Fri, 18 Nov 2016 21:48:19 +0100
Message-ID: <f0d6803c-19bc-d2eb-a91b-0436d00f9345@axentia.se>
References: <1479481269-16363-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10115.outbound.protection.outlook.com ([40.107.1.115]:12896
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752475AbcKRUs3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 15:48:29 -0500
In-Reply-To: <1479481269-16363-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

Hi,

Thanks for your patch!

Some small suggestions inline.

On 2016-11-18 16:01, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
> 
> This patch enable ACPI support for mux-pca954x driver.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 1091346..e7ef93b 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -42,6 +42,7 @@
>  #include <linux/i2c/pca954x.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>

Please keep the includes sorted.

>  #include <linux/of_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> @@ -120,6 +121,19 @@ struct pca954x {
>  };
>  MODULE_DEVICE_TABLE(i2c, pca954x_id);
>  
> +static const struct acpi_device_id pca954x_acpi_ids[] = {
> +	{ "PCA9540", pca_9540 },

I would write that as:

	{ .id = "PCA9540", .driver_data = pca_9540, },

But that doesn't seem common for other acpi_device_id tables.
I wonder why?

> +	{ "PCA9542", pca_9540 },
> +	{ "PCA9543", pca_9543 },
> +	{ "PCA9544", pca_9544 },
> +	{ "PCA9545", pca_9545 },
> +	{ "PCA9546", pca_9545 },
> +	{ "PCA9547", pca_9547 },
> +	{ "PCA9548", pca_9548 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pca954x_acpi_ids);

This table should be #ifdef CONFIG_ACPI.

> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id pca954x_of_match[] = {
>  	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
> @@ -245,8 +259,16 @@ static int pca954x_probe(struct i2c_client *client,
>  	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>  	if (match)
>  		data->chip = of_device_get_match_data(&client->dev);
> -	else
> +	else if (id) {
>  		data->chip = &chips[id->driver_data];
> +	} else {
> +		const struct acpi_device_id *id;

Please don't shadow the outer id variable.

Cheers,
Peter

> +
> +		id = acpi_match_device(pca954x_acpi_ids, &client->dev);
> +		if (!id)
> +			return -ENODEV;
> +		data->chip = &chips[id->driver_data];
> +	}
>  
>  	data->last_chan = 0;		   /* force the first selection */
>  
> @@ -321,6 +343,7 @@ static int pca954x_resume(struct device *dev)
>  		.name	= "pca954x",
>  		.pm	= &pca954x_pm,
>  		.of_match_table = of_match_ptr(pca954x_of_match),
> +		.acpi_match_table = ACPI_PTR(pca954x_acpi_ids),
>  	},
>  	.probe		= pca954x_probe,
>  	.remove		= pca954x_remove,
> 
