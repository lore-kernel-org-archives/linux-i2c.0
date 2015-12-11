From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6] at24: Support SMBus read/write of 16-bit devices
Date: Fri, 11 Dec 2015 14:19:40 +0100
Message-ID: <20151211131939.GC2742@katana>
References: <1914980865.104978.1447718293775.JavaMail.zimbra@xes-inc.com>
 <1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43742 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbLKNTt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 11 Dec 2015 08:19:49 -0500
Content-Disposition: inline
In-Reply-To: <1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2015 at 06:02:19PM -0600, Aaron Sierra wrote:
> Previously, the at24 driver would bail out in the case of a 16-bit
> addressable EEPROM attached to an SMBus controller. This is because
> SMBus block reads and writes don't map to I2C multi-byte reads and
> writes when the offset portion is 2 bytes.
>=20
> Instead of bailing out, this patch settles for functioning with single
> byte read SMBus cycles. Writes can be block or single-byte, depending
> on SMBus controller features.
>=20
> Read access is not without some risk. Multiple SMBus cycles are
> required to read even one byte. If the SMBus has multiple masters and
> one accesses this EEPROM between the dummy address write and the
> subsequent current-address-read cycle(s), this driver will receive
> data from the wrong address.
>=20
> Functionality has been tested with the following devices:
>=20
>     AT24CM01 attached to Intel ISCH SMBus
>     AT24C512 attached to Intel I801 SMBus
>=20
> Read performance:
>     3.6 KB/s with 32-byte* access
>=20
>     *limited to 32-bytes by I2C_SMBUS_BLOCK_MAX.
>=20
> Write performance:
>     248 B/s with 1-byte page (default)
>     3.9 KB/s with 128-byte* page (via platform data)
>=20
>     *limited to 31-bytes by I2C_SMBUS_BLOCK_MAX - 1.
>=20
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> ---
>  v2 - Account for changes related to introduction of
>       i2c_smbus_read_i2c_block_data_or_emulated()
>  v3 - Consolidate three patches into one
>     - Expand comments regarding SMBus multi-master read risks.
>     - Rely on current-address-read for improved read performance (i.e. one
>       dummy address write followed by multiple individual byte reads).
>       This improves performance from 1.4 KiB/s to 3.6 KiB/s.
>     - Use struct at24_data's writebuf instead of kzalloc-ing
>     - Only limit write_max by 1-byte when accessing a 16-bit device with
>       block writes instead of attempting to preserve a power-of-two.
>     - Style fixes (indentation, parentheses, unnecessary masking, etc.)
>  v4 - Address 16-bit safety in Kconfig
>     - Set "count" to zero later in at24_smbus_read_block_data()
>     - Fix over-80-columns issues in at24_eeprom_read()
>     - Fix write_max off-by-one in at24_probe()
>     - Check SMBus functionality needed for 16-bit device reads
>     - Homogenize indentation of SMBus functionality checks for SMBus write
>  v5 - 16-bit device read needs READ_BYTE not READ_BYTE_DATA
>     - Clarify write_max limiting with smbus_max
>     - Add X-ES copyright
>  v6 - Update comment associated with SMBus functionality testing for 16-b=
it
>       device read (READ_BYTE not READ_BYTE_DATA)
>=20
>  drivers/misc/eeprom/Kconfig |   5 +-
>  drivers/misc/eeprom/at24.c  | 132 ++++++++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 122 insertions(+), 15 deletions(-)

I remember I had a lengthy discussion with Guenter Roeck about 16 bit
support via smbus. I don't have the bandwidth right now to recap the
discussion and check if the concerns apply to your implementation as
well. Could you check this thread

https://lkml.org/lkml/2015/2/4/436

and report back if it applies to your patch as well? This would speed up
the review significantly.

Thanks,

   Wolfram


--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWas1rAAoJEBQN5MwUoCm2HywP/3dzqXClkNWnjSm139JIeZQk
lNOY4nISBIrobuOGrozCQLKr+9fm9K3elR2/T2BzQTWIIPDiwtubmkTxuohhQVuj
7GqoleWNMZBbPtgTQvm/S4gwhEqHJXUpZb3FhqULpA3+mebsuDyKK8JcwGqeYkbF
5WfmZCtq9gOwMOydFFXsJ2pfPhIiUK3xblUKDDvMrlSp1NfjAxkIqRBcs7lg/Exr
22ULieIIS2gmmUMUQiR122Cpdt0KA4RK90u+i3z0octI1dAg21WS4XvLX64HVB/z
BeO9QOepLcpO8SQglY05rluAgOcsWoOnFzjA9bs9HfrOfJpOR3AeUKQYpfkmix6r
Nc8wGkZR4X4Fc9PvQex/83MQie2XiQtap5sDTDpgL/p36Bt6Ai5DAc41dxJ0royn
hDLQwCQHwllWbXzHlRSGgZslsZvx9NHJCop2iAJd3vZ4RAXcF2V3ioawvQg8Xibw
Qv1+KScI3kWfkQb9N4GI3qoRrgCQrJuXiFiTntHSkMVwszOEHMDqs8zIWvjdrN+1
FJLm+EnortSp8StQlLkYMdsBvtEQbSC7nbHpZeaRfOWW6SLIJMrS1+cmxXlJpcny
PklQ6WhuU0M62Op++BXHZH4IyCQkt/MrHQhxt0sQfgYGMAODfJ52ihMRvrlWE0/o
H7G5zY7NGJm+vjEO5ud2
=6GUL
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
