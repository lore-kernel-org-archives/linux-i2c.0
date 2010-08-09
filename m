From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [CORRECTED] I2C driver supporting Moorestown and Medfield
 platform
Date: Mon, 9 Aug 2010 12:07:43 +0100
Message-ID: <20100809120743.05e22ef4@linux.intel.com>
References: <20100803143431.23655.31975.stgit@localhost.localdomain>
	<4C5F97AC.1020509@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C5F97AC.1020509-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> hardware/software resources, but IMO, MRST is not easy to imagine
> that it represents "Moorstone".  But this is not such a big deal.

mrst is used all over the place - I'm not familiar with how that came
about originally.

> > + * Copyright (c) 2009 Intel Corporation.
> > + * Copyright (c) 2009 Synopsys. Inc.
> 
> Having a quick glance of the patch, the driver is similar to the
> existing I2C_DESIGNWARE driver.  Presumably Intel people have already
> checkekd the i2c-designware.c and made a decision that it would be
> reasonable to create a new I2C driver to incorporate its requirements
> (such as PCI resource handlings, power management code, etc.), rather
> than to extend the existing one.  Is my understanding correct?
> 
> I'm not objecting to the patch, but would like to know the background
> of this driver, as one of the DW users.

There are various little differences along with the PCI, power
management, timing and configuration side. I've also looked at the two
side by side and agreed with the original Intel authors that it seemed
best to keep it as two drivers. Otherwise you drag a lot of PCI and PCI
pm logic into a simpler driver that is used on non PCI platforms.

Alan
