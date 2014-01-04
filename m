From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 04/13] i2c: isch: Use devm_request_region()
Date: Sat, 4 Jan 2014 22:23:46 +0100
Message-ID: <20140104212346.GD3150@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002801cefaf4$69243d70$3b6cb850$%han@samsung.com>
 <007501cefb93$32ca0df0$985e29d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <007501cefb93$32ca0df0$985e29d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jean Delvare' <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 10:48:07AM +0900, Jingoo Han wrote:
> Use devm_request_region() to make cleanup paths simpler.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

OK, this got reviewed. Applied to for-next, thanks!


--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSyHviAAoJEBQN5MwUoCm2LqkQAJ/UnKHxpES1ZocpYx+kvwxO
s0WV4cqmpUCONoNdzgH3vUSr4mIQ4NMUxfgcm7DJ1ZSWug/cFhsVWgM2TPAcfGPA
Jhv0HFrlH9PgeA5nrPxEKnrKLlDT8eGeHCvq9pG4R21eEK69JtF/hZYDIZ/VgMk1
gDg1SiAy2blcSShqx5xxBM6WP7+ah+wGXOogTCU6HXgbLXbXKWXAALXp9rlg2qBW
dXOBkvl1cJ0WTgUuUE4+xm1reci1Dze4JnH6kdA66L1DYL93eYxNZppLSzem82Fm
i1RfpTJfCSGHw2kc0xhQNjf3NSW5b9uWAUx+VGREce/70e83T1NgOFQn/AfAXRYx
j8IL2uz/DgYgvvF3Lz88kNCtuZspCm2+4dTbmBHedsle1DJCEYvubt4N0WcEjN9o
DKZi/qmo5Tjt8G8T6wqWCH4sIba1bRM/O5HfJogCOsAeG4KRzUvTT8Q4/ATuG4eB
CAk8RO3LoLFUoorn0QwfsALylZHDuASH/UGFkS4uVUwgRy0FrJUnOFUECthKDM/E
jd4wz0FBryufh5a0lwU1hSCc3lInbSmyoaNhRm3wMvuZoWUlvkviVhI6ho6zMETP
mfrn8GOBSS5kRcXpimi0T42iutdEX39i8qy946281F4Qw+OchK4Dm4i1AZ1/LB7X
/uuuroSYDfFi+ErAfmTg
=tRmW
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
