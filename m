From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 23/29] drivers/i2c/busses/i2c-ocores.c: simplify use of
 devm_ioremap_resource
Date: Thu, 15 Aug 2013 16:18:58 +0200
Message-ID: <20130815141858.GM17155@katana>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376471493-22215-24-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376471493-22215-24-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2013 at 11:11:27AM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> Remove unneeded error handling on the result of a call to
> platform_get_resource when the value is passed to devm_ioremap_resource.
>=20
> Move the call to platform_get_resource adjacent to the call to
> devm_ioremap_resource to make the connection between them more clear.
>=20
> A simplified version of the semantic patch that makes this change is as
> follows: (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@
> expression pdev,res,n,e,e1;
> expression ret !=3D 0;
> identifier l;
> @@
>=20
> - res =3D platform_get_resource(pdev, IORESOURCE_MEM, n);
>   ... when !=3D res
> - if (res =3D=3D NULL) { ... \(goto l;\|return ret;\) }
>   ... when !=3D res
> + res =3D platform_get_resource(pdev, IORESOURCE_MEM, n);
>   e =3D devm_ioremap_resource(e1, res);
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to for-next, thanks!


--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDONSAAoJEBQN5MwUoCm2f2QP/3b/muogXYR6bmM/kN7nK5I2
SCEcRiQ+whckMtGORckIOFopERCqtc/mB0sWiSOmZYbA4BsU17yj75lUCd7QB7Nq
zU/x2NgDGf4+5cINbhDxeUv+gCKhbcMB2BeW2GW/Z/rYIEFWki7+boqmXV1y2NtS
BF0rDiFCF3uzEiFAggc4luBNXRDawhAF9N6Q6B1m6p4F/omh1ecGTy/3pUwyipQt
mLnPYZH2DJB5TQdscZflf9+vudiwY86VssbhUa4+c1XgEMks/a60pOMNtwCXBxRz
qOUa1HsT/wzCued9zE4h2xO4FxeKWyO5khDXLgK29VyEZnPKXqXhL4MzO4vV7xY0
5nlnkq+n2Dpm+SXqMiyiHNuIaAGxeGcpd7BH5BCKAs+RZc5E82wY1+JTOiLqe1WR
/9B/U0X32XKWxfq9cD7dLBOUyXn9r8BiNosLhCVdvx7sB5WpYk4pC3ABqWrDLDIC
6IJ8oREuyd+YIpLFVQdIVrMsPqv2vmbWkVxR7jfs3NAK2PfVc2B1n/EBtUUFylDn
Bi9MaunDvbl8XKR47x4KYC6z1o/JUBIrQsrDLfGthcCXdc1h1uUVZNGP/oWR9+F0
kqQPua4WZUMNTRzUsWjWN0jEcstpmCl3CiF03riZKHB0dbBThk5VMGa0jMs6M96P
lqpC6T8MxKs6KvtIa1OY
=meFS
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
