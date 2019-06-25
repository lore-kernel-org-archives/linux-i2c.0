From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v6 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Tue, 25 Jun 2019 13:42:45 +0100
Message-ID: <20190625124245.GC54126@ediswmail.ad.cirrus.com>
References: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
 <20190621100815.12417-5-ckeepax@opensource.cirrus.com>
 <20190625115011.GE2640@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625115011.GE2640@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 25, 2019 at 02:50:11PM +0300, Mika Westerberg wrote:
> On Fri, Jun 21, 2019 at 11:08:12AM +0100, Charles Keepax wrote:
> > In preparation for more refactoring make i2c_acpi_get_irq available
> > outside i2c-core-acpi.c.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > Changes since v5:
> >  - Pass a struct device rather than acpi_device to i2c_acpi_get_irq,
> >    note this is more awkward than I would have liked as I am very
> >    unconvinced that adev->dev can actually be passed to
> >    ACPI_COMPANION. If anyone can answer that for sure that would be
> >    very helpful.
> 
> I don't think you can do that.
> 

Yeah I think we are pretty sure that is not possible, although
not what is done in the patch, was just responding to on an
earlier comment.

> I probably missed some previous discussion but what's wrong passing
> struct i2c_client instead and use ACPI_COMPANION() for that?
> 

Really this is all about the splitting out the original patch
into two patches, one to export the function and one to move its
use to probe time. There isn't really any nice way to do it as two
patches and still pass the i2c_client struct. Hence we ended up
on this system with struct device.

I would be happy to squash the two patches, and go back to the
i2c_client approach, if that was preferred and  as long as Andy
doesn't mind.

> > 
> > Thanks,
> > Charles
> > 
> >  drivers/i2c/i2c-core-acpi.c | 13 +++++++++++--
> >  drivers/i2c/i2c-core.h      |  7 +++++++
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > index c91492eaacd93..37bf80b35365f 100644
> > --- a/drivers/i2c/i2c-core-acpi.c
> > +++ b/drivers/i2c/i2c-core-acpi.c
> > @@ -145,8 +145,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> >  	return 1;
> >  }
> >  
> > -static int i2c_acpi_get_irq(struct acpi_device *adev)
> > +/**
> > + * i2c_acpi_get_irq - get device IRQ number from ACPI
> > + * @client: Pointer to the I2C client device
> 
> I think this should be @dev now.
> 

Yes it should, sorry will fix that.

Thanks,
Charles
