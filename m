From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: xgene-slimpro: Add ACPI support by using PCC
 mailbox
Date: Fri, 2 Jun 2017 22:31:29 +0200
Message-ID: <20170602203128.uxuy5lgzyopvvpkr@ninjato>
References: <1493056826-16776-1-git-send-email-hotran@apm.com>
 <1493056826-16776-3-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djewz3jmdu4vxxjz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493056826-16776-3-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>
List-Id: linux-i2c@vger.kernel.org


--djewz3jmdu4vxxjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 11:00:26AM -0700, Hoan Tran wrote:
> This patch adds ACPI support by using PCC mailbox communication
> interface.
>=20
> Signed-off-by: Hoan Tran <hotran@apm.com>

Please make use checkpatch:

WARNING: braces {} are not necessary for single statement blocks
#149: FILE: drivers/i2c/busses/i2c-xgene-slimpro.c:242:
+	if (!acpi_disabled) {
+		mbox_chan_txdone(ctx->mbox_chan, 0);
+	}

Fixed that and applied to for-next, thanks!

BTW is there anyone inside apm.com who is willing to take over maintainersh=
ip
for this driver? This person needs to review patches thoroughly, yet it usu=
ally
means patches will go in faster.

Regards,

   Wolfram


--djewz3jmdu4vxxjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkxyyAACgkQFA3kzBSg
KbbqMA//ftZ7xp+JBlujcp8V/u7R2LIFnqfgEta9PnwowfFA6Zw5eohkziCQfqYg
ehco87lwgmAAMW0lOW+S/ZkTl9vuhHC9R8JVyD4W0HOxlD2lJhcA+VJ5KWADSDTh
LFVyzyDDmiyyATNwP0SzfHarBKjKt2w7gJumIEdGIRcv2mFDFtHOHNvJcSJtBJ6f
2j2p7L7ZODFsafl+MZ4yJtxgBuJ3tVRM7QhZtzdBZM1H/l9E4MQAXsrZHb0ufSrd
u4kw/yso4lauxgSnDuO4PlmX3PMYcCnGrRyq80JHSHKfuawYR4zkMvayTWsAGWR+
v38eRxJWO6L5ockaoZx/RWIEwx21bNQkV5wTLukAGN0/gg6J3JTbyR0rs82SVKP8
Wi1o/4WHT8XMEAk1dQwJ3OQFYFXJRx+6vy4ST2MTrig4zG3dxV5WPnlN1jxPj49y
1JPJrjXtP+oUVCNBJh+ectucO9HA2PZNU73Pr/2Ec/cb1lApi/YsyLlkha4F+1O9
0LIwxDU4CQUXrIb+PF7YAba6COpUS5Wwk605rY5lsZSJbnVUVvDz071+ogYMWCOe
4uDcoPQyohhap25B08e8zA5QUMQREhfG9JGhohTr72YRHFbVz6jIM13EzvZlZB8/
MLBqTG+0+aXxyXIT4SyZ0oeLFW+M1Qyc1nO9fkWhUB3+vFVGz/w=
=C/RP
-----END PGP SIGNATURE-----

--djewz3jmdu4vxxjz--
