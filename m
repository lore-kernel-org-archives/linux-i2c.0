From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: i2c: designware: prevent signals from aborting I2C transfers
Date: Fri, 7 Jun 2013 10:53:39 +0200
Message-ID: <20130607085327.GA570@ab42.lan>
References: <1369216991-13334-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369216991-13334-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 22, 2013 at 10:03:11AM -0000, Mika Westerberg wrote:
> If a process receives signal while it is waiting for I2C transfer to
> complete, an error is returned to the caller and the transfer is abor=
ted.
> This can cause the driver to fail subsequent transfers. Also accordin=
g to
> commit d295a86eab2 (i2c: mv64xxx: work around signals causing I2C
> transactions to be aborted) I2C drivers aren't supposed to abort
> transactions on signals.
>=20
> To prevent this switch to use wait_for_completion_timeout() instead o=
f
> wait_for_completion_interruptible_timeout() in the designware I2C dri=
ver.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>=20
> ---
> drivers/i2c/busses/i2c-designware-core.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/b=
usses/i2c-designware-core.c
> index c41ca63..db20a28 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -580,14 +580,13 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2=
c_msg msgs[], int num)
>  	i2c_dw_xfer_init(dev);
> =20
>  	/* wait for tx to complete */
> -	ret =3D wait_for_completion_interruptible_timeout(&dev->cmd_complet=
e, HZ);
> +	ret =3D wait_for_completion_timeout(&dev->cmd_complete, HZ);
>  	if (ret =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		i2c_dw_init(dev);
>  		ret =3D -ETIMEDOUT;
>  		goto done;
> -	} else if (ret < 0)
> -		goto done;
> +	}
> =20
>  	if (dev->msg_err) {
>  		ret =3D dev->msg_err;

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
