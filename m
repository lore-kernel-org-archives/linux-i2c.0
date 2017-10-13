From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v2] i2c: riic: remove fixed clock restriction
Date: Fri, 13 Oct 2017 19:37:50 +0000
Message-ID: <SG2PR06MB11658FE2DCDC2A50FA5ED7258A480@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170929171637.121262-1-chris.brandt@renesas.com>
 <SG2PR06MB11656505D83C3D552B2CAC2D8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171013185633.lakiw4cu5o22cwjf@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171013185633.lakiw4cu5o22cwjf@ninjato>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, October 13, 2017, Wolfram Sang wrote:
> On Wed, Oct 11, 2017 at 03:20:29PM +0000, Chris Brandt wrote:
> > On Friday, September 29, 2017, Chris Brandt wrote:
> > > Most systems with this i2c are going to have a clock of either 33.3MH=
z
> or
> > > 32MHz. That 4% difference is not reason enough to warrant that the
> driver
> > > to completely fail.
> > >
> > > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > > ---
> > > v2:
> > >  * simplified error message.
> > > ---
> >
> > What ever happened to this patch?
> > Was there any objection?
>=20
> In deed, I'd prefer to limit the settings to the two known frequencies.
> We shouldn't use the settings if someone is using it with e.g. 16MHz?

How about a range of -4% to +2% ?


	/*
	 * TODO: Implement formula to calculate the timing values depending on
	 * variable parent clock rate and arbitrary bus speed.
	 * For now, just use calculations based on a 33325000Hz clock.
	 */
	rate =3D clk_get_rate(riic->clk);
	if ((rate < 32000000) || (rate > 34000000)) {
		dev_err(&riic->adapter.dev,
			"invalid parent clk (%lu). Must be 32MHz-34MHz\n",
			rate);
		clk_disable_unprepare(riic->clk);
		return -EINVAL;
	}



> Of course, my most favorite option would be implementing the formula
> instead of fixed settings, but I am not forcing that on you.

So I looked at that.

However...

Technically, to do it right, to calculate the ACTUAL I2C baud rate, you=20
have to take into effect the load resistance and capacitance of the=20
lines in order to factor in the rise and fall times correctly. Of course=20
that varies board to board. And then, 100kHz (standard-mode) and 400kHz=20
(fast-mode) have different minimum HIGH/LOW times and duty cycle=20
restrictions, so that has to be taken into account when coming up with a fo=
rmula.

   --or--

Just live with the fact that the speed might be off by 4%.


   (I decided on option #2)


Chris
