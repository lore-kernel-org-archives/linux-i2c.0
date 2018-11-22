From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
Date: Thu, 22 Nov 2018 21:02:02 +0100
Message-ID: <20181122210202.6af50fcc@bbrezillon>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor Soares <vitor.soares@synopsys.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Thu, 22 Nov 2018 17:54:54 +0000
Vitor Soares <vitor.soares@synopsys.com> wrote:

> From: Vitor Soares <soares@synopsys.com>
> 
> This patch slipts dw-i3c-master.c into three pieces:
> 	dw-i3c-master.c - contains the code that interacts directly with the
> 	core in master mode.
> 
> 	dw-i3c-platdrv.c - contains the code specific to the platform driver.
> 
> 	dw-i3c-core.h - contains the definitions and declarations shared by
> 	dw-i3c-master and dw-i3c-platdrv
> 
> This patch will allow SOC integrators to add their code specific to
> DesignWare I3C IP.

Isn't it too early to do this change? Can't we wait until we have a SoC
that actually embeds this IP?

> 
> Signed-off-by: Vitor Soares <soares@synopsys.com>
> ---
>  drivers/i3c/master/Kconfig          |   9 +-
>  drivers/i3c/master/Makefile         |   5 +-
>  drivers/i3c/master/dw-i3c-core.h    | 214 ++++++++++++++++++++++++++
>  drivers/i3c/master/dw-i3c-master.c  | 299 ++----------------------------------
>  drivers/i3c/master/dw-i3c-platdrv.c | 112 ++++++++++++++

I'd prefer to have a dw/ subdir where you'd place all dw files.

>  5 files changed, 349 insertions(+), 290 deletions(-)
>  create mode 100644 drivers/i3c/master/dw-i3c-core.h
>  create mode 100644 drivers/i3c/master/dw-i3c-platdrv.c
> 
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 8ee1ce6..fdc6e46 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -5,9 +5,14 @@ config CDNS_I3C_MASTER
>  	help
>  	  Enable this driver if you want to support Cadence I3C master block.
>  
> -config DW_I3C_MASTER
> -	tristate "Synospsys DesignWare I3C master driver"
> +config DW_I3C_CORE
> +	tristate
> +
> +config DW_I3C_PLATFORM
> +	tristate "Synospsys DesignWare I3C Platform driver"
> +	select DW_I3C_CORE
>  	depends on I3C
> +	depends on HAS_IOMEM
>  	depends on !(ALPHA || PARISC)
>  	# ALPHA and PARISC needs {read,write}sl()
>  	help
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index fc53939..004ad1c 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,2 +1,5 @@
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
> -obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
> +obj-$(CONFIG_DW_I3C_CORE)		+= dw-i3c-core.o
> +dw-i3c-core-objs			:= dw-i3c-master.o
> +obj-$(CONFIG_DW_I3C_PLATFORM)		+= dw-i3c-platform.o
> +dw-i3c-platform-objs			:= dw-i3c-platdrv.o

Do we really have to create one module for the core and one per SoC?
Can't we have everything in the same .ko?
