From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 11:08:24 -0800
Message-ID: <20181115190824.GJ2089@sirena.org.uk>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vCQF5Fh1eN3mBuH/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115135731.25f60990@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: vitor <vitor.soares@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org


--vCQF5Fh1eN3mBuH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 01:57:31PM +0100, Boris Brezillon wrote:

> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.

Yes, this is much safer and more robust especially if the bus has
enumeration requirements like you're saying it does.  It's much easier
and more sensible to do this if the bus can be enumerated than it is
with SPI, USB would be a good example here I guess (though I've never
looked at the details of how USB does this on the implementation side=20
so this may be me speaking in blissful ignorance).

I do agree that there will be use cases that turn up for this.

--vCQF5Fh1eN3mBuH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvtxCcACgkQJNaLcl1U
h9Cwqgf9FzaFIpuw5W1ZNyAo/CrKG9CG7oGaFJL30zMrjp4pW4+47CHwCNFgWYa8
934xtfIiTiMP+TJgyRu9HkkW1/FnQQbjPUFG1sDZxDUJIrAyRpJNySUqr9gIbW0V
d/ghzX8St9zFvrvzm7aILWbwC35lbjpSFIb2pXhtril67M5ZbWBNlRONJIAXePLR
4uPM5hr202hXDVw3EJOHb5M/q+SneMMei60TIMep9qYBI/zSGHIcUUEc/nDkgU3p
gLkitVuEv1M3Imj+KmB+dnVFP5GGijN5yq5zcuKMpBoxPgt9TBpelkpFTO1ncelW
1GZMkdv9qBVLAmGo7gaP5scgYnFr/w==
=HYvt
-----END PGP SIGNATURE-----

--vCQF5Fh1eN3mBuH/--
