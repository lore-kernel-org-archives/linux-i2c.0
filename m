From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c: xgene-slimpro: Support v2
Date: Tue, 31 Oct 2017 11:14:54 +0200
Message-ID: <1509441294.10233.81.camel@linux.intel.com>
References: <1509402256-3357-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbdJaJR6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 05:17:58 -0400
In-Reply-To: <1509402256-3357-1-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, patches@apm.com

On Mon, 2017-10-30 at 15:24 -0700, Hoan Tran wrote:
> This patch supports xgene-slimpro-i2c v2 which uses the non-cachable
> memory
> as the PCC shared memory.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(I'm totally fine with ACPI bits here, for the rest I hope it had been
tested and works as expected)

> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
> v2:
>  - Remove un-necessary ifdef CONFIG_ACPI
>  - Use acpi_match_table pointer from pdev
>  - Use MEMREMAP_WT for non-cachable memory
> 
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 30
> ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c
> b/drivers/i2c/busses/i2c-xgene-slimpro.c
> index 7e89ba6..a7ac746 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -129,6 +129,11 @@ struct slimpro_i2c_dev {
>  #define to_slimpro_i2c_dev(cl)	\
>  		container_of(cl, struct slimpro_i2c_dev, mbox_client)
>  
> +enum slimpro_i2c_version {
> +	XGENE_SLIMPRO_I2C_V1 = 0,
> +	XGENE_SLIMPRO_I2C_V2 = 1,
> +};
> +
>  /*
>   * This function tests and clears a bitmask then returns its old
> value
>   */
> @@ -476,6 +481,15 @@ static int xgene_slimpro_i2c_probe(struct
> platform_device *pdev)
>  		}
>  	} else {
>  		struct acpi_pcct_hw_reduced *cppc_ss;
> +		const struct acpi_device_id *acpi_id;
> +		int version = XGENE_SLIMPRO_I2C_V1;
> +
> +		acpi_id = acpi_match_device(pdev->dev.driver-
> >acpi_match_table,
> +					    &pdev->dev);
> +		if (!acpi_id)
> +			return -EINVAL;
> +
> +		version = (int)acpi_id->driver_data;
>  
>  		if (device_property_read_u32(&pdev->dev, "pcc-
> channel",
>  					     &ctx->mbox_idx))
> @@ -514,9 +528,16 @@ static int xgene_slimpro_i2c_probe(struct
> platform_device *pdev)
>  		 */
>  		ctx->comm_base_addr = cppc_ss->base_address;
>  		if (ctx->comm_base_addr) {
> -			ctx->pcc_comm_addr = memremap(ctx-
> >comm_base_addr,
> -						      cppc_ss-
> >length,
> -						      MEMREMAP_WB);
> +			if (version == XGENE_SLIMPRO_I2C_V2)
> +				ctx->pcc_comm_addr = memremap(
> +							ctx-
> >comm_base_addr,
> +							cppc_ss-
> >length,
> +							MEMREMAP_WT);
> +			else
> +				ctx->pcc_comm_addr = memremap(
> +							ctx-
> >comm_base_addr,
> +							cppc_ss-
> >length,
> +							MEMREMAP_WB);
>  		} else {
>  			dev_err(&pdev->dev, "Failed to get PCC comm
> region\n");
>  			rc = -ENOENT;
> @@ -581,7 +602,8 @@ MODULE_DEVICE_TABLE(of, xgene_slimpro_i2c_dt_ids);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
> -	{"APMC0D40", 0},
> +	{"APMC0D40", XGENE_SLIMPRO_I2C_V1},
> +	{"APMC0D8B", XGENE_SLIMPRO_I2C_V2},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
