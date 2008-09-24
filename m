From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: guard against oopses from bad
 init sequences
Date: Wed, 24 Sep 2008 11:55:27 +0200
Message-ID: <20080924115527.315d2968@hyperion.delvare>
References: <200809231138.19583.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200809231138.19583.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Tue, 23 Sep 2008 11:38:19 -0700, David Brownell wrote:
> From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> 
> Guard I2C against oopsing because of init sequence problems, by
> verifying that i2c_init() has been called before calling any
> routines that rely on that initialization.  This specific test
> just requires that bus_register(&i2c_bus_type) was called.
> 
> Examples of this kind of oopsing come from subystems and drivers
> which register I2C drivers in their subsys_initcall code but
> which are statically linked before I2C by drivers/Makefile.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> Alternatively have postcore_initcall(i2c_init), which may
> be better ... the initcall levels are pretty limited, and
> in these cases the "subsystem" of interest builds on I2C
> and needs to work before device_initcall.  Having I2C use
> subsys_initcall kind of forces things into fs_initcall.
> 
> I'd encourage the anti-oopsing paranoia in any case, even
> if i2c switches to postcore_initcall (or earlier).

I'm confused. If i2c_register_adapter() is called before i2c_init(),
your patch prevents an oops, but things will still not work, right? So
this doesn't seem to add much value. In any case we need to fix the
init sequence, so let's just do that.

> 
>  drivers/i2c/i2c-core.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -443,6 +443,12 @@ static int i2c_register_adapter(struct i
>  
>  	mutex_lock(&core_lock);
>  
> +	/* can't register until after driver model init */
> +	if (WARN_ON(!i2c_bus_type.p)) {
> +		res = -ENOENT;
> +		goto out_list;
> +	}
> +
>  	/* Add the adapter to the driver core.
>  	 * If the parent pointer is not set up,
>  	 * we add this adapter to the host bus.
> @@ -696,6 +702,10 @@ int i2c_register_driver(struct module *o
>  {
>  	int res;
>  
> +	/* can't register until after driver model init */
> +	if (WARN_ON(!i2c_bus_type.p))
> +		return -ENOENT;
> +
>  	/* new style driver methods can't mix with legacy ones */
>  	if (is_newstyle_driver(driver)) {
>  		if (driver->attach_adapter || driver->detach_adapter


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
