From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Tue, 29 Nov 2016 19:37:07 +0100
Message-ID: <20161129183707.GA3378@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
 <20161129091928.GB29487@hardcore>
 <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35650 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756211AbcK2ShL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 13:37:11 -0500
Content-Disposition: inline
In-Reply-To: <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: Jan Glauber <jan.glauber@caviumnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2016 at 12:22:34PM -0600, Steven J. Hill wrote:
> On 11/29/2016 03:19 AM, Jan Glauber wrote:
> >=20
> > if possible we should at least revert commit 70121f7f3725. I should get
> > access to an Octeon 71xx board tomorrow, but I'm afraid we'll miss the
> > deadline for a well tested fix that works across all machines.
> >=20
> I second Jan's advice. Please revert the commit and we'll have the
> fix for the next release.

Okay, I will pick up patch 1/3 from Jan (the revert) and read your
comment above as an ack. Paul, is your tested-by still valid?

Thanks,

   Wolfram


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPcrTAAoJEBQN5MwUoCm2ctsP/iIjGn6MWF0c380QWx8moelM
nNH5QcAmWc9jCLTZmOjis6GrjJurDh2H3OyzUbNqhbmDOjiR4olK8PAY+W+nSP1N
J7wULS2Nxzh/ntqfbb6C+hwMAKY9Pnmads5WDwXE/8dvg9dDvK5KJ3sJbWLsuKcL
c1GUrYjv17HoYXA6BA/cGISQlRz1M12qGhAN4a/uYmh26reBKtJ9RvuZ4ArmXDE2
WwWLHWbFnStbZfd7Yj+7TWVF1YiW7ihyOsZ+0vICqF2HAdwnSEvOyU3nSRPwKjJk
pqsvC5+xW5YJG6V2q1FODF3pulOA0HuguNlHx6u2f6NUyC03LN7mUAkj5MJI6leY
h1hrZUcyWIDRcNS/r8ZzqRTioALm06rAZ2T6vH10ni7CiFOn7uttjR/wIZi2ewjl
NvrPTWaLHEayGHQRRGYiEmryfwhMyAHrc3RwMYdIXn1d1KkAITbtOXv3YWH1SpRt
LHFNS/ZrJKREZUs/RVL2SCZDJUvHVtKrSfpcwDxg+RJ0rNbRx+U8LGdrScpI9noE
WOPmQrZA90VRPPhcqnSq4QQ+ow+M3peww4XaFbN14qE0ixLw6nV4AwDR7n+qyEZI
gKaA5sMv6tA7YHOUT1++wXu8USOkj4uf4lw9CLb7+y+dSjQ10FTIQN6D+GtC50WZ
RHIHRpOT3bH2n2Hf9d+Q
=lhs7
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
