From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Date: Tue, 10 Jul 2018 20:50:43 +0200
Message-ID: <20180710185042.x3slnms5wzocobqu@ninjato>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fq6hwdzeuvar2asy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org


--fq6hwdzeuvar2asy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +	cmd |=3D FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
> > I just noticed this and wonder: Don't you need the LSB of the address?
> > It is not the RW flag, this is encoded in msg->flags.
>=20
> So, the hardware interprets the LSB as the RW flag. It wouldn't be possib=
le
> to have a device addressed with the LSB set on this I2C master.

But msg->addr is 7 bit and LSB aligned. If I am not horribly wrong, with
the above code, an EEPROM at 0x50 would show up as 0x28 with your
driver?

> Indeed, real 10-bit addresses require some additional manipulation of this
> I2C master in order to work. We don't support it right now.

Then you should remove the associated FUNC flag.


--fq6hwdzeuvar2asy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltE//0ACgkQFA3kzBSg
KbYMUw//cH0wosOacYmvFj3v0EDNtwEm4WJNqN+c3LaumKW3HpJftZkaeCRJ26e7
+JZSI/K34W6BEkUfd7bg+C+D6q9uQrpjFyQE0VERHC2l1qjpl1+CaXNgkM/fGzyR
Q2Pg23jB8peAGbrUbQ9fw7A522bToRXuy/r6hRaH6hEC4GWlLbVmJn8SoWx0lgWX
Zl6dQPi7cpm09pw0FqROWzknvHkyDeARwGlBAT8/M6H30ERe0Les7VbepFSpZwK/
kb8z2bz8zj7cMT4O3bCe3zcJI03pD9FqqOfZCv0Cy1EhbyRuM7OwyztISqCHkVAQ
I25WcNWdk7DtYfFzfKFki7Cg0dcCxYX9kw9R/fC52XdlwHOMpqL+lsPMgRZFMy2h
Kg+/x8uo+0S46AWM1DoYFPTL6Hfj9PJhu5DdPwFGQagjH7xpZhUCh3hz4hB3O+CO
hQS1J4tTng2tYk5fp2OOALRpt6+CDrvdT6eLtDTcSwhCgHhMBBKZVM8QDE0PBD6V
bSusXcU7GIKcw1OAogtVDPAcHzrc8v1WHRrGCoVvn4YzEo+WjLOdqGhpx+QeHUDV
zRytXxl8cIO45FuF7yCfiyBJ3SQftXnrHGp7N9HTY3amXP4cyXgoC7vRleYVHfh2
LM47Itdn9QMGR3GtVLBkhOTb6f5P9Ysk7dUBuqsXFTy8gG9ajzM=
=WdKa
-----END PGP SIGNATURE-----

--fq6hwdzeuvar2asy--
