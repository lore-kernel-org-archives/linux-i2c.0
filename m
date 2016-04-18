From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] i2c: dln2: Pass forward ACPI companion
Date: Mon, 18 Apr 2016 10:54:13 +0300
Message-ID: <20160418075413.GL1714@lahna.fi.intel.com>
References: <1458845956-30991-1-git-send-email-irina.tirdea@intel.com>
 <20160416213304.GF1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20976 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbcDRHyR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Apr 2016 03:54:17 -0400
Content-Disposition: inline
In-Reply-To: <20160416213304.GF1522@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Irina Tirdea <irina.tirdea@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>

On Sat, Apr 16, 2016 at 11:33:04PM +0200, Wolfram Sang wrote:
> On Thu, Mar 24, 2016 at 08:59:16PM +0200, Irina Tirdea wrote:
> > Share the ACPI companion for the platform device with the
> > i2c adapter, so that the adapter has access to the properties
> > defined in ACPI tables.
> > 
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> 
> Adding Mika for my question: A few drivers do this, does it make sense
> to put this into the core?

It is pretty much dependent on the driver in question, how it wants to
deal with the ACPI companion.

DT does the same for of_node:

	ACPI_COMPANION_SET(&dln2->adapter.dev, ACPI_COMPANION(&pdev->dev));
  	dln2->adapter.dev.of_node = dev->of_node;

> Apart from that, looks good to me.

Looks good to me too.

> >  drivers/i2c/busses/i2c-dln2.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
> > index 1600edd..f2eb4f7 100644
> > --- a/drivers/i2c/busses/i2c-dln2.c
> > +++ b/drivers/i2c/busses/i2c-dln2.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mfd/dln2.h>
> > +#include <linux/acpi.h>
> >  
> >  #define DLN2_I2C_MODULE_ID		0x03
> >  #define DLN2_I2C_CMD(cmd)		DLN2_CMD(cmd, DLN2_I2C_MODULE_ID)
> > @@ -210,6 +211,7 @@ static int dln2_i2c_probe(struct platform_device *pdev)
> >  	dln2->adapter.algo = &dln2_i2c_usb_algorithm;
> >  	dln2->adapter.quirks = &dln2_i2c_quirks;
> >  	dln2->adapter.dev.parent = dev;
> > +	ACPI_COMPANION_SET(&dln2->adapter.dev, ACPI_COMPANION(&pdev->dev));
> >  	dln2->adapter.dev.of_node = dev->of_node;
> >  	i2c_set_adapdata(&dln2->adapter, dln2);
> >  	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d",
> > -- 
> > 1.9.1
> > 
