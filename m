From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] Allow mixed endianness accesses
Date: Fri, 15 Jan 2010 09:01:02 +0900
Message-ID: <4B4FB03E.1070708@necel.com>
References: <20100113193224.753273000@octasic.com> <20100113193421.212989000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100113193421.212989000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean-Hugues Deschenes wrote:
> Allows CPUs of a given endianness to access a dw controller of a different
> endianness. Endianncess difference is detected at run time through the dw
> component type register.
> 
> ---
>  drivers/i2c/busses/i2c-designware.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
> ===================================================================
> --- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
> +++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
> @@ -36,6 +36,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/swab.h>
>  
>  /*
>   * Registers offset

I'm working on 2.6.27 MIPS kernel, and this <linux/swab.h> brings
the following errors.

  CC      drivers/i2c/busses/i2c-designware.o
In file included from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:39:
/home/skuribay/git/linux/include/linux/swab.h:109:1: warning: "__swab16" redefined
In file included from /home/skuribay/git/linux/include/linux/byteorder/big_endian.h:12,
                 from include2/asm/byteorder.h:69,
                 from include2/asm/bitops.h:21,
                 from /home/skuribay/git/linux/include/linux/bitops.h:17,
                 from /home/skuribay/git/linux/include/linux/kernel.h:15,
                 from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:28:
/home/skuribay/git/linux/include/linux/byteorder/swab.h:144:1: warning: this is the location of the previous definition
In file included from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:39:
/home/skuribay/git/linux/include/linux/swab.h:118:1: warning: "__swab32" redefined
In file included from /home/skuribay/git/linux/include/linux/byteorder/big_endian.h:12,
                 from include2/asm/byteorder.h:69,
                 from include2/asm/bitops.h:21,
                 from /home/skuribay/git/linux/include/linux/bitops.h:17,
                 from /home/skuribay/git/linux/include/linux/kernel.h:15,
                 from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:28:
/home/skuribay/git/linux/include/linux/byteorder/swab.h:148:1: warning: this is the location of the previous definition
In file included from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:39:
/home/skuribay/git/linux/include/linux/swab.h:127:1: warning: "__swab64" redefined
In file included from /home/skuribay/git/linux/include/linux/byteorder/big_endian.h:12,
                 from include2/asm/byteorder.h:69,
                 from include2/asm/bitops.h:21,
                 from /home/skuribay/git/linux/include/linux/bitops.h:17,
                 from /home/skuribay/git/linux/include/linux/kernel.h:15,
                 from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:28:
/home/skuribay/git/linux/include/linux/byteorder/swab.h:152:1: warning: this is the location of the previous definition
In file included from /home/skuribay/git/linux/drivers/i2c/busses/i2c-designware.c:40:
/home/skuribay/git/linux/include/linux/swab.h:46: error: redefinition of '___swab16'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:65: error: previous definition of '___swab16' was here
/home/skuribay/git/linux/include/linux/swab.h:57: error: redefinition of '___swab32'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:69: error: previous definition of '___swab32' was here
/home/skuribay/git/linux/include/linux/swab.h:68: error: redefinition of '___swab64'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:75: error: previous definition of '___swab64' was here
/home/skuribay/git/linux/include/linux/swab.h:158: error: redefinition of '__swab16p'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:168: error: previous definition of '__swab16p' was here
/home/skuribay/git/linux/include/linux/swab.h:171: error: redefinition of '__swab32p'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:181: error: previous definition of '__swab32p' was here
/home/skuribay/git/linux/include/linux/swab.h:184: error: redefinition of '__swab64p'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:201: error: previous definition of '__swab64p' was here
/home/skuribay/git/linux/include/linux/swab.h:227: error: redefinition of '__swab16s'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:172: error: previous definition of '__swab16s' was here
/home/skuribay/git/linux/include/linux/swab.h:239: error: redefinition of '__swab32s'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:185: error: previous definition of '__swab32s' was here
/home/skuribay/git/linux/include/linux/swab.h:252: error: redefinition of '__swab64s'
/home/skuribay/git/linux/include/linux/byteorder/swab.h:205: error: previous definition of '__swab64s' was here

I don't have the latest kernel which could make i2c-designware.c
driver built-in right now, so I'm not sure it works or not there.
I hope this works with the latest LMO tree.

> @@ -222,11 +225,19 @@ struct dw_i2c_dev {
>  
>  static u32 i2c_dw_readl(struct dw_i2c_dev *dev, int addr)
>  {
> -	return readl(dev->base + addr);
> +	u32 value = readl(dev->base + addr);
> +
> +	if (dev->swab)
> +		return swab32(value);
> +	else
> +		return value;
>  }
>  
>  static void i2c_dw_writel(struct dw_i2c_dev *dev, u32 b, int addr)
>  {
> +	if (dev->swab)
> +		b = swab32(b);
> +
>  	writel(b, dev->base + addr);
>  }

Now I understand the background of the patch, so my question is,
is this worth run-time probed?  In this case, DW IP's endian is
different from CPU endian, and which can not be resolved via io/swab
settings in any way, that's fine.

Then I wonder is there any way to statically optimize them?

Note that I'm not objecting against this patch, just would like
to search for a better way if available!

-- 
Shinya Kuribayashi
NEC Electronics
