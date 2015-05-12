From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: Increase wait timeout to 1 second
Date: Tue, 12 May 2015 09:15:06 +0200
Message-ID: <20150512071506.GW12671@pengutronix.de>
References: <1431373468-18302-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431373468-18302-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 11, 2015 at 12:44:28PM -0700, Doug Anderson wrote:
> Although unlikely, it is remotely possible for an i2c command to need
> more than 200ms complete. Unlike smbus, i2c devices can clock stretch
> for an unspecified amount of time. The longest time I've seen
> specified for a device is 144ms (bq27541 battery gas), but one could
> imagine a device taking a bit slower. 1 second "ought to be enough fo=
r
> anyone."
>=20
> The above is not the only justifcation for going above 200ms for a
> timeout, though.  It turns out that if you've got a large number of
> printks going out to a serial console, interrupts on a CPU can be
> disabled for hundreds of milliseconds. That's not a great situation t=
o
> be in to start with (maybe we should put a cap in vprintk_emit()) but
> it's pretty annoying to start seeing unexplained i2c timeouts.
>=20
> Note that to understand why we can timeout when printk has interrupts
> disabled, you need to understand that on current Linux ARM kernels
> interrupts are routed to a single CPU in a multicore system. Thus,
> you can get:
>=20
> 1. CPU1 is running rk3x_i2c_xfer()
> 2. CPU0 calls vprintk_emit(), which disables all IRQs on CPU0.
> 3. I2C interrupt is ready but is set to only run on CPU0, where IRQs
>    are disabled.
> 4. CPU1 timeout expires. I2C interrupt is still ready, but CPU0 is
>    still sitting in the same vprintk_emit()
> 5. CPU1 sees that no interrupt happened in 200ms, so timeout.
>=20
> A normal system shouldn't see i2c timeouts anyway, so increasing the
> timeout should help people debugging without hurting other people
> excessively.
>=20
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
