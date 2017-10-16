From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v2] i2c: riic: remove fixed clock restriction
Date: Mon, 16 Oct 2017 17:21:07 +0000
Message-ID: <SG2PR06MB11659AC755BCA8000EC8D30D8A4F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170929171637.121262-1-chris.brandt@renesas.com>
 <SG2PR06MB11656505D83C3D552B2CAC2D8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171013185633.lakiw4cu5o22cwjf@ninjato>
 <SG2PR06MB11658FE2DCDC2A50FA5ED7258A480@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171013215109.l35j652amscnrsfe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171013215109.l35j652amscnrsfe@ninjato>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Friday, October 13, 2017, Wolfram Sang wrote:
> > Technically, to do it right, to calculate the ACTUAL I2C baud rate, you
> > have to take into effect the load resistance and capacitance of the
> > lines in order to factor in the rise and fall times correctly. Of cours=
e
>=20
> We have those generic bindings upstream:
>=20
> - i2c-scl-falling-time-ns
>         Number of nanoseconds the SCL signal takes to fall; t(f) in the
> I2C
>         specification.
>=20
> - i2c-scl-internal-delay-ns
>         Number of nanoseconds the IP core additionally needs to setup SCL=
.
>=20
> - i2c-scl-rising-time-ns
>         Number of nanoseconds the SCL signal takes to rise; t(r) in the
> I2C
>         specification.
>=20
> - i2c-sda-falling-time-ns
>         Number of nanoseconds the SDA signal takes to fall; t(f) in the
> I2C
>         specification.
>=20
> So far, that was all that is needed, however...

So for now, I'm going to take the easy way out and just put in the range
as you suggested.


But, I think later I will revisit this and come up with an algorithm for
calculating the rate/duty at run-time. I want to do that when I have=20
more time to verify things with a scope and such.


Thanks,
Chris
