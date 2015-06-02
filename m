From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: Reduce stack size of
 acpi_i2c_space_handler()
Date: Wed, 3 Jun 2015 00:29:46 +0900
Message-ID: <20150602152945.GA2661@katana>
References: <20150513065812.GB1490@lahna.fi.intel.com>
 <1432129012-26648-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432129012-26648-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 04:36:52PM +0300, Jarkko Nikula wrote:
> sizeof(struct i2c_client) is 1088 bytes on a CONFIG_X86_64=3Dy build and
> produces following warning when CONFIG_FRAME_WARN is set to 1024:
>=20
> drivers/i2c/i2c-core.c: In function =E2=80=98acpi_i2c_space_handler=E2=80=
=99:
> drivers/i2c/i2c-core.c:367:1: warning: the frame size of 1152 bytes is
> larger than 1024 bytes [-Wframe-larger-than=3D]
>=20
> This is not critical given that kernel stack is 16 kB on x86_64 but lets
> reduce the stack usage by allocating the struct i2c_client from the heap.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbcvpAAoJEBQN5MwUoCm2nJkP/jGJlQlA6LCjvIfH/KFrNTpJ
NwT089mlIMxVd+zhwF00on4EvsdQjcbxI0d9DbVdVOt4yWYSRncbs/13MyvSVFGm
ZCTOUqKiHR96g6dW42vsVWYgJ1UbPe6slpCl8WDg4cL2T4REm8xL0jqdMWC8SyKn
jn70ZD4/h3tQASM9J+zQnDtZdDa75dMW9ubAVst+F3g5pDORa9qgZotAmSq+tfzE
sJjibFnntuRhbOhCPijlHaqvrSKkyoZWfL6c052aDQJG3StDWxUHQqNou0MUsytO
V0ANElYTxQ03sv6Iq8P9Th1ulHQxz+FGBqHgXXTQ2Io6nexj8v7pDLtdJYn+7y1g
h6+Nz5IadfWsIsbQ4C3MEi2FsjI23PDvTaKm+mg74BvgRlZcPuAfkqlt9HyybbNh
qR4alVcMATd/guv0yZqk88TnlRwn+/Xq5SaMiB+yE/r1ymT7ejcaP6eLtrHwU93Y
4J0aVZOsIX2WQ8ogYP0JtWS8TLUrrfTRBt/ViMts7B21VqCwQ9MAWVOMBpAORD4O
r5ZcUDA2rt6g0meTAUX6kNP+REPckq3iBM2ozZGPit9BfgZ3rDpiGdWXPhqLIIKa
tE2W8nTIUh1LbxmEFeFRsxcpGchAj0yKsRU/4Mz+MMxv4gT2ZQIqGJT8InyN4Oxc
ixRc74AvYW0SAyNrJjc2
=6o3S
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
