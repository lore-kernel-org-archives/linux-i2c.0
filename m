From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] i2c-scmi: Quirk to work on IBM machines with broken BIOSes
Date: Wed, 21 Oct 2009 08:57:13 -0600
Message-ID: <200910210857.13978.bjorn.helgaas@hp.com>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com> <20091021023016.GC32413@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091021023016.GC32413@crane-desktop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Crane Cai <crane.cai@amd.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, lenb@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 20 October 2009 08:30:16 pm Crane Cai wrote:
> Hi Darrick,
> 
> On Tue, Oct 20, 2009 at 04:11:49PM -0700, Darrick J. Wong wrote:
> > On some old IBM workstations and desktop computers, the BIOS presents in the
> > DSDT an SMBus object that is missing the HID identifier that the i2c-scmi
> > driver looks for.  It also omits the leading "_" in the method names (it should
> > be _SBR, not SBR_).  Modify the ACPI device scan code to insert the missing HID
> > if it finds an IBM system with such an object, and modify the i2c-scmi driver
> > to handle the odd method names.
> I have a suggestion:
> You can need not to add quirk in acpi part, instead you can add your ACPI device
> HID in i2c-scmi with your specificied methods set.

Maybe Darrick understands your suggestion, but I don't.  The only way
i2c-scmi ever learns about a device is when acpi_smbus_cmi_add() is
called, and that's only called when the Linux/ACPI core has found a
device that matches "SMBUS01".

Can you elaborate on your suggestion?

The i2c-scmi driver *could* walk the whole namespace itself, looking
for devices with the SBI/SBR/SBW methods, but I like Darrick's quirk
approach better because it allows i2c-scmi to continue to use the
normal ACPI driver model.

Bjorn
