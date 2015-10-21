From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Wed, 21 Oct 2015 11:02:39 +0300
Message-ID: <20151021080239.GP1526@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
 <20151020125111.GJ1526@lahna.fi.intel.com>
 <1693922.rKkZ06EDTQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58033 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbbJUICp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 04:02:45 -0400
Content-Disposition: inline
In-Reply-To: <1693922.rKkZ06EDTQ@vostro.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com

On Wed, Oct 21, 2015 at 01:12:01AM +0200, Rafael J. Wysocki wrote:
> Well, we already have that in the MFD case, but in principle it may be
> problematic for things like power management (say you want to put a
> child device into D3, so you use _PS3 on its ACPI companion and then
> the parent is powere down instead).

That case I understand and we should not allow that. However, here we
have an I2C adapter which is purely Linux abstraction that does not have
any representation either in DT nor ACPI. And we don't do any power
management for that either.

If I understand correctly, DT shares the same of_node for both the host
controller device and the adapter which then makes it possible to
enumerate devices behind by just looking adap->dev.of_node. In case of
ACPI we need to know that it's the parent device that we should look for
child devices which may not be true always (like what this patch is
trying to resolve).

> At least, devices in that setup should not be attached to the ACPI PM
> domain.

Agreed.

Currently acpi_dev_pm_attach() only attaches the first physical device
to the ACPI power domain so this should be taken care already.
