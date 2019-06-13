From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Thu, 13 Jun 2019 16:06:11 +0100
Message-ID: <20190613150611.GV28362@ediswmail.ad.cirrus.com>
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
 <20190612152718.GC2640@lahna.fi.intel.com>
 <20190613084858.GU28362@ediswmail.ad.cirrus.com>
 <CAO-hwJL-U0n5oFP-QXX8rD2Fxt9mDOKp-AknRN6QwXEhZsUBYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJL-U0n5oFP-QXX8rD2Fxt9mDOKp-AknRN6QwXEhZsUBYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 13, 2019 at 11:32:47AM +0200, Benjamin Tissoires wrote:
> On Thu, Jun 13, 2019 at 10:49 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > On Wed, Jun 12, 2019 at 06:27:18PM +0300, Mika Westerberg wrote:
> > > On Tue, Jun 11, 2019 at 01:30:58PM +0100, Charles Keepax wrote:
> > > > In preparation for more refactoring make i2c_acpi_get_irq available
> > > > outside i2c-core-acpi.c.
> > > >
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > >
> > > > Changes since v3:
> > > >  - Move the change to use the helper function from i2c-core-base into its own patch.
> > > >
> > > > Thanks,
> > > > Charles
> > > >
> > > >  drivers/i2c/i2c-core-acpi.c | 15 +++++++++++++--
> > > >  drivers/i2c/i2c-core.h      |  7 +++++++
> > > >  2 files changed, 20 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > > > index 7d4d66ba752d4..35966cc337dde 100644
> > > > --- a/drivers/i2c/i2c-core-acpi.c
> > > > +++ b/drivers/i2c/i2c-core-acpi.c
> > > > @@ -144,8 +144,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> > > >     return 1; /* No need to add resource to the list */
> > > >  }
> > > >
> > > > -static int i2c_acpi_get_irq(struct acpi_device *adev)
> > > > +/**
> > > > + * i2c_acpi_get_irq - get device IRQ number from ACPI
> > > > + * @client: Pointer to the I2C client device
> > > > + *
> > > > + * Find the IRQ number used by a specific client device.
> > > > + *
> > > > + * Return: The IRQ number or an error code.
> > > > + */
> > > > +int i2c_acpi_get_irq(struct i2c_client *client)
> > > >  {
> > > > +   struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
> > >
> > > Is this adev checked for being NULL somewhere below before it is being
> > > dereferenced?
> > >
> > > It could explain the issue Benjamin is seeing.
> > >
> >
> > Yeah could be that or just for some reason this isn't returning
> > the same adev as we previously had. I will do some digging see if
> > I can find any likely culprits.
> 
> That was almost the culprit: client is NULL here.
> So the call of i2c_acpi_find_client_by_adev(adev) fails.
> 
> I guess this explains why the next commit is also not working :)
> 

Ah.. yeah because at this stage this code is probably running
before that client has been created I think, this crept in on
that last splitting of the patch into two. Let me see if I can
come up with a new solution and do a new version. Thank you very
much for the help going through this.

Thanks,
Charles
