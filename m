From: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Drivers shouldn't include <linux/i2c-id.h>
Date: Sat, 13 Nov 2010 12:34:23 -0200
Message-ID: <4CDEA1EF.407@infradead.org>
References: <20101105210753.4d1a03bc@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101105210753.4d1a03bc-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LMML <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Hunold <michael-nMDb6ONjQAQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Em 05-11-2010 18:07, Jean Delvare escreveu:
> Drivers don't need to include <linux/i2c-id.h>, especially not when
> they don't use anything that header file provides.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Michael Hunold <michael-nMDb6ONjQAQ@public.gmane.org>
> Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

I suspect that you want to include it via your tree, so:
Acked-by: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/media/common/saa7146_i2c.c    |    1 -
>  drivers/media/video/ir-kbd-i2c.c      |    1 -
>  drivers/staging/olpc_dcon/olpc_dcon.c |    1 -
>  3 files changed, 3 deletions(-)
> 
> --- linux-2.6.37-rc1.orig/drivers/media/common/saa7146_i2c.c	2010-11-02 09:19:35.000000000 +0100
> +++ linux-2.6.37-rc1/drivers/media/common/saa7146_i2c.c	2010-11-05 15:34:25.000000000 +0100
> @@ -391,7 +391,6 @@ static int saa7146_i2c_xfer(struct i2c_a
>  
>  /*****************************************************************************/
>  /* i2c-adapter helper functions                                              */
> -#include <linux/i2c-id.h>
>  
>  /* exported algorithm data */
>  static struct i2c_algorithm saa7146_algo = {
> --- linux-2.6.37-rc1.orig/drivers/media/video/ir-kbd-i2c.c	2010-11-02 09:19:35.000000000 +0100
> +++ linux-2.6.37-rc1/drivers/media/video/ir-kbd-i2c.c	2010-11-05 15:34:18.000000000 +0100
> @@ -44,7 +44,6 @@
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/workqueue.h>
>  
>  #include <media/ir-core.h>
> --- linux-2.6.37-rc1.orig/drivers/staging/olpc_dcon/olpc_dcon.c	2010-11-02 09:19:37.000000000 +0100
> +++ linux-2.6.37-rc1/drivers/staging/olpc_dcon/olpc_dcon.c	2010-11-05 15:34:14.000000000 +0100
> @@ -17,7 +17,6 @@
>  #include <linux/console.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_device.h>
> -#include <linux/i2c-id.h>
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
>  #include <linux/interrupt.h>
> 
> 
