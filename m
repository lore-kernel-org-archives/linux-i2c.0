From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v5 5/6] i2c: designware-baytrail: Fix race when resetting
 the semaphore
Date: Tue, 10 Jan 2017 15:16:22 +0200
Message-ID: <d07aa4d4-77b5-89c8-948c-046d5d9763f2@linux.intel.com>
References: <20170101201521.12364-1-hdegoede@redhat.com>
 <20170101201521.12364-5-hdegoede@redhat.com>
 <1483349801.9552.187.camel@linux.intel.com>
 <d8525a7d-2363-3065-bc3d-22c7a0553d75@redhat.com>
 <1483351617.9552.192.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25520 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161115AbdAJNQ0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Jan 2017 08:16:26 -0500
In-Reply-To: <1483351617.9552.192.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On 01/02/2017 12:06 PM, Andy Shevchenko wrote:
> On Mon, 2017-01-02 at 10:55 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 02-01-17 10:36, Andy Shevchenko wrote:
>>> On Sun, 2017-01-01 at 21:15 +0100, Hans de Goede wrote:
>>>> Use iosf_mbi_modify instead of iosf_mbi_read + iosf_mbi_write so
>>>> that
>>>> we keep the iosf_mbi_lock locked during the read-modify-write done
>>>> to
>>>> reset the semaphore.
>>>>
>>>
>>> While patch itself looks good to me, I think it reduces a
>>> probability to
>>>  race and doesn't eliminate an issue completely.
>>
>> All accesses through this register are done through the
>> iosf_mbi_ helpers, and the modify helper holds the
>> iosf_mbi_lock during the entire read-modify-wrtie cycle,
>> so I don't see how there can still be any issue left.
>
> Ah, seems you are right.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
