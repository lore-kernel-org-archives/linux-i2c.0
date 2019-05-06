From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Model Divider in CCF
Date: Mon, 06 May 2019 11:14:03 -0700
Message-ID: <87o94fo3h0.fsf@anholt.net>
References: <20190505034339.30778-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7674460212077477684=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190505034339.30778-1-nh6z@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: stefan.wahren@i2se.com, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: linux-i2c@vger.kernel.org

--===============7674460212077477684==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Annaliese McDermond <nh6z@nh6z.net> writes:

> Model the I2C bus clock divider as a part of the Core Clock Framework.
> Primarily this removes the clk_get_rate() call from each transfer.
> This call causes problems for slave drivers that themselves have
> internal clock components that are controlled by an I2C interface.
> When the slave's internal clock component is prepared, the prepare
> lock is obtained, and it makes calls to the I2C subsystem to
> command the hardware to activate the clock.  In order to perform
> the I2C transfer, this driver sets the divider, which requires
> it to get the parent clock rate, which it does with clk_get_rate().
> Unfortunately, this function will try to take the clock prepare
> lock, which is already held by the slave's internal clock calls
> creating a deadlock.
>
> Modeling the divider in the CCF natively removes this dependency
> and the divider value is only set upon changing the bus clock
> frequency or changes in the parent clock that cascade down to this
> divisor.  This obviates the need to set the divider with every
> transfer and avoids the deadlock described above.  It also should
> provide better clock debugging and save a few cycles on each
> transfer due to not having to recalcuate the divider value.

Any chance we could reuse clk_register_divider() instead of having our
own set/round/recalc rate implementations?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzQeWsACgkQtdYpNtH8
nuh5Lg/9Hz9DEDFEVdhjXtd+t3vKtl5okxkdaEIugqXb/lA3D71R/ish1ONL2sDL
09JoAA3Zt+WTMAZM/qPmU7GaDh1gJ9sRNzKi4AktA+XPZK/TUrFdGqZEpwhTYcEe
NHc3bp6TIzi6zDffoleIwIEhbJbfM42j/XlOycFSocqkIajreaYlofCxMNwQGn80
+JxoQbixw4xhq+0eTbDxO5rwrocM7++l4egkimH3/oX6y+mv39k+T/wwk5zLUQZS
KNqQgH9Z5Ad12lORo/OxO4XwCwXvFXWQpbAsu27W91d0dRV+SvHJcFNHAYWj7Wol
lJa6LpDoxLUZBMSroI0qZT3XcQCjJ7Szt18MIGj5AKoRZb3qUK6wI4eRM3CLtSwi
9FyKLMb7anvfubplCKHT2zBr1CpZRHQAafWQEDmlNyqqsfQRU4w66RuhUwtZ9BXy
zCCLNsPB2C+oi9bF7RTdsbNWysD0qzT1dGYJIh3FRDjeuAdsKfUqeToXWTnQIxod
kxpvC84lZgwfJohqt1QLe0vYXmMJ7m24+fwK9U8B7oBCMMvP574VJpUaJUHQUt+l
WSGN3bihzs1TZOBHyVBuA/ewQndOGbYamLUYXSf0fb6f6JYVFDc42zOh2VGDt+ts
Qw2bMUaviG5cse6/C25pPYeLiCiH5oX6MGptPmMd+ExHd/shC+Y=
=Gimv
-----END PGP SIGNATURE-----
--=-=-=--


--===============7674460212077477684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7674460212077477684==--
