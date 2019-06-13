From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Thu, 13 Jun 2019 09:48:58 +0100
Message-ID: <20190613084858.GU28362@ediswmail.ad.cirrus.com>
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
 <20190612152718.GC2640@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190612152718.GC2640@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 12, 2019 at 06:27:18PM +0300, Mika Westerberg wrote:
> On Tue, Jun 11, 2019 at 01:30:58PM +0100, Charles Keepax wrote:
> > In preparation for more refactoring make i2c_acpi_get_irq available
> > outside i2c-core-acpi.c.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > Changes since v3:
> >  - Move the change to use the helper function from i2c-core-base into its own patch.
> > 
> > Thanks,
> > Charles
> > 
> >  drivers/i2c/i2c-core-acpi.c | 15 +++++++++++++--
> >  drivers/i2c/i2c-core.h      |  7 +++++++
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > index 7d4d66ba752d4..35966cc337dde 100644
> > --- a/drivers/i2c/i2c-core-acpi.c
> > +++ b/drivers/i2c/i2c-core-acpi.c
> > @@ -144,8 +144,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> >  	return 1; /* No need to add resource to the list */
> >  }
> >  
> > -static int i2c_acpi_get_irq(struct acpi_device *adev)
> > +/**
> > + * i2c_acpi_get_irq - get device IRQ number from ACPI
> > + * @client: Pointer to the I2C client device
> > + *
> > + * Find the IRQ number used by a specific client device.
> > + *
> > + * Return: The IRQ number or an error code.
> > + */
> > +int i2c_acpi_get_irq(struct i2c_client *client)
> >  {
> > +	struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
> 
> Is this adev checked for being NULL somewhere below before it is being
> dereferenced?
> 
> It could explain the issue Benjamin is seeing.
> 

Yeah could be that or just for some reason this isn't returning
the same adev as we previously had. I will do some digging see if
I can find any likely culprits.

Thanks,
Charles
