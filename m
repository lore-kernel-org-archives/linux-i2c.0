From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created
 via i2c_acpi_new_device()
Date: Wed, 21 Nov 2018 16:15:22 +0200
Message-ID: <20181121141522.GA16476@kuha.fi.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
 <c2ad13ad-cf27-2700-a051-4dda56755ebd@redhat.com>
 <20181121133549.GL10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121133549.GL10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi guys,

On Wed, Nov 21, 2018 at 03:35:49PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 21, 2018 at 12:44:27PM +0100, Hans de Goede wrote:

> > I see 2 possible solutions here:
> > 
> > 1) Changing this patch so that i2c_acpi_new_device() does:
> > 
> >         /*
> >          * The fwnode can not be shared between instantiated clients when
> >          * adding device-properties to the instantiated client.
> >          */
> > 	if (!info->properties)
> > 		info->fwnode = acpi_fwnode_handle(adev);
> > 
> > 2) Leave whether info->fwnode should be set or not up to the
> > caller of i2c_acpi_new_device() (info is already passed in as
> > a param). E.g. i2c-multi-instantiate.c could do this (for now,
> > maybe in the future we will also want to add properties for
> > some HIDs).
> > 
> > I think that 1. is the best solution and this is all kernel internal,
> > so we can always revisit this if necessary.
> 
> Heikki told me he has some ideas, but for now I will drop this patch.

I think the only thing that we can do is to assign the ACPI node as the
secondary node to this kind of mfd "cells". It would most likely
require some changes to the apci code in Linux kernel, probable
nothing major, but no driver needs this for now (I think), so we don't
need to worry about it right now.


thanks,

-- 
heikki
