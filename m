From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] i2c: I2C_RCAR should depend on HAS_DMA
Date: Sun, 22 May 2016 11:45:47 +0200
Message-ID: <20160522094547.GQ29375@bigcity.dyn.berto.se>
References: <1463902715-12680-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463902715-12680-1-git-send-email-geert@linux-m68k.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Geert,

On 2016-05-22 09:38:35 +0200, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
>     drivers/built-in.o: In function `rcar_i2c_dma_unmap':
>     i2c-rcar.c:(.text+0x6f06c6): undefined reference to `bad_dma_ops'
>     drivers/built-in.o: In function `rcar_i2c_dma':
>     i2c-rcar.c:(.text+0x6f07e2): undefined reference to `bad_dma_ops'
>     i2c-rcar.c:(.text+0x6f0838): undefined reference to `bad_dma_ops'
>=20
> Add a dependency on HAS_DMA to fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/i2c/busses/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2dd40ddf04de3117..8ffb0d7015b0f4fe 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -985,6 +985,7 @@ config I2C_XLP9XX
> =20
>  config I2C_RCAR
>  	tristate "Renesas R-Car I2C Controller"
> +	depends on HAS_DMA
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select I2C_SLAVE
>  	help
> --=20
> 1.9.1
>=20

--=20
Regards,
Niklas S=F6derlund
