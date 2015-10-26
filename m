From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Mon, 26 Oct 2015 08:17:46 +0000
Message-ID: <20151026081746.GC597@x1>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, James Hogan <james.hogan@imgtec.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ray Jui <rjui@broadcom.com>, Tejun Heo <tj@kernel.org>, Andrew Bresticker <abrestic@chromium.org>, Scott Branden <sbranden@broadcom.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Pawel Moll <pawel.moll@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, Xudong Chen <xudong.chen@mediatek.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Wolfram
List-Id: linux-i2c@vger.kernel.org

> This series adds two I2C controller drivers.
> (they are completely different IPs.)
>=20
> The first one is a very simple FIFO-less I2C controller,
> which is used on some older UniPhier SoCs.
>=20
> The other one is higher-performance I2C controller with TX/RX FIFO,
> used on newer UniPhier SoCs.

And you have sent this to me because ... ?

> Changes in v2:
>   - Delete if-block after platform_get_resource()
>   - Add I2C_FUNC_SMBUS_EMUL to functionality
>   - Add bindings document
>   - Add entry to MAINTAINERS
>   - Delete if-block after platform_get_resource()
>   - Add I2C_FUNC_SMBUS_EMUL to functionality
>   - Add bindings document
>   - Fix a typo in a comment block
>=20
> Masahiro Yamada (2):
>   i2c: uniphier: add UniPhier FIFO-less I2C driver
>   i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
>=20
>  .../devicetree/bindings/i2c/i2c-uniphier-f.txt     |  25 +
>  .../devicetree/bindings/i2c/i2c-uniphier.txt       |  25 +
>  MAINTAINERS                                        |   1 +
>  drivers/i2c/busses/Kconfig                         |  16 +
>  drivers/i2c/busses/Makefile                        |   2 +
>  drivers/i2c/busses/i2c-uniphier-f.c                | 584 +++++++++++=
++++++++++
>  drivers/i2c/busses/i2c-uniphier.c                  | 441 +++++++++++=
+++++
>  7 files changed, 1094 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphie=
r-f.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphie=
r.txt
>  create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
>  create mode 100644 drivers/i2c/busses/i2c-uniphier.c
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
