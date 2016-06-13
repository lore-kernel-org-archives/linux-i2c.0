From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 13 Jun 2016 11:19:46 +0200
Message-ID: <20160613111946.54779d0d@endymion>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
	<20160608162913.GA24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160608162913.GA24234@mail.corp.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Benjamin,

On Wed, 8 Jun 2016 18:29:13 +0200, Benjamin Tissoires wrote:
> >  static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  {
> >  	unsigned char temp;
> > @@ -1277,6 +1368,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  	priv->adapter.dev.parent = &dev->dev;
> >  	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
> >  	priv->adapter.retries = 3;
> > +	mutex_init(&priv->acpi_lock);
> >  
> >  	priv->pci_dev = dev;
> >  	switch (dev->device) {
> > @@ -1339,10 +1431,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  		return -ENODEV;
> >  	}
> >  
> > -	err = acpi_check_resource_conflict(&dev->resource[SMBBAR]);
> > -	if (err) {
> > +	err = i801_acpi_probe(priv);
> > +	if (err)
> >  		return -ENODEV;
> > -	}
> 
> I'd say that once this has been set, we need to call
> acpi_remove_address_space_handler() in case of failure later (in the 2
> returns after).

Good catch, sorry for missing it during my review.

The first error return can probably be left unchanged by calling
i801_acpi_probe() after it rather than before. The second will need a
call to i801_acpi_remove(priv) for sure.

-- 
Jean Delvare
SUSE L3 Support
