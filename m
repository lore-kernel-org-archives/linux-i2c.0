From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: xlr: fix extra read/write at end of rx transfer
Date: Tue, 15 Dec 2015 13:21:19 +0100
Message-ID: <20151215122119.GB1521@katana>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
 <1446429818-24155-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446429818-24155-2-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 02:03:37AM +0000, Mans Rullgard wrote:
> The BYTECNT register holds the transfer size minus one.  Setting it
> to the correct value requires a dummy read/write only for zero-length
> transfers as it is impossible to request one from the hardware.  If a
> zero-length transfer is requested, changing the length to 1 and setting
> "buf" to a dummy location allows making the main loops less convoluted.
>=20
> In other words, this patch makes the driver transfer the number of bytes
> requested unless this is zero, which is not supported by the hardware,
> in which case one byte is transferred instead.

Uh, this is wrong, zero byte should really not transfer anything. We
need to fix that and bail out, so probably something like

	if (!len)
		return -EOPNOTSUPP;

Also, the xlr_func() should mask out I2C_FUNC_SMBUS_QUICK.

Other than that, the patch looks good to me.

Out of curiosity, your first driver had the registers 32bit apart. Now
you can deal with 8bit. Is this configurable on this SoC?

Thanks,

   Wolfram


--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcAW/AAoJEBQN5MwUoCm2i50P/jM4OYjz1GzcKzTEctOrFdOl
xtSqMo+/Hss4xDlaW8KdHT6Ks5sDdbOQ6B5FHLdT0kxBfLR1A8HbItBuxJtIL6Nm
Cwvz0X/gG3x9AM1U8XvxrfB+ei7l/y3kQ4iAkcCGhbsyRZvrk9cPEiu+9f5RleDS
RJNP4VrMV6RAG2l3SRHZnTS5pnO5zEOAcmwnkkHSKZWj3zmDI5ULYsFZBu/iC2Bp
Zy0+NNDzhN+FCe98Oej5+h2pq0YF0OKXZbZER3VY9eYRX+YKhaKx8VJug7i02ZCC
MflMXtNZtGdUuFRKNanJjgnQbUT3r9XAyiRAnL7KZ+JMjLL9t/mKGFJKsrY9BWW7
ILEUuphdXPSobIFBtyRm+EqWVma2nbQCR8BFT+ueONCOTZpSiMM8M3wbuISAbyg/
1En/WEKgvYC0xT0Ae5NKsgydsbGCkVfJssxV/uIL+IKnh1zvWPJyNJb5Tb9OT094
lm8XLiKW7tpWcGylnnCTSAks7vWTHIgBHahiQWYQXgVyyveVPlZrh91nwmdvKiuh
bvGZic0cpi0XBTj0z+uSbPM09a2TuhZci7qXAGbPvJSXz3+dZJW1sT+KPFlZjdrD
gqNRD7TYtICEXIJA47Yp06MCUQlxr0itZqoChTuAkUJBfeldFlnziCmBiVMzUCj5
IV0n8Ernh7IR+Kjz20QX
=t38g
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
