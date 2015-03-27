From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mux-gpio: Change log level to debug for probe
 deferrals
Date: Fri, 27 Mar 2015 16:29:33 +0100
Message-ID: <20150327152932.GB27238@katana>
References: <20150325174351.GB5209@ulegcpding.emea.nsn-net.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150325174351.GB5209-w/hiR2Wfoz+b6vRP15A4uhaOaYmgohGe0e7PPNI6Mm0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ioan Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mathias Rulf <mathias.rulf-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 06:43:51PM +0100, Ioan Nicu wrote:
> Probe deferral is not an error case. It happens only when
> the necessary dependencies are not there yet.
>=20
> The driver core is already printing a message when a driver
> requests probe deferral, so this can be traced in the logs
> without these error prints.
>=20
> This patch changes the error messages from these deferral cases
> to debug messages.
>=20
> Signed-off-by: Ionut Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Why not simply removing it?


--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFXdcAAoJEBQN5MwUoCm2MpIP+weyCnMal0H0+PseAPYDbcx/
ECuc0w7Su+O84rvCoMBGbYIdp9GfJEhPYc5DE1ChS22IRjiCTZMw01/b6KhPKZ8Z
TBU4j8Sxitse/83yq7ODpVtPxobSY0XaDbl2qC+8qFLB4lcMn5L5YaYviHe7jCor
FOI+mF9cWTnUoCfCxOb9gboiveZHXMFzSBa+f7OyXOHAEgi0JYyc3p0qJydFydBo
NhtAaGmyXtUmPkc4D1iAVsVI8xhVe6ke/sV9r5V9EadTnRKtHoPpn8qNUgpblWxs
gmTAfIQ06HneYP0M6rNu9nx3fSpiKPJA1wuKGSqbP24ket1byCHyJlwCrDb+POr5
joNwnGuisg3WGRJc1NIuPlsgXAob37qP406rDwEeKDhp0d+YxjB2chKoG8ptZ4SF
Wv57lPfMBJtMkPXkmy6vUHSrvbOBOB/bPeblWq5603qDXCe/FMdF4M4SBIfG9OvS
eK27WUc502cW11jEXTVNBqzylIM066b0tlskO9RVRfpHvLs5yMbiyEzXi9beCtQJ
H8iUV0gdwTtG/XSuecEtaRIghVMLNB4QZV8/fjTKL6L10uaGX3w9W9kKjOBXvtwd
Y6OLFnUOpG2yACF3cmiGKwop0yFjtNgFOR335L9cfSkvOqgYv/RNUFEvdWyyIDeh
otDrZpql5lWp8b77kRuZ
=Vwr9
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
