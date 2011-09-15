From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add Device Tree support to versatile-i2c driver
Date: Thu, 15 Sep 2011 09:55:13 +0100
Message-ID: <1316076913.3297.102.camel@hornet.cambridge.arm.com>
References: <1315475019-10088-1-git-send-email-pawel.moll@arm.com>
	 <20110914211556.GB2146@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110914211556.GB2146-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Morning,

> > This patch adds Device Tree binding ("arm,versatile-i2c") and
> > basic support (bus population) to versatile-i2c driver.
>=20
> what happens when !CONFIG_OF ?

Nothing sinister, really...
=20

> > @@ -99,6 +100,7 @@ static int i2c_versatile_probe(struct platform_d=
evice *dev)
> >  	strlcpy(i2c->adap.name, "Versatile I2C adapter", sizeof(i2c->adap=
=2Ename));
> >  	i2c->adap.algo_data =3D &i2c->algo;
> >  	i2c->adap.dev.parent =3D &dev->dev;
> > +	i2c->adap.dev.of_node =3D dev->dev.of_node;
> >  	i2c->algo =3D i2c_versatile_algo;
> >  	i2c->algo.data =3D i2c;

include/linux/device.h:551
struct device {
<...>
        struct dev_archdata     archdata;
       =20
        struct device_node      *of_node; /* associated device tree nod=
e */

        dev_t                   devt;   /* dev_t, creates the sysfs "de=
v" */
<...>
}

As you see of_node is always present...
=20
> > @@ -111,6 +113,7 @@ static int i2c_versatile_probe(struct platform_=
device *dev)
> >  		ret =3D i2c_bit_add_bus(&i2c->adap);
> >  	if (ret >=3D 0) {
> >  		platform_set_drvdata(dev, i2c);
> > +		of_i2c_register_devices(&i2c->adap);
> >  		return 0;
> >  	}

include/linux/of_i2c.h:

#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
<...>
#else
static inline void of_i2c_register_devices(struct i2c_adapter *adap)
{
        return;
}      =20
#endif /* CONFIG_OF_I2C */

> > @@ -133,12 +136,19 @@ static int i2c_versatile_remove(struct platfo=
rm_device *dev)
> >  	return 0;
> >  }
> > =20
> > +static struct of_device_id i2c_versatile_match[] =3D {
> > +	{ .compatible =3D "arm,versatile-i2c", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, i2c_versatile_match);
> > +
> >  static struct platform_driver i2c_versatile_driver =3D {
> >  	.probe		=3D i2c_versatile_probe,
> >  	.remove		=3D i2c_versatile_remove,
> >  	.driver		=3D {
> >  		.name	=3D "versatile-i2c",
> >  		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D i2c_versatile_match,
> >  	},
> >  };

include/linux/device.h:185:

struct device_driver {
<...>
        bool suppress_bind_attrs;       /* disables bind/unbind via sys=
fs */
       =20
        const struct of_device_id       *of_match_table;
       =20
        int (*probe) (struct device *dev);
<...>
}

Same here.

Generally Grant claims that there is no more need for #ifdef CONFIG_OF,
and I trust him :-)

Cheers!

Pawe=C5=82
