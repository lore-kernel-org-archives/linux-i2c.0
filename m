From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-xiic: Fix big-endian register access
Date: Thu, 13 Nov 2014 01:18:31 +0100
Message-ID: <20141113001831.GB2062@katana>
References: <1413216527-11933-1-git-send-email-Thomas.Gessler@exp2.physik.uni-giessen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413216527-11933-1-git-send-email-Thomas.Gessler-Tvfv6JZYqycq7YrIr1+ioITjL5QYi2yUhC4ANOJQIlc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gessler <Thomas.Gessler-Tvfv6JZYqycq7YrIr1+ioITjL5QYi2yUhC4ANOJQIlc@public.gmane.org>
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2014 at 06:08:47PM +0200, Thomas Gessler wrote:
> The driver tried to access device registers with the (little-endian)
> iowrite/ioread functions. While this worked on little-endian machines
> (e.g. Microblaze with AXI bus), it made the driver unusable on
> big-endian machines (e.g. PPC405 with PLB).
>=20
> During the probe function, the driver tried to write a 32-bit reset mask
> into the reset register. This caused an error interrupt on big-endian
> systems, because the device detected an invalid (byte-swapped) reset
> mask. The result was an Oops.
>=20
> The patch implements an endianness detection similar to the one used in
> other Xilinx drivers like drivers/spi/spi-xilinx.c. It was tested on a
> PPC405/PLB system.
>=20
> Signed-off-by: Thomas Gessler <Thomas.Gessler-Tvfv6JZYqycq7YrIr1+ioITjL5QYi2yUhC4ANOJQIlc@public.gmane.org>

Applied to for-next, thanks!


--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY/jXAAoJEBQN5MwUoCm2ThAP/Amim6GRJ7gd48UNKhYLmowO
cH5s+hEIrEu/gI41B55N8WRLGlwiCN78+LWkJ5MSJ8nHV5/BR/P5Py83yuLG1LxK
Cyj3qLemPXMSLdIiqrxlm+G3VinVT8BWeiRpU4YfaF7CcuMpKZ7nGEYz6bI+JnC8
f+2fRrAiiADjH93jlfI7G+0wVilZoouZWEDyh0ju+ppvS6FDUrxrHxAMo4R9Z1MJ
wCyN8dtFFrbnOXuf6gN+3e1oCLoWpRaifs50a8ADrg/Mq6X+JUbUKKg+0N2hqjnm
CwHk0NBpWtXn+h9V8ACypHJKyqeHbCCnWRMapKyoDTlds5F74pHyXn2Gk5eaQ8Fo
kC1LICe1fmXJi7tzxlQqbBECjxMnio9d25IgHhEtBqBqispCkEIaXsv86mmu0O38
Jjtr1Oy0J66Y8UBG9yiLDu38cf0NMJGHxU+keNYachilf4v94+/Yl/RUMBP22mly
UtMvPs1ZrurCwWpFnHpfTLyO2jWxkIOdyKTVQPTzDvwqCXLNPjn+ONjy62lT2QYp
6CWrbAexhVda0e3txBzwRc/2ElnlMvYLKr/K7fO6GcgPmeoupC6N8aV4nA9/6a+6
RgVV1hj9nDtzTWn5YhW+qSSz+Fs4FfrgK26efQGK9b6/svo088RqUci7rCnCA1nX
/76nX9ux5kRHWhrtLQ9/
=52DW
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
