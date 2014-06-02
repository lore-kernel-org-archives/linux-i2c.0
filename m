From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: Provide 'device type' to 'OF device node'
 look-up
Date: Mon, 2 Jun 2014 17:19:15 +0100
Message-ID: <20140602161915.GA30879@lee--X1>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
 <1401716463-23457-2-git-send-email-lee.jones@linaro.org>
 <20140602160631.F2F6DC40476@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140602160631.F2F6DC40476-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > We have a problem.  There are lots of I2C device ID tables scattere=
d
> > around the kernel which are redundant in all Device Tree and/or ACP=
I
> > only supported device drivers.  After recent discussions it has bec=
ome
> > apparent that the only thing blocking the complete removal of these
> > tables is the continued support of 'register an I2C device via sysf=
s'
> > functionality.  As the sysfs method doesn't know anything about Dev=
ice
> > Tree or ACPI, we can not pass any nodes in.  This patch searches al=
l
> > known Device Tree nodes and attempts to acquire a match from the
> > device name provided via sysfs.  It can not fail, but if found assi=
gns
> > the matching of_node to i2c_board_info prior to registering.
>=20
> Ummm... blech!  :-)
>=20
> It shouldn't actually be necessary to have a node when instantiating =
an
> i2c_device... in fact, there /shouldn't/ be a node if the device is
> getting instantiated by had via sysfs. If there was a node, then I wo=
uld
> expect a device to have been created at the same time.

You're right.  I realised that about 10 mins after I sent the patch!

> I think panto's overlays solve the problem where a node actually is
> required to instantiate the device by actually adding a node and lett=
ing
> the i2c subsystem create the associated device automatically.

This looks like it's exactly what I need.  Pulling the code now.

> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 7c7f4b8..2e47641 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -64,6 +64,7 @@ static DEFINE_IDR(i2c_adapter_idr);
> > =20
> >  static struct device_type i2c_client_type;
> >  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driv=
er *driver);
> > +static struct device_node *of_i2c_type_to_node(char *type);
> > =20
> >  static struct static_key i2c_trace_msg =3D STATIC_KEY_INIT_FALSE;
> > =20
> > @@ -863,6 +864,8 @@ i2c_sysfs_new_device(struct device *dev, struct=
 device_attribute *attr,
> >  		return -EINVAL;
> >  	}
> > =20
> > +	info.of_node =3D of_i2c_type_to_node(info.type);
> > +
> >  	client =3D i2c_new_device(adap, &info);
> >  	if (!client)
> >  		return -EINVAL;
> > @@ -1088,8 +1091,36 @@ struct i2c_adapter *of_find_i2c_adapter_by_n=
ode(struct device_node *node)
> >  	return i2c_verify_adapter(dev);
> >  }
> >  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> > +
> > +static struct device_node *of_i2c_type_to_node(char *type)
> > +{
> > +	struct device_node *np;
> > +	const char *compatible, *name;
> > +	int len;
> > +
> > +	if (!type)
> > +		return NULL;
> > +
> > +	for_each_of_allnodes(np) {
> > +		compatible =3D of_get_property(np, "compatible", &len);
> > +		if (!compatible)
> > +			continue;
> > +
> > +		name =3D strchr(compatible, ',');
> > +		if (!name)
> > +			name =3D compatible;
> > +		else
> > +			name++;
> > +
> > +		if (!strncmp(name, type, len - (name - compatible)))
> > +			return np;
> > +	}
> > +
> > +	return NULL;
> > +}
> >  #else
> >  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
> > +static struct device_node *of_i2c_type_to_node(char *type) { retur=
n NULL; }
> >  #endif /* CONFIG_OF */
> > =20
> >  /* ACPI support code */
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
