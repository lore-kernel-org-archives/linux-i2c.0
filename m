From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 0/5] Add I3C subsystem
Date: Mon, 31 Jul 2017 22:47:01 +0200
Message-ID: <20170731204701.GD1542@katana>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <20170731191745.GB1542@katana>
 <20170731224019.737bc624@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170731224019.737bc624@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-i2c@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I agree this is the least invasive and also the most compatible
> > approach. The other solution would probably be to have some kind of
> > emulation layer?
>=20
> Could you detail a bit more what you mean by "emulation layer"?

Not really. That was more a extremly high level approach of what
theoretically could be possible. When I try to think about details, it
gets pretty invasive.

> > Since the spec is not public, details about the protocol will be
> > especially useful, I'd say.
>=20
> Okay, I'll see what I can do.

Thanks.


--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/l0EACgkQFA3kzBSg
KbZaUg/+Pdq9jD3nwEz6XxA3GUALJZyhNoH2Uri/Lb82XDQy5DaJuvVvyFyy94GY
3N/4g9orfiUH/1Py+vq87BNAQ/oU5mgw1VgwX8KZ9DxmfXyJfNl07+IVEqhGPJUi
pZcCFuCcmBqTQVCe9kC0A2Jwp//Q3CXg9JAhq6KW61LJfqjXp0c3HFpmFgqjSjFW
q9t8rvO+J9OObrhHecqiTjX4gAawGyWA7QETB7ish1eiTC/rZokeM+sGO2o0boRr
igOshYb0i486gObSQ0fDpTl8VY+qIAsV68nQVdPZjibiNWYSmEKk87rV6CW3Ionl
yVhH+NyVSCi69HDQ1D1CApFIdmMnGeqn1fErGjkhrcOByNBipEczNFmFEAHccw7l
mQ5v6F/nxFwJDDbWzZKO7d9GNQM6qSm09ly6C4dx0pz3+cyGn+1h/cMen0Nb18Yb
vs09UemXWXg7wVw9I2nn0HGOT6muFB3YAYkUZZ6E2bA2FwDRm0OYENUJ8k5jelwW
RjN64Zn8EKlxBFuEpfZlpogfAos+aDEw/AhwESpzd2DpbZzdXPBeK5a+J8rH0zMb
HBNaKL7bNXgtEVzyLRVWcgcgHQrUY/GrMNiVLi8ykdpdetFe83ojV+1S+rqu9xL7
tlADDykq7vKbFKVguDFTqP6mxgKFV6K8X6wttE82PbLrAoA4Gyw=
=W/zc
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
