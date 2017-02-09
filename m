From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix regression when dynamic TAR update
 is disabled
Date: Thu, 09 Feb 2017 22:07:38 +0200
Message-ID: <1486670858.2133.436.camel@linux.intel.com>
References: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdBIUUB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 15:20:01 -0500
In-Reply-To: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shah Nehal-Bakulchandra <Nehal-Bakulchandra.Shah@amd.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com
Cc: lucas.demarchi@intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

On Fri, 2017-02-10 at 01:20 +0530, Shah Nehal-Bakulchandra wrote:
> The following commit causes a regression when dynamic TAR update is
> disabled:
> 
>      commit 63d0f0a6952a1a02bc4f116b7da7c7887e46efa3 ("i2c:
> designware:
>      detect when dynamic tar update is possible")

Please, leave just 12 characters, it still enough.

> In such case, the DW_IC_CON_10BITADDR_MASTER is R/W, and is changed
> by the logic that's trying to detect  dynamic TAR update.The original
> value of DW_IC_CON_10BITADDR_MASTER bit should be restored.
> 

+ Fixes tag?

> Signed-off-by: Shah Nehal-Bakulchandra <Nehal-
> bakulchandra.Shah@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c
> b/drivers/i2c/busses/i2c-designware-core.c
> index 6d81c56..0c57166 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -987,6 +987,11 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>  	    (reg & DW_IC_CON_10BITADDR_MASTER)) {
>  		dev->dynamic_tar_update_enabled = true;
>  		dev_dbg(dev->dev, "Dynamic TAR update enabled");
> +	} else {
> +		/* If test is failed then restore the original value
> */

> +		dev->dynamic_tar_update_enabled = false;

It's default.

> +		dev_dbg(dev->dev, "Dynamic TAR update disable restore
> the value");

I think this is useless. Either you have enabled message, or have
nothing.

> +		dw_writel(dev, reg, DW_IC_CON);
>  	}
>  
>  	i2c_dw_release_lock(dev);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
