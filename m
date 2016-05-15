From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c: rcar: add DMA support
Date: Sun, 15 May 2016 08:52:04 +0200
Message-ID: <20160515065204.GA1846@katana>
References: <1463228228-32560-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37657 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbcEOGwM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 15 May 2016 02:52:12 -0400
Content-Disposition: inline
In-Reply-To: <1463228228-32560-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 14, 2016 at 02:17:08PM +0200, Niklas S=C3=B6derlund wrote:
> Make it possible to transfer i2c message buffers via DMA.
> Start/Stop/Sending_Slave_Address and some data is still handled using
> the old state machine, it is sending the bulk of the data that is done
> via DMA.
>=20
> The first byte of a transmission and the last two bytes of reception are
> sent/received using PIO. This is needed for the HW to have access to the
> first byte before DMA transmit and to be able to set the STOP condition
> for DMA reception.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Fixed a checkpatch warning (trailing */) and applied to for-next,
thanks!


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXOByUAAoJEBQN5MwUoCm23tUP/35G0Tmb9gBCeO/iHIxLZLn2
xJdbCB3ExP1uVW59HRph5BW4HEA+sHdntdTXexREa0/r4pLE3PzOS/TCOx81ajBv
0GnZKXuap/r/zOnFEaRv02KaBNby+pQlCamQeY+i7oBCiYVH2AcPwv/BwQ8V39uy
Hz3UF+KIJcfVBS96F5Ci/ITu+dMzIjhxoYo2JEreFBjJLh14Kj84ZWzn+wUfqzPc
hoCrj89NWortSeKruOCuPL67uJzbWmVe/RqooNGJsUpzmRB29RRKFpkxf/PrUapa
XZHDpFpbkU3GoLj8JpqJC1esh08H4orUCnq5xY0Z+SuLYZuPLRrwDcmQtlBurIgF
zCBWXrEMzDjbWwmCbXV5CFxh64uKewseqYpyKlzY1QzoFvU4kusSKINefOBfAFJp
UbNCzm4r4Agv/AWZ4IlC1mb+WB+689/yEJIExFKYbwKkJXyBycKn6KL4UXZR02Wp
CEzu2s4r8eo8brTTEj4uD346mU45K6F5HQnB2Jzr8jFJ+TXefx9S1+NpIGEfs/l5
TgdhIMYmMi2oO5ldNf6NGDNdpcjRYefXhAHNyr6WJUauWeFc0Uhj+6/PIdignKsR
2vY/nbQReRLFLVnOvgZGvb7e9GFEPIFY0QUGn167WY2XP2oW8osuAxJR2loTzIsi
Tt1X05d8w+nkR2FSm+LH
=SdPA
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
