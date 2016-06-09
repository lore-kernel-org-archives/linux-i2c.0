From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Thu, 9 Jun 2016 11:15:46 +0300
Message-ID: <20160609081546.GA1791@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55257 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbcFIIPw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 04:15:52 -0400
Content-Disposition: inline
In-Reply-To: <20160608162913.GA24234@mail.corp.redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 08, 2016 at 06:29:13PM +0200, Benjamin Tissoires wrote:
> > -	err = acpi_check_resource_conflict(&dev->resource[SMBBAR]);
> > -	if (err) {
> > +	err = i801_acpi_probe(priv);
> > +	if (err)
> >  		return -ENODEV;
> > -	}
> 
> I'd say that once this has been set, we need to call
> acpi_remove_address_space_handler() in case of failure later (in the 2
> returns after).

Indeed - I wonder how many mistakes one patch can contain :-(

Let me fix this and submit yet another version.

> The rest looks OK to me.

Thanks!
