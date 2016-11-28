From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Mon, 28 Nov 2016 15:22:08 +0100
Message-ID: <20161128142208.GA3916@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57272 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933019AbcK1OWM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 28 Nov 2016 09:22:12 -0500
Content-Disposition: inline
In-Reply-To: <20161122145539.GA7716@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > This does not work on Octeon 71xx platforms. I will look at it more
> > > closely tomorrow.
> >=20
> > What's the outcome here? It seems we want a bugfix for 4.9 but this
> > report keeps me reluctant to apply the series.
> >=20
>=20
> Steven, did you have a chance to check which of the patches makes
> Octeon 71xx fail?

How do we proceed with this one? Is somebody at Cavium able to contact
Steven internally? I mentioned this on-going regression to Linus and
said an rc8 would help us, but reading LWN it seems we shouldn't count
on it...


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPD2QAAoJEBQN5MwUoCm2JYoP/A4Kkd5Po+2VqOJj356UZYLN
msaLO1kvDAzOWZkTsOf/v4nBcHhxRMswzVyZtQTCFH3UmsYhyT4JxGVvuFHyKcHM
8qefVnHlZ2JaeP7aTpdVuD46x4lEfzbf+aQGAjRChFvW8RYvv3YaK1s6TqzunHVT
Gfmn4T3AP8s/i9RJnzikcUNb6rxL/q+D34vlZjZ4c9TZ+PSqKjc842K8fXowCLXq
HNQ6iOpSyVeqqSLntlSyailItXodbMeiKjtFG00Z3nXnbFwSpNRWQ3fQabbUenuL
HdAX1+9+Z0kq9/L5CBX+j0VENpeOZ5O4S5C/y6KoKny2KSTJpPWpZNPq269IMd2+
YWJ8FK6WPqbhj0JHxn5rtutEfpyvGzq+O7iM2WAbVF0cai9xbDqtfYQpHHJDd4JZ
7Q7GPuPX/REB2hntxN9QN8nPugEJM3/v1XWA4X431DIp2tcsBszie2y3I1DU6zX9
RPJZ/80luWuHNG2U4QsMOJSmVrIoTMiuNCvow1HPveWA8Bg+7kB2XOEUZ1FOQRvG
1rjEJxK69Pu/SmGabGd0xujh2X972U3L1sDKAX5d2Wt+ulN+W2GpDYc5ilL9XB9p
o5NSLQxxhEPCqFd4aTa0b9TQ5Zucz5kN1BiVcjrsNJlLOa2IGmRb8UmC4QQvLeHI
wIeWAipmBc25VPELPbp/
=LeNA
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
