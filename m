From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c-iop3xx.c: fix memory resource
Date: Fri, 11 Dec 2009 10:40:42 -0800
Message-ID: <1260556842.18299.34.camel@Joe-Laptop.home>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB1063@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB1063-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2009-12-11 at 13:32 -0500, H Hartley Sweeten wrote:
> The i2c-iop3xx driver requires a resource region of 0x18 bytes and
> currently uses the magic number IOP3XX_I2C_IO_SIZE (defined in
> i2c-iop3xx.h) to indicate this.  All of the users of this driver
> have a platform memory resource so use resource_size() instead of
> the magic number.  This requires fixing a couple of the memory
> resources since they were either off by 1 or just wrong.
[]
>  static struct resource iop13xx_i2c_0_resources[] = {
>  	[0] = {
>  		.start = IOP13XX_I2C0_PHYS,
> -		.end = IOP13XX_I2C0_PHYS + 0x18,
> +		.end = IOP13XX_I2C0_PHYS + 0x17,

etc.

> -#define	IOP3XX_I2C_IO_SIZE	0x18

Maybe it's clearer to keep the IO_SIZE define
and let the compiler do the adding.

.start = FOO;
.end = FOO + IOP3XX_I2C_IO_SIZE - 1;
