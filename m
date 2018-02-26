From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Avoid clock stretching timeouts
Date: Mon, 26 Feb 2018 15:33:50 -0800
Message-ID: <87fu5njpgh.fsf@anholt.net>
References: <1519422151-6218-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2691394944973922524=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519422151-6218-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

--===============2691394944973922524==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> From: Eric Anholt <eric@anholt.net>
>
> The CLKT register contains at poweron 0x40, which at our typical 100kHz
> bus rate means .64ms. But there is no specified limit to how long devices
> should be able to stretch the clocks, so just disable the timeout. We
> still have a timeout wrapping the entire transfer.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
> Hi,
> just like "i2c: bcm2835: Set up the rising/falling edge delays" this is a
> outstanding bugfix. Unfortunately i only have I2C slaves, which doesn't
> stretch the clock. So test feedback is very welcome.

I also didn't have any particular devices that this fixed.  It was just
an issue that came up in a previous discussion of clock stretching.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqUmV4ACgkQtdYpNtH8
nui6Rg//c/DVhjJlnVwtKXfhMErTWLDsq07Ky4Kr1EBgT+Yd/uCWIOBrrIJGa14Y
acxNyJ15BvAz8MxpiNtAcrSb3RfIHMVpqpKtLrvzCJtXt3A9AGdfXXedlcKQf8xB
NUt3hNnhpH30U+drG0WGv7ZS0MzzsgmmjO//+uHRTm9AAXjlXPAC0ZGbF59MySll
WO/ASAMeUOzgwMH5JcHmd9tptRXXZvmg+AA9arm0WXvHKw44x2aEq6Lzqo6SxMww
Hz02Qeubx7Kh1v5h24qB8sJiXknt9sVEe+xXuOTUkRhhul1JcVpKUzXBHgUtNXsB
2RSISgelzL+LodMhOo3Pfl8BK6QAwX6TmpFA1jAUc5RNnC3hmFOzsiKtW5qgLFrK
frsKPJGzk/GH0o1trisI3rg6UudtfzFJMWsPqFL+PhC9q1aXyvgFY8WJVJ26lMbw
7UfG4vLiAW8MocJlTjgJNSZsCbFJJsv/54Il19DuVbjh+GosKaJyANTnCubL09eb
v70YnAWZuQS8GUR2o66fmCoj55hV9pGm3z4Lz0jjDtOsOg+Bsve5aJdk3aSOcVWn
SRsYe7JLOpOHzqBGYbyGnYr9e/gkmRv+GoLxTDnfsQg684bZDEv812B1VlBLHQuv
7QqwRVn8hvwhfPbuxcF9rq9aqXFEMcBqQsBva56oaHXAtCTp/sc=
=eeS2
-----END PGP SIGNATURE-----
--=-=-=--


--===============2691394944973922524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2691394944973922524==--
