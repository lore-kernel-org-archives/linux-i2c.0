From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V3 4/8] dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp
 compatible string
Date: Sun, 28 Oct 2018 22:19:52 +0000
Message-ID: <20181028221952.GF1882@kunai>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
 <1539886483-15775-5-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4077184603953680056=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1539886483-15775-5-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============4077184603953680056==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2018 at 06:19:29PM +0000, A.s. Dong wrote:
> Add imx8qxp compatible string
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Doesn't apply...

>    - "fsl,imx8dv-lpi2c" for LPI2C compatible with the one integrated on i=
=2EMX8DV soc

=2E.. I don't have this line in my tree.

Would you maybe volunteer to maintain this driver? To prevent stuff like
this from happening? :)

Regards,

   Wolfram


--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWNgcACgkQFA3kzBSg
KbZoAA//VGgfk7XArEeM6JoAMXTdir7abDgfjRo3hI2zQVF2yrgQXjB1Ew01SIaO
FL1WOZrCi4oq4pDTLW/v3YBoCFmhsCdbX5PuILrijaI8JaEPI3DmuQCE+3A7zpAV
5Gy9ImqdVqPYy4P9335CdRr2Y/2cx9a+j+Z8EuanREQ4hZXeYpMn2rpKAhbynzyG
v8f03vlroD/RSp1mcLvwQ3Ni5fbout/SdEztrqVbISE//te9+vpX4wNNC4/RDled
wNPvlKsH8853evYv+gHFXmAEhc5S3rnznQysXdGHrirFTLDJ8+0yK7sedb1o7srz
aWDVr6/Cc3Ia+3gd0nVXd3v2IeG6CSpA2AZ614mOb1F7ROIuMgtH6w5Pd8ZeXl+d
pr4rlJWdqYMMpBBac0ihI2mskrcrbXffR+R1TgJvEERY9eOuY7uCDXiYN71wjLTJ
C8w4oKU9FCMZRZz/hFEu5h6qaAEpv1o5WE08eA3VUKovGUVheHzvxeen/a52Cvq9
PGTJx9qal6hZc3M29sJu3GgA7SxnMi3ejei5EVt0yGvFOhWg8Qf83uv+PvRLvvmZ
Ubjexd6ozpW0vjoY1LxZAVAq6zhzXRgTnD1sK65wPvdPWpfRcE9dwqlFaZosNhMt
dhj1jArOmcGM9BSbwje1fg4OQp3lkaHLhjdoiONBA/2fD+KoOzo=
=CExn
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--


--===============4077184603953680056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4077184603953680056==--
