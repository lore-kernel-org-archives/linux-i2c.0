From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: nomadik: match status to return type of read_i2c
Date: Sun, 15 Mar 2015 11:02:19 +0100
Message-ID: <20150315100218.GD6770@katana>
References: <1423398883-24687-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423398883-24687-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 07:34:43AM -0500, Nicholas Mc Guire wrote:
> return type of read_i2c() is int not u32. As the assignments to status
> are consistent with int here its type is changed to int.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBViqAAoJEBQN5MwUoCm2iLYP/1DLKstYsd+NKKAsUsXBNqy/
IZKtYglcOnYRu0UYGxC0agrW1oyUMUxJac7crbXSXEe/6UCrid24igj/I1xwLpz2
RTSBe9/ox2VDidffx/Gb+dYoX8WepeJUgD5WHylg2w0DBkG5mhs5n0qqcWvJyy3N
bQfKEjZzchr8OYc96RYcqJds4FCuxrTIF4FWvWMCFYd/yBtiwdfh7pewk1fe7hpB
y1IBYCCuF685RQpBad6Phl/uvAjsgXcNZRWJZlexx2zOmXIOMqRc0ggXjBx8vXML
JnAfzqbhkQK1tz0NYXi+O78yf7bpVYAtdjDqjRjaWxHjcp0M6BYkIOoafYoh6i+b
YwAcRxhtvsAlWsO5PTdFPCV52Bab3RXNf4zt59UgGwHXyq4eZf2kshQnGmF07dRL
dgDB+H8Nwiz7BqzLlGIXx9ilxxyFzTCfrp/lvhmJdVjkWUeDFauapN81/dAJnrBL
oXSHl3f4sJ3UOf+emHFWhTC+bSr8puxd2KcW72OOCVz8tCyVdDVZX1658+LV56K3
i3PaTX+yBh7zV0ap1t0CeCMGVkxIOljTRh3+93b2esiyzF80HkwOj/8+ttcKFcCS
bUo/INKjGZWKdyd+YWWtH0+2UcITxQMJhjMAOGHTMQWzUJ+kkUNinE5LXq58xJb2
qxFidQPvJBtBTm+5H++d
=mKoa
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
