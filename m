From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv7 08/11] i2c: match vendorless strings on the internal
 string length
Date: Mon, 14 Nov 2016 23:27:07 +0100
Message-ID: <20161114203208.GA4207@katana>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-9-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ak2bzy2z6b4uvhhz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478522866-29620-9-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--ak2bzy2z6b4uvhhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 12:47:43PM +0000, Kieran Bingham wrote:
> If a user provides a shortened string to match a device to the sysfs i2c
> interface it will match on the first string that contains that string
> prefix.
>=20
> for example:
>   echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
> will match as3711, as3722, and ak8975 incorrectly.
>=20
> Correct this by using sysfs_streq to match the string exactly
>=20
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

Any objections that I squash this directly into patch 2? It is more like
a bugfix, no?


--ak2bzy2z6b4uvhhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYKjo7AAoJEBQN5MwUoCm2sT0P/15AGOvbg5KbR8cGUbb/UF95
h96HDt9tsMsFZu+YU5qtpAnc8icoizU7VKknohJ0jjbtjYM4JP4vvfc4+chOP2kk
AyRYVhjcz1oJr9tkHaoVGjQPuq0/kTc0Kd7PKm+hUXZYYt1B1Pmu0rJ3kQGGc0Sh
rO6SrV/bJJgw1kZNy3d7eSY70DbLj/pgB7dctk54xjpyN7yu3a+wMqsalTaI+bnk
yKr6d9WFXSRXPrCknLHeTCXfw336wTrGhL5IiHVn/CweZB/s/twnnWtSrVRGNoRt
99i8C0kyrbQv1B45gXxcJJBAy+NEKcgSvweKNsJVhq1iWYovf4u7buGvcu0a0zIn
W2oukfIZHm4vfN8crI0nGpTm/1G3kShxlm/mnVSGv/72AGjMqsQGaIfXjAeM9Kdv
p7z33o11qMElS/TjhF3IdBsbcVfpBXB4nu1ruY4gVoNP/dIUhPv6FMt4EBW6Mmqg
tS3nXGwjZKQfAKeU6FGF2aVYpw9FKqlCo2UVkshSZFpvQCkvcjjPR8oXMxZYpjO4
350hmPPPYM8GXGnKg6hzJL0uhqrQ3WsswuojXTkOa9mx6ecZYmjtUYHLNUaAPyAG
4LcmmCI36escWDI9d+3Ktc6ScRVUCGBYQk2M6ea6MNzhQc+7iJFGC4M8Fz3WInCg
rF6xjunnyX4KkJPDuB38
=E0NS
-----END PGP SIGNATURE-----

--ak2bzy2z6b4uvhhz--
