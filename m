From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH][RFC] OMAP4: I2C : I2C context save
Date: Mon, 20 Jun 2011 08:35:23 -0700
Message-ID: <87ips08qis.fsf@ti.com>
References: <1308559552-24028-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308559552-24028-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(shubhrajyoti-l0cyMroinI0@public.gmane.org's message of "Mon, 20 Jun 2011 14:15:52 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: shubhrajyoti-l0cyMroinI0@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

shubhrajyoti-l0cyMroinI0@public.gmane.org writes:

> From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> Currently the OMAP4 doesnot hit device off still the
> driver may have support for it.Adding support for the
> same.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Please Cc linux-omap as this change to the hwmod data would go through
Tony.

Also, please describe why this hwmod data change affects the problem
described in the changelog.

Kevin

> ---
> Applies on top of patches from Andy Green
> http://www.spinics.net/lists/linux-i2c/msg05632.html
>
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 0fe9556..5e2c748 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>  };
>  
>  static struct omap_i2c_dev_attr i2c_dev_attr = {
> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>  };
>  
>  /* i2c1 */
