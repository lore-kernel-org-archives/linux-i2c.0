From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 2/3] i2c: designware: detect when dynamic tar update is
 possible
Date: Tue, 16 Aug 2016 17:00:12 +0300
Message-ID: <f4c1fb29-b315-33ee-f029-684ef9cd6264@linux.intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
 <1469743424-2480-3-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3194 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbcHPOAP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 16 Aug 2016 10:00:15 -0400
In-Reply-To: <1469743424-2480-3-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, linux-i2c@vger.kernel.org
Cc: christian.ruppert@alitech.com, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>

Hi, + Wolfram

On 07/29/2016 01:03 AM, Lucas De Marchi wrote:
> This adapter can be synthesized with dynamic tar update enabled or disabled.
> When enabled it is not necessary to disable the adapter to change the slave
> address in some situations, which saves some time per transaction.
>
> There is no direct register to know if this feature is enabled but we can do it
> indirectly by writing to the 10BIT_ADDR field in IC_CON: this field is
> read only when dynamic tar update is enabled.
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 37 ++++++++++++++++++++++----------
>  drivers/i2c/busses/i2c-designware-core.h |  1 +
>  2 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 2c61585..a8408db 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -388,6 +388,20 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	/* configure the i2c master */
>  	dw_writel(dev, dev->master_cfg , DW_IC_CON);
>
> +	/*
> +	 * Test if dynamic TAR update is enabled in this controller by writing to

Over 80 characters in this line.

> +	 */
> +	reg = dw_readl(dev, DW_IC_CON);
> +	dw_writel(dev, reg ^ DW_IC_CON_10BITADDR_MASTER, DW_IC_CON);
> +
> +	if ((dw_readl(dev, DW_IC_CON) & DW_IC_CON_10BITADDR_MASTER) ==
> +	    (reg & DW_IC_CON_10BITADDR_MASTER)) {
> +		dev->dynamic_tar_update_enabled = true;
> +		dev_dbg(dev->dev, "Dynamic TAR update enabled");
> +	}

Is this possible to move to i2c_dw_probe()? I guess the enabled status 
doesn't change runtime?

-- 
Jarkko
