From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 1/2] Documentation: devicetree: Add i2c binding
 for mediatek MT2701 Soc Platform
Date: Thu, 9 Feb 2017 17:35:32 +0100
Message-ID: <20170209163532.ulv33rz4jzwrn4zf@ninjato>
References: <1484732461-13594-1-git-send-email-jun.gao@mediatek.com>
 <1484732461-13594-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5466852371063574705=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484732461-13594-2-git-send-email-jun.gao@mediatek.com>
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


--===============5466852371063574705==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pytdljq32yyrxvld"
Content-Disposition: inline


--pytdljq32yyrxvld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 05:41:00PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> This add i2c DT binding to i2c-mt6577.txt for MT2701.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-mt6577.txt
> index 0ce6fa3..ef22ecf 100644
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
> +	"mediatek,mt2701-i2c", for i2c compatible with mt2701 i2c.
> +	"mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> +	"mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> +	"mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> +	"mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> +	"mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
>    - reg: physical base address of the controller and dma base, length of=
 memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.

Are there no driver changes needed? It currently lists only 3 of the
above. If so, that would be nice to be mentioned in the commit message.


--pytdljq32yyrxvld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlicmlQACgkQFA3kzBSg
KbaskA/+LYSblw3MpmBpTuxIu5vFnn+DPkT3yVkBpB56P+8UvniRoYlBUPqey8yP
aaA5aBiY52vLsEL/AniO5iqRnPfVp3bWaLm0yaxt6sOhjZnElQMg+9VOGbZkaG7J
YC+9i1q+wH4q9HXTeF7j5sx148ZsM27kExkQbL7Y7NaGKgDULIxgwC6Xh6iR4SVw
uqqdIy7pP6+ZPFu7cyS91n/9WjePHb4abh8WtQVRYBy9DI9LVOem+FsssKrI/pc6
E3NBfJIZrnqe+7XVF9ZXwDNqleF7v+TOrvwDKUn5OXdcVcJmzvf0epU9KOazdUL+
140dzEGyXN9Gp+1//di83aEJh57cCu+Pum/pWRWeQKfPY/oMJPADOeit0R/E8dut
ECu9Gv1bsev4RjL81b9mZ297TTStEFQ2oJfsmA8e9mvETclrR5TMfIYLM2CQRXDb
4PsSP8pE/3dFji5QF6jLwjwaoaQnlMPSXbKkmcQsmh4GvLdcEWahHVUEyE6WosxK
RLv55Yo+HMkCJcmX3HFzcynd/g0n1ckGP0CFUgxmcCoXtTFJwCtrVU3gn4EEJ4ZQ
ow4dhBvEQg+ff4EGwmdlpaYogPEUgc0KrgYqziSHUXK5fPDgYbi+jsLGFzKDsZeu
UYbw/GDuwQvHxoW5jT1OXw2xYuQHZem+eUauHjuQWV1o1IdYWto=
=A757
-----END PGP SIGNATURE-----

--pytdljq32yyrxvld--


--===============5466852371063574705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5466852371063574705==--
