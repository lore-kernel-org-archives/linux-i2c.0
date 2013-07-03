From: Christian Ruppert <christian.ruppert@abilis.com>
Subject: Re: [PATCH linux-next] i2c-designware: use div_u64 to fix link
Date: Wed, 3 Jul 2013 10:44:31 +0200
Message-ID: <20130703084429.GB19130@ab42.lan>
References: <1372758414-21513-1-git-send-email-vincent.stehle@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372758414-21513-1-git-send-email-vincent.stehle@freescale.com>
Sender: linux-next-owner@vger.kernel.org
To: Vincent Stehlll <vincent.stehle@freescale.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 02, 2013 at 11:46:54AM +0200, Vincent Stehlll wrote:
> This fixes the following link error:
>=20
>   drivers/built-in.o: In function `dw_i2c_probe':
>   of_iommu.c:(.text+0x18c8f0): undefined reference to `__aeabi_uldivm=
od'
>   make: *** [vmlinux] Error 1

Looks good. I also tested it on our ARC based platform, no issues with
compilation or functionality. Thanks for pointing this out.

Reviewed-by: Christian Ruppert <christian.ruppert@abilis.com>

> Signed-off-by: Vincent Stehl=E9 <vincent.stehle@freescale.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Christian Ruppert <christian.ruppert@abilis.com>
> Cc: Pierrick Hascoet <pierrick.hascoet@abilis.com>
> ---
>=20
>=20
> Hi,
>=20
> Linux next-20130702 link broke for ARM config multi_v7_defconfig. Thi=
s is with
> gcc 4.7.2 but I am not sure it matters much here.
>=20
> This patch repairs the link.
>=20
> It did not break anything for me on i.MX6 sabre sd, but it does'nt ha=
ve a
> designware i2c, so more reviewing/testing is welcome.
>=20
> Best regards,
>=20
> V.
>=20
>=20
>  drivers/i2c/busses/i2c-designware-platdrv.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2=
c/busses/i2c-designware-platdrv.c
> index def79b5..4c5fada 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -122,7 +122,8 @@ static int dw_i2c_probe(struct platform_device *p=
dev)
> =20
>  		of_property_read_u32(pdev->dev.of_node,
>  					"i2c-sda-hold-time-ns", &ht);
> -		dev->sda_hold_time =3D ((u64)ic_clk * ht + 500000) / 1000000;
> +		dev->sda_hold_time =3D div_u64((u64)ic_clk * ht + 500000,
> +					     1000000);
>  	}
> =20
>  	dev->functionality =3D
> --=20
> 1.7.10.4
>=20
>=20
>=20

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
