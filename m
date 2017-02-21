From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Tue, 21 Feb 2017 21:14:03 +0100
Message-ID: <20170221201403.GA1481@katana>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
 <20170220182214.izi46a7lbzck7q4r@ninjato>
 <23773cd4-a9a4-5323-4cc2-71d1d617b232@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:45010 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752239AbdBUUOI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Feb 2017 15:14:08 -0500
Content-Disposition: inline
In-Reply-To: <23773cd4-a9a4-5323-4cc2-71d1d617b232@i2se.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Peter Robinson <pbrobinson@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >On Thu, Feb 16, 2017 at 09:20:45PM +0000, Stefan Wahren wrote:
> >>Since commit e2474541032d ("bcm2835: Fix hang for writing messages
> >>larger than 16 bytes") the interrupt handler is prone to a possible
> >>NULL pointer dereference. This could happen if an interrupt fires
> >>before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
> >>on the RPi 3. Even this is an unexpected behavior the driver must
> >>handle that with an error instead of a crash.
> >>
> >>CC: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> >>CC: Martin Sperl <kernel@martin.sperl.org>
> >>Reported-by: Peter Robinson <pbrobinson@gmail.com>
> >>Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger tha=
n 16 bytes")
> >>Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >Applied to for-next, thanks (will be in 4.11)!
> >
>=20
> since this patch is too late for 4.10, should i resent with CC to stable =
in
> order to get it into the next 4.10 release?

It has the Fixes: tag, that will do.


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYrJ+LAAoJEBQN5MwUoCm2KBUP/1zD0skX/CfkGhAphN29TXEQ
xHOTfyQWgUtd9aYas/WJw27pQ29Q2m1C3zW8uXIr0hLbATf0ip5qgocJUXvzXjkl
Io6eEUxZ0tJHQ/WhMACvKu8stvAWTkTZ8B3hH+HbUXz/Xu4qo9ZbNAcqFi+Bt+xb
RslVR+3QucRrWCrXgyCMBk5hWbOp1Qq00fFkv5mSNxBYRhwyJkfCMIhG+0t3pwvW
tGW8WiqA+mRwjNyLwC9oV2VBu92OufP4hkQWwXN8aZVh0CgIDLfnHoEdXJ4jh2N5
mI2V9ECLN7fGvQ2vXLJgUd1Eq/+JAJZLsEVJ3YJINIQ5RkiryQr0NsUU18feGRmE
JrgFrmovfOz0YBuj2/vZud2C1aLZ8awln8vGkzIy1SNmLsQj5tiWTOZ4hCvkz0ol
gmlKl72Pg7XmeIIYjPEOWyVuDQRVfxtnXYEj8rB0W8G7KZfQ2E1dcdcQOwIf66Nm
7jw0n5QajQbzfelaxuMrUeoolZbNGDSrBdBuc04LOL/foxm9LODfyRuMCMvKgSHa
EM0mCAu9sTGUFyAC6DHh7asnbUV9oNB35dIenu0M4Wo02xI06Gwkln6BTRpEieXv
g3l0eOSp7J1bNBtH8QXzi3FteVrQn8XDXpPykv4w2xxFe+VyAt6E5elHOKrKaP35
FnLXPb4/tJD0b/XvS54O
=ESxE
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
