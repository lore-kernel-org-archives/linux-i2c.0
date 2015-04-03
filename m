From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mux-gpio: remove error messages for probe
 deferrals
Date: Fri, 3 Apr 2015 22:00:55 +0200
Message-ID: <20150403200055.GE2016@katana>
References: <20150330130338.GB5933@ulegcpding.emea.nsn-net.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150330130338.GB5933-w/hiR2Wfoz+b6vRP15A4uhaOaYmgohGe0e7PPNI6Mm0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ioan Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mathias Rulf <mathias.rulf-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 03:03:38PM +0200, Ioan Nicu wrote:
> Probe deferral is not an error case. It happens only when
> the necessary dependencies are not there yet.
>=20
> The driver core is already printing a message when a driver
> requests probe deferral, so this can be traced in the logs
> without these error prints.
>=20
> This patch removes the error messages for these deferral cases.
>=20
> Signed-off-by: Ionut Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHvF3AAoJEBQN5MwUoCm2+SIP/R9sruR463wPqO8icBDv3pHs
QStXEnXGXtkswDInTmiZXTlLUpn5BCCdWBgLYXBA1ktHRm7gNJhB5AnqAMYwp92u
xT6EXLQc6BkMlhCOkdDMpF5YZFdBSGFHwC1At6v5Tr0T3/Z87dzJggnweXWQluLo
L6RO5f3D1dJq0dXOKaRrv6Tuk0+NYjHHNSS/NDqeqR61ZLBJCyWSsE/kIeFemfgG
E+Ghv3yrVOXLI5BuKWbAHTqMOGDOW+ZWDU0t56fmYKRAWg9yftaBbpJAQraNg3wa
+Wf1en2kSMGZWgfJCyT1NrVae3EzUUJkk2NncTJVKzMXoeSPyPgvyZjS1gh6a6YX
kD2abbgxiXX3o87mfwDmlmtjJdtLFd7GsCr/DZ8VsN3yFIs3iMdHstB2fEg/J/xc
mpTviYX5Yc3DhNyDwUkEoVjpRohzRJhWPM70t2TlFkZJOUEYzrj+ns5Kj6ZeiuJH
MV6k9/7q8fxTFxtdveVL1NfKMPicJYyyjEwobRKamcvV72T+iurWF2GWrck1RvyJ
1IzAlQheJ+/6B6kQZZSEe1X1npMg8xVY6MuZYtgsRL2VYZ63pXA5o2efl1SbDexI
vobEj6jqBsky1bgTHr8E6ud4D7GQYEUVPBY6CmsHTtrMTiKwrjyn1U4EJdGArYW3
ApAZLhLNkK79fxAsWB+f
=En6Z
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
