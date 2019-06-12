From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: acorn: fix i2c warning
Date: Wed, 12 Jun 2019 12:15:30 +0200
Message-ID: <20190612101530.k42zgjzfrxozeynx@ninjato>
References: <E1hajwY-0003Aj-OD@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8439239120433849110=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1hajwY-0003Aj-OD@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============8439239120433849110==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ujig6z743qexizo2"
Content-Disposition: inline


--ujig6z743qexizo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 05:48:18PM +0100, Russell King wrote:
> The Acorn i2c driver (for RiscPC) triggers the "i2c adapter has no name"
> warning in the I2C core driver, resulting in the RTC being inaccessible.
> Fix this.
>=20
> Fixes: 2236baa75f70 ("i2c: Sanity checks on adapter registration")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-current, thanks!


--ujig6z743qexizo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0A0MIACgkQFA3kzBSg
KbbxABAApo3YraVz4iOF0+J+PKPTnSHZ3u7ed5Qmk8KWZAaCv//9m1z76+Sh7qVL
1U/OaqJvMSfkr/r7zWa4AIkJfmzbXYGVAb1CtJM2aJwjo3rDdUHtWKmQZUx3NyhY
2W0GkABqCVzCRphb8MY3UTexn0d7jg2qGzS/iY5tVfbGEpiFI5wFG5ziuQy8uEP3
iF17F+HfA3sLG99XgBwDHCD/qoV/Q4mxwvPiVXXwUQexUdcn1Bjze5abeZ/BAk4Q
L1sLJilnXDp39/E8e1pk7jw3kIbEDhnAax0yl+zLigShanKj7Qh/ck2klymZniH9
7KGT+fPl7gmSsLv2i5qZUmK0Brc3TCpiSlQVxK3M/uH8oWPr7oPW+54JHyGQsfE3
Hs2XL2fc5e08POZgEiCKcSTtz6dUMKXJGJs8IVbIMpfAp0+Y5abRG+xNHwsidi3x
75b91Z3jbXoqDcmaHNaC3xKaaPBpZbeCHmH8rA86AeSrK7CNNACwE6WfRB7918Am
vMvzvcTPeGLn+8+Uto4meCkO55T5CrBgiQS455mCYlC2r0V1JPyIcrbX6fItmKEO
nCMMztMcJ3PU9b+wP0KfGd0NLWaF23l6PLIvZBfFz9Wu99zl1uJ2I3aHV2/mRjQo
dOzLm0/GZnkmHi0/Dh8jul8b6zRzXW1IWqz0ImzARaDT3GjgzBY=
=UXD5
-----END PGP SIGNATURE-----

--ujig6z743qexizo2--


--===============8439239120433849110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8439239120433849110==--
