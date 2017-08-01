From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 19:27:03 +0200
Message-ID: <20170801172703.GA2737@katana>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon>
 <20170731214211.GA11776@tetsubishi>
 <1538596b-80ed-7800-db97-70e73b90b9e2@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538596b-80ed-7800-db97-70e73b90b9e2@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'm surprised they didn't allow for slave clock stretching when
> communicating with a legacy i2c device, it will prohibit use of a rather
> large class of devices. :(

Yes, but I3C is push/pull IIRC.

> As for interrupts you are always free to wire up an out-of-band
> interrupt like before. :)

Yes, my wording was a bit too strong. It is possible, sure. Yet, I
understood that one of the features of I3C is to have in-band interrupt
support. We will see if the demand for backward compatibility or "saving
pins" is higher.


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmAueMACgkQFA3kzBSg
KbbOow//VRF0acsc9HmV4bEcTZJwiiHER6G15l+GI4eaHcHxxK3xnjBZykh73SHh
I1TvBVUTJQyiVbsc/jypBfhfPgIeMgcLDMfKKQJfR67im6/6yIY84qtxBCKemGhf
l3q5p1nEjnKjK9KpQ1nLoKBgQy27L1lO1gMIECGoGBz+9piSm1hGjg7tO3ecmq+Q
OV7UVbb9iJX/4gMZ0ot4pCj0sha3puemoC77Wtix5RCWDhjgSaV+0De0jJNdDV2L
XKIZlAoICFIReVRSlyzlamXH3WsCSHbV4pWS/gwhmWAChhuQn2vW1HIsfq5QztTf
QphJYqdLoy9qLaRzrJls0wPWRA0FirfKfyJhWdQuZ3kn+pU1el49dj6GM1v32PSk
howTjyGpufWnvfgOwGrkndMTx4fiamH9yFfG4ci3OPG4akpup7uEzGvWPCzOypUz
KoJNiIDbmWOGWfxr8p3ExAt8wQIDfFmp4mRnFi4ruKSh9Ry+dR4v9Ho56PV/vBLm
ZRWxAPAPBmEtJfxSaWL1Bd2LuynwvGcv8bTqDHgFFBC7xaOz/fAxYxsUk/DThZG4
3c+e8aFMu1aX+nIb2kaUv0clXd7ULg3k8ZRsmQiD+Xj700IG6W1gd///39jIGdZ5
rJVLzLczJq3l55/cyRnn0+ug+aAFmzOKax6c7t6q/7WKGV2fP6k=
=1e44
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
