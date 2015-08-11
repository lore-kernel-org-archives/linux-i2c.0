From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v3] driver/i2c/mux: Add register-based mux i2c-mux-reg
Date: Tue, 11 Aug 2015 22:02:54 +0200
Message-ID: <20150811200254.GC1523@katana>
References: <1434657458-16553-1-git-send-email-yorksun@freescale.com>
 <20150811153916.GD1525@katana>
 <55CA1ADF.200@freescale.com>
 <20150811161610.GA1523@katana>
 <55CA2472.9080000@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55CA2472.9080000-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I'd think that "little-endian" or "big-endian" force a setting. If none
> > is present, we shall take the CPU endianess. Or am I overlooking
> > something?
>=20
> You are right. The current code checks for littel-endian property. If mis=
sing,
> the CPU endianess is used. Do you prefer to check littlen-endian first, if
> missing then big-endian, if both missing then use CPU endianess?

Yes. Do it like this.


--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVylTtAAoJEBQN5MwUoCm2JccP/1CO3DLe6OfXDzAV2SgABYj8
zeeZp/iOfmHkedKu44600KLS2SYb73QEu6/sW0niow4p/SITt/Vbi32QooG0BpEQ
GdwNy4z4FxS7cEmgTv8TGmvugBHc8RAHsa89IPCQzUPhLYQ8Dxl0R9ZR7kSughnQ
7/paPLnQfSZIFWkmNyeSNbLAeI5+akWkhii167IlOmwmFj1ja8nYJq04mwr6m7U8
9VaUMGz96bbWM6/C8au6026fHjtFWWXcyjVXPfDtAkeCCK796AvRL6JZ5357ETzR
kAx/HmarS7bP0B3sWa2yl1yj/xaREZootUqOTrHVNJjhLn0FDRegk1Rbx09BWmsR
2bCYCPI7a8ARidQjCqKqzcW5Mx2h3iq9+crhKkqeIK9E60FeTZNa21GfsCotdQFt
rhBMeXZAeaXg3sm/UE8e1OWGgi4JMWIRO+eYNP+XsmgwP0+0GI6zOaBx1QFLk0ZD
mzpsRCslHiWW7t3dQj7WIRVVShPZRIid20uXkQnQXNpOOZZF5nRKH53OVXdrud2Y
v2v+/O1gRMrb3UNPb4suK4R0SaUEzQ2iS4r9MX15S4RK+lFGsMsS3KSwf/aQThO+
voTrphy2Ps3sqKugrRQYIYvFa+oDCHE8mDt42DAHkBuN5o3G2ml2cIh5tderHrTJ
+11NAnlq+olIcF01eJwK
=h17B
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
