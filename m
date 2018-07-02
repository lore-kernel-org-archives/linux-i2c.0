From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Date: Mon, 2 Jul 2018 20:24:34 +0200
Message-ID: <20180702182434.5wxxszpgpf6wergl@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023823.i3fmdegn2sric5kx@ninjato>
 <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhxnagpnshnqsemd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org


--yhxnagpnshnqsemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +	if (msg->flags & I2C_M_RD)
> > > +		cmd |=3D I2C_CMD_READ;
> > Since you support MANGLING, I'd think you can easily support
> > I2C_M_REV_DIR_ADDR here, too?
>=20
> Hm, I don't really understand the purpose of that flag. From the docs:
>=20
> This toggles the Rd/Wr flag. That is, if you want to do a write, but
> =C2=A0=C2=A0=C2=A0 need to emit an Rd instead of a Wr, or vice versa, you=
 set this
> =C2=A0=C2=A0=C2=A0 flag. For example:
> S Addr Rd [A] Data [A] Data [A] ... [A] Data [A] P
>=20
> I don't think our hardware supports this type of operation.

I'd think something like this should do:

	if (msg->flags & I2C_M_REV_DIR_ADDR)
		cmd ^=3D I2C_CMD_READ;


--yhxnagpnshnqsemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls6beIACgkQFA3kzBSg
KbbaORAAswydmxmWNfNqtkPEkp+nF0CxGMkNxdsL0sGKq/fRpmUFApwZAu0f8eBm
z3mezjFVsYO99lb4WU4dzSWZgOWx293ruYoFLjza1CE3Vf5HQTpRZCM0eWSWP3/T
tmIIJwivXUbjEuhTQY4SJCAsNZyBMM6ehBotdvU5c9PDnhEqLoMUVJCX/aPIuJLr
AgDamRyUH2crRMx7kaP9fazU4UAGfOlljslFai9zf7+ojgc9YknXTy9tDhUi0EeW
XeRg6yiFygf6obS9d0E3VI3PiFckbqhM9Sq80YeHPNGAq7uQeW98lBRfy74ln+jh
SOWcP1sDz8quX0Hm0Hh5sSKW3GFqviovPbh+wVbKQDik71/i3vS98gcQgOEhYae4
6kUSFfk756f0qfWlzYNIUhABYaEgjOjzpkGu8RIbc2IxD9IAz4CwQAuKKcyuLqMt
QKIx8/g4IOHZlYTYL4VGZrcQ7hEkiBppUefA3vZBP159lByFU90ASCh3VqnDJ0VI
cBJdGkTGHriDOrfV+jGMh34GJtljDPfpYNoeh9wpqfvpXXf+Y29Nk73zHhJo4TWC
3ZRouWXbVyQT+AQGJCR7X6I3m4Vs3FJgD0nlViaDoD0hroQTI0R5p5mtiK3sqWhV
Zz7BPeJ9hiH/TsbgLqyTrWjrGnW+atIDSYnuas/q3qeuOCj743E=
=tcvP
-----END PGP SIGNATURE-----

--yhxnagpnshnqsemd--
