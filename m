From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: make const array supported_speeds static
 to shink object code size
Date: Fri, 22 Sep 2017 10:10:59 +0300
Message-ID: <f2c03d85-da0d-7bb0-2f1a-5a3b298200e9@linux.intel.com>
References: <20170921223007.21081-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:28867 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbdIVHUL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 22 Sep 2017 03:20:11 -0400
In-Reply-To: <20170921223007.21081-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2017 01:30 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const array supported_speeds on the stack, instead
> make it static.  Makes the object code smaller by 150 bytes:
> 
> Before:
>     text	   data	    bss	    dec	    hex	filename
>     8474	   1440	      0	   9914	   26ba	i2c-designware-platdrv.o
> 
> After:
>     text	   data	    bss	    dec	    hex	filename
>     8324	   1440	      0	   9764	   2624	i2c-designware-platdrv.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0e65b97842b4..8a7b29b9afbe 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -257,7 +257,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>   	u32 acpi_speed, ht = 0;
>   	struct resource *mem;
>   	int i, irq, ret;
> -	const int supported_speeds[] = { 0, 100000, 400000, 1000000, 3400000 };
> +	static const int supported_speeds[] = {
> +		0, 100000, 400000, 1000000, 3400000
> +	};
>   
Oh, this is so easy to forget.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
