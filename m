From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 0/3] i2c: Hookup typec power-negotation to the PMIC and
 charger
Date: Mon, 4 Sep 2017 15:33:22 +0200
Message-ID: <be26a8cd-e089-0997-2438-5f12ecd02988@redhat.com>
References: <20170903124156.7440-1-hdegoede@redhat.com>
 <20170904045645.fb6scegrypdodvfl@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752835AbdIDNdZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Sep 2017 09:33:25 -0400
In-Reply-To: <20170904045645.fb6scegrypdodvfl@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On 04-09-17 06:56, Wolfram Sang wrote:
> Hi,
> 
>> The first 2 patches are i2c patches, if you could review and
>> merge these (preferably for 4.14, but 4.15 is fine too) that would
>> be great.
> 
> Definately for v4.15 and I very likely won't be able to review them
> before rc1 or rc2 time, if even that. Sorry, but I2C core changes need
> extra careful review and I2C maintenance is largely done in my limited
> spare time.

Ok, I understand.

> If you could get other people to review/tag the patches,
> this would be very helpful.

FWIW althought the first patch is a core change it is not really a big
one and won't impact any existing drivers, but I fully understand
you still want to take your time to review it.

Andy (Shevchenko) can you perhaps take a look at the first patch
in this series and give your opinion on it ?

>> Darren, Andy, the single platform/x86 patch in here should only
>> be merged after the 2 i2c patches are in place, otherwise users
>> of the board(s) in question will end up not having any battery
>> monitoring. Also note that this patch applies on top of the
>> "[PATCH v2] platform/x86: intel_cht_int33fe: Work around BIOS bug on some devices"
>> patch I send out yesterday.
> 
> Is that dependency for v4.14?

Yes that dep should make 4.14.

> Would it be an idea if I take the platform
> patch via the i2c tree then?

I've some other patches pending which require further changes to the
intel_cht_int33fe driver (*), so I think it would be best if the last
patch got merged through the platform/x86 tree. The dependencies
between patch 2-3 are runtime only (and not fatal if missing, just
inconvenient) so merging this to 2 separate trees should be fine
as long as both patches get merged for 4.15.

Regards,

Hans


*) The intel_cht_int33fe and i2c/busses/i2c-cht-wc drivers together
instantiate 4 i2c devices which together make all the "magic" behind
the Type-C connector on these boards happen. The patch-series
completed by these 3 patches ties 3 of the 4 drivers together so
that charging and battery monitoring fully works. Ideally all 4
i2c-clients would be instantiated from a single place, e.g.
intel_cht_int33fe.c, but the charger is hooked up through a "child"
i2c bus on the pmic, which is where i2c/busses/i2c-cht-wc.c
comes into play.

The next series adds support for the 4th chip, the type-c cross-switch/
mux which is necessary to get superspeed usb and/or displayport working
over the Type-C connector.
