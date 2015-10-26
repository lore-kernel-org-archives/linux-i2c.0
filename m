From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: Enable Cadence driver for ARM64
Date: Mon, 26 Oct 2015 14:32:36 +0000
Message-ID: <20151026143236.GK597@x1>
References: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36118 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbJZOcl (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Oct 2015 10:32:41 -0400
Received: by wicfx6 with SMTP id fx6so116998932wic.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2015 07:32:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Joachim Eastwood <manabian@gmail.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>

Regarding your address list -- it's too big.  Most of your addressees
don't care about this patch.  Please be more selective when sending
patches to people, most of us have enough (relevant) mail as it is.

> This IP is available on Xilinx ZynqMP.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b86178e8fb..d54c0e6d65d8 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -422,7 +422,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> =20
>  config I2C_CADENCE
>  	tristate "Cadence I2C Controller"
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARM64
>  	help
>  	  Say yes here to select Cadence I2C Host Controller. This controll=
er is
>  	  e.g. used by Xilinx Zynq.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
