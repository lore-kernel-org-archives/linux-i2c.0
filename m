From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Date: Thu, 7 Dec 2017 11:49:15 +0100
Message-ID: <20171207104915.fdqkj35ga2yxeg3n@ninjato>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
 <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
 <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
 <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4twrd6hgxtjb2646"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55615 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbdLGKtR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 05:49:17 -0500
Content-Disposition: inline
In-Reply-To: <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Harini Katakam <harinikatakamlinux@gmail.com>
Cc: Andrew Worsley <amworsley@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--4twrd6hgxtjb2646
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I attach a patch of the changes to the i2c driver showing my debug in
> > this driver.
> > As I said I am happy to send more verbose bug output - I have about 36
> > odd runs with 9 occurences of the bug.
> > Once it happen twice in the one run
> >
> > I include the crashing line from the runs where the bug occured (I
> > added more diagnostics as the runs progressed):
>=20
> I'll check with out HW team as well and check your flow to
> see if we can reproduce it; will also check if the existing errata
> has larger scope.
> I'll let you know if we require further assistance with debug
> next week.

Any news here?


--4twrd6hgxtjb2646
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopHKsACgkQFA3kzBSg
KbZTUhAAmjygswHqDzxDsiVMw/C6gNbIaSK0xYkbgT1/pN5unpCEZH9eqMqRaZQB
S1k6Z1ydTWDtQgTPItRWYSP5i3yFWXzx02FsVVHPPlGW/haFxNUxtSPRMgtS2hSi
VUqBTrv0/CLBKhecvyYq7/fpyj6FBuhfZHzp/OylM9dVGIx9gBaFBOzFZcW2KMTd
HJPrTquz1d7hbUK5kuirRUPp6fjpNh0O5Wv6Hh8zG5xEwyhk/RTeKOGP7HjK+0kJ
PR71MQOfDTWVemJKHGX/cCSXjrM2k5dKWC/4iYEbFnxv3YirlMJFCQtmfKl2pKdo
2GQjh8roqQpuMcGY7AXsRC2FwIX7Sb5Lv67oMwWbGZtwVuketb7QYkjcsPMNsc/f
eLu09as6dFv9cVZGac1h19qFDeAFpJ2poDJhpkON+gOTuU/bFyUM/uQNH25d3IUS
mDKZOEtfVJxlpl25c/ihHWgEOEUJcZEnq/IP8x08U6gf0Uvyp6NhONI7seYl/Rs/
ixGUqPVTvn+Z0B0zLDHQoCZa5ulCpSfJ2fa07w3PSLT3UT2D1g4ctLhFLj5zsvFI
Gnpi93jp2pR1ld05pv5ncV4kxAdz9P+kUxf72TOHkIYpuxGGXg/Od3WoT29j1+5j
9zypV8RTLwm2VhPyLk8OvDivAoEoLTLVsGjzlVGan0NJk4QPnZQ=
=EDor
-----END PGP SIGNATURE-----

--4twrd6hgxtjb2646--
