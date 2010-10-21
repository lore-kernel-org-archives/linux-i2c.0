From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: Add maintainer for PCA9541 I2C bus master
 selector driver
Date: Thu, 21 Oct 2010 17:34:14 +0200
Message-ID: <20101021173414.638fc069@endymion.delvare>
References: <1287674950-2881-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287674950-2881-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 21 Oct 2010 08:29:10 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f46d8e6..f96e8a3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4458,6 +4458,12 @@ S:	Maintained
>  F:	drivers/leds/leds-pca9532.c
>  F:	include/linux/leds-pca9532.h
>  
> +PCA9541 I2C BUS MASTER SELECTOR DRIVER
> +M:	Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> +L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Maintained
> +F:	drivers/i2c/muxes/pca9541.c
> +
>  PCA9564/PCA9665 I2C BUS DRIVER
>  M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Applied, thanks.

-- 
Jean Delvare
