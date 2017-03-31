From: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Fri, 31 Mar 2017 11:04:26 +0300
Message-ID: <1490947466.3894.432.camel@vkrasnov.dev.rtsoft.ru>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
         <20170323204747.w2nxxrpjwypiygwb@ninjato>
         <20170330155233.dfnqe7d2xkr32zlo@ninjato>
         <20170331072004.GC2957@lahna.fi.intel.com>
         <1490945467.3894.426.camel@vkrasnov.dev.rtsoft.ru>
         <20170331074722.GF2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170331074722.GF2957@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, jdelvare@suse.com, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hello Mika,

> If there is only one file using a HID, then I think it is fine to keep
> it in the driver itself. If multiple files share the HID then it makes
> sense to put it to include/acpi/acpi_drivers.h.

Understood, thanks for the detailed explanation. Indeed,
ACPI_SMBUS_IBM_HID is referenced in several files, so it explains why
this HID is defined in include/acpi/acpi_drivers.h and not in i2c-scmi.c
itself.

Ok, I will correct the patch, retest it and resend in next few days.

Best regards,
Viktor Krasnov.

On Fri, 2017-03-31 at 10:47 +0300, Mika Westerberg wrote:
> On Fri, Mar 31, 2017 at 10:31:07AM +0300, Viktor Krasnov wrote:
> > Hello Mika,
> > 
> > thanks for the review.
> > 
> > > > --- a/include/acpi/acpi_drivers.h
> > > > +++ b/include/acpi/acpi_drivers.h
> > > > @@ -60,6 +60,8 @@
> > > > #define ACPI_DOCK_HID			"LNXDOCK"
> > > > /* Quirk for broken IBM BIOSes */
> > > > #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> > > > +/* SMBUS HID definition as supported by Microsoft Windows */
> > > > +#define ACPI_SMBUS_MS_HID		"SMB0001"
> > 
> > > I agree with the reasoning but why do you add the ID here also? Wouldn't
> > > it suffice if added only to the i2c-scmi.c driver?
> > 
> > This has been done by analogy with existing ACPI_SMBUS_IBM_HID which is
> > defined in acpi_drivers.h. I think that it may look confusing when some
> > HIDs are defined in i2c-scmi.c and others - in acpi_drivers.h. Could you
> > please clarify this moment and confirm that all HIDs must be defined
> > only in i2c-scmi.c? I will rework the patch then.
> 
> If there is only one file using a HID, then I think it is fine to keep
> it in the driver itself. If multiple files share the HID then it makes
> sense to put it to include/acpi/acpi_drivers.h.


