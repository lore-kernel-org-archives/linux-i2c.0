From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Fri, 6 May 2016 15:20:28 +0300
Message-ID: <20160506122028.GF15974@lahna.fi.intel.com>
References: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160506121249.GP2839@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12119 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758054AbcEFMUd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 6 May 2016 08:20:33 -0400
Content-Disposition: inline
In-Reply-To: <20160506121249.GP2839@codeblueprint.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, May 06, 2016 at 01:12:49PM +0100, Matt Fleming wrote:
> On Wed, 04 May, at 12:27:25PM, Mika Westerberg wrote:
> > Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
> > PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
>  
> [...]
> 
> 
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Given that there are systems shipping with this issue, I think this
> should probably be tagged for -stable too, right?

Right. I'll add that tag as well in v3.
