From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/15] ARM: ux500: Remove unused i2c platform_data
 initialisation code
Date: Wed, 9 May 2012 10:46:53 +0200
Message-ID: <CACRpkdZ70FasMuTTgBe68xaePB-4UNZ0W44BCxDve7fqXYT+vg@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
	<1336155805-18554-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336155805-18554-3-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Now that u5500 is obsolete, u8500 is the only user of the Nomadik
> i2c driver.

Well actually arch/arm/mach-nomadik has this block too,
but it's not making use of it right now, so why not.

> As such there is no requirement to differentiate between
> initialisation values. By the time a new SoC is released, almost all
> of the ux500 platform will be DT:ed, so we can make decisions based
> on the compatible property instead.
>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

So why not copy the contents of arch/arm/plat-nomadik/include/plat/i2c.h
into drivers/i2c/busses/i2c-nomadik.c and delete that header from
plat at the same time?

Then there sure is no way for platforms to sneak in any platform
data any other way.

Yours,
Linus Walleij
