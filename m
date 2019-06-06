From: Vitor Soares <Vitor.Soares@synopsys.com>
Subject: RE: [PATCH v2 2/3] i3c: add i3c_get_device_id helper
Date: Thu, 6 Jun 2019 16:58:51 +0000
Message-ID: <13D59CF9CEBAF94592A12E8AE55501350AABE7DC@DE02WEMBXB.internal.synopsys.com>
References: <cover.1559831663.git.vitor.soares@synopsys.com>
        <eaa9eb66df6b4c9b577aec46fd440b99d763a5a2.1559831663.git.vitor.soares@synopsys.com>
 <20190606171755.0feb8998@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606171755.0feb8998@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@collabora.com>, Vitor Soares <Vitor.Soares@synopsys.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>, "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, Jun 06, 2019 at 16:17:55

> On Thu,  6 Jun 2019 17:12:03 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > This helper return the i3c_device_id structure in order the client
> > have access to the driver data.
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> > Changes in v2:
> >   move this function to drivers/i3c/device.c
> >=20
> >  drivers/i3c/device.c       | 8 ++++++++
> >  include/linux/i3c/device.h | 1 +
> >  2 files changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> > index 69cc040..a6d0796 100644
> > --- a/drivers/i3c/device.c
> > +++ b/drivers/i3c/device.c
> > @@ -200,6 +200,14 @@ struct i3c_device *dev_to_i3cdev(struct device *de=
v)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_to_i3cdev);
> > =20
> > +const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cde=
v)
> > +{
> > +	const struct i3c_driver *i3cdrv =3D drv_to_i3cdrv(i3cdev->dev.driver)=
;
> > +
> > +	return i3cdrv->id_table;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_get_device_id);
>=20
> That's not what I asked. I told you to expose i3c_device_match_id()
> which already exists and is in master.c. What you really want is to get
> the device_id entry that matches your device, not the first entry in
> the table...
>=20

I didn't see it has the full table.
I will change it.

> > +
> >  /**
> >   * i3c_driver_register_with_owner() - register an I3C device driver
> >   *
> > diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> > index 5ecb055..e0415e1 100644
> > --- a/include/linux/i3c/device.h
> > +++ b/include/linux/i3c/device.h
> > @@ -187,6 +187,7 @@ static inline struct i3c_driver *drv_to_i3cdrv(stru=
ct device_driver *drv)
> > =20
> >  struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
> >  struct i3c_device *dev_to_i3cdev(struct device *dev);
> > +const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cde=
v);
> > =20
> >  static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
> >  				      void *data)
