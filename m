From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 06/13] i2c: designware-baytrail: Disallow the CPU to
 enter C6 or C7 while holding the punit semaphore
Date: Tue, 24 Jan 2017 17:48:49 +0100
Message-ID: <c6f21367-c346-d607-4e53-b83ddd07d5fc@redhat.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
 <20170123210958.18410-7-hdegoede@redhat.com>
 <1485251504.2133.296.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdAXQsy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Jan 2017 11:48:54 -0500
In-Reply-To: <1485251504.2133.296.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Hi,

On 01/24/2017 10:51 AM, Andy Shevchenko wrote:
> On Mon, 2017-01-23 at 22:09 +0100, Hans de Goede wrote:
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
>
>
>> Changes in v5:
>> -Update the pm_qos for a latency of 0 *before* requesting the
>> semaphore,
>>  instead of doing it while waiting for the request to be acked
>
> So, that's why you put to reset_semaphore() instead of
> baytrail_i2c_release(), right?

That is why the goto out gets introduced, baytrail_i2c_release()
and reset_semaphore() are functionally equivalent,
baytrail_i2c_release() does a bunch of argument error checking
and then calls reset_semaphore().

Regards,

Hans


> I perhaps missed your answer to my comment about that.
>
>>> @@ -56,6 +57,8 @@ static void reset_semaphore(struct dw_i2c_dev
>>> *dev)
>>  	data &= ~PUNIT_SEMAPHORE_BIT;
>>  	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
>> PUNIT_SEMAPHORE, data))
>>  		dev_err(dev->dev, "iosf failed to reset punit
>> semaphore during write\n");
>> +
>> +	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
>>  }
>
