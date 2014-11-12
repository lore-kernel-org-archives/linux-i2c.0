From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4] i2c/at91: adopt pinctrl support
Date: Wed, 12 Nov 2014 16:51:01 +0100
Message-ID: <20141112155101.GC4031@katana>
References: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415584552-11390-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 09:55:52AM +0800, Wenyou Yang wrote:
> Amend the at91 i2c pin controller to optionally take a pin control
> handle and set the state of the pins to:
> - "default" on boot and resume.
> - "sleep" on suspend().
>=20
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY4HkAAoJEBQN5MwUoCm2M4gP/0FC4eBZdi+9vyu+iDasENOe
Nt/sGnxFpuBHRA2JRvWruk29KmjBYmugT535ySzyzAavWzXoHLNT6hIWhs1vtFnV
1C4UVLgKFVOW2VviGJowj2Jiq+da5NO4WCA1J7vDHri0A/zHd1I+2nfUKSknUaye
XJcPb50811UXyn3w9pmwCGWmPgofcTfF9lfh2aMYBwkznhF6Mf8mRAzMsjxNx+uy
fBNzCzIIyd2zzppwmUD8VgUsTj7mS3SV3IgMRe6A1nRJtITmHgFyOt5rLAHASNZI
e03E8d46pAwCukNUGhplxNsiz32gLlskQDG4fgkQfQ37o09nVFGor3fbq+8fSWDw
hx4QN37PvdvtDe9oXK5y+SnHJq1lFVHjy8RBx2/ovI3xrs3YqdPxfrybjCSeH5z2
A7EwjLEovf56CmU6ywOwYdRm2LczsZ/oHBmaDCNC0/qnJw/qhBBYintFTGkMimMz
YebJJiP4N9/RnIVEnl6/CDnUaMJ1WpMzQbC+pBCH07ST3T2nhubDCaoyNXrl4pND
xcow7vuflDoALjhC5I+9M5aLc5HgbtWnorC7qsSeQEx2Swu11PzV7cVsBwX6WvN3
55SW92XFlVZ23a3jEyW0RmtUAnc3unVxWqVwPc8pHhYuGfCVjZXgJKcxrwfN+Wez
zFLUyoc4g0jPlPwDfRmL
=1clq
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
