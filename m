From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] i2c: cadence: Set the hardware time-out register
 to maximum value
Date: Thu, 4 Dec 2014 19:30:15 +0100
Message-ID: <20141204183015.GI7944@katana>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-3-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417610126-7957-3-git-send-email-harinik@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harini Katakam <harinik@xilinx.com>
Cc: mark.rutland@arm.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, vishnum@xilinx.com, harinikatakamlinux@gmail.com
List-Id: linux-i2c@vger.kernel.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 06:05:25PM +0530, Harini Katakam wrote:
> From: Vishnu Motghare <vishnum@xilinx.com>
>=20
> Cadence I2C controller has bug wherein it generates invalid read transact=
ions
> after timeout in master receiver mode. This driver does not use the HW
> timeout and this interrupt is disabled but the feature itself cannot be
> disabled. Hence, this patch writes the maximum value (0xFF) to this regis=
ter.
> This is one of the workarounds to this bug and it will not avoid the issue
> completely but reduces the chances of error.
>=20
> Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>

Applied to for-current, thanks!


--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKg2AAoJEBQN5MwUoCm23pwP/itLlYloGG6UhJiqE67jIxq1
Zzh/9XnWunZN62cDASUh663SfCTqQy6VzbFMbxlwZszDEcYpMEnApFy/QQarszBS
1tSgJaET7FK5nadhWrz3uqUTAqv5Qlcs54GhMoD8LNfJfT4OQKzk6luaOu+eUNXv
Re/rpRJmhLHPmpMhExvNA5fKKGcj5UOMTuulENhW+sBpuM16NkUuPY8S4bsh3Y0E
Hoho/A9KSlHdlVf/GMnZgv2qA2ke1vc52GfN+8E3KKntQaFdWL2TXwDNx6orUrGc
CUE9wyoYcIVEHs/f69J5ryAzbs/I2TkMJKcNyoPJ/ZKwtGEHPPClayLFKTJtmi5H
sDrKI/j1CDlQsWRWD3w60tNugBtcT+pNflfAAYcXa0IE59M/U/Ch+kyG/tdzHKdz
Cy53l2L8/U9CImBTExOKgQmSoeKJUeF//lhDkWdNr5JQ423VlnbRfZvRvIeNWsNC
AuTHkXbcqA8I6EQnN6cscjNK7hHM4hx5Z08NCqpvFh2veUilwL7ARCwevbseBvHg
Aqtmo4Eim2QhJkJCXvEHFaZH6meBcdQdD0nNQNLDX2Feb0+ixRaB3TzBmMjajaRm
dJowy/BKcOY9mWzGlzIsX3BJAzl6lQ1+P2AQ6/jQTxY6LRXLt6KAANY0WLfkNPhP
TYBPRjLehDUi/qz1GGGS
=BDJf
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
