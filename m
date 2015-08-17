From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Mon, 17 Aug 2015 12:00:45 -0700
Message-ID: <20150817190045.GA25318@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <20150817120305.GB1552@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150817120305.GB1552@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

Thanks for taking a look.

On Mon Aug 17 15:03, Mika Westerberg wrote:
> On Fri, Aug 14, 2015 at 12:31:32PM -0700, Dustin Byford wrote:

> >     Name (_DSD, Package ()
> >     {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >             Package (2) { "compatible", "nxp,pca9548" },
> >         }
> 
> Nice, you are using _DSD :-)

Yes, and I've got some other patches related to that.  I'll keep
sending, but the relative youth of _DSD does bring up a few higher level
issues (for me at least).  One thing at a time though, stay tuned.

> > I had to:
> > 
> > 1) Find and set an ACPI companion for the "virtual" I2C adapters created
> >    for each mux channel.
> > 
> > 2) Make sure to scan adap.dev when registering devices under each mux
> >    channel.

> I think the current code in I2C core is not actually doing the right
> thing according the ACPI spec at least. To my understanding you can have
> device with I2cSerialBus resource _anywhere_ in the namespace, not just
> directly below the host controller. It's the ResourceSource attribute
> that tells the corresponding host controller.

I think you're right.

> I wonder if it helps if we scan the whole namespace for devices with
> I2cSerialBus that matches the just registered adapter? Something like
> the patch below.

Looks reasonable to me.  Let me work with the patch for a bit and see if
I can make it work in my system.

		--Dustin
