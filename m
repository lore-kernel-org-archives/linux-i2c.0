From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: riic: correctly finish transfers
Date: Thu, 9 Feb 2017 17:44:26 +0100
Message-ID: <20170209164426.zlwhbcdv3te52ihm@ninjato>
References: <20170208024122.13116-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4pv3lj7f7oxj2pa2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45489 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753029AbdBIQpA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 11:45:00 -0500
Content-Disposition: inline
In-Reply-To: <20170208024122.13116-1-chris.brandt@renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>


--4pv3lj7f7oxj2pa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 09:41:22PM -0500, Chris Brandt wrote:
> This fixes the condition where the controller has not fully completed its
> final transfer and leaves the bus and controller in a undesirable state.
>=20
> At the end of the last transmitted byte, the existing driver would just
> signal for a STOP condition to be transmitted then immediately signal
> completion. However, the full STOP procedure might not have fully taken
> place by the time the runtime PM shuts off the peripheral clock, leaving
> the bus in a suspended state.
>=20
> Alternatively, the STOP condition on the bus may have completed, but when
> the next transaction is requested by the upper layer, not all the
> necessary register cleanup was finished from the last transfer which made
> the driver return BUS BUSY when it really wasn't.
>=20
> This patch now makes all transmit and receive transactions wait for the
> STOP condition to fully complete before signaling a completed transaction.
> With this new method, runtime PM no longer seems to be an issue.
>=20
> Fixes: 310c18a41450 ("i2c: riic: add driver")
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--4pv3lj7f7oxj2pa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlicnGoACgkQFA3kzBSg
KbZkZQ/9H4hiWOCR7f/RyFJ34nOiM6wkIa5JCUsgYlFOwaBtMHply/WW+rpz5ywA
0X1K6wOvXkukiVrtomqAkfqpcSKd3uSGzx6DYI9Y2fzv8vZQe9J9EC9xIvClyPiR
iOLBBGP+h6P8Tcbj7PBYSvxhpTY6OXOIFD4qcfbrChCkzyGxzXkkN6oi0RJzz0hx
jUyWhK/psn7EEQwieubyYhpcd5fpyXK9xAldNtvnZDOQOKzKpBIiG16Sz/7MAVgV
PH3iqU3EVMKyd+8V3XAtR3S7jrsyYJ1HEvulT7yk2V7ZwFZ+LC7P+VBf83PHOHg/
r8QgtrT6zcZQrYv285fnLKkqI9Q8Z27PihK99eeLqVRqJxt7SkuEOl28T1XoF+GI
B7PLGzvu4D6m6sKy1Q7+gpfz7jJAL3tIilJY/JDURREzOgpYcwyPehMTPzb1oc3D
pZZFMjns82aPdeJQi0uvd1o8EFOwNp5J8SF/2LzlMWhGNGO/mrnORCrnt+R6Ux1/
H/j3NEXjkMYIr7pQykG2WuWzgtlgL6dYk+iaIwaIMNWru5liNnST56apJF0RPeUG
qxUqywysxCyuiEnZPLMDJfll5polqVpTSFpbIU1voCOXKKL5qNyaI5gJVbsHTaUK
khJr1laY02W4P9b7IvKc8jl2WONc6ask77p2/xQEmx8vwiSePdg=
=x0CI
-----END PGP SIGNATURE-----

--4pv3lj7f7oxj2pa2--
