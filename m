From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: piix4: Disable completely the IMC during
 SMBUS_BLOCK_DATA
Date: Fri, 13 Oct 2017 21:04:15 +0200
Message-ID: <20171013190415.c6dqyjnhm6jwcmpo@ninjato>
References: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
 <20171013190326.gozfjhmv2pbmnrgt@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7cescmn7akkrs4k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171013190326.gozfjhmv2pbmnrgt@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--c7cescmn7akkrs4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2017 at 09:03:26PM +0200, Wolfram Sang wrote:
> On Tue, Oct 10, 2017 at 06:11:15PM +0200, Ricardo Ribalda Delgado wrote:
> > SMBUS_BLOCK_DATA transactions might fail due to a race condition with
> > the IMC (Integrated Micro Controller), even when the IMC semaphore
> > is used.
> >=20
> > This bug has been reported and confirmed by AMD, who suggested as a
> > solution an IMC firmware upgrade (obtained via BIOS update) and
> > disabling the IMC during SMBUS_BLOCK_DATA transactions.
> >=20
> > Even without the IMC upgrade, the SMBUS is much more stable with this
> > patch.
> >=20
> > Tested on a Bettong-alike board.
> >=20
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>=20
> Applied to for-current, thanks!

But please mention the dependency next time.


--c7cescmn7akkrs4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhDi8ACgkQFA3kzBSg
KbaOfRAAoaIPiIzfRgFPfMmsFgfxfhJ5lCzYP7Z3hEwwzmDqpXoGJgFdeEEj+VvB
Meexa2mvBXqNN9qP83C7iT30VPdFUpiId2RDf75Oz0dkxv6hpKBPrFXEJU6pjGyN
W2+1j58663CM+9U1ZnWy+TYdyasizB165bFp/nXp88jRoiIvewlQbPWXnWVC6aIC
1z0roJdwWUsD6KIQpcwLHK52D2dtqpPuQl7/Lb+BPEY14RztE/u+0381DbfYlj0W
jTe7A+BA65E5B0fJu/Jk5T1UEncnEsLHvaLyap2ZfJ7YDDEKliqy6eFqG5OAp3El
Gcmim8iYlDiosMPLbgAJp/Z3TxogyDhGjlkmRy8U8CCqz9hxYn9wrjyjbiGpB/7R
+gvUSvNVP7QggIyg7jASgvpIZIg1nZJUdJLRZvlacMP8IQB9cVXGZF9kXSReRLC+
FWJUxen43KQTSyY0ReX679BxkF/JBZdCp7iRQr50SpJ4ls82nLOOrPrGBQ4Qn/Bj
kNAdB0DeVY7/v2iillkBsxePIBLg6LeDfZmiyTj26NEJZ+DTSvt8EBZhenFJu7FG
+5b4D1BcI4Yi9qNM2CHTPUswjWx3LAeT0N72wcUsqQKV1ljBsvMDuj4nefwwOwsH
RJRimp+PCbD2T/3VSOz0dhD7XZ2WnHFPPB/jvdW4Z9JP3qk4IM0=
=FaAI
-----END PGP SIGNATURE-----

--c7cescmn7akkrs4k--
