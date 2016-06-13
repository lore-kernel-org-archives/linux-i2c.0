From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 13 Jun 2016 11:48:30 +0200
Message-ID: <20160613094830.GZ29844@pali>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
 <20160613111946.54779d0d@endymion>
 <20160613094500.GY29844@pali>
 <20160613094618.GG1791@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160613094618.GG1791@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday 13 June 2016 12:46:18 Mika Westerberg wrote:
> On Mon, Jun 13, 2016 at 11:45:00AM +0200, Pali Roh=C3=A1r wrote:
> > On Monday 13 June 2016 11:19:46 Jean Delvare wrote:
> > > Hi Benjamin,
> > >=20
> > > On Wed, 8 Jun 2016 18:29:13 +0200, Benjamin Tissoires wrote:
> > > > >  static int i801_probe(struct pci_dev *dev, const struct pci_=
device_id *id)
> > > > >  {
> > > > >  	unsigned char temp;
> > > > > @@ -1277,6 +1368,7 @@ static int i801_probe(struct pci_dev *d=
ev, const struct pci_device_id *id)
> > > > >  	priv->adapter.dev.parent =3D &dev->dev;
> > > > >  	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev-=
>dev));
> > > > >  	priv->adapter.retries =3D 3;
> > > > > +	mutex_init(&priv->acpi_lock);
> > > > > =20
> > > > >  	priv->pci_dev =3D dev;
> > > > >  	switch (dev->device) {
> > > > > @@ -1339,10 +1431,9 @@ static int i801_probe(struct pci_dev *=
dev, const struct pci_device_id *id)
> > > > >  		return -ENODEV;
> > > > >  	}
> > > > > =20
> > > > > -	err =3D acpi_check_resource_conflict(&dev->resource[SMBBAR]=
);
> > > > > -	if (err) {
> > > > > +	err =3D i801_acpi_probe(priv);
> > > > > +	if (err)
> > > > >  		return -ENODEV;
> > > > > -	}
> > > >=20
> > > > I'd say that once this has been set, we need to call
> > > > acpi_remove_address_space_handler() in case of failure later (i=
n the 2
> > > > returns after).
> > >=20
> > > Good catch, sorry for missing it during my review.
> > >=20
> > > The first error return can probably be left unchanged by calling
> > > i801_acpi_probe() after it rather than before. The second will ne=
ed a
> > > call to i801_acpi_remove(priv) for sure.
> >=20
> > Maybe we should call acpi_remove_address_space_handler() after firs=
t
> > ACPI access to driver?
>=20
> I fixed it already in v6 which got applied by Wolfram.

I mean to call acpi_remove_address_space_handler() in
i801_acpi_io_handler() after acpi_reserved is properly set.

As once acpi_reserved is set address space handler is not needed
anymore.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
