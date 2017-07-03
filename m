From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI
 devices
Date: Mon, 03 Jul 2017 18:48:54 +0300
Message-ID: <1499096934.22624.241.camel@linux.intel.com>
References: <20170701100311.11859-1-hdegoede@redhat.com>
         <1499080212.22624.237.camel@linux.intel.com>
         <3a2b63d6-d88e-aae8-d8a1-a6203a8e971e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25532 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752312AbdGCPs6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Jul 2017 11:48:58 -0400
In-Reply-To: <3a2b63d6-d88e-aae8-d8a1-a6203a8e971e@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org

On Mon, 2017-07-03 at 17:04 +0200, Hans de Goede wrote:
> On 03-07-17 13:10, Andy Shevchenko wrote:
> > On Sat, 2017-07-01 at 12:03 +0200, Hans de Goede wrote:

> > > This commit makes the i2c-core ignore LNXVIDEO compatible ACPI
> > > devices
> > > which has 2 positive results:
> > > 
> > > 1) The bogus i2c-client for these is no longer created.
> > > 2) i2c_acpi_lookup_speed now ignores the 100KHz speed from the
> > > pseudo
> > > i2c-resouce and properly returns 400KHz as speed for the
> > > touchscreen
> > > i2c bus, fixing the touchscreen not working on various devies.
> > 
> > Should it have Fixes tag?
> 
> Well it is a fix, but it does not fix one specific commit, so no
> I don't think it should.

One may put several Fixes tags to make it clear that it applies on top
of the tree that has all of them (in the given sequence AFAIR).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
