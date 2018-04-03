From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
Date: Tue, 3 Apr 2018 17:01:39 +0200
Message-ID: <20180403150139.l7oec4doafmsidfp@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9147165970046067010=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============9147165970046067010==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nsfyatgpqm7a6nes"
Content-Disposition: inline


--nsfyatgpqm7a6nes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> - switch to generic recovery using minimal helpers to drive the SDA/SCL lines
>   directly

If you had added this incrementally, reviewing would have been easier (=
faster). The callbacks look okay...

> - don't recover on every error

... but you are now never recovering. You don't call i2c_recover_bus().

> - add patch to sanity check i2c_transfer() arguments in core code (#3)

See small comment there.


--nsfyatgpqm7a6nes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDl1MACgkQFA3kzBSg
KbbHhw//Zpf1v0NYoiMaDpdWR/XBIUH6tOLcUk5nUIy3SHgQrnRqTe5UKjdALscf
H5cYseyJIYBtwmoPcYLp8BX7K2SpfyoU/59AMfgz1FhBg10dBWp8J3ataFAHuxpp
eoHuc5odvBv8+t73/eTZZmmSaQ0yB9CPGxCh5vrvftcCb4JIfVhfOdk8iRLzej11
1f498KQsxrVj5RVMfkll2BvTJ6MWjDJWAIElrva8OLsCXE9Gia1rj9QXYGAb3phk
6cJll507TeIYwTguGEQZicfqb49BUxcXATtjbSDoQ8POwRHIq2lwryWO54Xj0XBV
ff0+rAHNp7o94B02a0opIUClt0lfuZMy51Cfo19342PYm28/aFmI4nKVlCv2+7Ro
ESyMj4fQrrNjruiQHumX+l1efgWN5ApKDCI0GN+bujA3Jq1CJQZMGKHRx6p41XXI
XKyc+tfXnSlCZF6s5+TPdqxE/+o6xWEuOfFcB+/YypyzsUK4HQW6FZHLSuFHL4k/
qQ2OIMo7BhUHUatJ3Fkvg885YjSYk+76BVqwUFi/uAxWboiBUskrtRkjAzJlRGK+
vhMZMc/jAHbYtN3sQdv+pgZ2xkZLXzG+jKnRMzsv4scxG11gPnqsvdxOQi9TVX4x
D90BmH/2aIobT2x9Azn1gTZmQLjFMPKYOHR7rQzIM+dF9hyBeSA=
=dZ+W
-----END PGP SIGNATURE-----

--nsfyatgpqm7a6nes--


--===============9147165970046067010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9147165970046067010==--
