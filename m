From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: bcm2835: Add full name of devicetree node to
 adapter name
Date: Thu, 29 Aug 2019 20:52:59 +0200
Message-ID: <20190829185258.GF3740@ninjato>
References: <1566925456-5928-1-git-send-email-wahrenst@gmx.net>
 <1566925456-5928-4-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5007886936825014046=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566925456-5928-4-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5007886936825014046==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 07:04:16PM +0200, Stefan Wahren wrote:
> Inspired by Lori Hikichi's patch for iproc, this adds the full name of
> the devicetree node to the adapter name. With the introduction of
> BCM2711 it's very difficult to distinguish between the multiple instances.
>=20
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied to for-next, thanks!


--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1oHwoACgkQFA3kzBSg
KbaAlhAAn9G0ZUGQTYXFyYIW4w3nIISRT1DCe/hw6DNo3JK7fLdbwHiecrA29Vnx
mgsA5gp2kSreMJlkM6TZRt90QdhCbpswa7MS7r2VH7p+WWtRyBsSD3Uerrkw1vSs
dZJcB/8r/RN9XIo1h3sOChGcS4EoEc9U3aPls3XpUloPhY5lF+XPB/suZnp47tGI
OHCPESXRhFzabYbhr0O16X794BSrLFSe4YIYG7zzuc1hErW5qNTWYGSyOl5t6bar
2vYjvZSf1yyBhsXNDKV+/hwy88Gc0K/VHPU8qcfbIPlnpxYV0l6jYev6ArFEkKN7
st1+LZ7+RPyloqf7ZMkEngYf30cmrLG2AbpRViNjKT5ja+augDMs6vPMh5Uac0Ci
mkc3Xt/YIiVEvE6msBplWGQ7FLIhxAWMmUlZxUVzRg9lSJ35ew3j5UH3pcP1gOcI
XpIFMK73nAx3H83CjFvufIxo4XUkcpJIwaJIsqBC1WN9ygEOp+gJMWNnjYzu8f47
ctklX2fcOSkP1Dy1rTY9qrfsHJeDakD1uYA+eQvYZzLN0wS98kpe2fxEgPYL6+Qj
B4kx98BFaadQIXG3Ae1L8ziOGEWQlSZS/3Rbv1Q3m72Fz9VRNKXmCbJOUdUsfAZi
XFD0Ulkuy16WZYA8gCMe7SU4Ntzm/fGERw+4717jqBRVSxv7utg=
=b2WE
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--


--===============5007886936825014046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5007886936825014046==--
