From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/3] i2c: designware-pci: Introduce Merrifield support
Date: Wed, 15 Jun 2016 17:09:54 +0300
Message-ID: <1465999794.30123.122.camel@linux.intel.com>
References: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1465944960-25444-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <ffcdc682-1948-f048-b8df-4f3360fbe501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58757 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934AbcFOOJD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 10:09:03 -0400
In-Reply-To: <ffcdc682-1948-f048-b8df-4f3360fbe501@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Wed, 2016-06-15 at 16:48 +0300, Jarkko Nikula wrote:
> On 06/15/2016 01:55 AM, Andy Shevchenko wrote:
> > This patch enables I2C controllers found on Intel Edison board.

> > +static int mrfld_setup(struct pci_dev *pdev, struct
> > dw_pci_controller *c)
> > +{
> > +	switch (PCI_SLOT(pdev->devfn)) {
> > +	case 8:
> > +		c->bus_num =3D PCI_FUNC(pdev->devfn) + 0 + 1;
> > +		return 0;
> > +	case 9:
> > +		c->bus_num =3D PCI_FUNC(pdev->devfn) + 4 + 1;
> > +		return 0;
> > +	}
> > +	return -ENODEV;
> > +}
> > +
>=20
> What kind of bus numbers we are expected to see here and what offsets=
=C2=A0
> these magic numbers represent?

Official bus numbers are [1..7]. Thus, this + 1 at the end. First PCI
device provides 4 functions, that's why +0 and +4.
Do I need to add a comment there?

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
