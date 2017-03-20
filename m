From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c-mux-pca954x ACPI case
Date: Mon, 20 Mar 2017 17:38:09 +0100
Message-ID: <7a78677b-3a43-f30f-33c4-0086da38ef72@axentia.se>
References: <1490025873.19767.119.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0138.outbound.protection.outlook.com ([104.47.1.138]:20448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754417AbdCTQil (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Mar 2017 12:38:41 -0400
In-Reply-To: <1490025873.19767.119.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tin Huynh <tnhuynh@apm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 2017-03-20 17:04, Andy Shevchenko wrote:
> The commit bbf9d262a147aeaeee0bf4e1c121166d69e556d4 ("i2c: mux: pca954x:
> Add ACPI support for pca954x") adds a so called "ACPI support" for the
> driver and thus I have few questions (besides obvious typo in it):
> 
> 0. Had it ever been tested?
> 1. Is there *real* DSDT / registered ACPI IDs for a such device(s)?
> 2. If "yes" on 1, can you provide Documentation with *real* DSDT
> excerpt?
> 
> If the answer is "no" on 2, I'm about to revert this, because
> ACPI is *not* like Device Tree chaotic mess. Any ID, property and
> related stuff *must* be officially registered and carefully chosen.
> 
> To maintainers of the drivers, including but not limited to I2C
> subsystem, please, Cc ACPI guys (Rafael, Mika, me, etc) *before*
> applying any ACPI IDs if there no clear and *real* DSDT excerpt.
> 
> It's disregard if this case (pca954x) valid or not.
> 
> Thank you for understanding.

Hi Andy,

I have no idea if PCA9540 etc are valid DSDT entries. Going forward,
I will Cc: ACPI people before taking ACPI patches. Sorry for the
inconvenience and sorry for my ignorance.

But before reverting, let's give Tin a chance to speak up...

Cheers,
peda
