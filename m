From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Fri, 31 Mar 2017 10:47:22 +0300
Message-ID: <20170331074722.GF2957@lahna.fi.intel.com>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
 <20170323204747.w2nxxrpjwypiygwb@ninjato>
 <20170330155233.dfnqe7d2xkr32zlo@ninjato>
 <20170331072004.GC2957@lahna.fi.intel.com>
 <1490945467.3894.426.camel@vkrasnov.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490945467.3894.426.camel@vkrasnov.dev.rtsoft.ru>
Sender: linux-acpi-owner@vger.kernel.org
To: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: Wolfram Sang <wsa@the-dreams.de>, jdelvare@suse.com, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 31, 2017 at 10:31:07AM +0300, Viktor Krasnov wrote:
> Hello Mika,
> 
> thanks for the review.
> 
> > > --- a/include/acpi/acpi_drivers.h
> > > +++ b/include/acpi/acpi_drivers.h
> > > @@ -60,6 +60,8 @@
> > > #define ACPI_DOCK_HID			"LNXDOCK"
> > > /* Quirk for broken IBM BIOSes */
> > > #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> > > +/* SMBUS HID definition as supported by Microsoft Windows */
> > > +#define ACPI_SMBUS_MS_HID		"SMB0001"
> 
> > I agree with the reasoning but why do you add the ID here also? Wouldn't
> > it suffice if added only to the i2c-scmi.c driver?
> 
> This has been done by analogy with existing ACPI_SMBUS_IBM_HID which is
> defined in acpi_drivers.h. I think that it may look confusing when some
> HIDs are defined in i2c-scmi.c and others - in acpi_drivers.h. Could you
> please clarify this moment and confirm that all HIDs must be defined
> only in i2c-scmi.c? I will rework the patch then.

If there is only one file using a HID, then I think it is fine to keep
it in the driver itself. If multiple files share the HID then it makes
sense to put it to include/acpi/acpi_drivers.h.
