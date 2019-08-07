From: Alexander Stein <alexander.stein@mailbox.org>
Subject: Re: [PATCH] i2c: imx: Allow the driver to be built for ARM64 SoCs such as i.MX8M
Date: Wed, 07 Aug 2019 14:09:24 +0200
Message-ID: <2445092.UF1PKDTzN1@ws-140106>
References: <20190807114332.13312-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190807114332.13312-1-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Juergen Fitschen <jfi@ssv-embedded.de>, Ajay Gupta <ajayg@nvidia.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Vignesh R <vigneshr@ti.com>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Paul Cercueil <paul@crapouillou.net>, Kamal Dasu <kdasu.kdev@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, August 7, 2019, 1:44:06 PM CEST Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The imx I2C controller is used in some ARM64 SoCs such as i.MX8M.
> To make use of it, append ARM64 to the list of dependencies.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 09367fc014c3..46b653621513 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -664,7 +664,7 @@ config I2C_IMG
>  
>  config I2C_IMX
>  	tristate "IMX I2C interface"
> -	depends on ARCH_MXC || ARCH_LAYERSCAPE || COLDFIRE
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE || COLDFIRE || ARM64

I don't think this should be necessary at all as ARCH_MXC is also available for arm64, see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig.platforms#n167
I rather wonder why ARCH_MXC is not set. Same for fec.

>  	help
>  	  Say Y here if you want to use the IIC bus controller on
>  	  the Freescale i.MX/MXC, Layerscape or ColdFire processors.
> 
