From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C device board info
Date: Sat, 18 Jul 2009 16:39:25 +0200
Message-ID: <20090718163925.5cbe1f45@hyperion.delvare>
References: <20090718105600.GA29887@n2100.arm.linux.org.uk>
	<20090718150803.68fea223@hyperion.delvare>
	<20090718131237.GB4120@n2100.arm.linux.org.uk>
	<20090718152918.09912dea@hyperion.delvare>
	<20090718135713.GC4120@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090718135713.GC4120-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 18 Jul 2009 14:57:13 +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 18, 2009 at 03:29:18PM +0200, Jean Delvare wrote:
> > On Sat, 18 Jul 2009 14:12:37 +0100, Russell King - ARM Linux wrote:
> > > That is my intention - I'm preparing patches for Realview and Versatile.
> > > This will only leave the MX* series of platforms in arch/arm doing this,
> > > which fall into Sascha's domain.
> > 
> > OK, thank you. I'll send a patch for the blackfin ones then.
> 
> Can I get an ack for this please?
> 
> Thanks.
> 
> Subject: ARM: Realview & Versatile: Fix i2c_board_info definitions
> 
> Fix i2c_board_info definitions - we were defining the 'type' field
> of these structures twice since the first argument of I2C_BOARD_INFO
> sets this field.  Move the second definition into I2C_BOARD_INFO().
> 
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
>  arch/arm/mach-realview/core.c  |    3 +--
>  arch/arm/mach-versatile/core.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
> index ab615e7..dc3519c 100644
> --- a/arch/arm/mach-realview/core.c
> +++ b/arch/arm/mach-realview/core.c
> @@ -208,8 +208,7 @@ struct platform_device realview_i2c_device = {
>  
>  static struct i2c_board_info realview_i2c_board_info[] = {
>  	{
> -		I2C_BOARD_INFO("rtc-ds1307", 0xd0 >> 1),
> -		.type = "ds1338",
> +		I2C_BOARD_INFO("ds1338", 0xd0 >> 1),
>  	},
>  };
>  
> diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
> index afc0f87..975eae4 100644
> --- a/arch/arm/mach-versatile/core.c
> +++ b/arch/arm/mach-versatile/core.c
> @@ -343,8 +343,7 @@ static struct platform_device versatile_i2c_device = {
>  
>  static struct i2c_board_info versatile_i2c_board_info[] = {
>  	{
> -		I2C_BOARD_INFO("rtc-ds1307", 0xd0 >> 1),
> -		.type = "ds1338",
> +		I2C_BOARD_INFO("ds1338", 0xd0 >> 1),
>  	},
>  };
>  

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
