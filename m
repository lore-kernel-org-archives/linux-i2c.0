From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Mon, 26 Jan 2015 16:55:50 +0100
Message-ID: <20150126155550.GB13494@katana>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150122144818.GG3413@katana>
 <CAL_JsqKEBYwX=5zgWbdVRxm-H-sFiDa9rAp26BvuKNECoNW=uQ@mail.gmail.com>
 <20150122150243.GI3413@katana>
 <CAL_JsqKYvcec=xWQM7_Dgrr5zmkefXqGCQvHwJ+uxNgfiv7fcw@mail.gmail.com>
 <20150124042623.GB1190@katana>
 <DEFFB75F-347B-43F9-98E5-BBD019276A37@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DEFFB75F-347B-43F9-98E5-BBD019276A37-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2015 at 09:16:16AM +0200, Pantelis Antoniou wrote:
> Hi Wolfram,
>=20
> > On Jan 24, 2015, at 06:26 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >=20
> >=20
> >> Feel free to apply it for 3.19 with my ack. You then want to pick up
> >> v1 of this patch.
> >=20
> > Sigh, I give up, this is too confusing. I don't know which one is V1,
> > they are not numbered in any way. And I have been holding back my pull
> > request for too long already.
> >=20
> > I'll drop this patch. Whatever should be applied should be resent,
> > mentioning the release it is aimed for and how the planning/dependency
> > on the DT patch is.
> >=20
>=20
> Nooooo! This is a bugfix for 3.19 :)
>=20
> I=E2=80=99m resending the original patch; the dependency is on=20
>=20
> 	"of: Empty node & property flag accessors when !OF=E2=80=9D
>=20
> https://lkml.org/lkml/2015/1/21/602

Which is going in when?


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxmOGAAoJEBQN5MwUoCm2L+YP/1ezLdiB0KEY5nizdqYvLjk4
3JbnofJ/3lOpTNKQj9j+ReBwEoX1/GbHmocZplSAOKTBMLbesJYqpTbzNugsct5p
0n0J5LN1qbsWRvhhGpz58RY/Ud7eGQ82oW3OLtBFiGmyaWkXZfJIDstCjDDjlBNu
kAEy0IDBEjC1Gz2p60bgKAjr6u91ScoRmbSTDzPKtuI7Wcr697t2x8xzuRv0AOIY
76TuSQ2CoW+ziQYPD5k5iIJE60KwhW7wrYLbFpyDSoEcsUCx3vot9WjoeWExYVO4
8dAzfc+dXoXPk5kRYsi0Z5yn7bFB46Lg79aiVjomfK+Z5ocHbf15zSePuLQIF3ue
llGMaH3zFuIs1EyAG6Q1ls3+qjhpjGePoEw6snyfO3d3z3Vqkzi25FjKT3KkFLKW
cVjcFprgJM0SCJBo1gchHGvESSVRPMXOjwxKASN2x6AXKkrM15knxdovMhW+ZEdB
eiUgUkH9rEVQbiIObQe4m/3gac45ERJPzMzuKbMeUGjoYGwTOBaphL8wBXXbNayJ
WbKTjEzcOAJ/2uC/qWuCsAu/iCIVNorS/7So6vu3TKZ1oYE58G65zPsRxlLDQabl
ZhYMJZdZXhggeZphe1Px5I485tVqqMw04mt/o1yF8B4eUxRp5eEg8bV9kanfoZSE
W9ZQMlONPcyYwk2aj9Kw
=jMAw
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
