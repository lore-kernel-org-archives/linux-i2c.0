From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: i2c-mux-pca954x ACPI case
Date: Tue, 21 Mar 2017 14:18:23 +0200
Message-ID: <1490098703.19767.120.camel@linux.intel.com>
References: <1490025873.19767.119.camel@linux.intel.com>
         <7a78677b-3a43-f30f-33c4-0086da38ef72@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:60221 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756437AbdCUMS1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 08:18:27 -0400
In-Reply-To: <7a78677b-3a43-f30f-33c4-0086da38ef72@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Tin Huynh <tnhuynh@apm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Mon, 2017-03-20 at 17:38 +0100, Peter Rosin wrote:
> On 2017-03-20 17:04, Andy Shevchenko wrote:
> > The commit bbf9d262a147aeaeee0bf4e1c121166d69e556d4 ("i2c: mux:
> > pca954x:
> > Add ACPI support for pca954x") adds a so called "ACPI support" for
> > the
> > driver and thus I have few questions (besides obvious typo in it):
> > 
> > 0. Had it ever been tested?
> > 1. Is there *real* DSDT / registered ACPI IDs for a such device(s)?
> > 2. If "yes" on 1, can you provide Documentation with *real* DSDT
> > excerpt?
> > 
> > If the answer is "no" on 2, I'm about to revert this, because
> > ACPI is *not* like Device Tree chaotic mess. Any ID, property and
> > related stuff *must* be officially registered and carefully chosen.
> > 
> > To maintainers of the drivers, including but not limited to I2C
> > subsystem, please, Cc ACPI guys (Rafael, Mika, me, etc) *before*
> > applying any ACPI IDs if there no clear and *real* DSDT excerpt.
> > 
> > It's disregard if this case (pca954x) valid or not.
> > 
> > Thank you for understanding.
> 
> Hi Andy,
> 
> I have no idea if PCA9540 etc are valid DSDT entries. Going forward,
> I will Cc: ACPI people before taking ACPI patches. Sorry for the
> inconvenience and sorry for my ignorance.

Thank you, Peter.

> But before reverting, let's give Tin a chance to speak up...

Of course! That's why I wrote this message beforehand.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
