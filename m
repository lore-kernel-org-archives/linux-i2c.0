From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Wed, 21 Jun 2017 23:36:47 +0200
Message-ID: <20170621213647.GA2419@katana>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
 <1494947612.7509.24.camel@infinera.com>
 <1495547252.17446.60.camel@infinera.com>
 <20170529210419.GA2527@katana>
 <1496095395.17446.111.camel@infinera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35366 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdFUVgu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Jun 2017 17:36:50 -0400
Content-Disposition: inline
In-Reply-To: <1496095395.17446.111.camel@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I did my I2C reset analysis many years ago but I found the reason in
> som old code I had lying around, just sending 9 clocks will not
> recover the case when stuck in an I2C write sequence. Adding START
> into the sequence keeps the device in START once it has seen at least
> one START, then the STOP will release the bus in the end.

OK. I had some time to dig into the specs and understand why I was a bit
cautious: Chapter 3.1.16 of the I2C specs describes the procedure of 9x
toggling to be done when SDA is stuck low (which is super bad because
you can't signal a STOP then). SDA can only stuck low in the read case.
In the write case, the master controls SDA, and thus, you should be able
to signal STOP immediately.

So, for the write case, I'd think a single STOP before toggling should
do. Toggling 9x even means you could then write something somewhere
which in case of a PMIC can be really dangerous.

(BTW I just noticed that the generic recovery routines in the I2C core
do not send any STOP. Neither before nor after the toggling. This might
need fixing but is a seperate issue).

This is all from a theoretical point of view. I don't have a test case
for that. Do you have a reproducibly misbehaving device?


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllK5usACgkQFA3kzBSg
KbawyQ/+Ju2QAmfSwoCm1bXfdHsjTw1UjxWgkGKN+mzRK+SRPNjooD7s8+vGvNDC
pL4eskGVm5LwiSSptSbz15VcHlhWQjZ9qSt6l30OQeqLgIioPu+/pDZvwYKRQEFQ
wIuL3msC62Ikram0E8o3BcmUaEaNov1gbYE73mtG6JTPkCwCxspjy57zevPJYVbS
9cOSsfNsO00r9DI4Uyb81XEhvc8LJi4AWmvmDlnX3vhfgvJjjTO+y/DanCFrUAiq
rRCpSi2Sr/oqaJJ0C4D9keT4P6Cj+QY2dlJlVGE8NQZMgZK1qvHE0jKodnd+sv6a
4iNaT1htwWyCz7CcN45Ti2IozEkFa2f0HTVurpik6sf4AT3sxERxdR0yVOVYL55X
DfVKksONW3fgoIFr1iVJhrhc3+REoBTUHbVC8nu4J4RKpfy5/tvXuj8w7mBx/vcA
oO5uATAnaNJfmVptIHRqeR6Xlhgf6Xrrjcn66Drz3W413+wHFYzmGHPcokv8fJCD
NKRmoJqLfhyhVLGNYYXrDhtk4tFZ5kuL10OvqxHj8q6p0kCYFyQ1uZ3CxLmawjI+
l+VOm2SzKxDNlQwNOQcKl4fj11FWx053kuxKaCUsdjpZqfhFe4lpGhvJ1IVPpZzR
S7VBoIiI7QmPdfJF/UE6HL+Lu07hchTxnMa0LhVSYY/8djq7rfc=
=P02N
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
