From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Thu, 19 May 2016 13:09:13 +0300
Message-ID: <20160519100913.GO2043@lahna.fi.intel.com>
References: <1463143555-20261-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160519114546.65433c59@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26230 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbcESKKZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 May 2016 06:10:25 -0400
Content-Disposition: inline
In-Reply-To: <20160519114546.65433c59@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, May 19, 2016 at 11:45:46AM +0200, Jean Delvare wrote:
> Hi Mika,
> 
> On Fri, 13 May 2016 15:45:55 +0300, Mika Westerberg wrote:
> > +	if (function == ACPI_READ)
> > +		status = acpi_os_read_port(address, (u32 *)value, bits);
> > +	else
> > +		status = acpi_os_write_port(address, (u32)*value, bits);
> 
> Jeremy McNicoll at RedHat brought to my attention that this may not be
> safe. This assumes that function is either exactly ACPI_READ or exactly
> ACPI_WRITE. However function is a 32-bit bitfield if I understand
> correctly.

In theory, yes.

> Shouldn't it instead be:
> 
> 	if ((function & ACPI_IO_MASK) == ACPI_READ)
>
> as drivers exfldio, acpi_ipmi and i2c-core do? Maybe it makes no
> difference if other bits are never used, but maybe they will be in the
> future.

I'll do another spin with this fixed. Thanks.
