From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: jz4780: Fix build for m68k and sparc64
Date: Wed, 15 Apr 2015 17:57:52 +0200
Message-ID: <20150415155752.GC914@katana>
References: <1429112927-19789-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429112927-19789-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 08:48:47AM -0700, Guenter Roeck wrote:
> Fix:
>=20
> drivers/i2c/busses/i2c-jz4780.c: In function 'jz4780_i2c_readw':
> drivers/i2c/busses/i2c-jz4780.c:181:2: error:
> 		implicit declaration of function 'readw'
> drivers/i2c/busses/i2c-jz4780.c: In function 'jz4780_i2c_writew':
> drivers/i2c/busses/i2c-jz4780.c:187:2: error:
> 		implicit declaration of function 'writew'
>=20
> seen with sparc64:allmodconfig and m68k:allmodconfig.
>=20
> The driver has to include linux/io.h.
>=20
> Fixes: ba92222ed63a ("i2c: jz4780: Add i2c bus controller driver
> 	for Ingenic JZ4780")
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Applied to for-next, thanks!


--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLoqAAAoJEBQN5MwUoCm2Pn8P/1XysumEnSbKLo0xQ5KEENO0
+iXpC4RSXue/Ph10w1dHVvY7/x7SFL2cEYJDAr0b/BLyY5HTasnjm2rltvSU2mog
mdiZ/OJzPX2MfUFHOMA4wyEosbDtIMn2T6c0miHcjv8sXvzjRr3+r7eiTtHCHs+W
H1Cnf+NPB+xvhOfIQJipc9YwOEbLND2/rcHPL7wyg7LO4pE9tC5Rkq+bMvltufF/
7vfyNmpmi/lZc95QnPg2ORZZeNuQgEk3dUxk/8M5YOuAJD2t4hdcubODMQ1hTYUI
7fADnZF8+EiSPCSeBZv/3HSlLxdlTvIYAwtpdSF8Zmutb+cHNTgcc6Adrsxm3yGU
IwyZGBelf55DlrME2EdB8OWwmInE2vu0Gg2A1srNKDrGFnKNaAv/3hUzZQAUeaSo
zY+sDMczb32jzrT/iqVOxkJFPMAz2xVyjNcbXJIYv90K8f/+skLMv+vP71vl1McB
cKKZLRZnbJ992XK0cBA8IMVoXFQUn5jNFWDLW17kSA45/ipeZWNrV/XYSnUG4df5
Ni39uDhvITKVb8glJIpB2HoksibIkJmNGZHQc7voh3Po434kMiK4SWCcqLVkpsN/
onuceMP+hVSHPuwMJAK4YEP1fVdis1/Eswtqh1S0iG12Bh4oqGMDNm2L+HrQ+3Rr
b43sWBT4/TLySX1PGExV
=aGnF
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
