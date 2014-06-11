From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support
Date: Wed, 11 Jun 2014 10:47:57 +0200
Message-ID: <4433415.Jcexj2E6Ru@wuerfel>
References: <1402475980-15513-1-git-send-email-boris.brezillon@free-electrons.com> <1402475980-15513-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402475980-15513-3-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 11 June 2014 10:39:40 Boris BREZILLON wrote:
> The P2WI controller looks like an SMBus controller which only supports byte
> data transfers. But, it differs from standard SMBus protocol on several
> aspects:
> - it supports only one slave device, and thus drop the address field
> - it adds a parity bit every 8bits of data
> - only one read access is required to read a byte (instead of a write
>   followed by a read access in standard SMBus protocol)
> - there's no Ack bit after each byte transfer
> 
> This means this bus cannot be used to interface with standard SMBus
> devices (the only known device to support this interface is the AXP221
> PMIC).
> However the P2WI protocol is close enough to SMBus to be integrated in
> the I2C subsystem (see this thread [1] for detailed reasons that led to
> integrating this driver in the I2C subsystem).
> 
> [1] http://www.spinics.net/lists/linux-i2c/msg15066.html
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index c94db1c..a6023fe 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -771,6 +771,18 @@ config I2C_STU300
>           This driver can also be built as a module. If so, the module
>           will be called i2c-stu300.
>  
> +config I2C_SUN6I_P2WI
> +       tristate "Allwinner sun6i internal P2WI controller"
> +       depends on MACH_SUN6I && RESET_CONTROLLER

One very minor comment: I wonder if we should make this 

	depends on RESET_CONTROLLER
	depends on MACH_SUN6I || COMPILE_TEST

instead so we have better build coverage. I haven't tested if building
on other architectures works, or if there are additional dependencies.

No need to change this if there are no other comments.

	Arnd
