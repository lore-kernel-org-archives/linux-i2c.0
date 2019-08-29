From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: bcm2835: Add brcm,bcm2711 compatible
Date: Thu, 29 Aug 2019 20:52:52 +0200
Message-ID: <20190829185251.GD3740@ninjato>
References: <1566925456-5928-1-git-send-email-wahrenst@gmx.net>
 <1566925456-5928-2-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4400648218800844429=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566925456-5928-2-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============4400648218800844429==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 07:04:14PM +0200, Stefan Wahren wrote:
> Add a new compatible for the BCM2711, which hasn't the clock stretch bug.
>=20
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1oHwMACgkQFA3kzBSg
KbZRRg//Ryv7Zq+mHMTNa3cr8ox0/gmPrj0BRADdaDUn/V4haoxNg/ItcG0N94zf
rBUXZ1IwcGXQ3AiI+5lmEcj+kAVGRPvN1IYqK6MNGEcIRQq8KO9U1xHYesdORiNh
EQRxyJpjGdxXHSoEduhdHx5CLPTAFScj7xVMBiueVNdJWEXO7RvWIJyAfLQ8uTuG
HUGikkBmOb8aTLRvP5ltNJWKCjaF53MH8mel25KyykhdN+oYfZhxRkkxVLd1pF39
mb6olPxLpPPIODm4iLCC88e6hXY8BB08dne9d73vZI3WSgBr2eNYT0M/5ZzNbRbc
elrzOGUi7aLeRGZDeT6noC/rxEIGSmiKBRdrgOT4oKVvh1SvdkZCEq+TTTodHQ3p
RPlBcgyrJp6NtvrV/AjmSwyWrhU5wxMfGbH2K0ALmndlCWSt19AWhOF2jNWAbqzC
sTnbOi4b1oCPW1fSI7hRf7sHu8QB+CAr6plmPFoGdMqxRW8J9LTvNj3xT4Vegf9z
rCzsucbOn1T0d/R80dnbRAyb5LuYj5hOlZyky1GiN2kqCL0ApQ3FGb4Kcxa700wH
0WLciVQAZJqqAf6SW0by/DTtp1FrGcY8GuBxogw6UbeQzeRZEnT9U7WEpkekMTce
zOgMioM3Hw84yQgo5CVDubafVNBQIJ671UCxmwm1prdXI/c61Gw=
=Wx3G
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--


--===============4400648218800844429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4400648218800844429==--
