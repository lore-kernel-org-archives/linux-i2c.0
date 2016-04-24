From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
Date: Sun, 24 Apr 2016 23:10:44 +0200
Message-ID: <20160424211044.GD4317@katana>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40969 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbcDXVKu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 24 Apr 2016 17:10:50 -0400
Content-Disposition: inline
In-Reply-To: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, lee.jones@linaro.org, linux-i2c@vger.kernel.org, Frederic Pillon <frederic.pillon@st.com>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +/*
> + * i2c bus recovery routines
> + * get_scl and set_scl must be defined to avoid the recover_bus field of
> + * i2c_bus_recovery_info to be overriden with NULL during the
> + * i2c_add_adapter call
> + */

Oh, that shouldn't be like this. Can you try this patch and remove the
empty functions please?

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 4979728f7fb2de..604936955807e5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1595,10 +1595,12 @@ static int i2c_register_adapter(struct i2c_adapter =
*adap)
=20
 			bri->get_scl =3D get_scl_gpio_value;
 			bri->set_scl =3D set_scl_gpio_value;
-		} else if (!bri->set_scl || !bri->get_scl) {
+		} else if (bri->recover_bus =3D=3D i2c_generic_scl_recovery) {
 			/* Generic SCL recovery */
-			dev_err(&adap->dev, "No {get|set}_gpio() found, not using recovery\n");
-			adap->bus_recovery_info =3D NULL;
+			if (!bri->set_scl || !bri->get_scl) {
+				dev_err(&adap->dev, "No {get|set}_scl() found, not using recovery\n");
+				adap->bus_recovery_info =3D NULL;
+			}
 		}
 	}
=20

> +static int st_i2c_recover_bus(struct i2c_adapter *i2c_adap)
> +{

Can you describe what the function does? It is not clear to me that it
generates 9 scl pulses.

> +	struct st_i2c_dev *i2c_dev =3D i2c_get_adapdata(i2c_adap);
> +	u32 ctl;
> +
> +	dev_err(i2c_dev->dev, "Trying to recover bus\n");

This is not an error. Either dev_dbg or drop it, I'd say.

> +
> +	/* Disable interrupts */
> +	writel_relaxed(0, i2c_dev->base + SSC_IEN);
> +
> +	st_i2c_hw_config(i2c_dev);
> +
> +	ctl =3D SSC_CTL_EN | SSC_CTL_MS |	SSC_CTL_EN_RX_FIFO | SSC_CTL_EN_TX_FI=
FO;
> +	st_i2c_set_bits(i2c_dev->base + SSC_CTL, ctl);
> +
> +	st_i2c_clr_bits(i2c_dev->base + SSC_I2C, SSC_I2C_I2CM);
> +	usleep_range(8000, 10000);
> +
> +	writel_relaxed(0, i2c_dev->base + SSC_TBUF);
> +	usleep_range(2000, 4000);
> +	st_i2c_set_bits(i2c_dev->base + SSC_I2C, SSC_I2C_I2CM);
> +
> +	return 0;
> +}

Thanks,

   Wolfram


--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHTZUAAoJEBQN5MwUoCm25S0P/347ynQWPjQha7I2QKY4HzVk
SogWfr6uDyXUYp2XGrNVGto/ZIwwNbzZIiJDAo1YDMCtGNTfRC8Ru74g+FiEK6tj
9ubk80R/fPuDjTbIS3SeeTYYkfjNowG5rPXk9/UlfTcKS7Vi1coNJ+ulTvkLvns0
LtNlPnaQ14vInzcPzlO+TDM0zL+ae8DWgMBwwYJrmmnqu4J57A5Hn0xBfgSG0YXf
lpAl7oIXUBUFTUtFzbegRX99H+PNtqsMDJuXGzgb1sLQanu1JxuipkVjnQ+j1LS2
J4YmTrIRZQtrcckhCH9KHNaFI1iDrkrM9jt/rMyfbgX0RDFOjz31TRWOwzb5pJ1+
aMUTeN96z/tMwgm2BaGQTQMOt5t3vTuQ1/jSWiz1V5zmXZr0GRjm6cX0+cXv00GP
fj7uNYQRnNnJRpTF7akjye0lFYx/DHk+XkbLtoWU/vmgwtVe7Rhd2pjWvmQ2colR
Iz1oQ2WhccUMsA8nVA4DQsyu75QaNPMQgxEnb08442Z81tyJxyxRczEI5nfny3hV
d28jl+Al+WB72dGb/UjQCzM4O85DrAJN069zJOkkYs8lll9DCrFwivefviet77A5
8aGlLh4H/5Lxh+6mApDsPSzQFKvatRviEt5OH1gDFUPxnamG7qa1oW921clVxkR5
ybaTJ9bYE5WgoN6qH0Xi
=bIvh
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
