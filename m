From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v5 0/4] i2c-core improvements for acpi devices + ACPI
 INT33FE driver
Date: Thu, 13 Apr 2017 12:09:33 -0700
Message-ID: <20170413190933.GA9783@fury>
References: <20170404220335.9815-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404220335.9815-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 05, 2017 at 12:03:31AM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v5 of my patch-set for my i2c-core improvements for acpi
> devices + the ACPI INT33FE platform driver.
> 
> New in this version are some minor fixed to the INT33FE driver.
> 
> The INT33FE driver depends on the i2c-core changes, so if
> it is ok with Darren / Andy I believe it would be best for
> this driver to be merged through the i2c subsys tree (with
> their ack).

Is there an immutable i2c branch I can merge with these changes in order to add
the Cherry Trail driver on top of those?

-- 
Darren Hart
VMware Open Source Technology Center
