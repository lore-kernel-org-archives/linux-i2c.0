From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: cadence: Move to sensible power management
Date: Sun, 25 Oct 2015 16:40:35 +0100
Message-ID: <20151025154035.GA23308@katana>
References: <1444912015-6912-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46300 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbbJYPkk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 11:40:40 -0400
Content-Disposition: inline
In-Reply-To: <1444912015-6912-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 05:56:55PM +0530, Shubhrajyoti Datta wrote:
> Currently the clocks are enabled at probe and disabled at remove.
> Which keeps the clocks enabled even if no transaction is going on.
> This patch enables the clocks at the start of transfer and disables
> after it.
>=20
> Also adapts to runtime pm.
> Remove xi2c->suspended and use pm runtime status instead.
>=20
> converts dev pm to const to silence a checkpatch warning.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

Can you resend please with the driver maintainers in cc? Best use
get_maintainer.pl to create the CC list. Thanks!

> ---
>  drivers/i2c/busses/i2c-cadence.c |   73 ++++++++++++++++++++++++--------=
------
>  1 files changed, 46 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-ca=
dence.c
> index 84deed6..6b08d16 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
> =20
>  /* Register offsets for the I2C device. */
>  #define CDNS_I2C_CR_OFFSET		0x00 /* Control Register, RW */
> @@ -96,6 +97,8 @@
>  					 CDNS_I2C_IXR_COMP)
> =20
>  #define CDNS_I2C_TIMEOUT		msecs_to_jiffies(1000)
> +/* timeout for pm runtime autosuspend */
> +#define CNDS_I2C_PM_TIMEOUT		1000	/* ms */
> =20
>  #define CDNS_I2C_FIFO_DEPTH		16
>  /* FIFO depth at which the DATA interrupt occurs */
> @@ -128,7 +131,6 @@
>   * @xfer_done:		Transfer complete status
>   * @p_send_buf:		Pointer to transmit buffer
>   * @p_recv_buf:		Pointer to receive buffer
> - * @suspended:		Flag holding the device's PM status
>   * @send_count:		Number of bytes still expected to send
>   * @recv_count:		Number of bytes still expected to receive
>   * @curr_recv_count:	Number of bytes to be received in current transfer
> @@ -141,6 +143,7 @@
>   * @quirks:		flag for broken hold bit usage in r1p10
>   */
>  struct cdns_i2c {
> +	struct device		*dev;
>  	void __iomem *membase;
>  	struct i2c_adapter adap;
>  	struct i2c_msg *p_msg;
> @@ -148,7 +151,6 @@ struct cdns_i2c {
>  	struct completion xfer_done;
>  	unsigned char *p_send_buf;
>  	unsigned char *p_recv_buf;
> -	u8 suspended;
>  	unsigned int send_count;
>  	unsigned int recv_count;
>  	unsigned int curr_recv_count;
> @@ -569,9 +571,14 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *=
adap, struct i2c_msg *msgs,
>  	struct cdns_i2c *id =3D adap->algo_data;
>  	bool hold_quirk;
> =20
> +	ret =3D pm_runtime_get_sync(id->dev);
> +	if (ret < 0)
> +		return ret;
>  	/* Check if the bus is free */
> -	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA)
> -		return -EAGAIN;
> +	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA) {
> +		ret =3D -EAGAIN;
> +		goto out;
> +	}
> =20
>  	hold_quirk =3D !!(id->quirks & CDNS_I2C_BROKEN_HOLD_BIT);
>  	/*
> @@ -590,7 +597,8 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *a=
dap, struct i2c_msg *msgs,
>  			if (msgs[count].flags & I2C_M_RD) {
>  				dev_warn(adap->dev.parent,
>  					 "Can't do repeated start after a receive message\n");
> -				return -EOPNOTSUPP;
> +				ret =3D -EOPNOTSUPP;
> +				goto out;
>  			}
>  		}
>  		id->bus_hold_flag =3D 1;
> @@ -608,20 +616,26 @@ static int cdns_i2c_master_xfer(struct i2c_adapter =
*adap, struct i2c_msg *msgs,
> =20
>  		ret =3D cdns_i2c_process_msg(id, msgs, adap);
>  		if (ret)
> -			return ret;
> +			goto out;
> =20
>  		/* Report the other error interrupts to application */
>  		if (id->err_status) {
>  			cdns_i2c_master_reset(adap);
> =20
> -			if (id->err_status & CDNS_I2C_IXR_NACK)
> -				return -ENXIO;
> -
> -			return -EIO;
> +			if (id->err_status & CDNS_I2C_IXR_NACK) {
> +				ret =3D -ENXIO;
> +				goto out;
> +			}
> +			ret =3D -EIO;
> +			goto out;
>  		}
>  	}
> =20
> -	return num;
> +	ret =3D num;
> +out:
> +	pm_runtime_mark_last_busy(id->dev);
> +	pm_runtime_put_autosuspend(id->dev);
> +	return ret;
>  }
> =20
>  /**
> @@ -760,7 +774,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_b=
lock *nb, unsigned long
>  	struct clk_notifier_data *ndata =3D data;
>  	struct cdns_i2c *id =3D to_cdns_i2c(nb);
> =20
> -	if (id->suspended)
> +	if (pm_runtime_suspended(id->dev))
>  		return NOTIFY_OK;
> =20
>  	switch (event) {
> @@ -808,14 +822,12 @@ static int cdns_i2c_clk_notifier_cb(struct notifier=
_block *nb, unsigned long
>   *
>   * Return: 0 always
>   */
> -static int __maybe_unused cdns_i2c_suspend(struct device *_dev)
> +static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev =3D container_of(_dev,
> -			struct platform_device, dev);
> +	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct cdns_i2c *xi2c =3D platform_get_drvdata(pdev);
> =20
>  	clk_disable(xi2c->clk);
> -	xi2c->suspended =3D 1;
> =20
>  	return 0;
>  }
> @@ -828,26 +840,25 @@ static int __maybe_unused cdns_i2c_suspend(struct d=
evice *_dev)
>   *
>   * Return: 0 on success and error value on error
>   */
> -static int __maybe_unused cdns_i2c_resume(struct device *_dev)
> +static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev =3D container_of(_dev,
> -			struct platform_device, dev);
> +	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct cdns_i2c *xi2c =3D platform_get_drvdata(pdev);
>  	int ret;
> =20
>  	ret =3D clk_enable(xi2c->clk);
>  	if (ret) {
> -		dev_err(_dev, "Cannot enable clock.\n");
> +		dev_err(dev, "Cannot enable clock.\n");
>  		return ret;
>  	}
> =20
> -	xi2c->suspended =3D 0;
> -
>  	return 0;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(cdns_i2c_dev_pm_ops, cdns_i2c_suspend,
> -			 cdns_i2c_resume);
> +static const struct dev_pm_ops cdns_i2c_dev_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
> +			   cdns_i2c_runtime_resume, NULL)
> +};
> =20
>  static const struct cdns_platform_data r1p10_i2c_def =3D {
>  	.quirks =3D CDNS_I2C_BROKEN_HOLD_BIT,
> @@ -881,6 +892,7 @@ static int cdns_i2c_probe(struct platform_device *pde=
v)
>  	if (!id)
>  		return -ENOMEM;
> =20
> +	id->dev =3D &pdev->dev;
>  	platform_set_drvdata(pdev, id);
> =20
>  	match =3D of_match_node(cdns_i2c_of_match, pdev->dev.of_node);
> @@ -913,10 +925,14 @@ static int cdns_i2c_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(id->clk);
>  	}
>  	ret =3D clk_prepare_enable(id->clk);
> -	if (ret) {
> +	if (ret)
>  		dev_err(&pdev->dev, "Unable to enable clock.\n");
> -		return ret;
> -	}
> +
> +	pm_runtime_enable(id->dev);
> +	pm_runtime_set_autosuspend_delay(id->dev, CNDS_I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(id->dev);
> +	pm_runtime_set_active(id->dev);
> +
>  	id->clk_rate_change_nb.notifier_call =3D cdns_i2c_clk_notifier_cb;
>  	if (clk_notifier_register(id->clk, &id->clk_rate_change_nb))
>  		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
> @@ -966,6 +982,8 @@ static int cdns_i2c_probe(struct platform_device *pde=
v)
> =20
>  err_clk_dis:
>  	clk_disable_unprepare(id->clk);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }
> =20
> @@ -984,6 +1002,7 @@ static int cdns_i2c_remove(struct platform_device *p=
dev)
>  	i2c_del_adapter(&id->adap);
>  	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
>  	clk_disable_unprepare(id->clk);
> +	pm_runtime_disable(&pdev->dev);
> =20
>  	return 0;
>  }
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLPfzAAoJEBQN5MwUoCm2FaMP/3AFHwRs4+dfGSBFRfH+Uj7t
anofdaLjiVNXlDRHXolz6fxvUvLw2l2rEYVrGdX6M+vBiglKe5P/4lQaD6bO+Ug1
fMg9zqnG0p0PVApfl5VDnGfKJBnGvDPnlNQmgloUiYWHukPOtOrSAUofQN9I9uCy
aci0ZAMA/J3q58HlcwK4CmFfaEepHv2wnoEVZ2OWpuNiiGP8fzcjThc1PrisUsZp
j0SN0Kdx1eFAA49ZymjGaiO9H9VDPqVPDvaY0EFfAtuDyU/qBYXc6J68bk3By6vm
smxB6Omj10wf6PM7hVRHASUnJyPij0qRNVpHu+PM8HjJPv+OUkvi6D9FH5pKicfa
FWiS00e2JGrKriqm/Fiz83w140QORnplstDl7f+tvo+WZvYnebfG71mrOEA2/hHl
GsLfKPM8U9WnIbdiRgCD9WtY9CJN4D3gmXFG5LokoT7+LCZ6/LwpElto/oWQ95h3
5BJm0guKySjKJPEsRQFibCLD00yw6ECveR5u/TxRkfQBOUkTkgYvxk1u4RGpW6Za
EgyAJ5WgPUB16VRjlZCP0YIaFS/SCQ3Ht3kDpjEav+sNuQci/cTYBrgVRb9SLNUy
jW8p/MiXYtdMqcfv6ZL48SoxO70bTPns9rwOQVSDROgmbDVju1p3nbt3qzQGTH6l
GCeq+w/ntixIjduaSmuo
=A7/O
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
