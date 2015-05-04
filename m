From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
Date: Mon, 4 May 2015 10:33:12 +0200
Message-ID: <20150504083312.GN25193@pengutronix.de>
References: <1430430247-9632-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430430247-9632-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 30, 2015 at 02:44:07PM -0700, Doug Anderson wrote:
> While it's not sensible for an i2c command to _actually_ need more
> than 200ms to complete, let's increase the timeout anyway.  Why?  It
> turns out that if you've got a large number of printks going out to a
> serial console, interrupts on a CPU can be disabled for hundreds of
> milliseconds. That's not a great situation to be in to start with
> (maybe we should put a cap in vprintk_emit()) but it's pretty annoyin=
g
> to start seeing unexplained i2c timeouts.
>=20
> A normal system shouldn't see i2c timeouts anyway, so increasing the
> timeout should help people debugging without hurting other people
> excessively.
Hmm, correct me if I'm wrong: You say that the following can happen:

	rk3x_i2c_xfer calls wait_event_timeout and blocks
	schedule ... disable_irqs ... xfer complete ... do some work ... enabl=
e_irqs
	control back to i2c driver after timeout elapsed
	wait_event_timeout returned 0

The documentation of wait_event_timeout tells:

 * Returns:
 * 0 if the @condition evaluated to %false after the @timeout elapsed,
 * 1 if the @condition evaluated to %true after the @timeout elapsed,
 * or the remaining jiffies (at least 1) if the @condition evaluated
 * to %true before the @timeout elapsed.

Where is the misunderstanding?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
