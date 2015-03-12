From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC V2 12/12] i2c: bcm-iproc: make use of the new
 infrastructure for quirks
Date: Thu, 12 Mar 2015 15:56:07 +0100
Message-ID: <20150312145607.GC9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
 <54EFAD2A.9060501@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54EFAD2A.9060501@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Change on the iproc i2c driver looks good to me. Sanity tested the
> change from Wolfram's i2c/quirks branch on Cygnus 958300K combo board.
> Sanity tested with an attempt to transfer large amount of I2C data to
> ensure the transfer is denied by the i2c-core:
>=20
> / # cat /dev/i2c-0
> [  657.310261] i2c i2c-0: quirk: msg too long (addr 0x0000, size 4096, re=
ad)
>=20
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Tested-by: Ray Jui <rjui@broadcom.com>

Thanks for testing, and especially describing your test! Much
appreciated.


--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAakHAAoJEBQN5MwUoCm2fhkP/RegkbE8DFbXjl3zsQrI3uCi
znNLVQG8LUjRJlC8YsLgcQsC7ph6BQjCTYtkLQGpz6zxn0SGR3T4lJmzakfbFCuy
NMt4yuUdpktXE3ARA7k0u2DG8J0LTzeYo0MIBaWlwtitswmEhGuTkfkXif2iGOBq
ddquZ3SRzWPFo4m7/9FgCYMwR4EPi8NKUor4QZ4R866oug2uWX/IOr/gPtsrIwM5
BbFoysprOtmwFNfaCEBCNvKKWGG8HJFHOzITj+s6BpG9Z0xxyilKoTBtCkef/jA2
qj0fhLVP3DvjjLLPcb2oZuF0NNvpP6KEeGwWEtXYiqwkUVXaSXfIn6OkuikGj8eB
sW/DEyjvyo6U2VZvXX5SdW/HDk7m52mmhvOMNMJ+ZDxfMxIVr/lmIS8YMcQDMXPa
I85vlFW4/1hbwIttfG71b9AEdgCVOzWH3GrgsFjP3dGhi1y3H+r8pCwsI8Q6lOTi
mgWWm6vZ6Oup9xEp0D8YJZIlCqRUAeF4vJ0EbqKZ4/58wUH+kYy/svAViHdYJ5hr
frDuQVqRFN0eIxQ/QIP8qTWUqrjVx6wObvFw4I/jrg6aWwfZ6wrPWAhO5xbY4QRl
CDQs7/236BZ4GpSRbvwosdwP2le6xxuRs7CtWnxshV3cHTVakYBiDRwTswybHfZl
YSE/CSiPwPrn28XdxMfY
=qVbz
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
