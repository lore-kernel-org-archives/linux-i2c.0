From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 4/5] i2c: designware-baytrail: Disallow the CPU to
 enter C6 or C7 while holding the punit semaphore
Date: Tue, 13 Dec 2016 15:42:54 +0200
Message-ID: <6dc5a59d-4dc8-cab7-15f5-48e36ebcc337@linux.intel.com>
References: <20161212215612.9262-1-hdegoede@redhat.com>
 <20161212215612.9262-4-hdegoede@redhat.com>
 <1481622976.7188.60.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933013AbcLMNpJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Dec 2016 08:45:09 -0500
In-Reply-To: <1481622976.7188.60.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On 12/13/2016 11:56 AM, Andy Shevchenko wrote:
> On Mon, 2016-12-12 at 22:56 +0100, Hans de Goede wrote:
>> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
>> repeated
>> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
>> in
>> 1 - 3 runs guaranteed.
>>
>> This seems to be causes by the cpu trying to enter C6 or C7 while we
>> hold
>> the punit bus semaphore, at which point everything just hangs.
>>
>> Avoid this by disallowing the CPU to enter C6 or C7 before acquiring
>> the
>> punit bus semaphore.
>>
>
> Just a nitpick for abbreviations: pmic -> PMIC, punit -> P-Unit, but I'm
> okay with the contents which is more important.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
No need for v5 from my side either (Andy agreed it later in the thread)

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109051
>
> What would be good is to have comments / tags from Len and Ville.
>
We can have also follow up patch if some other PM QoS acrobatics are 
required than what's implemented here. Getting real bug fixed is quite 
big benefit.
