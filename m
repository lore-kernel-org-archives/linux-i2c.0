From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Mon, 29 May 2017 23:04:19 +0200
Message-ID: <20170529210419.GA2527@katana>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
 <1494947612.7509.24.camel@infinera.com>
 <1495547252.17446.60.camel@infinera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:37852 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdE2VEW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 May 2017 17:04:22 -0400
Content-Disposition: inline
In-Reply-To: <1495547252.17446.60.camel@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:47:34PM +0000, Joakim Tjernlund wrote:
> On Tue, 2017-05-16 at 17:13 +0200, Joakim Tjernlund wrote:
> > On Thu, 2017-05-11 at 14:20 +0200, Joakim Tjernlund wrote:
> > > Current I2C reset procedure is broken in two ways:
> > > 1) It only generate 1 START instead of 9 STARTs and STOP.
> > > 2) It leaves the bus Busy so every I2C xfer after the first
> > >    fixup calls the reset routine again, for every xfer there after.
> > >=20
> > > This fixes both errors.
> >=20
> > Ping?
>=20
> Ping again, pretty please?

I am interested in this patch. Especially why you think the generic
recovery structure is not suitable and if we maybe need to update that,
too. But I need time to think into it and that may still need 1-2 weeks.
I am aiming for 4.12 nonetheless.


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlksjM4ACgkQFA3kzBSg
Kbb5KA/9G+ephALgxRSQPVclr/Gzlu5Ojz+sa3RtmbPE6RZRzMnZ4G4p6fUXHRza
d9MEHUn/rvxyphmKRLxTMUcfmkcdS1wOAM7Vio2h9l/fOjo6l43dFqr3NX2sOoSf
UTIAJk1wfUFBD0Sj0+OPlkqW/ccOnuxGw4ldzheOaB/yP6kFDHunALR05Rsm+fyl
naPGQTdw5I+5BZydN8Qa5LsIPn0pxF2C2Du9WT3ig31FxAzWmLKYzCWZTzO9Z4rY
l7AjVibT1gJ5JWOAxA3tB9g4cJrKWu3/LX9r1xuvfIUTvz4Jscg+E2RZDhv8lrqk
lr85B3roQKmRLhjqUmBtxkZ6AB1AWxizzsuMu18Gzz78cE9b7rfh6TS6SU5WsN9f
WD+kzr0FDSw6JjtoAWJLkDVKBilbrICJsybQvP5WVOo1LeLxf/nowJXUPMdbdD6S
vu3NTUDoqnvB2iz+3eE1ckfJe1iSNwDMWKacBRvJ+s4fsVHhz7LSDlCQ6vDef3yt
XU5WOPAKM6DL08trOy9ethCtVKagto2CEutnMMjTA2UD83v6d0CMmPUOp96aHJYr
E8dPWj6EXDqLTrBfiEvunSuxyxfpLG4V+nQpUNret29yJgZgOdHGVEJ0MkV2kNCJ
62tt/DlVIBT4FBoz33iRRhldRJW2rgIi51OyPmMpXng2kTQoN+Y=
=qybz
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
