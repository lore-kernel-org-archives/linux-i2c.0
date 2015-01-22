From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 22 Jan 2015 15:48:19 +0100
Message-ID: <20150122144818.GG3413@katana>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421346798-17148-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 08:33:18PM +0200, Pantelis Antoniou wrote:
> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> This is required to avoid multi probing when using I2C and device
> overlays containing a mux.
> This patch is also more careful with the release of the adapter device
> which caused a deadlock with muxes, and does not break the build
> on !OF since the node flag accessors are not defined then.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Applied to for-current, thanks!


--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwQ2yAAoJEBQN5MwUoCm2HaEP/11sSC+KDGNTm1Xo/RWS0+Uc
vrxQ3b6vTzLUEE+kRl2GbEqWIM37Ja35CGqNRbc1E70ldeoRZ6ovZeyYRNc0bmwz
bRvX396SlCJvF1kTYSWHrrAhIs55vv/Igqb7XPT5RLQed+HJSv679luoQ5qngd9l
mwc4+3RXdwSg5DrBLOTS6/xGOYpxV/kAV+iWlsEcd/8OopMtdWoMgDOXTseaFyS9
pCRijYj5YWPubMQXzQprf+gZDL1HdGo4daJo1tzQLex93TMsNfnj3JQpdBu3Y0YV
OdEoleSFRQyszYEyT5+1aSYQ0KIk5zfvk2H86mF+tu3JdgoZ/TeMsqG5nfqE3r8/
kIGRDcx0jY3E2jowbYBWrVppB3fFYr0aBy5TO4NlakVkrtigFPxA9aAONmjDx63f
v4/8enQAcesokq/VQ+d8TcK/KWbupMm2FjVMXkwskRdHHvUoj6PhT2WJ6Qc+nVHi
ZbiJJ4RjCb3kLSCQtme+rvfrEJhxmKsESbgF36eP9PvByi6QpqMMiExu5oLhY5Fi
ZvTuSCiuggZ22NqpnVUutzQzGLiesiMYbSrJqbrtbJn6B1+xGiRyT6du/WRJKoWU
9jFeXtNjYG4GbASg0TkYPU+nGyY5T1qynqxqxe/N3HBdPbl0gdlOIskQmtLpL2MU
EHjZJFJyEE0RsIFrIlaR
=Tr5G
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
