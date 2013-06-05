From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/9] Fix Marvell mv63xxx I2C driver
Date: Wed, 5 Jun 2013 23:48:22 +0200
Message-ID: <20130605214822.GE2934@katana>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130516202921.GW18614-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 09:29:21PM +0100, Russell King - ARM Linux wrote:
> This patch series fixes a whole chunk of problems with this driver,
> discovered with the Marvell Armada 510 chip on the Solid-run cubox.
>=20
> Most notable of these is the I2C driver aborting a transaction
> because a signal is pending - which might be SIGPIPE or SIGALRM
> for the process.  Meanwhile, the calling driver may be in the
> middle of a critical read-modify-write cycle on a device register,
> causing it to fail.
>=20
> Other problems are race conditions in the handling of multi-part
> messages, where we end up sending multiple start conditions -
> sometimes more times than we have i2c_msg's to send.
>=20
> Lastly is the rather poor probe error handling, which ranges from
> non-existent to lacking propagating the provided error code.

Applied rest of the series to for-next, thanks!


--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRr7IlAAoJEBQN5MwUoCm2ys0P/2qnDyg5CEinH4we1hPFF84Z
JeE7mAWyB6AiLef2+8E4+1LnWlJoF6b8o6nmXf+dqtkN2Uys+ehVyvUqXilkzUvA
hjhTWq+QDa0/FDcDb27XozoTI21a+X/d981mNCyJJGf0CmcEi6uw9VggeL0WS4g8
WQh8hfNw6UTX1wngtI5yMGCGBogUH9jUuDMSZ5OfuTbzCFBeIs5ICTBQ3jXsCG8r
5Jypf6kAs7huFeOUPxMqHCGDCf4VJVQe3neCYQob4baCOclhtsnaQb1kYOTfOn2F
2skcIQMA79r0thDwbFzhcmsB6nAY1Vh+R3L9qdxDYpZYhnbfF7PA7kxGTO8cjukV
275rqrwJmHlEPr33o3OySF/sljViT/xclWqops0iFXSOhtvTY5MnIVBbQKmvWztd
vNf7givDP1OfH+fbgDCQ/5gp1KPnRRS2eCEoEQuR2O2VIv5GVhyXsFB7Lu7MDB4D
PBXlHc3CwmPCR923fXkFgOVlqJ93cD0oXSis/gQ6vR9NZsOsrEf223uK0d3hy31d
d4sxFEfh6zCa3+8fhfLr+EvdAOjAc7sDYpXPPix3KcjJkr4UF7EVIg7RNj7dVsHP
IVe22UdCe3653QSxT5UUpRpBc1Kj++sGq7v+6HlEDyB9aKxXnhreDePxpAykKuId
2/UuyYqd1lIYxIvYZ9SD
=YL3S
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
