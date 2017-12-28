From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] i2c: ismt: Use %pad specifier for dma_addr_t
 variables
Date: Thu, 28 Dec 2017 17:21:51 +0200
Message-ID: <1514474511.7000.422.camel@linux.intel.com>
References: <20171110183358.86100-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:40561 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753394AbdL1PXZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Dec 2017 10:23:25 -0500
In-Reply-To: <20171110183358.86100-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Fri, 2017-11-10 at 20:33 +0200, Andy Shevchenko wrote:
> ...which takes care of proper format and size of the value.

Wolfram, any comment on this?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-ismt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-
> ismt.c
> index b51adffa4841..c0d0f34d34f3 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -572,8 +572,7 @@ static int ismt_access(struct i2c_adapter *adap,
> u16 addr,
>  			return -EIO;
>  		}
>  
> -		dev_dbg(dev, " dma_addr = 0x%016llX\n",
> -			(unsigned long long)dma_addr);
> +		dev_dbg(dev, " dma_addr = %pad\n", &dma_addr);
>  
>  		desc->dptr_low = lower_32_bits(dma_addr);
>  		desc->dptr_high = upper_32_bits(dma_addr);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
