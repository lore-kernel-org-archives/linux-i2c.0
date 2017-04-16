From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i2c-scmi: add a MS HID
Date: Sun, 16 Apr 2017 21:50:13 +0200
Message-ID: <20170416195013.oldw47c4novlyxwh@ninjato>
References: <1491322707-2991-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3zeaun3kycraaggs"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491322707-2991-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Sender: linux-acpi-owner@vger.kernel.org
To: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, echerkasov@dev.rtsoft.ru, Michael.Brunner@kontron.com
List-Id: linux-i2c@vger.kernel.org


--3zeaun3kycraaggs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 07:18:27PM +0300, Viktor Krasnov wrote:
> From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
>=20
> Description of the problem:
>  - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
>  - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
>    Interface Specification, version 1.0": "Each device must specify
>    'SMBUS01' as its _HID and use a unique _UID value";
>  - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
>    and implement "SMB0001" HID instead of "SMBUS01";
>  - I speculate that they do this because only "SMB0001" is hard coded in
>    Windows SMBus driver produced by Microsoft.
>=20
> This leads to following situation:
>  - SMBus works out of box in Windows but not in Linux;
>  - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
>    SMBus work in Linux. Moreover the same board vendors complain that
>    tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
>    and produce errors.  So they need to constantly patch the compiler for
>    each new version of BIOS.
>=20
> As it is very unlikely that BIOS vendors implement a correct HID in
> future, I would propose to consider whether it is possible to work around
> the problem by adding MS HID to the Linux i2c-scmi driver.
>=20
> v2: move the definition of the new HID to the driver itself.
>=20
> Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>

Applied to for-next, thanks!


--3zeaun3kycraaggs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljzyvUACgkQFA3kzBSg
KbZdWw/9E6oOZGNOJZiYhYWt27kl3DbZ0IFoklJarjpA6lpHuIa6Zqzhj2I3HR/t
AM/PclX06YG7xfJo/zzi8Ex5DsRqEmASMWxW5WcmIVgeHMeYEObwS5SPowqTN21o
F+LuR3VyeMBdqlwm8V1OulLpXI4iXGf0aLpCC6iOpo70tgnDcyhZvw48gVa9B/UE
A/Ni+vv+aYpcLN4dh0GvxMe5jKg/L9ScDT7M50nK/utMsOEZU4YAYyBkj8GyoA4l
tdIObD2bLzlcT2jaLyWE3y59rqNlT8BcllPYAJnE1ZUOEUlUBE/Jsltp546MmWUs
IBezrDIWVjt9Kr4l6B3sm/LZQjjYy8ezt7Uk/njZbmrDfEFPPURhZ/OL6p/8w/P0
dBf8mPAqTUAGsCs9yqRSv9g6pnzbGr54ovZRc2PaR8I1du3crRke2xZwCIX2tmIw
b19r5mqQ4XGeM4+1zzk+Q0+1Fb0ymWp2tEWyMUzGwg04AkkMvRtnJfM1dd5AYO4h
BZKjSmtPb953Ok6MyDHTkwiPZNfJ0qdcz2LE5767ZBZHR8JgIRL/zywtKB+cdQN9
jtxMPheGJKBiq+iI/sQSdCxEWA/45pCeo4rENKCvzGH6xpVrBscgDZm7y+Y4Q/Qn
mbWyrpi1/MhCvzEkXRLc+/1YjNR/Te0h3PZYTpQRWNgZZV42AOA=
=k7Qn
-----END PGP SIGNATURE-----

--3zeaun3kycraaggs--
