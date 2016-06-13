From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 13 Jun 2016 12:46:18 +0300
Message-ID: <20160613094618.GG1791@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
 <20160613111946.54779d0d@endymion>
 <20160613094500.GY29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56241 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964844AbcFMJqc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 13 Jun 2016 05:46:32 -0400
Content-Disposition: inline
In-Reply-To: <20160613094500.GY29844@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jun 13, 2016 at 11:45:00AM +0200, Pali Roh=E1r wrote:
> On Monday 13 June 2016 11:19:46 Jean Delvare wrote:
> > Hi Benjamin,
> >=20
> > On Wed, 8 Jun 2016 18:29:13 +0200, Benjamin Tissoires wrote:
> > > >  static int i801_probe(struct pci_dev *dev, const struct pci_de=
vice_id *id)
> > > >  {
> > > >  	unsigned char temp;
> > > > @@ -1277,6 +1368,7 @@ static int i801_probe(struct pci_dev *dev=
, const struct pci_device_id *id)
> > > >  	priv->adapter.dev.parent =3D &dev->dev;
> > > >  	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->d=
ev));
> > > >  	priv->adapter.retries =3D 3;
> > > > +	mutex_init(&priv->acpi_lock);
> > > > =20
> > > >  	priv->pci_dev =3D dev;
> > > >  	switch (dev->device) {
> > > > @@ -1339,10 +1431,9 @@ static int i801_probe(struct pci_dev *de=
v, const struct pci_device_id *id)
> > > >  		return -ENODEV;
> > > >  	}
> > > > =20
> > > > -	err =3D acpi_check_resource_conflict(&dev->resource[SMBBAR]);
> > > > -	if (err) {
> > > > +	err =3D i801_acpi_probe(priv);
> > > > +	if (err)
> > > >  		return -ENODEV;
> > > > -	}
> > >=20
> > > I'd say that once this has been set, we need to call
> > > acpi_remove_address_space_handler() in case of failure later (in =
the 2
> > > returns after).
> >=20
> > Good catch, sorry for missing it during my review.
> >=20
> > The first error return can probably be left unchanged by calling
> > i801_acpi_probe() after it rather than before. The second will need=
 a
> > call to i801_acpi_remove(priv) for sure.
>=20
> Maybe we should call acpi_remove_address_space_handler() after first
> ACPI access to driver?

I fixed it already in v6 which got applied by Wolfram.
