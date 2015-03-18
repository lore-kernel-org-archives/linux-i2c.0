From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Wed, 18 Mar 2015 13:30:12 +0100
Message-ID: <20150318123012.GA3580@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Gabriel Dobato <dobatog@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 01:21:05PM +0100, Sebastian Hesselbarth wrote:
> I2C mux pinctrl driver currently determines the number of sub-busses by
> counting available pinctrl-names. Unfortunately, this requires each
> incarnation of the devicetree node with different available sub-busses
> to be rewritten.
>=20
> This patch reworks i2c-mux-pinctrl driver to count the number of
> available sub-nodes instead. The rework should be compatible to the old
> way of probing for sub-busses and additionally allows to disable unused
> sub-busses with standard DT property status =3D "disabled".

Not sure about this change. With DYNAMIC_OF these days, you can't rely
that 'disabled' stays disabled all the time. My gut feeling tells me
that people will want to use this someday.

>=20
> This also amends the corresponding devicetree binding documentation to
> reflect the new functionality to disable unused sub-nodes. While at it,
> also fix two references to binding documentation files that miss an "i2c-"
> prefix.
>=20
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changelog:
>=20
> v2->v3:
> - remove mention of "I2C bus numbers" (Suggested by Stephen Warren)
> - require pinctrl-names property for "each child" instead of
>   "each enabled child" (Suggested by Stephen Warren)
> - swap enabled/disabled child nodes (Suggested by Stephen Warren)
>=20
> v1->v2:
> - added a Tested-by for i2c-mux-pinctrl changes from Stepen Warren.
> - reworded i2c-mux-pinctrl devicetree doc changes
>   (Suggested by Stephen Warren).
>=20
> Patches 2/4 - 4/4 remain unchanged.
>=20
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Gabriel Dobato <dobatog@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: linux-i2c@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    | 21 ++++---
>  drivers/i2c/muxes/i2c-mux-pinctrl.c                | 70 ++++++++++++++--=
------
>  2 files changed, 58 insertions(+), 33 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt b/=
Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
> index ae8af1694e95..cd94a0f64d76 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
> @@ -28,17 +28,18 @@ Also required are:
>  * Standard pinctrl properties that specify the pin mux state for each ch=
ild
>    bus. See ../pinctrl/pinctrl-bindings.txt.
> =20
> -* Standard I2C mux properties. See mux.txt in this directory.
> +* Standard I2C mux properties. See i2c-mux.txt in this directory.
> =20
> -* I2C child bus nodes. See mux.txt in this directory.
> +* I2C child bus nodes. See i2c-mux.txt in this directory.
> =20
> -For each named state defined in the pinctrl-names property, an I2C child=
 bus
> -will be created. I2C child bus numbers are assigned based on the index i=
nto
> -the pinctrl-names property.
> +For each enabled child node an I2C child bus will be created.
> =20
> -The only exception is that no bus will be created for a state named "idl=
e". If
> -such a state is defined, it must be the last entry in pinctrl-names. For
> -example:
> +There must be a corresponding pinctrl-names entry for each child node at=
 the
> +position of the child node's "reg" property.
> +
> +Also, there can be an idle pinctrl state defined at the end of possible =
pinctrl
> +states. If such a state is defined, it must be the last entry in pinctrl=
-names.
> +For example:
> =20
>  	pinctrl-names =3D "ddc", "pta", "idle"  ->  ddc =3D bus 0, pta =3D bus 1
>  	pinctrl-names =3D "ddc", "idle", "pta"  ->  Invalid ("idle" not last)
> @@ -68,10 +69,12 @@ Example:
>  		pinctrl-1 =3D <&state_i2cmux_pta>;
>  		pinctrl-2 =3D <&state_i2cmux_idle>;
> =20
> +		/* Disabled child bus 0 */
>  		i2c@0 {
>  			reg =3D <0>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> +			status =3D "disabled";
> =20
>  			eeprom {
>  				compatible =3D "eeprom";
> @@ -79,10 +82,12 @@ Example:
>  			};
>  		};
> =20
> +		/* Enabled child bus 1 */
>  		i2c@1 {
>  			reg =3D <1>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> +			status =3D "okay";
> =20
>  			eeprom {
>  				compatible =3D "eeprom";
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-=
mux-pinctrl.c
> index b48378c4b40d..033dacfabfdf 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -56,9 +56,12 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pin=
ctrl *mux,
>  				struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> -	int num_names, i, ret;
> +	struct device_node *child;
> +	struct property *prop;
> +	int num_names, num_children, ret;
>  	struct device_node *adapter_np;
>  	struct i2c_adapter *adapter;
> +	const char *state;
> =20
>  	if (!np)
>  		return 0;
> @@ -77,32 +80,16 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pi=
nctrl *mux,
>  		return num_names;
>  	}
> =20
> -	mux->pdata->pinctrl_states =3D devm_kzalloc(&pdev->dev,
> -		sizeof(*mux->pdata->pinctrl_states) * num_names,
> -		GFP_KERNEL);
> -	if (!mux->pdata->pinctrl_states) {
> -		dev_err(mux->dev, "Cannot allocate pinctrl_states\n");
> -		return -ENOMEM;
> +	num_children =3D of_get_available_child_count(np);
> +	if (num_children < 0) {
> +		dev_err(mux->dev, "Unable to count available children: %d\n",
> +			num_children);
> +		return num_children;
>  	}
> =20
> -	for (i =3D 0; i < num_names; i++) {
> -		ret =3D of_property_read_string_index(np, "pinctrl-names", i,
> -			&mux->pdata->pinctrl_states[mux->pdata->bus_count]);
> -		if (ret < 0) {
> -			dev_err(mux->dev, "Cannot parse pinctrl-names: %d\n",
> -				ret);
> -			return ret;
> -		}
> -		if (!strcmp(mux->pdata->pinctrl_states[mux->pdata->bus_count],
> -			    "idle")) {
> -			if (i !=3D num_names - 1) {
> -				dev_err(mux->dev, "idle state must be last\n");
> -				return -EINVAL;
> -			}
> -			mux->pdata->pinctrl_state_idle =3D "idle";
> -		} else {
> -			mux->pdata->bus_count++;
> -		}
> +	if (num_names < num_children) {
> +		dev_err(mux->dev, "Found less pinctrl states than children\n");
> +		return -EINVAL;
>  	}
> =20
>  	adapter_np =3D of_parse_phandle(np, "i2c-parent", 0);
> @@ -118,6 +105,39 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_p=
inctrl *mux,
>  	mux->pdata->parent_bus_num =3D i2c_adapter_id(adapter);
>  	put_device(&adapter->dev);
> =20
> +	mux->pdata->pinctrl_states =3D devm_kzalloc(&pdev->dev,
> +		sizeof(*mux->pdata->pinctrl_states) * num_children,
> +		GFP_KERNEL);
> +	if (!mux->pdata->pinctrl_states) {
> +		dev_err(mux->dev, "Cannot allocate pinctrl_states\n");
> +		return -ENOMEM;
> +	}
> +
> +	of_property_for_each_string(np, "pinctrl-names", prop, state)
> +		if (!strcmp(state, "idle"))
> +			mux->pdata->pinctrl_state_idle =3D "idle";
> +
> +	for_each_available_child_of_node(np, child) {
> +		u32 reg;
> +
> +		ret =3D of_property_read_u32(child, "reg", &reg);
> +		if (ret < 0) {
> +			dev_err(mux->dev, "Missing reg property for child node: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret =3D of_property_read_string_index(np,
> +				    "pinctrl-names", reg, &state);
> +		if (ret < 0) {
> +			dev_err(mux->dev, "Cannot parse pinctrl-names for mux %d: %d\n",
> +				reg, ret);
> +			return ret;
> +		}
> +
> +		mux->pdata->pinctrl_states[mux->pdata->bus_count++] =3D state;
> +	}
> +
>  	return 0;
>  }
>  #else
> --=20
> 2.1.0
>=20

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCW/UAAoJEBQN5MwUoCm2XqYP/iO3sKphyOGowpsB4g3hSTQW
JG6wQvacJqH+Mow/O6v0f6JK8Y8V6080Q80xVfvJgJOWvP+u2TrxqqhyCOeb3BCl
CEUWV+AE037Xt42VC8t+9fAkvVHmmFwMJ7+keJ8Fj/N2ZdZTqs/KcgCCo0iXMJYx
cUwx7ATgg6F4wCnwkKjb/y+NxrwxdcHFhNxYlyUUyFpjOzcepIMYNnpsd1nwJAD7
HVYNGXZDA+RhPI/WIj6XXWVWrZEq+HKgmqOeVUTmHVlRfpHjceyXq9laJaSPGCVp
aFPnSEuygIGz+vhdsO36lT4Y3MdfIuE3CBg4IK7Q6ah7SPiBGdj/Hlg6lF/oJdAi
zQ0s+/ft+arNKpdabVz1uD/ARwTnj3LSVCch9MDesJKs3ElYWRgGpJ5D/FHDtQxA
cRvH5p6tU4elfINy5SGaDpEDd9mLlEFE48BtGl40iJcLsPRnPbniziaIB+YQgNZt
WRUb99qOTJWubMas6rxCJ47X6fOD0a3311JDfkLtoovqiREj2rBhCSOOlq6aPGFr
OdcCwuFliTG+yCnUB2Bhyu6ENUOiTGpxQ2zs+Tb0Y06agZVUDiNngGbxl0NT4yZ8
hvuNcqKCwzJlq/M/BPL1FT3bGtNo6w68L6Inap85yCgMAsKrmT3/KjFjxue1t+4j
NOQANb6Pt75uLORI1jXg
=yXBB
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
