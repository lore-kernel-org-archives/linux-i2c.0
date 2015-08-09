From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Sun, 9 Aug 2015 17:22:55 +0200
Message-ID: <20150809152255.GA2367@katana>
References: <20150730201431.GA5255@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150730201431.GA5255@dtor-ws>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 01:14:31PM -0700, Dmitry Torokhov wrote:
> Instead of having each i2c driver individually parse device tree data in
> case it or platform supports separate wakeup interrupt, and handle
> enabling and disabling wakeup interrupts in their power management
> routines, let's have i2c core do that for us.
>=20
> Platforms wishing to specify separate wakeup interrupt for the device
> should use named interrupt syntax in their DTSes:
>=20
> 	interrupt-parent =3D <&intc1>;
> 	interrupts =3D <5 0>, <6 0>;
> 	interrupt-names =3D "irq", "wakeup";
>=20
> This patch is inspired by work done by Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> for
> pixcir_i2c_ts driver.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

I think it is a useful addition. Can someone add a paragraph describing
this handling on top of the new generic i2c binding docs?

http://patchwork.ozlabs.org/patch/505368/

> @@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
>  	if (!device_can_wakeup(&client->dev))
>  		device_init_wakeup(&client->dev,
>  					client->flags & I2C_CLIENT_WAKE);

I was about to ask if we couldn't combine this and the later if-blocks
with an if-else combination. But now I stumble over the above block in
general: If the device cannot cause wake ups, then we might initialize
it as a wakeup-device depending on client->flags??

> +
> +	if (device_can_wakeup(&client->dev)) {
> +		int wakeirq =3D -ENOENT;
> +
> +		if (dev->of_node) {
> +			wakeirq =3D of_irq_get_byname(dev->of_node, "wakeup");
> +			if (wakeirq =3D=3D -EPROBE_DEFER)
> +				return wakeirq;
> +		}
> +
> +		if (wakeirq > 0 && wakeirq !=3D client->irq)
> +			status =3D dev_pm_set_dedicated_wake_irq(dev, wakeirq);
> +		else if (client->irq > 0)
> +			status =3D dev_pm_set_wake_irq(dev, wakeirq);
> +		else
> +			status =3D 0;
> +
> +		if (status)
> +			dev_warn(&client->dev, "failed to set up wakeup irq");
> +	}
> +
>  	dev_dbg(dev, "probe\n");
> =20
>  	status =3D of_clk_set_defaults(dev->of_node, false);
>  	if (status < 0)
> -		return status;
> +		goto err_clear_wakeup_irq;
> =20
>  	status =3D dev_pm_domain_attach(&client->dev, true);
>  	if (status !=3D -EPROBE_DEFER) {
>  		status =3D driver->probe(client, i2c_match_id(driver->id_table,
>  					client));
>  		if (status)
> -			dev_pm_domain_detach(&client->dev, true);
> +			goto err_detach_pm_domain;
>  	}
> =20
> +	return 0;
> +
> +err_detach_pm_domain:
> +	dev_pm_domain_detach(&client->dev, true);
> +err_clear_wakeup_irq:
> +	dev_pm_clear_wake_irq(&client->dev);
>  	return status;
>  }
> =20
> @@ -692,6 +722,10 @@ static int i2c_device_remove(struct device *dev)
>  	}
> =20
>  	dev_pm_domain_detach(&client->dev, true);
> +
> +	dev_pm_clear_wake_irq(&client->dev);
> +	device_init_wakeup(&client->dev, 0);
> +
>  	return status;
>  }
> =20
> --=20
> 2.5.0.rc2.392.g76e840b
>=20
>=20
> --=20
> Dmitry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVx3BPAAoJEBQN5MwUoCm2NUgP/idxNiOiSPDc1ILNp7Dl/1/v
N0PQ0YMC091FxNDJedrUqY5LWOem+X6jQI8sozNDVM977L13Qg6RgkDj9Swe1q2N
9VArCR7My9GG/78iSrK9c1rsm+CINade2itzOuisTySBnMT1823dDv70WgHl2pPb
hQ/AYTLN9l8TXQlWXu7P1PloxHyxG2+m2pMiVXXLUJEAE5LTH6v9A0XuVp+x5zeo
acSLJANXR76shpw8YfhznU0DuLw6MNeyVTKCSbs2YS/ZxdXs02de6gbjvFijhzpg
x8e+IuJaZcKl7jM6YtqKBgIqzieQ0lgEE8LAIR9AHahEc9rLzu11j3+KOF+DMhOV
tG28+nU2JJvqMnsi8bnr+v6VAlUt+SFhA3gM3qbbVGKKKqnGNZvoO7ht3nn/e1sd
g5Hg3k/2lqxPbx12wTfkjICPAcF3aHkloM4UEJskD5xfyqMXgFHELvU+F/eHxGyw
Y44S+RYrF29vOp23XUJ2n0BK9Yx0hGzNEjpKRAUJs3llMFn7PZIRlaTpXgqofFLQ
FG1a8ugO7RFvGJJqEGoU9Y65kTQIJTJGsPM5R26xW7EpmBxY2P/+Xdj7yd1RYWCB
4J/Ih6h5AyKGN9WL/JC5cX9B04+VnG5WeHzGKHL89sQzz5qgQ7leD/EL6Ns1dOaJ
UfDcwkJ6Lu8/UQKMAXu+
=o4Lz
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
