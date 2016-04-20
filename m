From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/4] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
Date: Wed, 20 Apr 2016 15:55:14 +0300
Message-ID: <57177C32.4090000@linux.intel.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
 <1460638414-5987-3-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39831 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbcDTMzS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 08:55:18 -0400
In-Reply-To: <1460638414-5987-3-git-send-email-jszhang@marvell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/14/2016 03:53 PM, Jisheng Zhang wrote:
> If i2c_dw_probe() fail, we should call i2c_dw_plat_prepare_clk() to
> disable and unprepare the clk, otherwise the clk enable and prepare
> is left unbalanced.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 00f9e99..1488cea 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -268,6 +268,8 @@ rpm_disable:
>   		pm_runtime_put_noidle(&pdev->dev);
>   	}
>
> +	i2c_dw_plat_prepare_clk(dev, false);
> +
>   	return r;
>   }
>
This is a bit unclear to me does devm_clk_get take care of clk disabling 
in case of probe error or driver removal?

I see Andy's 1cb715ca4694 ("i2c-designware: move to managed functions 
(devm_*)") removed it but at quick look drivers/clk/clk-devres.c: 
devm_clk_release() calls only clk_put and I don't see disable is done 
down the path.

-- 
Jarkko
