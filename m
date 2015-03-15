From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: match return type of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 11:02:41 +0100
Message-ID: <20150315100240.GF6770@katana>
References: <1423395596-2591-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423395596-2591-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Fugang Duan <B38611@freescale.com>, Yao Yuan <yao.yuan@freescale.com>, Fabio Estevam <fabio.estevam@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, Kaushal Butala <kaushalkernelmailinglist@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 06:39:56AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int.=20
> An appropriate variable of type unsigned long is introduced and the
> assignments fixed up.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Fixed variable name to 'time_left' and applied to for-next, thanks!


--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVjAAAoJEBQN5MwUoCm2BUsQALEjtZF9q9lt5bnUiembkFfI
6dnS+gELFZGBZ0BMVJA5QCORV04YWAusDiqF1/qofq21hogTrGNCmGqkFojF0JkA
I9xRtu7EfrEtKuK9e7qUSvmXSVNueAQaAU6CpJtVYS6cg9wi2jUUkxO3el8+LRFv
AnpOW5yiFpJMqSon8uAlPMw+QgvnLlJzeOdb4/B3bKXhePrsfyqhuyQ6Og42yicE
VeW252zYt8lngmaj26MYBjp9oNQF7yKuKPZkw8PG2cdCrS6jrzmb7YAmqYDGKy5Z
gZO/0duZg5I6nX2mxRbCLVlPmqZcrSLT3IQghUrBXMPgXHNanr6UoRHIi/TaVUQ+
ObSRv53mL611lD7t0fvCnoBsx6vSNIzEU1pDJ6cbwejcabvZIa0cn7bp9UwLJD3r
m7ORNGpBPlT2oT8BZkFdQRWNcmL3fIURs6dGVqigdBnkGZK38fOxIc7fHZRQZcyK
b4sMJ1OnzMZRNuo7zKdvnlejDh6rmVGPm/6rsQY7NNln48pAbOVIsh/Q0iVpd91m
Dl4ttz04DmOYySVvk0GoS+7T/omyBZL9B16aUZ6prsXHwrGq4uzSxYutURKrk22i
FkeGP8uUOxcp67cMvIKKH6+gx1XgRPMeJmQRdM0C6E1CpUtXPZkeDmkuUtXKtsO6
ghV60b7dtvILS/sWIXn+
=yr+I
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
