From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 2/2] i2c: add ACPI support for I2C mux ports
Date: Fri, 23 Oct 2015 11:40:13 +0300
Message-ID: <20151023084013.GS1526@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-3-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445505462-27915-3-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 22, 2015 at 02:17:42AM -0700, Dustin Byford wrote:
> Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
> device property compatible string match), enumerating I2C client devices
> connected through an I2C mux needs a little extra work.
> 
> This change implements a method for describing an I2C device hierarchy that
> includes mux devices by using an ACPI Device() for each mux channel along
> with an _ADR to set the channel number for the device.  See
> Documentation/acpi/i2c-muxes.txt for a simple example.
> 
> To make this work the ismt, i801, and designware pci/platform devs now
> share an ACPI companion with their I2C adapter dev similar to how it's done
> in OF.  This is done on the assumption that power management functions will
> not be called directly on the I2C dev that is sharing the ACPI node.
> 
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>

This looks good to me.

You did also some stylistic changes to the drivers in question which I
think should be placed to a separate patches.

Regardless of that,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I'll leave this up to Rafael and Wolfram to decide how to go forward
with this patch.
