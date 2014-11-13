From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add I2C bindings for mt65xx/mt81xx.
Date: Thu, 13 Nov 2014 19:16:50 +0100
Message-ID: <20141113181649.GG1275@katana>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
 <1415078977-18374-2-git-send-email-xudong.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415078977-18374-2-git-send-email-xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 01:29:35PM +0800, Xudong Chen wrote:
> Add devicetree bindings for Mediatek Soc I2C driver.
>=20
> Signed-off-by: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         | 39 ++++++++++++++++=
++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-mt6577.txt
> new file mode 100644
> index 0000000..733e65e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> @@ -0,0 +1,39 @@
> +* Mediatek's I2C controller
> +
> +The Mediatek's I2C controller is used to interface with I2C devices.
> +
> +Required properties:
> +  - compatible: value should be either of the following.
> +      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> +      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> +      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> +      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> +  - reg: physical base address of the controller and dma base, length of=
 memory mapped
> +    region.
> +  - interrupts: interrupt number to the cpu.
> +  - clock-div: the fixed value for frequency divider of clock source in =
i2c module.
> +    Each IC may be different.

? Doesn't that platform have CCF and can't we derive an I2C clock there?

> +  - clocks: clock name from clock manager
> +  - clock-names: clock name used in i2c driver probe

This needs names of the clocks. Check other binding documentation for
examples.

> +Optional properties:
> +  - clock-frequency: Frequency in Hz of the bus when transfer, the defau=
lt value is 100000.
> +  - mediatek,have-pmic: platform can control i2c form special pmic side.
> +    Only mt6589 and mt8135 support this feature.
> +  - mediatek,have-dcm: platform has DCM(hardware digital clock manager) =
property.
> +  - mediatek,use-push-pull: IO use push-pull mode.

About the last 3 ones: Can't we encode this in the driver? Like, if the
compatible is "mediatek,mt6589-i2c" we know it has this and that but not
this?

> +
> +Example:
> +
> +	i2c0: i2c@1100d000 {
> +			compatible =3D "mediatek,mt6577-i2c";
> +			reg =3D <0x1100d000 0x70>,
> +			      <0x11000300 0x80>;
> +			interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> +			clock-frequency =3D <100000>;
> +			mediatek,have-pmic;
> +			clock-div =3D <16>;
> +			clocks =3D <&i2c0_ck>, <&ap_dma_ck>;
> +			clock-names =3D "main", "dma";
> +	};
> +
> --=20
> 1.8.1.1.dirty
>=20

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZPWRAAoJEBQN5MwUoCm21mwP/19ldP8KxrJErVJG1I508pR4
FPluToB8zPG/cboC5kjm3Hy1mbr3HlNE2gsjJgo+4ltkTmwwem/y85EQvxl3VEY7
q6zqJ7m8cN4XU/uLyU0Upf1811Mx/TS19E5LjiaTBOdc7etcOloFruARRZnkAvg7
wDf9TqJAWwDwSCvqy888DWNqR9eMpjLkA0qGPAYnTHPnIDiUIpcWZyfVU+5bqw5o
/uAjlyKREMXNewEoCMYl59W2S3gu4KX3EGNbpmIwxrGRZiyhla+Bngt64RSQy7nT
iKZTEsUtpAZAH10TU1ckuEi7WiGrK4+8J8lauwGBKd6G0knplOwkNfiEf7e3Tt+J
UP/enGOAAlnsn2PDaN72iI2OAJ1LxmDTpeGMHFCeuLbr6NBa8WZ4M1KGA2qBOuSS
1aCHWMIHNiAKU8jMLTFe2HkqywKVrfIi5snBh7/nPNTJCRb3r8Hes9CG7Rdky76k
MaYIe+I5zS4bXrH54HgUEGuA5+WLD9/8Y4FjzyhzMWxO4EW5Z9VBZaYX80aWUsbj
rtQFLMeFxkErFOWKxJcuCWpuXja9OCPz/XSp4wqsKx4Yh1baFWdQ6Zj/0HVwqcYP
fpyrmBTVpiCHAFPNzB4IzxuVj4ZMwqQW8goSsx7w0qyyBzuujxG8g3KytXw9g4PG
mro1YU+vk+OcIcqK3NaK
=1nCo
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
