From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: mediatek: fix i2c multi transfer issue in high
 speed mode
Date: Sun, 3 Jan 2016 19:38:43 +0100
Message-ID: <20160103183843.GF1522@katana>
References: <1450164146-28995-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8281895243844750701=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1450164146-28995-1-git-send-email-liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8281895243844750701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2015 at 03:22:26PM +0800, Liguo Zhang wrote:
> For mt8173 platform with auto restart support, when doing i2c multi
> transfer in high speed, we should ignore the first restart irq after
> the master code, otherwise the first transfer will be discarded.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Applied to for-next, thanks!


--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWqyAAoJEBQN5MwUoCm2RgsQAJdqDRsdEYZi80ghsfkdazIG
2uWr8wBbJBqQluhUGHVxnUcSoo7Fp98nj5Kw8bfLUjgf0IcSHPvdyY91TfwerqwJ
mA76CK+kdtD0buq0lWR/NFpVi0mn2NMxdrCWENzzyY2B7SCOkn6tVLgU82eJyL/f
9RpgRMFheFJyb6U+EIafHJkTNq14cpWosqQaCSepAE0e3yXLoEtIgh8evPURP7Ss
mWbcs/r/rgoNOR/3tgJTwkO2IANigo1ug5+03ySlT61hn1Wwi9iApMNX4R25g+vs
rON2qlf0R8YtDv0/4VZlGuX3GpF/YtreolU1oydJXhcdgi0PV3Qb0dW+kBINXiE3
UnPuYz7+vJtt5GcB42bBxUWHDfcoFQfkAgnouvzBOTPiZUjsyll4RXD5rtXKZJjp
h3Jw1DX+eV/PqqOwV9VAAtDKToOY8s1rPAP1qcymFo+gFr9tvsrjpWW7DJ05Cuty
+Tbqo+BtEsBNrNLr5XDWNONYJVghmWcuJCyi8kRlutVNKjWk6SqRUj/ddJ9vIuF7
rU5sHKT4M4Ha7fEJQSi/7XKmLdTjJtaiaGqzRMB5dVOTWYQ/j/kPM0OShlL5H+TK
7SxBjtrtH0IsFgemJydhpJ2QAhu8Knx2giS9oBXvblj67+hBHN7YNXhzJmIPnK04
YLPZPS8YJ8openblu1WW
=S09g
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--


--===============8281895243844750701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============8281895243844750701==--
