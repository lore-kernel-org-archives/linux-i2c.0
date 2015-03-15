From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: ismt: fix type of return var of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 11:02:58 +0100
Message-ID: <20150315100258.GG6770@katana>
References: <1423382611-24463-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423382611-24463-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 03:03:30AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. As=
=20
> ret is in used for other calls a new appropriately typed variable timeout
> is added to handle wait_for_completion_timeout=20
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Fixed variable name to 'time_left' and applied to for-next, thanks!


--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVjSAAoJEBQN5MwUoCm2WucP/1xk1Z5hekrqtGSA4nu7GX6r
f55q49D1s8idviXMOhLe1cz/AbVxEJz8u4DEeciX3WNwxcrRumCUDW2y5VploYmb
b3qCoBDeUURTvF+IGUnaQszCDFASxhowvUHbDZWkWXuQXCQ0WEwtFQenD6ZD3ZX3
vj6+E2nEbMb+NdMeBaLwrrI0rrYlWFLZM16peRqGmtAiaEgOIlD8KZA8sM+xe6cC
TvGzbNbC2/SAFR7DRS7GIM/i9mK9SvEQwl551vsTIpgpgm/K+RpQQYWUK6aD7xNh
G33mQDtkbdpchXQ+eO/G7eE5FZYRHXPEq3GI3caIj1SBTSmvWU/CHbf8BKswS4xW
73tPtZN9DezhhJ+mDrW1uUvje9vKzXrONuGVkqv8bEO7GMx/khnzzgBrbyR7zkhp
N+4F3okuASmF1uKS+pyQaH5lYyMBKbHt9TV/ZmEzrMrNW6sLEy4aLYdtkEZ3Ml/B
t86fL6Fn7eWgznuvD4EwDe0Z9mx3Vq5bynq92J2AHbBzH9BdPJ5yYxrjxLCohZuw
0rSYI28q1NUCzwiNFY+omIOj6n4+6cds+cYOj3LyB5RodKh6o7cXtqL/CiNMgcDv
EEyW8s8vkQAEufVj+QqLUfzpfJMCvWSn/B11lT3SwMlk1BQHzqrknGLVh2qO6S56
HwNSZKTYppM2Uayoq+hW
=uhQf
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
