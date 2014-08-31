From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] adv7604: Use DT parsing in dummy creation
Date: Sun, 31 Aug 2014 20:18:58 +0300
Message-ID: <2204455.3fKSNVsp04@avalon>
References: <1409325303-15906-1-git-send-email-jean-michel.hautbois@vodalys.com> <1409325303-15906-2-git-send-email-jean-michel.hautbois@vodalys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409325303-15906-2-git-send-email-jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Friday 29 August 2014 17:15:03 Jean-Michel Hautbois wrote:
> This patch uses DT in order to parse addresses for dummy devices of a=
dv7604.
> The ADV7604 has thirteen 256-byte maps that can be accessed via the m=
ain
> I=B2C ports. Each map has it own I=B2C address and acts
> as a standard slave device on the I=B2C bus.
>=20
> If nothing is defined, it uses default addresses.
> The main prupose is using two adv76xx on the same i2c bus.
>=20
> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org=
>
> ---
>  .../devicetree/bindings/media/i2c/adv7604.txt      | 17 +++++-
>  drivers/media/i2c/adv7604.c                        | 60 ++++++++++++=
-------
>  2 files changed, 55 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt index
> c27cede..8486b5c 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> @@ -10,8 +10,12 @@ Required Properties:
>=20
>    - compatible: Must contain one of the following
>      - "adi,adv7611" for the ADV7611
> +    - "adi,adv7604" for the ADV7604

Addition of ADV7604 support is unrelated to the subject and needs to be=
 split=20
into a separate patch.

> -  - reg: I2C slave address
> +  - reg: I2C slave addresses
> +    The ADV7604 has thirteen 256-byte maps that can be accessed via =
the
> main
> +    I=B2C ports. Each map has it own I=B2C address and acts
> +    as a standard slave device on the I=B2C bus.
>=20
>    - hpd-gpios: References to the GPIOs that control the HDMI hot-plu=
g
>      detection pins, one per HDMI input. The active flag indicates th=
e GPIO
> @@ -32,6 +36,12 @@ The digital output port node must contain at least=
 one
> endpoint. Optional Properties:
>=20
>    - reset-gpios: Reference to the GPIO connected to the device's res=
et pin.
> +  - reg-names : Names of maps with programmable addresses.
> +		It can contain any map needing another address than default one.
> +		Possible maps names are :
> +ADV7604 : "main", "avlink", "cec", "infoframe", "esdp", "dpp", "afe"=
,
> "rep",
> +		"edid", "hdmi", "test", "cp", "vdp"
> +ADV7611 : "main", "cec", "infoframe", "afe", "rep", "edid", "hdmi", =
"cp"
>=20
>  Optional Endpoint Properties:
>=20
> @@ -50,7 +60,10 @@ Example:
>=20
>  	hdmi_receiver@4c {
>  		compatible =3D "adi,adv7611";
> -		reg =3D <0x4c>;
> +		/* edid page will be accessible @ 0x66 on i2c bus */
> +		/* other maps keep their default addresses */
> +		reg =3D <0x4c 0x66>;
> +		reg-names =3D "main", "edid";
>=20
>  		reset-gpios =3D <&ioexp 0 GPIO_ACTIVE_LOW>;
>  		hpd-gpios =3D <&ioexp 2 GPIO_ACTIVE_HIGH>;
> diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.=
c
> index d4fa213..56037dd 100644
> --- a/drivers/media/i2c/adv7604.c
> +++ b/drivers/media/i2c/adv7604.c
> @@ -326,6 +326,22 @@ static const struct adv7604_video_standards
> adv7604_prim_mode_hdmi_gr[] =3D { { },
>  };
>=20
> +static const char const *adv7604_secondary_names[] =3D {
> +	"main", /* ADV7604_PAGE_IO */
> +	"avlink", /* ADV7604_PAGE_AVLINK */
> +	"cec", /* ADV7604_PAGE_CEC */
> +	"infoframe", /* ADV7604_PAGE_INFOFRAME */
> +	"esdp", /* ADV7604_PAGE_ESDP */
> +	"dpp", /* ADV7604_PAGE_DPP */
> +	"afe", /* ADV7604_PAGE_AFE */
> +	"rep", /* ADV7604_PAGE_REP */
> +	"edid", /* ADV7604_PAGE_EDID */
> +	"hdmi", /* ADV7604_PAGE_HDMI */
> +	"test", /* ADV7604_PAGE_TEST */
> +	"cp", /* ADV7604_PAGE_CP */
> +	"vdp" /* ADV7604_PAGE_VDP */
> +};
> +
>  /* -----------------------------------------------------------------=
------
> */
>=20
>  static inline struct adv7604_state *to_state(struct v4l2_subdev *sd)
> @@ -2528,13 +2544,31 @@ static void adv7604_unregister_clients(struct
> adv7604_state *state) }
>=20
>  static struct i2c_client *adv7604_dummy_client(struct v4l2_subdev *s=
d,
> -							u8 addr, u8 io_reg)
> +						unsigned int i)
>  {
>  	struct i2c_client *client =3D v4l2_get_subdevdata(sd);
> +	struct adv7604_platform_data *pdata =3D client->dev.platform_data;
> +	unsigned int io_reg =3D 0xf2 + i;
> +	unsigned int default_addr =3D io_read(sd, io_reg) >> 1;

This modifies the behaviour of the driver. It previously used fixed def=
ault=20
addresses in the DT case, and now defaults to whatever has been program=
med in=20
the chip. This might not be an issue in itself, but it should be docume=
nted in=20
the commit message (and possibly split to a separate patch).

> +	struct i2c_client *new_client;
> +
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		/* Try to find it in DT */
> +		new_client =3D i2c_new_secondary_device(client,
> +			adv7604_secondary_names[i], default_addr);
> +	} else if (pdata) {
> +		if (pdata->i2c_addresses[i])
> +			new_client =3D i2c_new_dummy(client->adapter,
> +						pdata->i2c_addresses[i]);
> +		else
> +			new_client =3D i2c_new_dummy(client->adapter,
> +						default_addr);
> +	}
>=20
> -	if (addr)
> -		io_write(sd, io_reg, addr << 1);
> -	return i2c_new_dummy(client->adapter, io_read(sd, io_reg) >> 1);
> +	if (new_client)
> +		io_write(sd, io_reg, new_client->addr << 1);
> +
> +	return new_client;
>  }
>=20
>  static const struct adv7604_reg_seq adv7604_recommended_settings_afe=
[] =3D {
> @@ -2677,6 +2711,7 @@ MODULE_DEVICE_TABLE(i2c, adv7604_i2c_id);
>=20
>  static struct of_device_id adv7604_of_id[] __maybe_unused =3D {
>  	{ .compatible =3D "adi,adv7611", .data =3D &adv7604_chip_info[ADV76=
11] },
> +	{ .compatible =3D "adi,adv7604", .data =3D &adv7604_chip_info[ADV76=
04] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adv7604_of_id);
> @@ -2717,20 +2752,6 @@ static int adv7604_parse_dt(struct adv7604_sta=
te
> *state) /* Disable the interrupt for now as no DT-based board uses it=
=2E */
> state->pdata.int1_config =3D ADV7604_INT1_CONFIG_DISABLED;
>=20
> -	/* Use the default I2C addresses. */
> -	state->pdata.i2c_addresses[ADV7604_PAGE_AVLINK] =3D 0x42;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_CEC] =3D 0x40;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_INFOFRAME] =3D 0x3e;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_ESDP] =3D 0x38;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_DPP] =3D 0x3c;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_AFE] =3D 0x26;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_REP] =3D 0x32;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_EDID] =3D 0x36;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_HDMI] =3D 0x34;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_TEST] =3D 0x30;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_CP] =3D 0x22;
> -	state->pdata.i2c_addresses[ADV7604_PAGE_VDP] =3D 0x24;
> -
>  	/* Hardcode the remaining platform data fields. */
>  	state->pdata.disable_pwrdnb =3D 0;
>  	state->pdata.disable_cable_det_rst =3D 0;
> @@ -2891,8 +2912,7 @@ static int adv7604_probe(struct i2c_client *cli=
ent,
>  			continue;
>=20
>  		state->i2c_clients[i] =3D
> -			adv7604_dummy_client(sd, state->pdata.i2c_addresses[i],
> -					     0xf2 + i);
> +			adv7604_dummy_client(sd, i);
>  		if (state->i2c_clients[i] =3D=3D NULL) {
>  			err =3D -ENOMEM;
>  			v4l2_err(sd, "failed to create i2c client %u\n", i);

--=20
Regards,

Laurent Pinchart
