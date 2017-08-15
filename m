From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/3] mfd: tps65010: move header file out of I2C realm
Date: Tue, 15 Aug 2017 09:19:28 +0100
Message-ID: <20170815081928.kqrmcxwz4mbezpsr@dell>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814163424.2197-3-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Aug 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> Change since V1:
> 
> * rebased to v4.13-rc5, no changes needed
> * acks added. I think none are missing.
> 
>  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
>  arch/arm/mach-omap1/board-h2.c          | 2 +-
>  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
>  arch/arm/mach-omap1/board-h3.c          | 2 +-
>  arch/arm/mach-omap1/board-osk.c         | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
>  drivers/mfd/tps65010.c                  | 2 +-
>  drivers/usb/host/ohci-omap.c            | 2 +-
>  drivers/usb/phy/phy-isp1301-omap.c      | 2 +-
>  drivers/video/fbdev/omap/lcd_h3.c       | 2 +-
>  include/linux/{i2c => mfd}/tps65010.h   | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/linux/{i2c => mfd}/tps65010.h (99%)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
