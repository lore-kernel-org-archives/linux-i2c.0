From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: piix4: Fix request_region size
Date: Sat, 28 Jan 2017 09:36:22 +0100
Message-ID: <1485592582.4916.1.camel@suse.de>
References: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46791 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdA1IgZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Jan 2017 03:36:25 -0500
In-Reply-To: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Ricardo,

On ven., 2017-01-27 at 15:59 +0100, Ricardo Ribalda Delgado wrote:
> Since '701dc207bf55 ("i2c: piix4: Avoid race conditions with IMC")'
> we
> are using the SMBSLVCNT register at offset 0x8. We need to request
> it.
> 
> Fixes: 701dc207bf55 ("i2c: piix4: Avoid race conditions with IMC")
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> Please note, not tested on hardware.
>  drivers/i2c/busses/i2c-piix4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-
> piix4.c
> index e34d82e79b98..73cc6799cc59 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -58,7 +58,7 @@
>  #define SMBSLVDAT	(0xC + piix4_smba)
>  
>  /* count for request_region */
> -#define SMBIOSIZE	8
> +#define SMBIOSIZE	9
> 

Are you certain that all supported devices have this extra register?

>  
>  /* PCI Address Constants */
>  #define SMBBA		0x090

-- 
Jean Delvare
SUSE L3 Support
