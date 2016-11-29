From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH V3] i2c: mux: pca954x: Add ACPI support for pca954x
Date: Tue, 29 Nov 2016 06:55:52 +0100
Message-ID: <07dfd83e-e878-fae6-6a9d-8a9678235744@axentia.se>
References: <1480391189-1775-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0090.outbound.protection.outlook.com ([104.47.2.90]:11677
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754538AbcK2H1y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 02:27:54 -0500
In-Reply-To: <1480391189-1775-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

Hi!

We're apparently misunderstanding each other, I meant only that last
#ifdef in the v2 review... Sorry for not being clearer, new attempt
below.

Cheers,
Peter

On 2016-11-29 04:46, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
> 
> This patch enables ACPI support for mux-pca954x driver.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> 
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
> 
> Change from V2:
>  -Remove CONFIG_ACPI.
> 
> Change from V1:
>  -Don't shadow id variable.
>  -Include sorted header.
>  -Redefine acpi_device_id.
>  -Add CONFIG_ACPI.
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 1091346..f80191e 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -35,6 +35,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -120,6 +121,19 @@ struct pca954x {
>  };
>  MODULE_DEVICE_TABLE(i2c, pca954x_id);
>  

#ifdef CONFIG_ACPI

> +static const struct acpi_device_id pca954x_acpi_ids[] = {
> +	{ .id = "PCA9540", .driver_data = pca_9540 },
> +	{ .id = "PCA9542", .driver_data = pca_9540 },
> +	{ .id = "PCA9543", .driver_data = pca_9543 },
> +	{ .id = "PCA9544", .driver_data = pca_9544 },
> +	{ .id = "PCA9545", .driver_data = pca_9545 },
> +	{ .id = "PCA9546", .driver_data = pca_9545 },
> +	{ .id = "PCA9547", .driver_data = pca_9547 },
> +	{ .id = "PCA9548", .driver_data = pca_9548 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pca954x_acpi_ids);

#endif

> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id pca954x_of_match[] = {
>  	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
> @@ -245,8 +259,16 @@ static int pca954x_probe(struct i2c_client *client,
>  	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>  	if (match)
>  		data->chip = of_device_get_match_data(&client->dev);
> -	else
> +	else if (id)
>  		data->chip = &chips[id->driver_data];
> +	else {
> +		const struct acpi_device_id *acpi_id;
> +
> +		acpi_id = acpi_match_device(pca954x_acpi_ids, &client->dev);

		acpi_id = acpi_match_device(ACPI_PTR(pca954x_acpi_ids),
					    &client->dev);

> +		if (!acpi_id)
> +			return -ENODEV;
> +		data->chip = &chips[acpi_id->driver_data];
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
