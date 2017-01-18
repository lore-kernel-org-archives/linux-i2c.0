From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 2/5] i2c: Add STM32F4 I2C driver
Date: Wed, 18 Jan 2017 19:42:37 +0100
Message-ID: <20170118184237.tvhlsksdcw2ckwan@pengutronix.de>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
 <1484666821-20551-3-git-send-email-cedric.madianga@gmail.com>
 <20170117193752.e6hju25w74bb4i4z@pengutronix.de>
 <CAOAejn0ea2j_oUijOdHgiL3JU4TM0HZoL+-ggzjpPL2eA7tDCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOAejn0ea2j_oUijOdHgiL3JU4TM0HZoL+-ggzjpPL2eA7tDCw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello Cedric,

On Wed, Jan 18, 2017 at 04:21:17PM +0100, M'boumba Cedric Madianga wrote:
> >> +      * In standard mode, the maximum allowed SCL rise time is 1000 n=
s.
> >> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is e=
qual to
> >> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits must =
be
> >> +      * programmed with 09h.(1000 ns / 125 ns =3D 8 + 1)
> >
> >         * programmed with 0x9.
> > (1000 ns / 125 ns =3D 8)
> >
> >> +      * So, for I2C standard mode TRISE =3D FREQ[5:0] + 1
> >> +      *
> >> +      * In fast mode, the maximum allowed SCL rise time is 300 ns.
> >> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is e=
qual to
> >> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits must =
be
> >> +      * programmed with 03h.(300 ns / 125 ns =3D 2 + 1)
> >
> > as above s/03h/0x3/;
> =

> ok
> =

> > s/.(/. (/;
> ok
> =

> > s/+ 1//;
> This formula is use to understand how we find the result 0x3
> So, 0x3 =3D> 300 ns / 125ns =3D 2 + 1

Yeah, I understood that, but writing 300 ns / 125ns =3D 2 + 1 is
irritating at best.

> >> +      * So, for I2C fast mode TRISE =3D FREQ[5:0] * 300 / 1000 + 1
> >> +      */
> >> +     if (i2c_dev->speed =3D=3D STM32F4_I2C_SPEED_STANDARD)
> >> +             trise =3D freq + 1;
> >> +     else
> >> +             trise =3D freq * 300 / 1000 + 1;
> >
> > I'd use
> >
> >         * 3 / 10
> >
> > without downside and lesser chance to overflow.
> =

> There is no chance of overflow as the max freq value allowed is 46

ok

> >> +             /*
> >> +              * In fast mode, we compute CCR with duty =3D 0 as with =
low
> >> +              * frequencies we are not able to reach 400 kHz.
> >> +              * In that case:
> >> +              * t_scl_high =3D CCR * I2C parent clk period
> >> +              * t_scl_low =3D 2 * CCR * I2C parent clk period
> >> +              * So, CCR =3D I2C parent rate / (400 kHz * 3)
> >> +              *
> >> +              * For example with parent rate =3D 6 MHz:
> >> +              * CCR =3D 6000000 / (400000 * 3) =3D 5
> >> +              * t_scl_high =3D 5 * (1 / 6000000) =3D 833 ns > 600 ns
> >> +              * t_scl_low =3D 2 * 5 * (1 / 6000000) =3D 1667 ns > 130=
0 ns
> >> +              * t_scl_high + t_scl_low =3D 2500 ns so 400 kHz is reac=
hed
> >> +              */
> >
> > Huh, that's surprising. So you don't use DUTY any more. I found two
> > hints in the manual that contradict here:
> =

> Yes with the above formula we could use duty =3D 0 by default
> =

> >
> >         f_{PCLK1} must be at least 2 MHz to achieve Sm mode I2C frequen=
cies
> =

> STM32F4_I2C_MIN_STANDARD_FREQ =3D 2
> =

> >         It must be at least 4 MHz to achieve Fm mode I2C frequencies.
> =

> STM32F4_I2C_MIN_FAST_FREQ =3D 6
> =

> > It must be a multiple of 10MHz to reach the 400 kHz maximum I2C Fm mode=
 clock.
> =

> If we use this rule only 3 values are allowed 10 Mhz, 20 Mhz, 30 Mhz and =
40 Mhz.
> It is very restrictive.
> So I don't take it into account in order to have more frequencies even
> if 400 Khz is not reached.
> Indeed, in many cases we are very close to 400 Khz.
> For example, the default I2C parent clock in my board is 45 Mhz
> I reach 395 kHz in theory and 390 kHz by testing.
> I am in Fast mode but not with the max freq but very close.

fine

> > and
> >
> >         [...]
> >         If DUTY =3D 1: (to reach 400 kHz)
> >
> > Strange.
> >
> >> +             val =3D DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);
> >
> > the manual reads:
> >
> >         The minimum allowed value is 0x04, except in FAST DUTY mode
> >         where the minimum allowed value is 0x01
> >
> > You don't check for that, right?
> =

> As the minimum freq value is 6 Mhz in fast mode the minimum CCR is 5
> as described in the comment.
> So I don't need to check that again as it is already done by checking
> parent frequency.

That would then go into a comment.

> > CCR is 11 bits wide. A comment confirming that this cannot overflow
> > would be nice.
> =

> Again there is no chance of overflow thanks to parent frequency check

Right, this time I saw this myself, so I requested a comment stating
this fact.
 =

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
