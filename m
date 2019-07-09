From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [RFC] SW connection between DVB Transport Stream demuxer and
 I2C-based frontend
Date: Wed, 10 Jul 2019 01:21:44 +0200
Message-ID: <20190709232144.GI22408@latitude>
References: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
 <7d47a978-5307-a2c8-acc2-f29ce7567bd5@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7108863224851939077=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7d47a978-5307-a2c8-acc2-f29ce7567bd5@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter@korsgaard.com>, Marc Gonzalez <marc.w.gonzalez@free.fr>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Brad Love <brad@nextdimension.cc>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, GPIO <linux-gpio@vger.kernel.org>, Antti Palosaari <crope@iki.fi>, I2C <linux-i2c@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Mauro Carvalho Chehab <mchehab@kernel.org>, Olli Salonen <olli.salonen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-media <linux-media@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============7108863224851939077==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2019 at 07:58:00PM +0000, Peter Rosin wrote:
> On 2019-07-08 13:08, Marc Gonzalez wrote:
[...]
> > +	dvb_demod: si2168@64 {
> > +		compatible =3D "silabs,si2168";
> > +		reg =3D <0x64>;
> > +		reset-gpios =3D <&tlmm 84 GPIO_ACTIVE_LOW>;
>=20
>=20
> In principle, I think you should be able to add something like this here:
>=20
> 		i2c-gate {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
>=20
> 			tuner@60 {
> 				compatible =3D "silabs,si2157";
> 				reg =3D <0x60>;
> 				/* whatever else is needed */
> 			};
> 		};
>=20
> But in practice, I don't know if the si2157 driver understands that or
> if there is anything else that gets in the way. Totally untested...

So far, both drivers don't deal with devicetree at all, and there are no
bindings, so we have the chance to write the best bindings possible.

An i2c-gate subnode on the si2168 node looks good to me, FWIW.


Greetings,
Jonathan Neusch=C3=A4fer

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl0lIWIACgkQCDBEmo7z
X9u4tQ//Uspzp7ZgorenRjW67VpJ2QDBh+TAxqGare8VptT6VuPpxAewaQcvuSoL
TvyQPaFLfzRcpAWXLIUvLclYkJxXl5nTjvvrT0UAtiKMFvVG0dwz9TH+8BqMmaXp
87C8/IKZhOslJbqKnSFWhnVs2PX+vQ0rpwX3GlrPXL+7a/QNQ5ElSupxJP77Mmfp
uDyN1mV/G16KbD8dXvbx+cmHJClixxcpxQDzxG3rn+xpfRuRrNyhbKM3leo68n0p
MuNyU97Hxr6WfNXfSXSzvMQfYzs8lKKk6W2z7cA3TIB47TbiARXf2THz01F+Mrbl
lQfi89kYATuEyxGZflFg8TNM3aYUsZnDb7Z0oF6VfgoyrtCvaZ1LUBT2YJN+h1Y+
g7lLcpk5p/iYettqg7Uw+TTVl4eEccrf+iQbe8mpllI1xdEJD9roci4ejazYfSPI
SNA/O/Drt49Boyiln3NqikccL0ZIpFPg9wehe/OANsKIcKjMCcHi8ti5+uuNHWe5
E7U3BDsRfSBHVC2GRLfIzaq9qyfibczB7xr7shuf6fVEjSDQo9qAfRmOmlT+WY8Q
bCRJczQjOYcUrwQjXs+apNFleXm1cU0LAVzTFSwXhYjJpwrMZTojgxYvlmzoRkrL
p982FJil2MjgYPZzVc+pHm2+V4QfRNEecxK7a7TaO0140eMOa4c=
=KEcJ
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--


--===============7108863224851939077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7108863224851939077==--
