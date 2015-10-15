From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: add maintainers for Synopsis Designware
 I2C drivers
Date: Thu, 15 Oct 2015 18:11:45 +0300
Message-ID: <1444921905.8361.648.camel@linux.intel.com>
References: <1444917533-1981-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11976 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbbJOPMz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 11:12:55 -0400
In-Reply-To: <1444917533-1981-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Thu, 2015-10-15 at 15:58 +0200, Wolfram Sang wrote:
> Those guys already have been helpful in the past and are actively
> working on this driver, unlike me.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> As suggested by Jarkko here:
> http://article.gmane.org/gmane.linux.drivers.i2c/24834
> 
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f467845ef725f..58d6b02d2dea78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9101,6 +9101,15 @@ S: Supported
>  F: Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt
>  F: drivers/net/ethernet/synopsys/dwc_eth_qos.c
>  
> +SYNOPSYS DESIGNWARE I2C DRIVER
> +M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
> +M:	Mika Westerberg <mika.westerberg@linux.intel.com>
> +L:	linux-i2c@vger.kernel.org
> +S:	Maintained
> +F:	drivers/i2c/busses/i2c-designware-*
> +F:	include/linux/platform_data/i2c-designware.h
> +
>  SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
>  M:	Seungwon Jeon <tgih.jun@samsung.com>
>  M:	Jaehoon Chung <jh80.chung@samsung.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
