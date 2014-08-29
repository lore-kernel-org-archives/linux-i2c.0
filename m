From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] adv7604: Use DT parsing in dummy creation
Date: Fri, 29 Aug 2014 17:49:26 +0200
Message-ID: <5400A106.6060004@metafoo.de>
References: <1409325303-15906-1-git-send-email-jean-michel.hautbois@vodalys.com> <1409325303-15906-2-git-send-email-jean-michel.hautbois@vodalys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409325303-15906-2-git-send-email-jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/29/2014 05:15 PM, Jean-Michel Hautbois wrote:
> This patch uses DT in order to parse addresses for dummy devices of a=
dv7604.
> The ADV7604 has thirteen 256-byte maps that can be accessed via the m=
ain
> I=C2=B2C ports. Each map has it own I=C2=B2C address and acts
> as a standard slave device on the I=C2=B2C bus.
>
> If nothing is defined, it uses default addresses.
> The main prupose is using two adv76xx on the same i2c bus.

Ideally this patch is split up in two patches. One patch adding support=
 for=20
i2c_new_secondary_device() and one patch adding support for DT for the =
adv7604.

[...]
> +static const char const *adv7604_secondary_names[] =3D {
> +	"main", /* ADV7604_PAGE_IO */

How about [ADV7604_PAGE_IO] =3D "main", instead of having the comment, =
this=20
makes things more explicit.

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
>   /* ----------------------------------------------------------------=
------- */
>
>   static inline struct adv7604_state *to_state(struct v4l2_subdev *sd=
)
> @@ -2528,13 +2544,31 @@ static void adv7604_unregister_clients(struct=
 adv7604_state *state)
>   }
>
>   static struct i2c_client *adv7604_dummy_client(struct v4l2_subdev *=
sd,
> -							u8 addr, u8 io_reg)
> +						unsigned int i)
>   {
>   	struct i2c_client *client =3D v4l2_get_subdevdata(sd);
> +	struct adv7604_platform_data *pdata =3D client->dev.platform_data;
> +	unsigned int io_reg =3D 0xf2 + i;
> +	unsigned int default_addr =3D io_read(sd, io_reg) >> 1;
> +	struct i2c_client *new_client;
> +
> +	if (IS_ENABLED(CONFIG_OF)) {

No CONFIG_OF. i2c_new_secondary_device() is supposed to be the generic=20
method of instantiating the secondary i2c_client, regardless of how the=
=20
address is specified. For this driver we still need to keep the old met=
hod=20
of instantiation via platform data for legacy reasons for now. So what =
this=20
should look like is:


	if (pdata && pdata->i2c_addresses[i])
		new_client =3D i2c_new_dummy(client->adapter,
			pdata->i2c_addresses[i]);=09
	else
		new_client =3D i2c_new_secondary_device(client,
			adv7604_secondary_names[i], default_addr);


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
>
[...]
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
