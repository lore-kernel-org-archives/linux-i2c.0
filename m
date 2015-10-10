From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/7] i2c: img-scb: fixes to support i2c on pistachio
Date: Sat, 10 Oct 2015 08:43:19 +0100
Message-ID: <20151010074318.GC1619@katana>
References: <1441896607-16310-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57269 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbbJJHnf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 10 Oct 2015 03:43:35 -0400
Content-Disposition: inline
In-Reply-To: <1441896607-16310-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Ionela Voinescu <Ionela.Voinescu@imgtec.com>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2015 at 03:50:00PM +0100, Sifan Naeem wrote:
> The following patches are required to fix the existing driver to
> support i2c on pistachio.
>=20
> Tested on Pistachio bub using an Adafruit I2C Non-Volatile FRAM Breakout
> (256Kbit / 32KByte) eeprom.
>=20
> Used i2c buildroot tools to test the eeprom and the other i2c blocks.
> Also used dd commands to copy data to and then to dump data from the
> eeprom. i2ctransfer was used to test repeated starts and verified
> using a scope.
>=20
> Odeally these fixes should go in to Stable kernel (v3.19+).
>=20
> Changes from v2:
> 	5/7: Remove start bit detected not required, use line_status instead of =
i2c->line_status
> 	7/7: use %u instead if %d for unsigned
>=20
> Sifan Naeem (7):
>   i2c: img-scb: enable fencing for all versions of the ip
>   i2c: img-scb: do dummy writes before fifo access
>   i2c: img-scb: use DIV_ROUND_UP to round divisor values
>   i2c: img-scb: fix LOW and HIGH period values for the SCL clock
>   i2c: img-scb: use line_status instead of i2c->line_status
>   i2c: img-scb: Clear line and interrupt status before starting a
>     transfer
>   i2c: img-scb: verify support for requested bit rate
>=20
>  drivers/i2c/busses/i2c-img-scb.c |   73 ++++++++++++++++++++++----------=
------
>  1 file changed, 43 insertions(+), 30 deletions(-)

Series applied to for-next. Thanks to both James for the review!


--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGMGWAAoJEBQN5MwUoCm27McP/1Knk4JWCtG7lz3DlQef8tVg
549USbZ/hI1MoYBur/xMtNjVd/89cBK4pCz8IQUMyrBXe48LLoCtTZa7gu+rd0NX
s2m4EnwM16IeZlp8QEiUOar1XttJy+mF6KjbWLNLfN5eY9pfdVYojr+JidO0U1yu
owwl9dotGbb5Roevu8IWzNnm5oLofDHpNk2CXl597A3kjSjgEYXpyVdeW5o7z8Hy
se6ewDBjAqSRvreNe0lO8G4YzXgOAITTIF2QTjrzXJ8sXiRD3WMu85E3pdA4uQky
O4ywuG0TjvB8Y+kS1cFrzIRbcJ4j1yiB5LhTHiplk+KlbKDutkM3NTsd/8BpKzxs
f/x1U6gTTGUy8KcPPp5/803BPvx7EorXrljaizfLnOXSy0R00hybXlbgeIKmpPsV
LIHZ+pWCd11RD005+0B8/477jG5U5ZavdAxw9Pi5YdrHGu+Z/Y3/Aru151x3M3Rn
1EAOdrZ+xafeJijmpJr3rocES3Kzv2R27seJ378WjCwHr38N4UEO5++B5Fh9stfb
/TXhqUV0ve6lhAPnH306HrRDv8T6+ZrRpi+dbNXgSi7iabSzOWyeZ+1y1jfTk0Jt
lXqvtTRULzJ8BrJq3qNhEEwkuc4QNmDK6O0RHmILVPcE1YKUM0I3uo5BV3C4CmI8
hJ6yDoNe4My6V/vIF5lg
=xiK5
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
