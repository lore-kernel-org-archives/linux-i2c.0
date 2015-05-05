From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
Date: Tue, 5 May 2015 15:10:08 +0200
Message-ID: <20150505131008.GH25193@pengutronix.de>
References: <1430430247-9632-1-git-send-email-dianders@chromium.org>
 <20150504083312.GN25193@pengutronix.de>
 <CAD=FV=W1UMOfVCEYAHmsxQfoyXvGRSd63Sw26zEki+A-7G7eiw@mail.gmail.com>
 <20150504152415.GS25193@pengutronix.de>
 <CAD=FV=VsH2r5w3RNwu4=xD04x=jgf4JO9wCnk6MOVsNFf5vPog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=VsH2r5w3RNwu4=xD04x=jgf4JO9wCnk6MOVsNFf5vPog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Max Schwarz <max.schwarz@online.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Mon, May 04, 2015 at 09:38:28AM -0700, Doug Anderson wrote:
> On Mon, May 4, 2015 at 8:24 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >> Thank you for looking at this!  I will clarify by giving explicit =
CPU
> >> numbers (this issue can only happen in SMP, I think):
> >>
> >> 1. CPU1 is running rk3x_i2c_xfer()
> >>
> >> 2. CPU0 calls vprintk_emit(), which disables all IRQs on CPU0.
> >>
> >> 3. I2C interrupt is ready but is set to only run on CPU0, where IR=
Qs
> >> are disabled.
> > Why does this irq only trigger on cpu0?
>=20
> So I've never done the research myself on the interrupt architecture
> on ARM, but certainly on all ARM boards I've worked on recently all
> IRQs (except those local to just one core) get routed to CPU0.  I've
> been told that there are some userspace programs that try to balance
> things out a little bit, but even in those cases each IRQ is assigned
> a single CPU and if that CPU has its interrupts off then the IRQ won'=
t
> be dynamically rerouted.  I think I remember someone telling me that
> there was also extra complexity around what happens when CPUs get
> taken offline...
>=20
> A quick search shows some discussion from 2011 at
> <http://comments.gmane.org/gmane.linux.ports.arm.kernel/102251>.
>=20
> Given that lots of smart people have looked at this and our interrupt=
s
> are still all going to CPU0, it's not something I'm going to try to
> solve right now...
researching a bit myself it seems you're right here. It would be nice t=
o
mention this in the commit log though.
=20
> > Assuming this is correct, the
> > more robust change would be to detect this situation after 200ms in=
stead
> > of waiting 1s to work around this issue.
>=20
> Detect in what way?  You mean add code to detect that the CPU that's
> assigned our interrupt has been stalled for 200ms?  ...and what do I
> do in that case?
>=20
> I suppose I could add code that reads the I2C interrupt status and
> notices that although the I2C controller claims that it should have a=
n
> interrupt by now but we never saw it go off.  I could then give it
> more time.  Is that what you're looking for?  We'd still want to
> timeout eventually since there could be some other bug in the system
> that's causing the interrupt not to ever go off...
Hmm, probably that's overkill. (Better spend the time fixing printk not
to disable irqs that long :-)

> That adds a bunch of extra complexity, though.  Is there a use case
> where a timeout of 1 second poses a problem for you that would justif=
y
> the extra code?  I'd presume you're thinking of a case where a timeou=
t
> would be expected in a case other than a bug in the i2c driver or a
> hardware bug in the i2c controller where 200ms is an acceptable
> timeout but 1 second is far too long.  Note: if we are using the
> timeout to detect a bug of some sort then I'd imagine that 1 second
> might be actually better (a slightly longer delay makes it more
> obvious that something bad is happening).
>=20
>=20
> One other thing occurs to me: having a longer than 200ms delay may
> actually be a correctness thing anyway.  Technically i2c devices are
> allowed to clock stretch "indefinitely", so transfers be quite long
> and still be "legal".  In practice a REALLY long clock stretch signal=
s
> a problem somewhere so we really do need some timeout, but 200ms may
> be too short.  For instance, some docs of the bq27541 battery gas
> gauge claim that it can clock stretch (in extreme cases) for 144ms.
> While this is still less than 200ms, it does seem prudent to give a
> little more leeway before seeing a timeout.
If you rework your commit log to describe the failing situation more
accurately that should be fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
