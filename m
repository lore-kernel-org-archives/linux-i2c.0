From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/10] i2c: add and export of_get_i2c_adapter_by_node()
 interface
Date: Wed, 8 Jul 2015 15:53:40 +0200
Message-ID: <20150708135338.GB16082@ulmo.nvidia.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1436360352-9181-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150708131140.GA12791@ulmo.nvidia.com>
 <559D2639.1030706@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559D2639.1030706-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 04:31:37PM +0300, Vladimir Zapolskiy wrote:
> Hi Thierry,
>=20
> On 08.07.2015 16:11, Thierry Reding wrote:
> > On Wed, Jul 08, 2015 at 03:59:12PM +0300, Vladimir Zapolskiy wrote:
> >> of_find_i2c_adapter_by_node() call requires quite often missing
> >> put_device(), and i2c_put_adapter() releases a device locked by
> >> i2c_get_adapter() only. In general module_put(adapter->owner) and
> >> put_device(dev) are not interchangeable.
> >>
> >> This is a common error reproduction scenario as a result of the
> >> misusage described above (for clearness this is run on iMX6 platform
> >> with HDMI and I2C bus drivers compiled as kernel modules):
> >>
> >>     root@mx6q:~# lsmod | grep i2c
> >>     i2c_imx                10213  0
> >>     root@mx6q:~# lsmod | grep dw_hdmi_imx
> >>     dw_hdmi_imx             3631  0
> >>     dw_hdmi                11846  1 dw_hdmi_imx
> >>     imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
> >>     drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_=
ldb
> >>     root@mx6q:~# rmmod dw_hdmi_imx
> >>     root@mx6q:~# lsmod | grep i2c
> >>     i2c_imx                10213  -1
> >>
> >>                                  ^^^^^
> >>
> >>     root@mx6q:~# rmmod i2c_imx
> >>     rmmod: ERROR: Module i2c_imx is in use
> >>
> >> To fix existing users of these interfaces and to avoid any further
> >> confusion and misusage in future, add one more interface
> >> of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
> >> sense that an I2C bus device driver found and locked by user can be
> >> correctly unlocked by i2c_put_adapter().
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> >> ---
> >> The change is based on RFC http://www.spinics.net/lists/linux-i2c/msg2=
0257.html
> >>
> >> * added new exported function declaration in include/linux/i2c.h
> >> * added put_device(dev) call right inside of_get_i2c_adapter_by_node()
> >> * corrected authorship of the change
> >>
> >>  drivers/i2c/i2c-core.c | 20 ++++++++++++++++++++
> >>  include/linux/i2c.h    |  6 ++++++
> >>  2 files changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >> index 069a41f..0d902ab 100644
> >> --- a/drivers/i2c/i2c-core.c
> >> +++ b/drivers/i2c/i2c-core.c
> >> @@ -1356,6 +1356,26 @@ struct i2c_adapter *of_find_i2c_adapter_by_node=
(struct device_node *node)
> >>  	return i2c_verify_adapter(dev);
> >>  }
> >>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> >> +
> >> +struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *no=
de)
> >> +{
> >> +	struct device *dev;
> >> +	struct i2c_adapter *adapter;
> >> +
> >> +	dev =3D bus_find_device(&i2c_bus_type, NULL, node,
> >> +			      of_dev_node_match);
> >> +	if (!dev)
> >> +		return NULL;
> >> +
> >> +	adapter =3D i2c_verify_adapter(dev);
> >> +	if (adapter && !try_module_get(adapter->owner))
> >> +		adapter =3D NULL;
> >> +
> >> +	put_device(dev);
> >=20
> > I don't think this is correct. Users still need to keep a reference to
> > the device, otherwise it can simply disappear even if the module stays
> > around (think sysfs bind/unbind attributes).
> >=20
> > Looking at i2c_put_adapter() it seems like it would need to do more than
> > just drop the module reference. Then again, that probably means that we
> > need to add a get_device() somewhere in i2c_get_adapter() to balance the
> > put_device() in i2c_put_adapter().
>=20
> it makes sense for me, thanks for momentary review.
>=20
> I'm hesitating to add put_device(dev) to i2c_put_adapter() etc. in this
> series though. After development and testing I would like to send
> another preceding independent change updating i2c_get_adapter(),
> i2c_put_adapter() and clients (or if you wish you can do it), then I'll
> rebase 01/10 on top of it, the rest most probably is unchanged.

I think that would make sense, yes.

Thierry

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVnStgAAoJEN0jrNd/PrOhnuwP/3ILQOj9MUCu3jtKsjnRPnzj
mZ1sxTUqCsHHNyV/yhvU1YI4fOyHL/XYXTaz3Q6IgWDvMxSI7ycndkGNxKFFyPam
COhI/Uw2cjkkyvfNChjaBMANj7yKahyl18DtihLC/N/fk0oVSjTm4fYE1jxhmaPt
EP0RJxIaojd3HU+iWkuROjLDIry+aOVpg8QtwAXvQi3Bw1S75zyX/CZjnAKiCXDm
1YxeUWK5I4NOFgB276xOKDSUkvN4qSC1zY/QryU8kUL5QNglPJZNIYCpIGPJVzqD
Wivio777MHKfw55fdxoFZEP/YBygRc+xlhQ4rmpmnY5MlxHVCi18o4qPWSN67ihp
JBn9bhU2uerRw7pla9QykyqLvw8rPrGLEPdKMu2R/eMghOQ4nkYCCoT2MZLsEFjl
9BXAMS3n/jSt8yg631MrXLNcnhUWjgX/F6/6wulyWTSDIXBQUXdbAF2XYkOm7KOQ
E33m3PCTrbxsxGruK35Zep942mETIJ5BkZ9uKjwlmBo+KhPVDL4wbxTi9dw23Q6e
nXonL4/VIhH4uEj+giUBtvr8BBRksXpAebdQbR6foEvCEVWm+i3klP7o7jZGq57j
v3mD7MwV0xGbBDp3sjFmD2v0VepUXOrATMUo7rKEItq7IM3zQmPX/WRoNyuS0dkB
Vdu2QMXSPVQ/fkL29jdV
=WpL+
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
