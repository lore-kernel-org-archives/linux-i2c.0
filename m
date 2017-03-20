From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: i2c-mux-pca954x ACPI case
Date: Mon, 20 Mar 2017 18:04:33 +0200
Message-ID: <1490025873.19767.119.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32533 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754187AbdCTQFu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Mar 2017 12:05:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>, Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

The commit bbf9d262a147aeaeee0bf4e1c121166d69e556d4 ("i2c: mux: pca954x:
Add ACPI support for pca954x") adds a so called "ACPI support" for the
driver and thus I have few questions (besides obvious typo in it):

0. Had it ever been tested?
1. Is there *real* DSDT / registered ACPI IDs for a such device(s)?
2. If "yes" on 1, can you provide Documentation with *real* DSDT
excerpt?

If the answer is "no" on 2, I'm about to revert this, because
ACPI is *not* like Device Tree chaotic mess. Any ID, property and
related stuff *must* be officially registered and carefully chosen.

To maintainers of the drivers, including but not limited to I2C
subsystem, please, Cc ACPI guys (Rafael, Mika, me, etc) *before*
applying any ACPI IDs if there no clear and *real* DSDT excerpt.

It's disregard if this case (pca954x) valid or not.

Thank you for understanding.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
