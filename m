From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Tue, 20 Jun 2017 11:23:10 +0200
Message-ID: <20170620092310.GA2337@katana>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
 <20170619144601.vhswaa27f5mcxcxs@ninjato>
 <681500CE65202E47A192754B01DAB4671B1674818F@SDE12.beckipc.net>
 <20170620082835.melqahq7lwyb2hfl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:59630 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbdFTJXO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 20 Jun 2017 05:23:14 -0400
Content-Disposition: inline
In-Reply-To: <20170620082835.melqahq7lwyb2hfl@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Andy Duan <fugang.duan@nxp.com>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 10:28:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Cc +=3D Andy Duan
>=20
> On Tue, Jun 20, 2017 at 10:20:42AM +0200, Michail Georgios Etairidis wrot=
e:
> >=20
> > The i2c-imx driver incorrectly uses readb()/writeb() to read and=20
> > write to the appropriate registers when performing a repeated start.=20
> > The appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions=20
> > should be used instead. Performing a repeated start results in=20
> > a kernel panic. The platform is imx.
>=20
> I really wonder why this didn't pop up earlier, maybe repeated start
> just isn't that usual.

Quite the contrary, read a register or something from an EEPROM and you
should have the write (for the memory pointer) and the read (actual
data) connected with a repeated start.

The readb() calls are only accessed when a read message is not the last
message. Since most transfers look like what I described above, this is
not so super often. Add to that that not everyone reports such patches
back upstream, this might go unnoticed for a while.

So, thanks Michail for the patch and keeping at it!

Note: I found there is some code duplication in the driver. Both
'if (is_lastmsg)' blocks look like copied to me...


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllI6XoACgkQFA3kzBSg
Kba2/RAAmAGrPcDpH5Pz2Q9ZdHBHwAXqlBpAmfWzsHNUhx+6yMeUeBtpAPuE51+2
lELlVMcgFw/wXB8oxdmxGAYVoYiXXlT1Lxfe4lHsvdYz16oGrj2Oj/MHNtuq3ZSG
M3SCoWdBdn6fxopZ6FfaEZw/SWhdWAeBu0OYiap9vd0FEnGzIhxtr3JrHyhoROqY
mjAVgA+JwDKB/px2bSSu/obcEhf1c7FsSfg19eZNMOxWiEyn1Yuk6Fkyo75FzS5h
zIh3xHMAtoB4zCn1VhfT3y+9eRRAUwaOfASI7p1o4iYPlTU6w4cB0/1aix48XUxN
SL+qtA+U6910SAYU1gWoVzh3OHlmzYTpMYKP8KNoeiFtwuctXvpPjHuS7N4VcLsj
LkGMvWLdCuLc+DxHusoKDM5JJ0SnAobuI/70y/lmjrZkHgoh74h9hkmCvrrJlWTQ
BA/U5IfpFWtubJkh914FOruAY3Zt4ri038bimmeDZflnJeaBe9UaVj2JkVrQWyPu
UqCiyUt8encZJvCHlGjlu5zCgaTD4bTWhbaEYDhFA/g/7P+EUfhX9IlhdL5TtX/D
gO+XURp7JYVpA8pulkf4iVywHPf07WxCvXZ8NnpdL1X3sOx1EpZ3WBnIhTOEJeT4
iXSR0U6//1dTc4NS3Y/g5Hzr3Ez65hRn45wHMujy4/c1mt/CFP4=
=Ru41
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
