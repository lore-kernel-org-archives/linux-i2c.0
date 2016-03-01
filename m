From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] i2c: cadence: Fix the Documentation
Date: Tue, 1 Mar 2016 08:33:09 +0100
Message-ID: <56D545B5.9060304@xilinx.com>
References: <1456813959-20398-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:31456
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751794AbcCAIGu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 1 Mar 2016 03:06:50 -0500
In-Reply-To: <1456813959-20398-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

On 1.3.2016 07:32, Shubhrajyoti Datta wrote:
> The runtime adaptation patch missed the documentation update.
> This fixes the same.
> No functional change.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index 6b08d16..a761520 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -815,7 +815,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
>  }
>  
>  /**
> - * cdns_i2c_suspend - Suspend method for the driver
> + * cdns_i2c_runtime_suspend -  Runtime suspend method for the driver
>   * @_dev:	Address of the platform_device structure

you should fix this parameter too.

>   *
>   * Put the driver into low power mode.
> @@ -833,7 +833,7 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
>  }
>  
>  /**
> - * cdns_i2c_resume - Resume from suspend
> + * cdns_i2c_runtime_resume - Runtime resume
>   * @_dev:	Address of the platform_device structure

and here too.

>   *
>   * Resume operation after suspend.
> 

There is also undocumented dev. Please fix it too.
drivers/i2c/busses/i2c-cadence.c:126: info: Scanning doc for struct cdns_i2c
drivers/i2c/busses/i2c-cadence.c:164: warning: No description found for
parameter 'dev'

Thanks,
Michal
