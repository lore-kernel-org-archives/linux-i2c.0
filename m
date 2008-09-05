From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Fix section for probe and remove function for Apple SMU
 Controller
Date: Fri, 5 Sep 2008 16:38:19 +0200
Message-ID: <20080905163819.2f858b2c@hyperion.delvare>
References: <20080902210501.GA4306@informatik.uni-freiburg.de>
	<20080902211556.GA6872@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754748AbYIEOiy@vger.kernel.org>
In-Reply-To: <20080902211556.GA6872@informatik.uni-freiburg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?ISO-8859-1?B?S2xlaW5lLUv2bmln?= <ukleinek@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

Note: patches to i2c bus drivers are better sent to the i2c mailing
list (Cc'd.)

On Tue, 2 Sep 2008 23:15:56 +0200, Uwe Kleine-K=F6nig wrote:
> __devexit for i2c_powermac_probe is obviously wrong.  In the definiti=
on
> of struct platform_driver i2c_powermac_driver the remove function
> i2c_powermac_remove is wrapped in __devexit_p, so it should be define=
d
> using __devexit.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.d=
e>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/i2c/busses/i2c-powermac.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i=
2c-powermac.c
> index 22f6d5c..0e7b1c6 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -180,7 +180,7 @@ static const struct i2c_algorithm i2c_powermac_al=
gorithm =3D {
>  };
> =20
> =20
> -static int i2c_powermac_remove(struct platform_device *dev)
> +static int __devexit i2c_powermac_remove(struct platform_device *dev=
)
>  {
>  	struct i2c_adapter	*adapter =3D platform_get_drvdata(dev);
>  	struct pmac_i2c_bus	*bus =3D i2c_get_adapdata(adapter);
> @@ -200,7 +200,7 @@ static int i2c_powermac_remove(struct platform_de=
vice *dev)
>  }
> =20
> =20
> -static int __devexit i2c_powermac_probe(struct platform_device *dev)
> +static int __devinit i2c_powermac_probe(struct platform_device *dev)
>  {
>  	struct pmac_i2c_bus *bus =3D dev->dev.platform_data;
>  	struct device_node *parent =3D NULL;

Looks good, patch applied. Thanks for your contribution.

--=20
Jean Delvare
