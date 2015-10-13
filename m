From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: add ACPI support for I2C mux ports
Date: Tue, 13 Oct 2015 14:32:35 +0300
Message-ID: <20151013113235.GK1492@lahna.fi.intel.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-3-git-send-email-dustin@cumulusnetworks.com>
 <20151012105023.GX1506@lahna.fi.intel.com>
 <20151012183231.GB5909@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:65310 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbbJMLer (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 13 Oct 2015 07:34:47 -0400
Content-Disposition: inline
In-Reply-To: <20151012183231.GB5909@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net

On Mon, Oct 12, 2015 at 11:32:31AM -0700, Dustin Byford wrote:
> I've been trying to consider the options, perhaps you can help my
> understanding.  Using the i801 driver as an example, the device is PCI
> and the companion is associated with the PCI dev.  The driver creates
> another device for the I2C interface (parented by the PCI device) by
> calling i2c_add_adapter().  The I2C dev has no ACPI companion.
> 
> In the case of an I2C mux port, I've used acpi_preset_companion() to
> associate each mux port I2C device with a ACPI node.  Unlike the i801,
> which has a single port, these companions are one per channel.  It's not
> an option to associate them all with the I2C mux device.
> 
> It seems like the options are to:
> 
> a) Special case the I2C mux to use the per-port I2C companions as I've
>    done here.
> 
> b) Move (or copy?) the companion from the i801 PCI dev to the i801 I2C
>    dev.  Then we would always look in the same place for the companion.
>    I think this approach has some advantages, at least it would make
>    more sense if an I2C PCI controller had more than one I2C port, but
>    I'm not sure that case exists.  I didn't pursue this approach because
>    it was specifically avoided in change b34bb1ee.
> 
> 
> What do you think?  I'd be happy to try out any ideas you have.

I would favour b) because that follows DT (the I2C host controller
device and I2C adapter share the same DT node as far as I can tell).
Neither of them have similar concept of I2C adapter as we have in Linux
(which is the "virtual" device on top of the I2C host controller).
