From: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Fri, 31 Mar 2017 10:31:07 +0300
Message-ID: <1490945467.3894.426.camel@vkrasnov.dev.rtsoft.ru>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
         <20170323204747.w2nxxrpjwypiygwb@ninjato>
         <20170330155233.dfnqe7d2xkr32zlo@ninjato>
         <20170331072004.GC2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:49360 "EHLO
        mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbdCaHbK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 31 Mar 2017 03:31:10 -0400
In-Reply-To: <20170331072004.GC2957@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, jdelvare@suse.com, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hello Mika,

thanks for the review.

> > --- a/include/acpi/acpi_drivers.h
> > +++ b/include/acpi/acpi_drivers.h
> > @@ -60,6 +60,8 @@
> > #define ACPI_DOCK_HID			"LNXDOCK"
> > /* Quirk for broken IBM BIOSes */
> > #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> > +/* SMBUS HID definition as supported by Microsoft Windows */
> > +#define ACPI_SMBUS_MS_HID		"SMB0001"

> I agree with the reasoning but why do you add the ID here also? Wouldn't
> it suffice if added only to the i2c-scmi.c driver?

This has been done by analogy with existing ACPI_SMBUS_IBM_HID which is
defined in acpi_drivers.h. I think that it may look confusing when some
HIDs are defined in i2c-scmi.c and others - in acpi_drivers.h. Could you
please clarify this moment and confirm that all HIDs must be defined
only in i2c-scmi.c? I will rework the patch then.

Best regards,
Viktor Krasnov.

On Fri, 2017-03-31 at 10:20 +0300, Mika Westerberg wrote:
> On Thu, Mar 30, 2017 at 05:52:33PM +0200, Wolfram Sang wrote:
> > On Thu, Mar 23, 2017 at 09:47:47PM +0100, Wolfram Sang wrote:
> > > On Fri, Mar 10, 2017 at 04:58:35PM +0300, Viktor Krasnov wrote:
> > > 
> > > Thanks for the patch!
> > > 
> > > adding linux-acpi to CC. This is more an ACPI question than I2C.
> > 
> > Mika? Andy? Jarkko? Any input on this?
> > 
> > > 
> > > > From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> > > > 
> > > > Description of the problem:
> > > >  - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
> > > >  - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
> > > >    Interface Specification, version 1.0": "Each device must specify 
> > > >    'SMBUS01' as its _HID and use a unique _UID value";
> > > >  - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
> > > >    and implement "SMB0001" HID instead of "SMBUS01";
> > > >  - I speculate that they do this because only "SMB0001" is hard coded in
> > > >    Windows SMBus driver produced by Microsoft.
> > > > 
> > > > This leads to following situation:
> > > >  - SMBus works out of box in Windows but not in Linux;
> > > >  - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
> > > >    SMBus work in Linux. Moreover the same board vendors complain that
> > > >    tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
> > > >    and produce errors.  So they need to constantly patch the compiler for 
> > > >    each new version of BIOS.
> > > > 
> > > > As it is very unlikely that BIOS vendors implement a correct HID in
> > > > future, I would propose to consider whether it is possible to work around
> > > > the problem by adding MS HID to the Linux i2c-scmi driver.
> > > > 
> > > > Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> > > > Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> > > > Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
> > > > ---
> > > >  drivers/i2c/busses/i2c-scmi.c | 1 +
> > > >  include/acpi/acpi_drivers.h   | 2 ++
> > > >  2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
> > > > index dfc98df..fb9aee0 100644
> > > > --- a/drivers/i2c/busses/i2c-scmi.c
> > > > +++ b/drivers/i2c/busses/i2c-scmi.c
> > > > @@ -51,6 +51,7 @@ struct acpi_smbus_cmi {
> > > >  static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
> > > >  	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
> > > >  	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
> > > > +	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
> > > >  	{"", 0}
> > > >  };
> > > >  MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
> > > > diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> > > > index 29c6912..d34538b 100644
> > > > --- a/include/acpi/acpi_drivers.h
> > > > +++ b/include/acpi/acpi_drivers.h
> > > > @@ -60,6 +60,8 @@
> > > >  #define ACPI_DOCK_HID			"LNXDOCK"
> > > >  /* Quirk for broken IBM BIOSes */
> > > >  #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> > > > +/* SMBUS HID definition as supported by Microsoft Windows */
> > > > +#define ACPI_SMBUS_MS_HID		"SMB0001"
> 
> I agree with the reasoning but why do you add the ID here also? Wouldn't
> it suffice if added only to the i2c-scmi.c driver?
