From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] of/i2c: Generalize OF support
Date: Thu, 10 Jun 2010 11:52:26 +0200
Message-ID: <20100610095226.GI5333@pengutronix.de>
References: <20100610052102.16222.86662.stgit@angua>
	<20100610052232.16222.942.stgit@angua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8561611667535982129=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100610052232.16222.942.stgit@angua>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8561611667535982129==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5uO961YFyoDlzFnP"
Content-Disposition: inline


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

looks good to me in general. A few questions:

On Wed, Jun 09, 2010 at 11:22:32PM -0600, Grant Likely wrote:
> This patch cleans up the i2c OF support code to make it selectable by
> all architectures and allow for automatic registration of i2c devices.
>=20
> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-cpm.c     |    3 ++-
>  drivers/i2c/busses/i2c-ibm_iic.c |    3 ++-
>  drivers/i2c/busses/i2c-mpc.c     |    3 ++-
>  drivers/of/Kconfig               |    2 +-
>  drivers/of/of_i2c.c              |   44 ++++++++++++++++++++++++--------=
------
>  include/linux/of_i2c.h           |   13 +++++++++--
>  6 files changed, 45 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index b02b453..03ae62e 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -652,6 +652,7 @@ static int __devinit cpm_i2c_probe(struct of_device *=
ofdev,
>  	cpm->adap =3D cpm_ops;
>  	i2c_set_adapdata(&cpm->adap, cpm);
>  	cpm->adap.dev.parent =3D &ofdev->dev;
> +	cpm->adap.dev.of_node =3D of_node_get(ofdev->dev.of_node);
> =20
>  	result =3D cpm_i2c_setup(cpm);
>  	if (result) {
> @@ -679,7 +680,7 @@ static int __devinit cpm_i2c_probe(struct of_device *=
ofdev,
>  	/*
>  	 * register OF I2C devices
>  	 */
> -	of_register_i2c_devices(&cpm->adap, ofdev->dev.of_node);
> +	of_i2c_register_devices(&cpm->adap);
> =20
>  	return 0;
>  out_shut:
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ib=
m_iic.c
> index bf34413..d964121 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -745,6 +745,7 @@ static int __devinit iic_probe(struct of_device *ofde=
v,
>  	/* Register it with i2c layer */
>  	adap =3D &dev->adap;
>  	adap->dev.parent =3D &ofdev->dev;
> +	adap->dev.of_node =3D of_node_get(np);
>  	strlcpy(adap->name, "IBM IIC", sizeof(adap->name));
>  	i2c_set_adapdata(adap, dev);
>  	adap->class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
> @@ -761,7 +762,7 @@ static int __devinit iic_probe(struct of_device *ofde=
v,
>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
> =20
>  	/* Now register all the child nodes */
> -	of_register_i2c_devices(adap, np);
> +	of_i2c_register_devices(adap);
> =20
>  	return 0;
> =20
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index df00eb1..d2e26d2 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -600,13 +600,14 @@ static int __devinit fsl_i2c_probe(struct of_device=
 *op,
>  	i2c->adap =3D mpc_ops;
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	i2c->adap.dev.parent =3D &op->dev;
> +	i2c->adap.dev.of_node =3D of_node_get(op->dev.of_node);
> =20
>  	result =3D i2c_add_adapter(&i2c->adap);
>  	if (result < 0) {
>  		dev_err(i2c->dev, "failed to add adapter\n");
>  		goto fail_add;
>  	}
> -	of_register_i2c_devices(&i2c->adap, op->dev.of_node);
> +	of_i2c_register_devices(&i2c->adap);
> =20
>  	return result;
> =20
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 097f42a..80dd631 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -26,7 +26,7 @@ config OF_GPIO
> =20
>  config OF_I2C
>  	def_tristate I2C
> -	depends on (PPC_OF || MICROBLAZE) && I2C
> +	depends on OF && !SPARC && I2C
>  	help
>  	  OpenFirmware I2C accessors
> =20
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index ab6522c..e05f9a1 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -14,34 +14,49 @@
>  #include <linux/i2c.h>
>  #include <linux/of.h>
>  #include <linux/of_i2c.h>
> +#include <linux/of_irq.h>
>  #include <linux/module.h>
> =20
> -void of_register_i2c_devices(struct i2c_adapter *adap,
> -			     struct device_node *adap_node)
> +void of_i2c_register_devices(struct i2c_adapter *adap)
>  {
>  	void *result;
>  	struct device_node *node;
> =20
> -	for_each_child_of_node(adap_node, node) {
> +	/* Only register child devices if the adapter has a node pointer set */
> +	if (!adap->dev.of_node)
> +		return;
> +
> +	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
> +
> +	for_each_child_of_node(adap->dev.of_node, node) {
>  		struct i2c_board_info info =3D {};
>  		struct dev_archdata dev_ad =3D {};
>  		const __be32 *addr;
>  		int len;
> =20
> -		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0)
> +		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
> +
> +		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
> +			dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
> +				node->full_name);
>  			continue;
> +		}
> =20
>  		addr =3D of_get_property(node, "reg", &len);
> -		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
> -			printk(KERN_ERR
> -			       "of-i2c: invalid i2c device entry\n");
> +		if (!addr || (len < sizeof(int))) {
> +			dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
> +				node->full_name);
>  			continue;
>  		}
> =20
> -		info.irq =3D irq_of_parse_and_map(node, 0);
> -
>  		info.addr =3D be32_to_cpup(addr);
> +		if (info.addr > (1 << 10) - 1) {
> +			dev_err(&adap->dev, "of_i2c: invalid addr=3D%x on %s\n",
> +				info.addr, node->full_name);
> +			continue;
> +		}
> =20
> +		info.irq =3D irq_of_parse_and_map(node, 0);
>  		info.of_node =3D node;
>  		info.archdata =3D &dev_ad;
> =20
> @@ -49,10 +64,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> =20
>  		result =3D i2c_new_device(adap, &info);
>  		if (result =3D=3D NULL) {
> -			printk(KERN_ERR
> -			       "of-i2c: Failed to load driver for %s\n",
> -			       info.type);
> -			irq_dispose_mapping(info.irq);

Why is the dispose removed?

> +			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
> +			        node->full_name);
>  			continue;
>  		}
> =20
> @@ -64,7 +77,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  		of_node_get(node);
>  	}
>  }
> -EXPORT_SYMBOL(of_register_i2c_devices);
> +EXPORT_SYMBOL(of_i2c_register_devices);
> =20
>  static int of_dev_node_match(struct device *dev, void *data)
>  {
> @@ -76,8 +89,7 @@ struct i2c_client *of_find_i2c_device_by_node(struct de=
vice_node *node)
>  {
>  	struct device *dev;
> =20
> -	dev =3D bus_find_device(&i2c_bus_type, NULL, node,
> -					 of_dev_node_match);
> +	dev =3D bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);

This change looks unrelated to me; where was this changed?

>  	if (!dev)
>  		return NULL;
> =20
> diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
> index 34974b5..0efe8d4 100644
> --- a/include/linux/of_i2c.h
> +++ b/include/linux/of_i2c.h
> @@ -12,12 +12,19 @@
>  #ifndef __LINUX_OF_I2C_H
>  #define __LINUX_OF_I2C_H
> =20
> +#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
>  #include <linux/i2c.h>
> =20
> -void of_register_i2c_devices(struct i2c_adapter *adap,
> -			     struct device_node *adap_node);
> +extern void of_i2c_register_devices(struct i2c_adapter *adap);
> =20
>  /* must call put_device() when done with returned i2c_client device */
> -struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
> +extern struct i2c_client *of_find_i2c_device_by_node(struct device_node =
*node);
> +
> +#else
> +static inline void of_i2c_register_devices(struct i2c_adapter *adap)
> +{
> +	return;
> +}
> +#endif /* CONFIG_OF_I2C */
> =20
>  #endif /* __LINUX_OF_I2C_H */
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5uO961YFyoDlzFnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwQtdoACgkQD27XaX1/VRtf+ACfZvlN3tYVwcdHvxy+Yyi3mjUk
iRQAn09WQeWqPQOJeZ6MIsrVSs483O8s
=wtxo
-----END PGP SIGNATURE-----

--5uO961YFyoDlzFnP--

--===============8561611667535982129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8561611667535982129==--
