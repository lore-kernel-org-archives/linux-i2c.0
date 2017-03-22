From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c
 binding
Date: Wed, 22 Mar 2017 10:05:44 +0100
Message-ID: <20170322090543.sxacnddn2o7stjnq@ninjato>
References: <1489029185-21447-1-git-send-email-jun.gao@mediatek.com>
 <1489029185-21447-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5765871367057151914=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489029185-21447-2-git-send-email-jun.gao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5765871367057151914==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7yun3mtaxkcmbklo"
Content-Disposition: inline


--7yun3mtaxkcmbklo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 11:13:04AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
> modify i2c driver.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

There is still the issue which Matthias Brugger pointed out on January,
24th: you need to describe the fallback compatibles.

> ---
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-mt6577.txt
> index 0ce6fa3..27dbbf9 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with=
 I2C devices.
> =20
>  Required properties:
>    - compatible: value should be either of the following.
> -      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> -      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> -      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> -      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> -      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
> +	"mediatek,mt2701-i2c"
> +	"mediatek,mt6577-i2c"
> +	"mediatek,mt6589-i2c"
> +	"mediatek,mt8127-i2c"
> +	"mediatek,mt8135-i2c"
> +	"mediatek,mt8173-i2c"
>    - reg: physical base address of the controller and dma base, length of=
 memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.
> --=20
> 1.7.9.5
>=20

--7yun3mtaxkcmbklo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljSPmcACgkQFA3kzBSg
Kbbj7RAAnO/LCOeUWPUOoNhV6SvB8w0aNKMHv+vjT7Ba3mUHCKjC/aYe4sQdJZHf
1nvYHkuLkMJeoI6b4KG8JM+0oEMb8UgNCtI4iroWpsP4fYciirra4HAuDVYzfsSk
anwckn/7Z04jDlOs6VskeDZSnBMJCsCQZ7pPEXGrqlOt0GFtqEs/CZOsNpyfQdYQ
ZNkJjy3DcMaYAK2fKYdLhLWbIZRj1Biz1j15I9+zjIwH1J8oy8jBkvdfvu51yg3c
4PDkw3aIfUGT4vyfxKFmYPD/0gqBSh5dEAtISZJru3B1B1nDqTvx6bQcLaKpZ4l2
53+k56netlffLUEc1Gn3rYlmF5ORdwDcYFcmGX4bTVSbeTyNd8idKHsL76MRHl6G
KcTgxUTF+l0z+gNduXSw2gpXCSyImI55hGrN5V42+5wp8BmoM0epp5Xjk42S+8hq
BkCBy6TxmSa+BQ6w8XHgM+GGWii19kSJMWcHpd8Q90jVKYbi9Yo+ByNhTUq9N7ys
hnueo2z9Z2nhVkRWiXN3FEtXkWfp/+fxC6Ixt69T/o+ALu1InoR4vqaajdcfEVOE
xKRCvufIIF7QyoU3nZEWLz9FnmFOBN3MdntFa3uOLxM/8eVKri2rTcuxQz7jShA3
mGbrQIt7ip/zYUvuofiMfGoxefTUvEGZhSYpIuWl+LKTqLFqV+I=
=zv9q
-----END PGP SIGNATURE-----

--7yun3mtaxkcmbklo--


--===============5765871367057151914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5765871367057151914==--
