From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
Date: Tue, 3 Apr 2018 20:12:16 +0200
Message-ID: <20180403181216.f22vtkqrnxjgreuo@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1362120823652869469=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
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
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============1362120823652869469==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sv4khltp42aic7yg"
Content-Disposition: inline


--sv4khltp42aic7yg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Yeah, good point. So when exactly should this be called? Only on error
> conditions that could be caused by a misbehaving slave?

Chapter 3.1.16 of the I2C specification, only when a slave keeps SDA
low. Usually you detect that before you start transmitting.

Really, please remove it for now and add it later, properly tested!

BTW what kind of tests did you do with this driver so far?


--sv4khltp42aic7yg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDw/sACgkQFA3kzBSg
KbaLBg//cFhYfifNVLV6ld/aiiE9RI5N2d//JSHnWhla9iQWqc83LjZrb6vLZs70
g5Il9+BNQPWCjmHDVsMIYOdQq6BLGTfpZ8JmYjj23MeWnlDAWVz3u8sOCkNbd7a2
h3CUh1aDNSJ0n+dkguuu8KKctcMJ45PFSM6RcWWzaDod196J0qFHgyPef7loxbRp
a3dr1ZsvJlKoWIz/1xKTWwIimkYiZdabSDUNeMnrzek+ehioS4KMcqD0ujnKjAhH
9ZyZRTxWRasDg8eIc2DIjDsU2umscw8kWBJtlAtQePbVVUrpsfKZQjGJYtIDxDuZ
1Bvfhda4fcAl2nVAsA9iFAaxiOEewP1hc+SpDYihLQpLRKZb0MxSWD5rqbfeU/G8
EWuh4ktU2i5d7Bn+0A3XGL331aeBpx5HJ5jW0hOP2jXtSGJwJB94DLo7TQhFyoWe
iZAUmUUHBeAkRZe9NYTGbpN8PaKkVWw3iPflxI00q3sWqcmssDH6DI2HTCTOIOrN
9v+koBycqujeHRwBIv7Lz8vv1S8wlneqEoPT75bCIpZmPh9FPY5iSTEGyvwA3/1T
it0XcNsMjK1ry/veySsbJqApsRpcfFo0Tf/Fn9EVGzXr3nT97o7Pq2UtFCqjVXzu
Ndkp3NUJ/ixzbG7LTo1vm+2dVO5C/sxcoQYNpW7K6eBAuRcQ6YQ=
=UXCV
-----END PGP SIGNATURE-----

--sv4khltp42aic7yg--


--===============1362120823652869469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1362120823652869469==--
