From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/chips: move ds1682 to drivers/misc
Date: Thu, 8 Oct 2009 08:40:41 +0200
Message-ID: <20091008084041.597e4c6d@hyperion.delvare>
References: <20091007115017.6941faa7@hyperion.delvare>
	<1254954710-18263-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1254954710-18263-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu,  8 Oct 2009 00:31:50 +0200, Wolfram Sang wrote:
> As i2c/chips is deprecated, move ds1682 to a more apropriate location.
> Build tested.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/chips/Kconfig  |   10 --
>  drivers/i2c/chips/Makefile |    1 -
>  drivers/i2c/chips/ds1682.c |  267 --------------------------------------------
>  drivers/misc/Kconfig       |   10 ++
>  drivers/misc/Makefile      |    1 +
>  drivers/misc/ds1682.c      |  267 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 278 insertions(+), 278 deletions(-)
>  delete mode 100644 drivers/i2c/chips/ds1682.c
>  create mode 100644 drivers/misc/ds1682.c

Thanks. Applied with one fix:

> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -246,6 +246,16 @@ config EP93XX_PWM
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called ep93xx_pwm.
>  
> +config DS1682
> +	tristate "Dallas DS1682 Total Elapsed Time Recorder with Alarm"
> +	depends on EXPERIMENTAL

Depends on I2C too.

> +	help
> +	  If you say yes here you get support for Dallas Semiconductor
> +	  DS1682 Total Elapsed Time Recorder.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ds1682.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"

-- 
Jean Delvare
