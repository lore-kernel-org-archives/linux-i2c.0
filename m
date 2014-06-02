From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: Provide 'device type' to 'OF device node'
 look-up
Date: Mon, 2 Jun 2014 14:57:22 +0100
Message-ID: <20140602135722.GC4146@lee--X1>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
 <1401716463-23457-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401716463-23457-2-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> We have a problem.  There are lots of I2C device ID tables scattered
> around the kernel which are redundant in all Device Tree and/or ACPI
> only supported device drivers.  After recent discussions it has becom=
e
> apparent that the only thing blocking the complete removal of these
> tables is the continued support of 'register an I2C device via sysfs'
> functionality.  As the sysfs method doesn't know anything about Devic=
e
> Tree or ACPI, we can not pass any nodes in.  This patch searches all
> known Device Tree nodes and attempts to acquire a match from the
> device name provided via sysfs.  It can not fail, but if found assign=
s
> the matching of_node to i2c_board_info prior to registering.
>=20
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

[...]

> +static struct device_node *of_i2c_type_to_node(char *type)
> +{
> +	struct device_node *np;
> +	const char *compatible, *name;
> +	int len;
> +
> +	if (!type)
> +		return NULL;
> +
> +	for_each_of_allnodes(np) {
> +		compatible =3D of_get_property(np, "compatible", &len);
> +		if (!compatible)
> +			continue;
> +
> +		name =3D strchr(compatible, ',');
> +		if (!name)
> +			name =3D compatible;
> +		else
> +			name++;
> +
> +		if (!strncmp(name, type, len - (name - compatible)))
> +			return np;
> +	}
> +
> +	return NULL;
> +}

Ah, this _might_ not work if there are more than one devices of the
same type.  I guess I need to check the 'reg' property too.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
