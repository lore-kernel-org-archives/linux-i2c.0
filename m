From: "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c-scmi: Quirk to work on IBM machines with broken
	BIOSes
Date: Wed, 21 Oct 2009 10:37:33 -0700
Message-ID: <20091021173733.GN26149@tux1.beaverton.ibm.com>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com> <20091021023016.GC32413@crane-desktop> <200910210857.13978.bjorn.helgaas@hp.com>
Reply-To: djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200910210857.13978.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 21, 2009 at 08:57:13AM -0600, Bjorn Helgaas wrote:
> On Tuesday 20 October 2009 08:30:16 pm Crane Cai wrote:
> > Hi Darrick,
> > 
> > On Tue, Oct 20, 2009 at 04:11:49PM -0700, Darrick J. Wong wrote:
> > > On some old IBM workstations and desktop computers, the BIOS presents in
> > > the DSDT an SMBus object that is missing the HID identifier that the
> > > i2c-scmi driver looks for.  It also omits the leading "_" in the method
> > > names (it should be _SBR, not SBR_).  Modify the ACPI device scan code to
> > > insert the missing HID if it finds an IBM system with such an object, and
> > > modify the i2c-scmi driver to handle the odd method names.
> > I have a suggestion: You can need not to add quirk in acpi part, instead
> > you can add your ACPI device HID in i2c-scmi with your specificied methods
> > set.

The problem is that the BIOS does not provide an HID for the SMBus object at
all...

> Maybe Darrick understands your suggestion, but I don't.  The only way
> i2c-scmi ever learns about a device is when acpi_smbus_cmi_add() is
> called, and that's only called when the Linux/ACPI core has found a
> device that matches "SMBUS01".
> 
> Can you elaborate on your suggestion?
> 
> The i2c-scmi driver *could* walk the whole namespace itself, looking
> for devices with the SBI/SBR/SBW methods, but I like Darrick's quirk
> approach better because it allows i2c-scmi to continue to use the
> normal ACPI driver model.

...which is why I need the quirk to stuff one in at the OS level.  Were it as
simple as recognizing a different HID, I could have written a less intrusive
patch. :/

--D
