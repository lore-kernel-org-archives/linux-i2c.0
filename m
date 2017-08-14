From: Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 harder
Date: Mon, 14 Aug 2017 12:06:10 -0400
Message-ID: <1502726770.489.0.camel@redhat.com>
References: <20170626204009.32607-1-lyude@redhat.com>
         <20170812111507.rxc7lzc6f7uoqlt2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16953 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbdHNQGN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 12:06:13 -0400
In-Reply-To: <20170812111507.rxc7lzc6f7uoqlt2@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: intel-gfx@lists.freedesktop.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Benjamin Tissoires <btissoir@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2017-08-12 at 13:15 +0200, Wolfram Sang wrote:
> On Mon, Jun 26, 2017 at 04:40:08PM -0400, Lyude wrote:
> > There's quite a number of machines on the market, mainly Lenovo
> > ThinkPads, that make the horrible mistake in their firmware of
> > reusing
> > the PCIBAR space reserved for the SMBus for things that are
> > completely
> > unrelated to the SMBus controller, such as the OpRegion used for
> > i915.
> > This is very bad and entirely evil, but with Lenovo's historically
> > poor
> > track record of fixing their firmware, it is extremely unlikely
> > this is
> > ever going to be properly fixed.
> > 
> > So, while it would be nice if we could just cut off the SMBus
> > controller
> > and call it a day this unfortunately breaks RMI4 mode completely
> > for
> > most of the ThinkPads. Even though this behavior is extremely
> > wrong, for
> > whatever reason sharing the PCIBAR between the OpRegion and SMBus
> > seems
> > to be just fine. Regardless however, I think it's safe to assume
> > that
> > when the BIOS accesses the PCIBAR space of the SMBus controller
> > like
> > this that it's trying to get to something else that we mapped the
> > SMBus
> > controller over.
> > 
> > On my X1 Carbon, this assumption appears to be correct. I've traced
> > down
> > the firmware accesses to being caused by the firmware mistakenly
> > placing
> > the SWSCI mailbox for i915 on top of the SMBus host controller
> > region.
> > And indeed, blacklisting i915 causes the firmware to never attempt
> > to
> > touch this region.
> > 
> > So, in order to try to workaround this and not break either SMBus
> > or
> > i915, we temporarily unmap the PCI device for the SMBus controller,
> > do the thing that the firmware wanted to do, then remap the device
> > and
> > report a firmware bug.
> > 
> > Signed-off-by: Lyude <lyude@redhat.com>
> 
> No full name? Or is it your full name?
Looks like I forgot to change my desktop's S-B identity to full name,
but it shouldn't be a big deal. I've got tons of other patches already
upstream like this.
> 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Benjamin Tissoires <btissoir@redhat.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Jean Delvare <jdelvare@suse.de>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: intel-gfx@lists.freedesktop.org
> 
> I don't know this matter at all. I'd need comments from these people
> on
> CC to proceed with this one.
> 
> > ---
> > So: unfortunately
> > 
> > a7ae81952cda (i2c: i801: Allow ACPI SystemIO OpRegion to conflict
> > with PCI BAR)
> > 
> > Seems to prevent the ThinkPad X1 Carbon 4th gen and the T460s from
> > actually
> > using their SMBus controllers at all. As mentioned above, I've
> > traced the issue
> > down to the firmware responding to the SWSCI by sticking data in
> > places it
> > shouldn't, e.g. the SMBus registers.
> > 
> > I'm entirely unsure if this patch is the correct fix for this, and
> > wouldn't be
> > at all surprised if it's just as bad of a patch as I think it is
> > ;P. So I
> > figured I'd send it to intel-gfx and the authors of the original
> > version of this
> > patch to get their take on it and see if there might be something
> > less hacky we
> > can do to fix this.
> > 
> >  drivers/i2c/busses/i2c-i801.c | 41 +++++++++++++++++++++++++----
> > ------------
> >  1 file changed, 25 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-i801.c
> > b/drivers/i2c/busses/i2c-i801.c
> > index 6484fa6..bfbe0f9 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -1406,33 +1406,42 @@ i801_acpi_io_handler(u32 function,
> > acpi_physical_address address, u32 bits,
> >  {
> >  	struct i801_priv *priv = handler_context;
> >  	struct pci_dev *pdev = priv->pci_dev;
> > +	struct device *dev = &pdev->dev;
> >  	acpi_status status;
> > +	int err;
> >  
> > -	/*
> > -	 * Once BIOS AML code touches the OpRegion we warn and
> > inhibit any
> > -	 * further access from the driver itself. This device is
> > now owned
> > -	 * by the system firmware.
> > -	 */
> >  	mutex_lock(&priv->acpi_lock);
> >  
> > -	if (!priv->acpi_reserved) {
> > -		priv->acpi_reserved = true;
> > +	/*
> > +	 * BIOS AML code should never actually touch the SMBus
> > registers,
> > +	 * however crappy firmware (mainly Lenovo's) can make the
> > mistake of
> > +	 * mapping things over the SMBus region that should
> > definitely not be
> > +	 * there (such as the OpRegion for Intel GPUs).
> > +	 * This is extremely bad firmware behavior, but it is
> > unlikely this will
> > +	 * ever get fixed by Lenovo.
> > +	 */
> > +	dev_warn_once(dev,
> > +		      FW_BUG "OpRegion overlaps with SMBus
> > registers, working around\n");
> >  
> > -		dev_warn(&pdev->dev, "BIOS is accessing SMBus
> > registers\n");
> > -		dev_warn(&pdev->dev, "Driver SMBus register access
> > inhibited\n");
> > -
> > -		/*
> > -		 * BIOS is accessing the host controller so
> > prevent it from
> > -		 * suspending automatically from now on.
> > -		 */
> > -		pm_runtime_get_sync(&pdev->dev);
> > -	}
> > +	pm_runtime_get_sync(dev);
> > +	pcim_iounmap_regions(pdev, 1 << SMBBAR);
> >  
> >  	if ((function & ACPI_IO_MASK) == ACPI_READ)
> >  		status = acpi_os_read_port(address, (u32 *)value,
> > bits);
> >  	else
> >  		status = acpi_os_write_port(address, (u32)*value,
> > bits);
> >  
> > +	err = pcim_iomap_regions(pdev, 1 << SMBBAR,
> > +				 dev_driver_string(&pdev->dev));
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			FW_BUG "Failed to restore SMBus region
> > 0x%lx-0x%Lx. SMBus is now broken.\n",
> > +			priv->smba,
> > +			(unsigned long long)pci_resource_end(pdev,
> > SMBBAR));
> > +		priv->acpi_reserved = true;
> > +	}
> > +
> > +	pm_runtime_put(dev);
> >  	mutex_unlock(&priv->acpi_lock);
> >  
> >  	return status;
> > -- 
> > 2.9.4
> > 
