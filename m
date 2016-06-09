From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: octeon: Avoid printk after too long SMBUS
 message
Date: Thu, 9 Jun 2016 22:09:44 +0200
Message-ID: <20160609200944.GG23522@katana>
References: <cover.1465304877.git.jglauber@cavium.com>
 <83c02ffe81ffb98f384d0633523118464bc27537.1465304877.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <83c02ffe81ffb98f384d0633523118464bc27537.1465304877.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 08:51:19AM +0200, Jan Glauber wrote:
> Remove the warning about a too long SMBUS message because
> the ipmi_ssif driver triggers this warning too frequently so it
> spams the message log.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-current, thanks!


--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWc0IAAoJEBQN5MwUoCm2SM0P/RfmX2BoEfldHUMloKIoXbiM
r9lIpppyE7WfeFcpCAuiakTaRzKwt0cMKHL5JnE253WTHS1zupoyzw9cWxgbdq7q
pFDEfUemh3ZCDNxWsdw9Sv4qIdPvkD/yboDZ7zHSf0jBfVQfr3HB0mgTyIFKtFzO
O96YJEkXXAAK94rRvVQBXUjQd4h0DL0oVhrp7mxtGYC+ESipyn7zL83/NtZ0Jmfk
t62kx52J7XzuCVo3R6sZcq83aqwBUo3oyYSoNHq6FPjYPUsfiVQ6pkrmNzfTJPrO
tdSfPMaDKJtn4gsCGburwQq4ZtAUzkTa0wCIZQRf8GhTlxHp+Buef13VOigo+qYq
PKWQ+MlS41hGco9Jjg5GJ5cseDxUAWVwBqHTEhn2CaxDJXAoc594Zq3IvgzrMRTK
GV+NkR+kXXS/hY7Je5IGUUCnvwgVBFc8GdHjICye4Uu+ENvmmLn24Q83V5It/azf
nmUIvWK/rKrTRxR4bW1cOETnX1RCmfjRTjge6DKtVlYFTvkt/8mZ0zdQrg18Xm5F
eYIoJC1NtcaAnHdlqyComXRWLDLToIFDlsJ3usszdJZil33wLysmReMrxkrk7VF+
WGsDf+yTSUWV+O6Gvw6SOvLFljS3fn66ku6EOvRJ4whbq3szEZlBvWzIInr8KkTA
kZIPQ9o/Vcz7LhSYC++H
=g8mj
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
