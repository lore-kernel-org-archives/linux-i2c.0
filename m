From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/3] i2c: parport: simplify Kconfig description
Date: Wed, 15 Jan 2020 12:07:39 +0100
Message-ID: <20200115120739.1992c46e@endymion>
References: <20200113210643.5033-1-wsa+renesas@sang-engineering.com>
        <20200113210643.5033-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOLHm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 15 Jan 2020 06:07:42 -0500
In-Reply-To: <20200113210643.5033-3-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org

On Mon, 13 Jan 2020 22:06:42 +0100, Wolfram Sang wrote:
> The driver is not 'new' anymore, so remove details from the driver it
> surpassed.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 933f15f0ad67..b2840c5ebf24 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1202,14 +1202,8 @@ config I2C_PARPORT
>  	  This supports parallel port I2C adapters such as the ones made by
>  	  Philips or Velleman, Analog Devices evaluation boards, and more.
>  	  Basically any adapter using the parallel port as an I2C bus with
> -	  no extra chipset is supported by this driver, or could be.
> -
> -	  This driver is a replacement for (and was inspired by) an older
> -	  driver named i2c-philips-par.  The new driver supports more devices,
> -	  and makes it easier to add support for new devices.
> -
> -	  An adapter type parameter is now mandatory.  Please read the file
> -	  Documentation/i2c/busses/i2c-parport.rst for details.
> +	  no extra chipset is supported by this driver, or could be. Please
> +	  read the file Documentation/i2c/busses/i2c-parport.rst for details.
>  
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-parport.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
