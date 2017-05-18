From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: stub: move module_init/exit annotations to the
 proper place
Date: Thu, 18 May 2017 10:14:35 +0200
Message-ID: <20170518081435.l4em4ntmgmdu4mps@ninjato>
References: <20170516112105.2793-1-wsa+renesas@sang-engineering.com>
 <20170518095842.7f3b612a@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ppqf3ra54xqfquz4"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170518095842.7f3b612a@endymion>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ppqf3ra54xqfquz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > -module_init(i2c_stub_init);
> > -module_exit(i2c_stub_exit);
>=20
> I'm not sure on what you base your claim that this is the "proper
> place". checkpatch doesn't complain about either, and if anything, the
> original style (module_init/exit) at end of file seems a lot more
> popular through the kernel tree.

In my book, this is more "old-style" than "popular" ;) And while I am
quite sure my change is common these days (put annotations directly
behind the functions), I in deed cannot find any public reference for
that.

No strong feelings, I can drop it.

Thanks,

   Wolfram


--ppqf3ra54xqfquz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkdV+cACgkQFA3kzBSg
KbYnBBAAkm8Yzolau3iXpjTvOdQUny0iT8qemmbw86LfJrMLEBJuHsK+Oh0CskEo
T+3m3Nr07Bx/6TZnCkeqf32AVkWL2JA6q9EdS2/irNu7wom1W9tQzWQyvCSdQjJx
6Rk4cJgfs5unbLsvlv3AMN6UMFhviUEFQNNp0eZsc4xXLJgMa12nBi59ACIkFnwn
3BaeMa1SSg8L3v38Var7x1nL/hHF6rqVlcPhtRfJCA/fMOxEBqJtaOLDJpJuBiKz
HGBIcckr+BnzU1h25ajpuKRby5lQeEFpAGU3dCB7hlbbx+uwWd5Xo3ItkFaTKUCd
xbYuALPdoE++qaoMoG/Qy5iV019pZ7c0dY0tCbxDhrDSjgvwNlCIBt51pN79endj
PvEDKoXxWuNoLHHxc96ScZDYIsb886wdIpNo4DNtONCByRN9s7TjxKM0j4AbMarT
I2z7BO4YkBFH/JNykymBqryJkS7QwXZjBoFymGknLpNe3y40qd3mZsC7dgB5lthH
v0a4usWfazA1ED4zfqrkVDX+zmr9DL0Jvk/uhEDHcserLObsq0Ej7RZNdQGrdRWW
hjJ6fGYlEMSfTQHIpvQP3tHkWYQu3/clsEuD9W/vADgx6FLNpCVLL6qKU1GLf1v9
s8t113NKxU74RBGNG0mzSW+4QR7wcC+UBYHMKW6GldgZjq5hPs8=
=FHxT
-----END PGP SIGNATURE-----

--ppqf3ra54xqfquz4--
