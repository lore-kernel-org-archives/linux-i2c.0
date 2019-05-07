From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Model Divider in CCF
Date: Mon, 06 May 2019 21:32:29 -0700
Message-ID: <878svivq8y.fsf@anholt.net>
References: <20190505034339.30778-1-nh6z@nh6z.net> <87o94fo3h0.fsf@anholt.net>
 <C611AB4D-7674-438D-BB95-9F83852043EA@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6135864611534393706=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <C611AB4D-7674-438D-BB95-9F83852043EA@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, swarren@wwwdotorg.org, wsa@the-dreams.de, team@nwdigitalradio.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--===============6135864611534393706==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Annaliese McDermond <nh6z@nh6z.net> writes:

>> On May 6, 2019, at 11:14 AM, Eric Anholt <eric@anholt.net> wrote:
>>=20
>> Annaliese McDermond <nh6z@nh6z.net> writes:
>>=20
>>> Model the I2C bus clock divider as a part of the Core Clock Framework.
>>> Primarily this removes the clk_get_rate() call from each transfer.
>>> This call causes problems for slave drivers that themselves have
>>> internal clock components that are controlled by an I2C interface.
>>> When the slave's internal clock component is prepared, the prepare
>>> lock is obtained, and it makes calls to the I2C subsystem to
>>> command the hardware to activate the clock.  In order to perform
>>> the I2C transfer, this driver sets the divider, which requires
>>> it to get the parent clock rate, which it does with clk_get_rate().
>>> Unfortunately, this function will try to take the clock prepare
>>> lock, which is already held by the slave's internal clock calls
>>> creating a deadlock.
>>>=20
>>> Modeling the divider in the CCF natively removes this dependency
>>> and the divider value is only set upon changing the bus clock
>>> frequency or changes in the parent clock that cascade down to this
>>> divisor.  This obviates the need to set the divider with every
>>> transfer and avoids the deadlock described above.  It also should
>>> provide better clock debugging and save a few cycles on each
>>> transfer due to not having to recalcuate the divider value.
>>=20
>> Any chance we could reuse clk_register_divider() instead of having our
>> own set/round/recalc rate implementations?
>
> Eric --
>
> I=E2=80=99d love to, but the set_rate implementation includes setting the
> BCM2835_I2C_FEDL_SHIFT and BCM2835_I2C_REDL_SHIFT registers for the=20
> rising and falling edge delay on the I2C bus based on what the divider
> value is.

Hmm.  I ran into that in clk-bcm2835.c as well, and the solution was
that bcm2835_register_pll_divider() sets up the divider structure and
then reuses clk_divider_ops.round_rate() and .recalc_rate()

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzRCl0ACgkQtdYpNtH8
nuiKtBAAs4+IMBaTZZ0RlmahxxJEhKLnDjOpLoGSfWG50cMiH4PckvwlRdFWL5Rn
nanNZ/qYTu24BIdlPffgEShPFxuIH94wMSM34F1CCM7G8H7uRfqZtuM9c1MC+mIo
FwYy1lHxuQm7vZ87XSvPoTCsaT8n+Co4kvReVUmy8jR+N0SsohIlZOSXLUbaGBcT
l2JFVbDGBKHAN6gH0Jb30NK95toeT8jiXDNxG2FJPosMeHL/FRLUGIJrN7+IVSzh
dZTSglUbJxUI9uT6JIMnfX6Qf0piD/fC2xQs4c+DfxxVCP44NJHCuieBGoCBOvh+
ZsYiPXBsYmaA/n+tou7LMkkhJMv5r+XzEOYDZI+llZxgyvDdO9c8t84YOpUl3eve
Vy36h2QfMJwk5eMljlWRVJr6MiRTOC1c0JBBq1K6wB+L8PFnzVjW7Cd5ffRBoi+N
8YOjJ3rHvS/hgCaHvizwbX3at3/cEWUAuJwWrt6pS2xPzFz2Yk73njBEuU0j/RcZ
4rdSMSuFLGW/0JPE2tTawVRQCvwYQjin2QFhc0P7N9fOudCUvoxZm6QT7S2yv5b7
OPuRe2KBYlDbkI+a/ltZT2GFWfmTZ+EG0a1k/583TyNljFgYRC7c9ZE2NQYYh8wT
+zSD1M6lhkbVcNXfzB2KtL/ht559VjaunsgSJI+iijodNs5nIMU=
=U+1L
-----END PGP SIGNATURE-----
--=-=-=--


--===============6135864611534393706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6135864611534393706==--
