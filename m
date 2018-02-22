From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: bcm2835: Set up the rising/falling edge delays
Date: Thu, 22 Feb 2018 12:21:12 +0100
Message-ID: <20180222112112.ctjfibmk6vppbrcp@ninjato>
References: <20180208135405.25446-1-boris.brezillon@bootlin.com>
 <20180221084259.o6754bfe4k2hcwhj@ninjato>
 <87h8qayp8v.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7183272451520095996=="
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <87h8qayp8v.fsf-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============7183272451520095996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54zjhqvur63ajoqj"
Content-Disposition: inline


--54zjhqvur63ajoqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Could you provide a Fixes tag if you think this should go to stable?
>=20
> It would be a fix back to the start of the driver, but should apply
> cleanly back to:
>=20
> Fixes: 9446f62e8e18 ("i2c: bcm2835: Add support for dynamic clock")
>=20
> and over a year ago seems like plenty of backport.

Thanks for the input. I simply added stable now, so people can apply it as
long as it fits. I didn't use the above Fixes because it did not really
introduce the issue.


--54zjhqvur63ajoqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqOp6gACgkQFA3kzBSg
KbYQQhAAgjNQ6AORocI7Q5DTdaa4hiXZHLTk7iPaJwNlTdyo4TH5UKplop93qoVJ
2xvcnxpaF1RNPffUXl4BhPM7iai6BbW2pquvmldhKnyL+RF7rF1vuogjoDFeH9bc
18TEFHrNb3aK4PKXaIsvXAKYx+CJexKIKgqT33xSzfUXgSATqOzw28iPVuQfeaIw
63i1CABXKe4qaOHBxNaoHOTvdmF9LDkHpHFqtd0Gio4CQ92Xc74Xe4dH0ZnY+GFP
vv0MFwWKra8fRl97DAUI3c6K5xFzdg38VkNuQkVsIZDV/+mdovZ8468V3Q6dlKLe
ldvu5i4zK/jcGuRSlCiObnNf503U+QRkrMGzoMSiVJCeED/axz3jCICH7xhjZ9gt
V7907PRagl36UY9B6BRn6Udg7l4EGkqYaZOuT6fGj4bXz5xAewZtrufiWIa+9I2r
lBlem1QBOGO4/of3C2fQomLuPeeRY8RuJqrgiWDVB9e3YASs0XPlcBzqboF+dt15
4vez5vXOgMAYTUVGveKjylZaF6zt40H7Z5wDgbABiGEArlJxOGlzOW7XZpmsyoOF
NdLILS0eOt9g1ZhkJSntCYzaKhkYPO5fd9nwFAGk5i+65bXB5ESAhipOiA8gi8OC
ukw4guNSj/e6i5N1SL7fClwce7Hnf0SJOMHQXg5CoK80lyFzoeA=
=HQo0
-----END PGP SIGNATURE-----

--54zjhqvur63ajoqj--


--===============7183272451520095996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============7183272451520095996==--
