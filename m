From: Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH linux 2/6] hwmon: occ: Add sysfs interface
Date: Mon, 09 Jan 2017 10:22:12 +1030
Message-ID: <1483919532.2950.1.camel@aj.id.au>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
         <1483120568-21082-3-git-send-email-eajames.ibm@gmail.com>
         <20161230193404.GB8516@roeck-us.net>
         <OFA812992D.D19B1368-ON002580A0.007A2966-862580A0.007A72F0@notes.na.collabserv.com>
         <8b182766-32a0-9eb1-7917-14abf811cef5@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-XBpeGEDaOSADCXVW28Vr"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <8b182766-32a0-9eb1-7917-14abf811cef5@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Edward James <eajames@us.ibm.com>
Cc: corbet@lwn.net, devicetree@vger.kernel.org, eajames.ibm@gmail.com, jdelvare@suse.com, joel@jms.id.au, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org


--=-XBpeGEDaOSADCXVW28Vr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2017-01-07 at 09:15 -0800, Guenter Roeck wrote:
> On 01/06/2017 02:17 PM, Edward James wrote:
>=20
> [ ... ]
>=20
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR(online, S_IWUSR | S_IRUGO, show_occ_online,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0store_occ_on=
line);
> > > > +
> > > > +struct occ_sysfs *occ_sysfs_start(struct device *dev, struct occ *=
occ,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0struct occ_sysfs_config *config)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0struct occ_sysfs *hwmon =3D devm_kzalloc(dev, si=
zeof(struct occ_sysfs),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GFP_KERNE=
L);
> > > > +=C2=A0=C2=A0=C2=A0int rc;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0if (!hwmon)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-ENOMEM);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0hwmon->occ =3D occ;
> > > > +=C2=A0=C2=A0=C2=A0hwmon->num_caps_fields =3D config->num_caps_fiel=
ds;
> > > > +=C2=A0=C2=A0=C2=A0hwmon->caps_names =3D config->caps_names;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0dev_set_drvdata(dev, hwmon);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0rc =3D device_create_file(dev, &dev_attr_online)=
;
> > > > +=C2=A0=C2=A0=C2=A0if (rc)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(rc);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0return hwmon;
> > > > +}
> > > > +EXPORT_SYMBOL(occ_sysfs_start);
> > > > +
> > > > +int occ_sysfs_stop(struct device *dev, struct occ_sysfs *driver)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0if (driver->dev) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0occ_remove_hwmon_attrs(driver)=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hwmon_device_unregister(driver=
->dev);
> > > > +=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0device_remove_file(driver->dev, &dev_attr_online=
);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0devm_kfree(dev, driver);
> > >=20
> > > Thw point of using devm_ functions is not to require remove/free func=
tions.
> > > Something is completely wrong here if you need that call.
> > >=20
> > > Overall, this is architectually completely wrong. One does not regist=
er
> > > or instantiate drivers based on writing into sysfs attributes. Please
> > > reconsider your approach.
> >=20
> > We had some trouble designing this driver because the BMC only has
> > access to the OCC once the processor is powered on. This will happen
> > sometime after the BMC boots (this driver runs only on the BMC). With
> > no access to the OCC, we don't know what sensors are present on the
> > system without a large static enumeration. Also any sysfs files created
> > before we have OCC access won't be able to return any data.
> >=20
> > Instead of the "online" attribute, what do you think about using the
> > "bind"/"unbind" API to probe the device from user space once the system
> > is powered on? All the hwmon registration would take place in the probe
> > function, it would just occur some time after boot.
> >=20
>=20
> A more common approach would be to have a platform driver. That platform
> driver would need a means to detect if the OCC is up and running, and
> instantiate everything else once it is.
>=20
> A trigger from user space is problematic because there is no guarantee
> that the OCC is really up (or that it even exists).

This is true in general, but for the BMC case we have more information:
The host CPU power supply is controlled by several GPIOs from
userspace. Once we receive the "power-good" signal for the host CPU we
can bind the OCC driver and trigger the probe.

Alternatively, in the style of your first para, we could push the host
CPU state management into the kernel and expose a boot/reboot/power-off=20
API to userspace. That would give us a place to hook calls for
configuring and cleaning up any host-dependent drivers on the BMC.

The solution to the host-power-state problem is also applicable to the
OpenFSI patches that were recently sent out:

https://lkml.org/lkml/2016/12/6/732

The OpenFSI infra needs to re-scan for CFAMs when the host is powered
up.

>=20
> An alternative might be to have the hwmon driver poll for the OCC,
> but that would be a bit more difficult and might require a kernel thread
> or maybe asynchronous probing.

This was our thought as a fallback solution.

Andrew

>=20
> Guenter
>=20
--=-XBpeGEDaOSADCXVW28Vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYctCsAAoJEJ0dnzgO5LT5z9MP/AhLhzP9udsCi8H/gcA42Wi/
xEpQpFY1OMthJc7Sgwg9wDHSTlpunHsiUS37w1E95UjKXcOXVS/kAJYaHu8lBPtl
O5S9i+G4ciuTbe7VslMc5elhnrDoGrz+BzahFGvspnAlgCe1Kp3sEiWNbDUTtrMV
AdcmfSYFm2pRCt9vff+3fkRkFSrYNzbSQYVMpCOfBsXM6FBF+X8BZvP7DvnBqNpC
XWDZuzLNSfD79ALXtqRSTby/QfgQmWivp3ykfDuCHTCqBrukMmDkFJ2zNbVo5XGa
I27nAs8UvQ0BVX2GBfoDLNhXKYFI9elWVLucL4MFkXGdarz+HSeMavELIBrWieC5
UXV1LQOtOFUNTiaB/x4DLv8Q+UvOvi3a20LICrY8Af/vWzakqA2uxcp1q9XhBHhg
7hBcuEwowJAJvsf0KoOdiqz7NrWP53BGsBwonDYclczkiMoi/TRLz+qwQl5TxlwF
65E0tJeP89tz95w2d58JsHmvWYrYV0lCGyt17DW7TPdsExkMowTuzo/4S9ZKrxQ0
qWRndAuBq/knrHOs3ktSqJssXhiMHryjGDjRGl7XpEaBh092aayxhDxqNxWw7SDC
EkRIz1mlxjYFr1mXRx1BQHmw6w5hVOGLjlaHsvy9rgG/T/GNLHuBZ53PHofur6ns
354Qi5N7FCFkt2eQOiNi
=Dhdn
-----END PGP SIGNATURE-----

--=-XBpeGEDaOSADCXVW28Vr--

