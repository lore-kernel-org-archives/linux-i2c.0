From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Fri, 6 May 2016 11:55:07 +0300
Message-ID: <20160506085507.GD15974@lahna.fi.intel.com>
References: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
 <2682382.6cA2VZCBS9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9452 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbcEFIzN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 6 May 2016 04:55:13 -0400
Content-Disposition: inline
In-Reply-To: <2682382.6cA2VZCBS9@vostro.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, May 04, 2016 at 10:04:40PM +0200, Rafael J. Wysocki wrote:
> > +	mutex_lock(&priv->acpi_lock);
> > +	if (priv->acpi_reserved) {
> > +		mutex_unlock(&priv->acpi_lock);
> > +		return -EPERM;
> 
> I'd return -EIO from here as that's what it looks like from the caller's perspective.

I can change that in v3 as I need to add reported-by and bugzilla links,
which I forgot, to the patch as well.

> That's not a big deal, though, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
