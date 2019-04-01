From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Date: Mon, 1 Apr 2019 15:42:24 +0200
Message-ID: <20190401134224.GD12232@hirez.programming.kicks-ass.net>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
 <20190401112109.GB12232@hirez.programming.kicks-ass.net>
 <20190401115414.hxrqqjujvwczdafz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401115414.hxrqqjujvwczdafz@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 01, 2019 at 01:54:14PM +0200, Wolfram Sang wrote:
>=20
> > > "This matches the use cases for atomic I2C transfers I have seen so f=
ar:
> > > very late communication (mostly to a PMIC) to powerdown or reboot the
> > > system."
> >=20
> > Ah, sorry, I missed that.
> >=20
> > > And yes, I would never recommend a HW design to use I2C for shutting
> > > down/rebooting. But such HW is out there.
> >=20
> > Can we then make the whole thing conditional on:
> >=20
> >   system_state > SYSTEM_RUNNING
> >=20
> > Such that we're sure to never trigger this under any other conditions?
>=20
> Oh, we can for sure modify the code to something else. Actually, this is
> why I was calling out to you. I was never comfortable with the old
> 'in_atomic() || irqs_disabled()' code, but wasn't sure what would be an
> adequate replacement which will not risk regressions.
>=20
> The above condition makes much more sense to me and is also much more
> readable. Can it simply replace irqs_disabled()? Are interrupts already
> disabled for system_state > SYSTEM_RUNNING? (I got a bit lost in the
> code paths when trying to figure it out)

Looking at kernel_restart_prepare(), we set SYSTEM_REBOOT in normal
context, specifically it just did a blocking notifier call.

So no, you'll have to combine the two.
