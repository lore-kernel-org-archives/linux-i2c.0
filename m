From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: inform about deprecated chips-directory
Date: Tue, 21 Oct 2008 18:56:17 +0200
Message-ID: <20081021185617.35254bc5@hyperion.delvare>
References: <1224604651-17321-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1224604651-17321-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 21 Oct 2008 17:57:31 +0200, Wolfram Sang wrote:
> The chips directory under drivers/i2c is deprecated. Spread the word!
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> Maybe this makes Jean's life a bit easier ;)
> 
>  drivers/i2c/chips/Kconfig  |    3 +++
>  drivers/i2c/chips/Makefile |    3 ++-
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 1735682..44a6e4c 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -1,6 +1,9 @@
>  #
>  # Miscellaneous I2C chip drivers configuration
>  #
> +#
> +# *** DEPRECATED! Do not add new entries! See Makefile ***
> +#
>  
>  menu "Miscellaneous I2C Chip support"
>  
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index ca520fa..23d2a31 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -1,7 +1,8 @@
>  #
>  # Makefile for miscellaneous I2C chip drivers.
>  #
> -# Think twice before you add a new driver to this directory.
> +# Do not add new drivers to this directory! It is DEPRECATED.
> +#
>  # Device drivers are better grouped according to the functionality they
>  # implement rather than to the bus they are connected to. In particular:
>  # * Hardware monitoring chip drivers go to drivers/hwmon

Good idea, it's more obvious that way. Applied, thanks!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
