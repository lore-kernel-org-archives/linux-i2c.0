From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c_dw: deadlock happening when system is trying to
 suspend
Date: Mon, 9 Jul 2012 15:31:54 +0200
Message-ID: <20120709133154.GK1296@pengutronix.de>
References: <27240C0AC20F114CBF8149A2696CBE4A0EE76A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A0EE76A-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Liu, Chuansheng" <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Yanmin Zhang <yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
	(yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org)" <yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Srivatsa S. Bhat" <srivatsa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Tu, Xiaobing" <xiaobing.tu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 02:29:13PM +0000, Liu, Chuansheng wrote:
> From: liu chuansheng <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: [PATCH] i2c_dw: deadlock happening when system is trying to susp=
end
>=20
> In i2c_dw code, there is a race condition that causes pm suspend
> thread blocking there always. The scenerio is as below:
>=20
> PM thread:
> suspend -->
> pm_suspend -->
> enter_state -->
> dpm_suspend_start(will call i2c_dw_pci_suspend(),
> and the dw_i2c_dev->lock is hold)
> ...
> suspend_enter -->
> dpm_suspend_noirq -->
> suspend_device_irqs -->
> synchronize_irq()
>=20
> synchronize_irq will wait for any pending irq is handled, and
> the correpsonding irq thread is finished.
>=20
> In this case, there is a i2c device interrupt is pending, the irq
> thread do the below things:
> IRQ thread:
> i2c_smbus_read_byte_data -->
> i2c_smbus_xfer -->
> i2c_transfer -->
> i2c_dw_xfer -->
> down()
>=20
> The irq thread blocked at down dw_i2c_dev->lock, because in PM thread,
> it has been hold after calling i2c_dw_pci_suspend(), but PM thread is
> waiting for IRQ thread, then deadlock happened.
>=20
> The solution is moving the down() action after pm_runtime_get_sync().
>=20
> Signed-off-by: liu chuansheng <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busse=
s/i2c-designware-core.c
> index 1e48bec..748ecb1 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -512,8 +512,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg =
msgs[], int num)
> =20
>         dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
> =20
> -       mutex_lock(&dev->lock);
>         pm_runtime_get_sync(dev->dev);
> +       mutex_lock(&dev->lock);
> =20
>         INIT_COMPLETION(dev->cmd_complete);
>         dev->msgs =3D msgs;

Don't you need to place the mutex_unlock() before pm_runtime_put then?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/63UoACgkQD27XaX1/VRt5YACfUi4fIDUIsZv9+1XWZR6g1G1/
AZoAn1uNdEfBvgVb+KAK58uaTAOFEio9
=GIAz
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--
