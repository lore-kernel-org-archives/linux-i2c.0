From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-rc2-git] make i2c_register_board_info() a
 NOP when CONFIG_I2C=n
Date: Fri, 22 Feb 2008 10:47:09 +0100
Message-ID: <20080222104709.2c2a0845@hyperion.delvare>
References: <200802220023.16643.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200802220023.16643.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 22 Feb 2008 00:23:16 -0800, David Brownell wrote:
> Don't require platform code to be #ifdeffed according to whether
> I2C is enabled or not ... if it's not enabled, let GCC compile out
> all I2C device declarations.  (Issue noted on an NSLU2 build that
> didn't configure I2C.)
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  include/linux/i2c.h |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- at91.orig/include/linux/i2c.h	2008-02-21 22:58:53.000000000 -0800
> +++ at91/include/linux/i2c.h	2008-02-21 23:02:57.000000000 -0800
> @@ -271,9 +271,16 @@ extern void i2c_unregister_device(struct
>   * This is done at arch_initcall time, before declaring any i2c adapters.
>   * Modules for add-on boards must use other calls.
>   */
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

I'm fairly certain that #ifdef CONFIG_I2C is enough.

>  extern int
>  i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsigned n);
> -
> +#else
> +static inline int
> +i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsigned n)
> +{
> +	return 0;
> +}
> +#endif
>  
>  /*
>   * The following structs are for those who like to implement new bus drivers:

Other than that I am fine with this patch. Want it in 2.6.25 or 2.6.26
is enough?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
