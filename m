From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/2] i2c: rk3x: add support for rk3228
Date: Mon, 14 Mar 2016 23:23:47 +0100
Message-ID: <1737352.02BE0tcSEc@diego>
References: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38302 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbcCNWX5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 18:23:57 -0400
In-Reply-To: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yakir Yang <ykk@rock-chips.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

Am Montag, 14. M=E4rz 2016, 11:09:15 schrieb Yakir Yang:
> Enable the I2C core for this SoC.
>=20
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 4 ++--
>  drivers/i2c/busses/i2c-rk3x.c                      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt index f0d71bc..0=
b4a85f
> 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> @@ -6,8 +6,8 @@ RK3xxx SoCs.
>  Required properties :
>=20
>   - reg : Offset and length of the register set for the device
> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2=
c" or
> -		"rockchip,rk3288-i2c".
> + - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2=
c",
> +		"rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
>   - interrupts : interrupt number
>   - clocks : parent clock
>=20
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-r=
k3x.c
> index 9096d17..3dcc5f3 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -855,6 +855,7 @@ static struct rk3x_i2c_soc_data soc_data[3] =3D {
>  static const struct of_device_id rk3x_i2c_match[] =3D {
>  	{ .compatible =3D "rockchip,rk3066-i2c", .data =3D (void *)&soc_dat=
a[0] },
>  	{ .compatible =3D "rockchip,rk3188-i2c", .data =3D (void *)&soc_dat=
a[1] },
> +	{ .compatible =3D "rockchip,rk3228-i2c", .data =3D (void *)&soc_dat=
a[2] },
>  	{ .compatible =3D "rockchip,rk3288-i2c", .data =3D (void *)&soc_dat=
a[2] },
>  	{},
>  };
