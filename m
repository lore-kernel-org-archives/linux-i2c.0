From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v2] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Fri, 6 May 2016 13:12:49 +0100
Message-ID: <20160506121249.GP2839@codeblueprint.co.uk>
References: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 04 May, at 12:27:25PM, Mika Westerberg wrote:
> Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
> PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
 
[...]


> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Given that there are systems shipping with this issue, I think this
should probably be tagged for -stable too, right?
