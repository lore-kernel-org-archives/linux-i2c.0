From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add support for Xilinx XPS IIC Bus Interface
Date: Wed, 23 Sep 2009 14:31:32 +0200
Message-ID: <20090923143132.7962dd62@hyperion.delvare>
References: <4ABA07F4.5090108@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ABA07F4.5090108-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?ISO-8859-15?B?UvZqZm9ycw==?= <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Sep 2009 13:35:16 +0200, Richard R=F6jfors wrote:
> This patch adds support for the Xilinx XPS IIC Bus Interface.
>=20
> The driver uses the dynamic mode, supporting to put several
> I2C messages in the FIFO to reduce the number of interrupts.
>=20
> It has the same feature as ocores, it can be passed a list
> of devices that will be added when the bus is probed.
>=20
> Signed-off-by: Richard R=F6jfors <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
> ---
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8206442..6b291e8 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -433,6 +433,16 @@ config I2C_OCORES
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-ocores.
>=20
> +config I2C_XILINX
> +	tristate "Xilinx I2C Controller"
> +	depends on EXPERIMENTAL && HAS_IOMEM
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Xilinx I2C controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called xilinx_i2c.
> +
>  config I2C_OMAP
>  	tristate "OMAP I2C adapter"
>  	depends on ARCH_OMAP
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index e654263..a2ce5b8 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_IXP2000)	+=3D i2c-ixp2000.o
>  obj-$(CONFIG_I2C_MPC)		+=3D i2c-mpc.o
>  obj-$(CONFIG_I2C_MV64XXX)	+=3D i2c-mv64xxx.o
>  obj-$(CONFIG_I2C_OCORES)	+=3D i2c-ocores.o
> +obj-$(CONFIG_I2C_XILINX)	+=3D i2c-xiic.o
>  obj-$(CONFIG_I2C_OMAP)		+=3D i2c-omap.o
>  obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi.o
>  obj-$(CONFIG_I2C_PNX)		+=3D i2c-pnx.o

You have an interesting notion of alphabetical order.

--=20
Jean Delvare
