From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: octeon: Missing AAK flag in case of
 I2C_M_RECV_LEN
Date: Thu, 9 Jun 2016 22:09:38 +0200
Message-ID: <20160609200938.GF23522@katana>
References: <cover.1465304877.git.jglauber@cavium.com>
 <d16b9cde449b0f6bad954c7ac1db2ac941231601.1465304877.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34818 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcFIUJm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:09:42 -0400
Content-Disposition: inline
In-Reply-To: <d16b9cde449b0f6bad954c7ac1db2ac941231601.1465304877.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 08:51:17AM +0200, Jan Glauber wrote:
> During receive the controller requires the AAK flag for all
> bytes but the final one. This was wrong in case of I2C_M_RECV_LEN,
> where the decision if the final byte is to be transmitted
> happened before adding the additional received length byte.
>=20
> Set the AAK flag if additional bytes are to be received.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-current, thanks!


--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWc0CAAoJEBQN5MwUoCm2EsYP/0CLGG6TcTdMhlZsLveZV/0x
FCtDNXCLEKBHGY0D5ecZxpfTJ688H/4vrTufNySJ8p771kmA7kocJWbQnkxh/AlS
+OZiZvqoef89KVYhb3/FqDirDj+yhfqvMO4acAEHHlgsOtYNaX/cuZ5h+ZnR7FC5
kygk8KVtRg9UFTAkkPCaa6UmhfD0WrqDuDV2r9PmU20zAQNxSr0OX/p2Gm8+SMZl
CIrEEUckCaavAiHiVyGRvAZ6b04t1THBgqxAL/EG3Jt7t0QXo6zlPhn6nYYmE2eT
o8OoE+d2GYhEHvIcpdorLIc1ps7UtXI8O5plWuq8hUZ7OGi9kC3xolusL15QpYZ4
io5eFtDVl1LgshhiFdFgKQPs2rNM0u5k/0N6BnzVyamaosqsBxgFhdOAvkRKRdGv
9U4aZxW5fhYh61hzSdUq1daS/2LOZHpzXO8nslaxRqGRHWzdkg6uaR9MEH/RL/9E
qmeIUi4/rk1x4MYE+0Lb0whJi6bw2wYh8n7fLFVg0rA8TX5RzGpQUjGkdg9fdIEh
linotcaOqTyt9/42+Z6J9StYoP9uPuPyY7jjGV+vCSrLGkjPreAlmQGIyHISR90K
xtbRRU7RRkscb/zYcelNisS3P3p1m4MqBfkWPS4th7IK24ZpBFHBVgZ7Q0Mywc2A
XM5mr6r3BOWUiygeCyZw
=DtjX
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
