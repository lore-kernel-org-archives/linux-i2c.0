From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help on selecting one (and only one) i2c bus
Date: Wed, 11 Mar 2009 20:09:49 +0100
Message-ID: <20090311200949.45ba0dde@hyperion.delvare>
References: <20090311122257.7c7805f0@hyperion.delvare>
	<001301c9a269$ab95d940$b23e81a4@par.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <001301c9a269$ab95d940$b23e81a4-J7BnVcvkGbbQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ayman,

On Wed, 11 Mar 2009 17:51:48 +0100, Ayman KHAMOUMA wrote:
> It's me again...
> 
> In I2c.h I found: 
> 
> /* Mainboard arch_initcall() code should register all its I2C devices.
>  * This is done at arch_initcall time, before declaring any i2c adapters.
>  * Modules for add-on boards must use other calls.
>  */
> 
> extern int
> i2c_register_board_info(int busnum, struct i2c_board_info const *info,
> unsigned n);
> 
> I guess I have to call this function near the arch_initcall().
> I greped my folder for arch_initcall() but couldn't figure out witch file to
> use...
> Any idea ?

I'm not much into embedded architectures, and I suspect it depends on
the architecture. Looking at the latest kernel tree I see this function
is called only in machine or platform initialization files, for example:

arch/arm/mach-pxa/cm-x300.c:	i2c_register_board_info(0, cm_x300_gpio_ext_info,
arch/arm/mach-rpc/riscpc.c:	i2c_register_board_info(0, &i2c_rtc, 1);
arch/arm/mach-s3c6410/mach-smdk6410.c:	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
arch/arm/mach-s3c6410/mach-smdk6410.c:	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
arch/arm/plat-omap/i2c.c:		err = i2c_register_board_info(bus_id, info, len);
arch/arm/mach-s3c2440/mach-osiris.c:	i2c_register_board_info(0, osiris_i2c_devs,
arch/arm/mach-s3c2440/mach-anubis.c:	i2c_register_board_info(0, anubis_i2c_devs,
arch/arm/mach-ep93xx/core.c:	i2c_register_board_info(0, devices, num);

I can't tell more without knowing which architecture and machine or
platform you're working on. And maybe the question would be better
asked to someone who is familiar with the architecture in question.

> Another thing, what would be the equivalent of
> MODULE_DEVICE_TABLE(i2c, example_idtable);
> As you said, the i2c_device_id structure doesn't exist in this kernel...

There is no equivalent, just omit this part.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
