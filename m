From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/5] i2c: mux: pca954x: Add missing pca9542 definition
 to chip_desc
Date: Mon, 9 Jan 2017 08:55:13 +0100
Message-ID: <f59d78b8-1d05-8751-2714-1bc90e8ad43f@axentia.se>
References: <1483589463-35380-1-git-send-email-preid@electromag.com.au>
 <1483589463-35380-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:46144
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752942AbdAIHzU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 9 Jan 2017 02:55:20 -0500
In-Reply-To: <1483589463-35380-2-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

On 2017-01-05 05:10, Phil Reid wrote:
> The spec for the pca954x was missing. This chip is the same as the pca9540
> except that it has interrupt lines. While the i2c_device_id table mapped
> the pca9542 to the pca9540 definition the compatible table did not. In
> preparation for irq support add the pca9542 definition.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
peda

> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index dd18b9c..bbf088e 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -84,6 +84,11 @@ struct pca954x {
>  		.enable = 0x4,
>  		.muxtype = pca954x_ismux,
>  	},
> +	[pca_9542] = {
> +		.nchans = 2,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
>  	[pca_9543] = {
>  		.nchans = 2,
>  		.muxtype = pca954x_isswi,
> @@ -110,7 +115,7 @@ struct pca954x {
>  
>  static const struct i2c_device_id pca954x_id[] = {
>  	{ "pca9540", pca_9540 },
> -	{ "pca9542", pca_9540 },
> +	{ "pca9542", pca_9542 },
>  	{ "pca9543", pca_9543 },
>  	{ "pca9544", pca_9544 },
>  	{ "pca9545", pca_9545 },
> @@ -124,7 +129,7 @@ struct pca954x {
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id pca954x_acpi_ids[] = {
>  	{ .id = "PCA9540", .driver_data = pca_9540 },
> -	{ .id = "PCA9542", .driver_data = pca_9540 },
> +	{ .id = "PCA9542", .driver_data = pca_9542 },
>  	{ .id = "PCA9543", .driver_data = pca_9543 },
>  	{ .id = "PCA9544", .driver_data = pca_9544 },
>  	{ .id = "PCA9545", .driver_data = pca_9545 },
> 
