From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
Date: Mon, 4 May 2015 17:24:15 +0200
Message-ID: <20150504152415.GS25193@pengutronix.de>
References: <1430430247-9632-1-git-send-email-dianders@chromium.org>
 <20150504083312.GN25193@pengutronix.de>
 <CAD=FV=W1UMOfVCEYAHmsxQfoyXvGRSd63Sw26zEki+A-7G7eiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=W1UMOfVCEYAHmsxQfoyXvGRSd63Sw26zEki+A-7G7eiw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Doug,

On Mon, May 04, 2015 at 08:11:10AM -0700, Doug Anderson wrote:
> On Mon, May 4, 2015 at 1:33 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Thu, Apr 30, 2015 at 02:44:07PM -0700, Doug Anderson wrote:
> >> While it's not sensible for an i2c command to _actually_ need more
> >> than 200ms to complete, let's increase the timeout anyway.  Why?  It
> >> turns out that if you've got a large number of printks going out to a
> >> serial console, interrupts on a CPU can be disabled for hundreds of
> >> milliseconds. That's not a great situation to be in to start with
> >> (maybe we should put a cap in vprintk_emit()) but it's pretty annoying
> >> to start seeing unexplained i2c timeouts.
> >>
> >> A normal system shouldn't see i2c timeouts anyway, so increasing the
> >> timeout should help people debugging without hurting other people
> >> excessively.
> > Hmm, correct me if I'm wrong: You say that the following can happen:
> >
> >         rk3x_i2c_xfer calls wait_event_timeout and blocks
> >         schedule ... disable_irqs ... xfer complete ... do some work ..=
. enable_irqs
> >         control back to i2c driver after timeout elapsed
> >         wait_event_timeout returned 0
> >
> > The documentation of wait_event_timeout tells:
> >
> >  * Returns:
> >  * 0 if the @condition evaluated to %false after the @timeout elapsed,
> >  * 1 if the @condition evaluated to %true after the @timeout elapsed,
> >  * or the remaining jiffies (at least 1) if the @condition evaluated
> >  * to %true before the @timeout elapsed.
> >
> > Where is the misunderstanding?
> =

> Thank you for looking at this!  I will clarify by giving explicit CPU
> numbers (this issue can only happen in SMP, I think):
> =

> 1. CPU1 is running rk3x_i2c_xfer()
> =

> 2. CPU0 calls vprintk_emit(), which disables all IRQs on CPU0.
> =

> 3. I2C interrupt is ready but is set to only run on CPU0, where IRQs
> are disabled.
Why does this irq only trigger on cpu0? Assuming this is correct, the
more robust change would be to detect this situation after 200ms instead
of waiting 1s to work around this issue.

> 4. CPU1 timeout expires.  I2C interrupt is still ready, but CPU0 is
> still sitting in the same vprintk_emit()
> =

> 5. CPU1 sees that no interrupt happened in 200ms, so timeout.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
