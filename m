From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 11:00:46 +0100
Message-ID: <20170112100046.GB1477@katana>
References: <20170110121600.30649-1-ricardo.ribalda@gmail.com>
 <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
 <20170112104006.4dfed9b7@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:36926 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdALKAt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 05:00:49 -0500
Content-Disposition: inline
In-Reply-To: <20170112104006.4dfed9b7@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +       unsigned short piix4_smba =3D adapdata->smba;
> > >         u8 smba_en_lo;
> > >         u8 port;
> > >         int retval;
> > > +       int timeout =3D 0;
> > > +       int smbslvcnt;
> >=20
> > Keep them just after your another added variable.
>=20
> FWIW, I don't think this makes sense as a general rule. I'd rather have
> the variables in an order which makes sense (for human readers or for
> stack size optimization - unless gcc does it for us?), rather than
> always adding at the same place. Is there a rationale for doing that? I
> don't think shrinking the patch size is good enough a reason.

Not really. Some say "Reorder to save bytes", some say "reorder to
utilize cache lines most". Unless I get some numbers showing the desired
effect, I go for "most readable" approach which is subjective, of
course. I'd be totally fine with the above.


--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYd1POAAoJEBQN5MwUoCm2UPYP/1it/l2pgLFjM/1IfAJLLW26
WwSXW3ivT2FSQ5uilPEEtertz00SFyZffQg5tsPbAspHA24XO/LEJRezXQC88Yiy
MikHcv6VJ2u3erCdz4ob8x4z6KiEddpKnAt4q3aohSvmfnJadI3EE9W51Of6b09G
0aRGAzcS8LBWe6C+hYWdM2/u1aZESTjUqTe5D1lDyyKcKTi47KfdO4OC2pq/rwgZ
LRPfLwtrC95fgcsBNxUESzYtV6Kq5Ap4okOIzPAJBj3V3A40/6/a0Nf9rzHIvZFO
Bt0y6q3lGEQRR55cyHvgfpLbxRnAjVfSh51Gi2vzlPpr3R/fzRrk5RqNwSWW+5fk
pFQ/aENo8W8sotCCoYZ47xAO0XjhExWKbx6kEy3EuShKJKaRN4wO1gIKCVBRRoBl
PBfhY6TZSlv9Sbn0o38L4ZuRVE32h2JeSJuJ3mQ7i0Uwxup6Szzi2oo27X3lAJHa
ih/+Trf//sLSScYjEIwhdDL11wPXbxYo+fm4BL+StiUMMNfZOg4Yc+OtN+S2h3lR
syBUOoGqn1+S4H5eHEDxAsrtpqvyVUHcznU4dhu1Bteev7cPvHlqKaWy+dyC6Wci
mlbHtrH3KNDUcWZ7RjcwXkEAP/ulAonpu7f3EYfmxylfUBwR5hbz3eFOJQ6jIDiD
dDVqE00Z0DSp7i8svIYm
=4RVB
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
