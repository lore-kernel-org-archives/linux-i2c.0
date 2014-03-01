From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] i2c: Add driver for Cadence I2C controller
Date: Fri, 28 Feb 2014 19:06:29 -0800
Message-ID: <8af0e222-6337-4ec4-b718-099a9decc5ec@TX2EHSMHS034.ehs.local>
References: <1393632046-20062-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393632046-20062-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Harini Katakam <harinik@xilinx.com>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-02-28 at 04:00PM -0800, Soren Brinkmann wrote:
> Add a driver for the Cadence I2C controller. This controller is for
> example found in Xilinx Zynq.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  .../devicetree/bindings/i2c/i2c-cadence.txt        |  21 +
>  MAINTAINERS                                        |   1 +
>  drivers/i2c/busses/Kconfig                         |   7 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-cadence.c                   | 901 +++++++++++=
++++++++++
>  5 files changed, 931 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence=
=2Etxt
>  create mode 100644 drivers/i2c/busses/i2c-cadence.c
>=20
[...]
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f5ed03164d86..7806c1654068 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -375,6 +375,13 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>  	help
>  	  The unit of the TWI clock is kHz.
> =20
> +config I2C_CADENCE
> +	tristate "Cadence I2C Controller"
> +	depends on ARCH_ZYNQ
This can be reduced to a dependency on COMMON_CLK only, I think.

	S=C3=B6ren


