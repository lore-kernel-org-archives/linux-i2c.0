From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/4 v2] i2c-i801: Make interrupt mode more robust
Date: Wed, 12 Nov 2014 16:28:05 +0100
Message-ID: <20141112152805.GA4031@katana>
References: <20141112101931.5f8c196a@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141112101931.5f8c196a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 10:19:31AM +0100, Jean Delvare wrote:
> Hi all,
>=20
> This is a patch series aiming at making the interrupt mode of the
> i2c-i801 driver more robust. A number of driver lock-ups have been
> reported on a few systems over the past few years, all related to
> interrupt mode. So let's make it more tolerant to unreliable hardware
> or whatever the actual problem is.
>=20
> i2c-i801: Use wait_event_timeout to wait for interrupts
> i2c-i801: Fallback to polling if request_irq() fails
> i2c-i801: Check if interrupts are disabled
> i2c-i801: Drop useless debug message

Applied to for-next, thanks!


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY3yEAAoJEBQN5MwUoCm2msMP/05tReXj2+ihNXUHvudtW6Zh
YnW5oR4+hBBFHCoGgIM65CJHkbMVTYu3JO2LxfuxI13+I2m7TRef6BMH9XJ8rZtW
1xhjhrA8Fx5xarmLwepyNcmlhZCWjdZtW53fuYIE/SfmCaaQLBLx5ZjNoTfVOVVi
YM2hC/zBtdFe9/yrAVBlwLq3B0b1klb4V0irrbLrIwhxZsWNp0xMlzFah+RXtjVF
a01nATP6clQoyKk/NJ5x9IcUvu95v0qW9boPlRevyhCEb6WdN/qcmc78mKrknMwH
eVRe92p9P/wLISpsDLH8D44FwQxWxB2JbXZWqxEtF2OjmgHrKcgMAOhWHVokCoMT
imOIw40CwHs/c2z3q3YfMnif3930Eh3xngHNKTqqTK4S4OhfzdgYKcIPwPQk4m6r
R5FSpnC0BjYVWIiuf6ja1P/Cqitp2AXB3ZfnQRT0CvrqECrxBkKpEyi7ihY2tL2g
h/W1eXtsc80sSSEkTxGalNNB22Fkl/xLG9UXkRZykNnyVwN18qJxgeH9JPqWy/P6
/Ij0ZKs5wOb4sAN+nyLfooAmRKDgLZTGBymoKdFfSshCp6CVb6CFz4VqPkfH9wly
DCzPnAuDd+SlUI2lxmN1NwK5J5rRYlQJvzSX69jRed0sOMFdyDMehXEKNKyZdcCx
Q1Hyy7rtpApB/zYVXxMr
=ubiq
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
