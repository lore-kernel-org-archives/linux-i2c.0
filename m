From: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Subject: Re: [PATCH] i2c: Remove unneeded inclusions of <linux/i2c-id.h>
Date: Sun, 26 Sep 2010 21:34:31 +0100 (IST)
Message-ID: <alpine.DEB.2.00.1009262133560.30315@skynet.skynet.ie>
References: <20100923114638.763f2c33@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100923114638.763f2c33-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Vincent Sanders <support-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Antonino Daplas <adaplas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maik Broemme <mbroemme-NVDgbhxX80LddJNmlsFzeA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> These drivers don't use anything which is defined in <linux/i2c-id.h>.
> This header file was never meant to be included directly anyway, and
> will be deleted soon.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>

Acked-by: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>

for all the drm bits.

Dave
.
> ---
>  drivers/gpu/drm/i915/intel_drv.h      |    1 -
>  drivers/gpu/drm/i915/intel_i2c.c      |    1 -
>  drivers/gpu/drm/nouveau/nouveau_i2c.h |    1 -
>  drivers/gpu/drm/radeon/radeon_mode.h  |    1 -
>  drivers/i2c/busses/i2c-ibm_iic.c      |    1 -
>  drivers/i2c/busses/i2c-nuc900.c       |    1 -
>  drivers/i2c/busses/i2c-pxa.c          |    1 -
>  drivers/i2c/busses/i2c-s3c2410.c      |    1 -
>  drivers/video/aty/radeon_i2c.c        |    1 -
>  drivers/video/i810/i810.h             |    1 -
>  drivers/video/intelfb/intelfb_i2c.c   |    1 -
>  drivers/video/savage/savagefb.h       |    1 -
>  12 files changed, 12 deletions(-)
> 
> --- linux-2.6.36-rc5.orig/drivers/gpu/drm/i915/intel_drv.h	2010-09-21 11:09:57.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/gpu/drm/i915/intel_drv.h	2010-09-23 10:21:14.000000000 +0200
> @@ -26,7 +26,6 @@
>  #define __INTEL_DRV_H__
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  #include "i915_drv.h"
>  #include "drm_crtc.h"
> --- linux-2.6.36-rc5.orig/drivers/gpu/drm/i915/intel_i2c.c	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/gpu/drm/i915/intel_i2c.c	2010-09-23 10:21:11.000000000 +0200
> @@ -27,7 +27,6 @@
>   */
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  #include "drmP.h"
>  #include "drm.h"
> --- linux-2.6.36-rc5.orig/drivers/gpu/drm/nouveau/nouveau_i2c.h	2010-09-21 11:07:13.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/gpu/drm/nouveau/nouveau_i2c.h	2010-09-23 10:21:17.000000000 +0200
> @@ -24,7 +24,6 @@
>  #define __NOUVEAU_I2C_H__
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  #include "drm_dp_helper.h"
>  
> --- linux-2.6.36-rc5.orig/drivers/gpu/drm/radeon/radeon_mode.h	2010-09-21 11:11:28.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/gpu/drm/radeon/radeon_mode.h	2010-09-23 10:21:21.000000000 +0200
> @@ -36,7 +36,6 @@
>  #include <drm_dp_helper.h>
>  #include <drm_fixed.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  
>  struct radeon_bo;
> --- linux-2.6.36-rc5.orig/drivers/i2c/busses/i2c-ibm_iic.c	2010-09-21 11:07:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/i2c/busses/i2c-ibm_iic.c	2010-09-23 10:20:54.000000000 +0200
> @@ -41,7 +41,6 @@
>  #include <asm/irq.h>
>  #include <linux/io.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_i2c.h>
>  
> --- linux-2.6.36-rc5.orig/drivers/i2c/busses/i2c-nuc900.c	2010-09-21 11:07:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/i2c/busses/i2c-nuc900.c	2010-09-23 10:21:00.000000000 +0200
> @@ -16,7 +16,6 @@
>  #include <linux/module.h>
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/init.h>
>  #include <linux/time.h>
>  #include <linux/interrupt.h>
> --- linux-2.6.36-rc5.orig/drivers/i2c/busses/i2c-pxa.c	2010-09-21 11:07:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/i2c/busses/i2c-pxa.c	2010-09-23 10:21:08.000000000 +0200
> @@ -22,7 +22,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/init.h>
>  #include <linux/time.h>
>  #include <linux/sched.h>
> --- linux-2.6.36-rc5.orig/drivers/i2c/busses/i2c-s3c2410.c	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/i2c/busses/i2c-s3c2410.c	2010-09-23 10:21:04.000000000 +0200
> @@ -24,7 +24,6 @@
>  #include <linux/module.h>
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/init.h>
>  #include <linux/time.h>
>  #include <linux/interrupt.h>
> --- linux-2.6.36-rc5.orig/drivers/video/aty/radeon_i2c.c	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/video/aty/radeon_i2c.c	2010-09-23 10:20:45.000000000 +0200
> @@ -7,7 +7,6 @@
>  
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  
>  #include <asm/io.h>
> --- linux-2.6.36-rc5.orig/drivers/video/i810/i810.h	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/video/i810/i810.h	2010-09-23 10:20:49.000000000 +0200
> @@ -17,7 +17,6 @@
>  #include <linux/agp_backend.h>
>  #include <linux/fb.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  #include <video/vga.h>
>  
> --- linux-2.6.36-rc5.orig/drivers/video/intelfb/intelfb_i2c.c	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/video/intelfb/intelfb_i2c.c	2010-09-23 10:19:43.000000000 +0200
> @@ -32,7 +32,6 @@ USE OR OTHER DEALINGS IN THE SOFTWARE.
>  #include <linux/fb.h>
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  
>  #include <asm/io.h>
> --- linux-2.6.36-rc5.orig/drivers/video/savage/savagefb.h	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc5/drivers/video/savage/savagefb.h	2010-09-23 10:20:42.000000000 +0200
> @@ -13,7 +13,6 @@
>  #define __SAVAGEFB_H__
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c-id.h>
>  #include <linux/i2c-algo-bit.h>
>  #include <linux/mutex.h>
>  #include <video/vga.h>
> 
> 
> 
