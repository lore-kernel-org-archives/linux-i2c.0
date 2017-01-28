From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4] i2c: core: helper function to detect slave mode
Date: Sat, 28 Jan 2017 22:13:29 +0100
Message-ID: <20170128211328.gxtq2yoyzdwtjn3m@ninjato>
References: <c63cd48f7ae24747187f593b27b1b86ae361c436.1485452304.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="chqqqxo4oax2vvas"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c63cd48f7ae24747187f593b27b1b86ae361c436.1485452304.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--chqqqxo4oax2vvas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 05:45:32PM +0000, Luis Oliveira wrote:
> This function has the purpose of mode detection by checking the
> device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
> Currently only checks using OF functions (ACPI slave not supported yet).
>=20
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> Suggested-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--chqqqxo4oax2vvas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliNCWkACgkQFA3kzBSg
Kbb+rA//cV0/MRNViUK8g/8/Km5dEkFALJyVr6tDtJcEAymBodMiaWqk4luHAO+r
tGdQ9BlCcFr+jfB75KvpKpKZwwpei9VYZAZXSYHT33lOI6Iv3eCRZGCgKvG84MLi
JWYD7Y74RMoNn4Hseu3vQaJ0SdgF7TVgrb3PQnZxuq6Y9G7v20etgnxmdxLX9eOP
9tjulO3nh9Yi6MGSfgiaeHmyn5NjYXQVuSE8j6iJ1A6rHhfBkS4R84EmLJerE47x
6pvFR6cHxWXlVNHjxep02i31A++l5R3nw4J54p//z5EVw834SYoKBjXJyZgdSDwG
zkDFqPSsn0a2FisFP/HKF6j5Pnv3zVjEiTf9JNSt55SNaGo6Xvvjcu/278TnJPi8
Nt3K2/8aX59s3kOQ4JiRXuHUqGQvsHB2/wBu745tRMHNG3bcZQlf3+2pJk095xaf
O+gmGd2EKUxWok4UEK868BCayNJPmsoTJqFZ7kQdIfe1DeDsDn2ItRKb5mhZenI4
lsK/QjtYLm9iwmDzqSvoSoxerRS0W4AGRpUxT/l9Myu0avMqUn3VDAPpfNSLB6cC
ZnW/kt7rTVIb+Mp997imdKEhufdgofrgQ/bkvSCr4sIG0HOiO8Gk4pl4Ys4Fm2hM
D+viLo7YSzndHOl7NWv0Z2cepzgx0G66euQOs4WLZ1umi/LjfE8=
=a5Ol
-----END PGP SIGNATURE-----

--chqqqxo4oax2vvas--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
