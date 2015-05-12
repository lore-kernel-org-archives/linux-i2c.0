From: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Subject: Re: [PATCH v2] i2c: rk3x: Increase wait timeout to 1 second
Date: Tue, 12 May 2015 15:16:13 +0200
Message-ID: <20150512131613.GF4447@schokonusskuchen.bad>
References: <1431373468-18302-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431373468-18302-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 12:44:28PM -0700, Doug Anderson wrote:
> Although unlikely, it is remotely possible for an i2c command to need
> more than 200ms complete. Unlike smbus, i2c devices can clock stretch
> for an unspecified amount of time. The longest time I've seen
> specified for a device is 144ms (bq27541 battery gas), but one could
> imagine a device taking a bit slower. 1 second "ought to be enough for
> anyone."
>=20
> The above is not the only justifcation for going above 200ms for a
> timeout, though.  It turns out that if you've got a large number of
> printks going out to a serial console, interrupts on a CPU can be
> disabled for hundreds of milliseconds. That's not a great situation to
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

Applied to for-next, thanks!


--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUf0dAAoJEBQN5MwUoCm2BjAP/2iti/LAl7dxZiZWhBBMunAu
/u5FE+EDk/zbMZdR0roKliK3nGd/kAroxIbJPY0Gbs7OsunIh/8L/8OI4dKYYv7U
gM9CiZLFLDIxx/8poHX+svp22dW5LC4k71/dEAtslKdcfFXbmpoSgWU+Flz88mgk
FmksaZCWP5+9Fn0NXvRbkuRVKzCfJ//0efJo/o2KYLjga1y6tli119v1SW+Z3IHR
sIUi4nCyxvWTNUq2zgVLX25Zv1M+spNwD271X5WCb6VA3yLh1phgvahDvDnI25Px
ZQtnzfdM/DoOW10ilR0yb3zcyTyoA67em30RkhqsbhPVpXsot4DJP9D2k9dFV4K0
5FJaRMVRuKbXiKPjVxL7ka36lFJhKCDAn2rrwh186vKE3/GFAzC7XHW+j4NxIZZn
GUpZDHE0QQLPt7mtqn+OUrgh2/T4UbBNjk6chcW7IzXiazF6j76ROFmnWyiVXzsd
TXQCIdbuCAq86sp9co8okKvnRmRcGqdXh9o1J6ZYLu2Ys7jNZszKq6x6UOzuLE09
G9u2rcyXsizwTxEOj93+Gz3rDPw00R5nEj9L/El6jVriZkpqeBjYU+Gr101Ny2+f
pOvJQ3/D/RwnbmW8tMU6DaQdceK7DxvAFi5oJhVR0Yw71Szbur6TYQijHyhI816L
n8OcO1t9kTbFWo6Bf+0Z
=SQJo
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
