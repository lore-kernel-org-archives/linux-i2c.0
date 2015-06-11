From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC]: Supporting PIO mode of operation in i2c_msg->flags
Date: Fri, 12 Jun 2015 08:41:19 +0900
Message-ID: <20150611234118.GA1534@katana>
References: <5562EF9D.1090403@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5562EF9D.1090403-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Current implementation:
> --------------------
>=20
> Everyone probably does have their own custom implementation for this.
> Or some other mechanism to achieve this (may be hardware support).

Do you have examples? It is easier to look at code.

> /* We can also check i2c_check_functionality(adap,I2C_FUNC_PIO) */
> 	if (msg->flags & I2C_M_PIO) {
> 		/* PIO mode operation */
> 	} else {
> 		/* non-pio mode of operation */
> 	}

I'd rather let the core decide. Like introduce a master_xfer_nosleep
callback and let the core use the standard or the nosleep one. We'd need
the same for smbus as well.

This leads to the question if we need a M_FLAG or expose the *_nosleep
functions directly?

And I wonder about the demand for it. There are a number of SoCs with
designated I2C cores for the PMIC which do automated transfers.


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVehyeAAoJEBQN5MwUoCm2v1sP/RM2PHpmVrQB0Aj570KtpOtB
JNbBnNgWs3ZRMZSAfMve1yx4utuBLSukjrq+9EZvaP82bEoBmC1WXm+vVGZAmEdq
nO6CQmjHI2ZMnscKGJlQ8bfUZvt6ZFMIfQXdO+orcYV1Yy2fvtxjr1VDh8S92N/k
VyHVdrkXYBORtDpHlSvRLLtttHMosDLVCXx9m9NIRrANhAK6b8DQ6gOZb3IU/Ooi
/0E11xqKQ/3yYWW1HT98MtXPNbffuq0AuDAlINQ7EmsBfIGwbz14CIfDExkEVAhQ
Xdqk2UZNShc2BxEMJylFaq1VYVhQY/CGuPZ64FJAE2T3w5kTWlk9vivqEsN4r4fn
B3itiR+yxAfbMzDFT2Ds7IDYsN4Z8GuFMy6P7nMAunkTJK8DE2URweduuntnZJ4W
vPNMMkuWzVVGOFKUjVATbD2euB/bf/y7SyaU8Wni8ctTtwypOzrBNV0CC+lhrBxL
sXCAyp5hySfaw7HmBjQhUkM3oVN7IRf9IIuhX6z2P7oJ+VFYXk/3HRsLrSo6jlj3
e6RvvMFxcRs/vchfQyFND55PawChsrq8U/acObts4uUAGuSw1vydSFsD6vqgTBQ8
z6g5L5ymYjxkY1qMwbNMNWhcEkWTWaonJXwuZUVWXSTgd8vVELFdRYhkNKDCcgbU
fwoq95Kutq3HonMYIBJQ
=CRME
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
