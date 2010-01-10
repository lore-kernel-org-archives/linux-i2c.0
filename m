From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2 0/2] I2C driver support for Nomadik/Ux500
Date: Sun, 10 Jan 2010 13:15:29 +0000
Message-ID: <20100110131529.GE1224@trinity.fluff.org>
References: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1262944133.git.srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, sachin.verma-qxv4g6HH51o@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 08, 2010 at 04:00:24PM +0530, srinidhi kasagar wrote:
> This is the v2 version of the patch which adds support for the
> ST-Ericsson's I2C block found in U8500/Nomadik 8815 platforms.
> 
> ---
> Changelog v1->v2
> - file rename from i2c-nmk.c to i2c-nomadik.c (Jean Delvare)
> - remove the unnecessary return statement (Jean Delvare)
> - kernel doc style comment fix & other fixes (Linus Walleij)
> - Added support for 400 KHz.
> 
> - patch 1/2 : targets plat-nomadik folder
> - patch v2 2/2 : fixes the above comments.
> ---
> 
> srinidhi kasagar (2):
>   ARM nomadik: add platform specific i2c configuration structures
>   i2c: Add support for Ux500/Nomadik I2C controller
> 
>  arch/arm/plat-nomadik/include/plat/i2c.h |   37 ++
>  drivers/i2c/busses/Kconfig               |    7 +
>  drivers/i2c/busses/Makefile              |    1 +
>  drivers/i2c/busses/i2c-nomadik.c         |  980 ++++++++++++++++++++++++++++++
>  4 files changed, 1025 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h
>  create mode 100644 drivers/i2c/busses/i2c-nomadik.c

I'll get round to reviewing the new patches in the next day or two.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
