From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 5/5] i2c: designware: Cleaning comments and formatation
Date: Tue, 13 Dec 2016 17:08:06 +0200
Message-ID: <b83be13e-483d-2d0c-d80d-ff752cc8bf04@linux.intel.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
 <02856fdb6ce3230a4ac1ba0958938ad51e763205.1481131072.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52801 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbcLMPIN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Dec 2016 10:08:13 -0500
In-Reply-To: <02856fdb6ce3230a4ac1ba0958938ad51e763205.1481131072.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 12/07/2016 07:55 PM, Luis Oliveira wrote:
> - Missspelling, comment formatation and fix a string of
>   the existing code
>
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changes V3->V4: (Andy Shevchenko)
> - created a commit message
>
>  drivers/i2c/busses/i2c-designware-common.c |  2 +-
>  drivers/i2c/busses/i2c-designware-slave.c  | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index 41b38d8b8732..838ef662d2c8 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -42,7 +42,7 @@ static char *abort_sources[] = {
>  	[ABRT_TXDATA_NOACK] =
>  		"data not acknowledged",
>  	[ABRT_GCALL_NOACK] =
> -		"no acknowledgement for a general call",
> +		"no acknowledgment for a general call",

I'm not a native speaker but are both acknowledgement and acknowledgment 
ok? I.e. is there need to change?

> diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
> index 1c7f82bb2513..442bc5ce6d47 100644
> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -70,8 +70,8 @@ int i2c_dw_init_slave(struct dw_i2c_dev *dev)
>  		/* Configure register access mode 16bit */
>  		dev->accessor_flags |= ACCESS_16BIT;
>  	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
> -		dev_err(dev->dev, "Unknown Synopsys component type: "
> -			"0x%08x\n", reg);
> +		dev_err(dev->dev,
> +		 "Unknown Synopsys component type: 0x%08x\n", reg);
>  		i2c_dw_release_lock(dev);
>  		return -ENODEV;
>  	}
> @@ -181,8 +181,10 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
>  		return -EBUSY;
>  	if (slave->flags & I2C_CLIENT_TEN)
>  		return -EAFNOSUPPORT;
> -		/* set slave address in the IC_SAR register,
> -		* the address to which the DW_apb_i2c responds */
> +		/*
> +		 * set slave address in the IC_SAR register,
> +		 * the address to which the DW_apb_i2c responds
> +		 */

These two should be done already in the patch 4/5 since it introduced 
the lines that you are changing here.

-- 
Jarkko
