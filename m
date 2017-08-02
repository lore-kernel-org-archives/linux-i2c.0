From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Wed, 2 Aug 2017 12:21:38 +0200
Message-ID: <20170802102138.GA1549@katana>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon>
 <20170731214211.GA11776@tetsubishi>
 <1538596b-80ed-7800-db97-70e73b90b9e2@ti.com>
 <20170801172703.GA2737@katana>
 <20170801234738.148a874c@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170801234738.148a874c@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+d>
List-Id: linux-i2c@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yes, my wording was a bit too strong. It is possible, sure. Yet, I
> > understood that one of the features of I3C is to have in-band interrupt
> > support. We will see if the demand for backward compatibility or "saving
> > pins" is higher.
> >=20
>=20
> Indeed, you can use in-band interrupts if your device is able to
> generate them, but that doesn't prevent I3C device designers from using
> an external pin to signal interrupts if they prefer.

Exactly. Thus, "We will see if the demand for backward compatibility or "sa=
ving
pins" is higher" :)


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmBp64ACgkQFA3kzBSg
KbYx2w/9HnA52gby01zn1TcmSs6Rxf7xvDvli1rQ6jgEsAhazTo0lgveE9oL9SsV
uzfN55vAwN1o6EOKLIi7Ol/wYuw9aUfrjYicpDWKfX4fYSVLQ4dWo5+UTIl7nttK
Gs6O3dje9DPOuSfDEMiigRdPBIOrD+8RSqjb3L/gvuxJQ+CkH7pMtDZ6HeokgZRd
VZprsf+//1ij1EMfpfaHmvABrGshHW8dntjur3C9OVomDfNyFS3RLsha6+qoSuI4
jeFhXPjKeBjJW0y/I/5GgZd+d+Wcb6fIEqtHVnlkPzEo7U9pYudiX0aQOnQvO8sN
ewfb4LssCUwiJ65MQyb4D7pq/xv9P2Wbn8bmAOi6zgm+PUfAg1ejvQ3f1OLfIlXZ
C9NXOlLZQQklPsTkt5mIv1quXHClCpCuuwQDKZtUKJGTn3zhEp1JpVQpyudYUl9H
+dAEXIXzd8p2S1uG7jS/0O/yXD5ODIkUx28UWv7jPPagfR7bNO+jactifEmDxdNL
xRRGSYJUdGyugrczUGmOkjlvWB51qNe5hVcFqGv1cWikHJ8ZaPIhpN3Tuk73SLfK
xbcKbqEf7hOUN2J54ODOl2RiSNDnzuqPtygVU7BfqDBWffh6LwCgRUqAOn+GdMkS
FpTB7Ochnz0YC9qoAXS9iDxJsMrYCBTi54YKh4kNSkUu1+dHLJo=
=QkMA
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
