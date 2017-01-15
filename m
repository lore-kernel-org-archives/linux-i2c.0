From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/7] i2c: designware-baytrail: Take punit lock on bus
 acquire
Date: Sun, 15 Jan 2017 12:21:58 +0100
Message-ID: <5aa8a3ab-a527-1f3b-0cf6-92fd4691ddc8@redhat.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
 <20170108134427.8392-4-hdegoede@redhat.com>
 <20170112184545.sejbzawnesu6zj5i@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbdAOLWD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 15 Jan 2017 06:22:03 -0500
In-Reply-To: <20170112184545.sejbzawnesu6zj5i@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Hi,

On 12-01-17 19:45, Wolfram Sang wrote:
> On Sun, Jan 08, 2017 at 02:44:23PM +0100, Hans de Goede wrote:
>> Take the punit lock to stop others from accessing the punit while the
>> pmic i2c bus is in use. This is necessary because accessing the punit
>> from the kernel may result in the punit trying to access the pmic i2c
>> bus, which results in a hang when it happens while we own the pmic i2c
>> bus semaphore.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Tested-by: tagorereddy <tagore.chandan@gmail.com>
>
> I don't think the I2C patches need to go via I2C tree, so:
>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Note that as mentioned in the cover-letter, these 2 i2c patches depend
on these:

https://patchwork.ozlabs.org/patch/710067/
https://patchwork.ozlabs.org/patch/710068/
https://patchwork.ozlabs.org/patch/710069/
https://patchwork.ozlabs.org/patch/710070/
https://patchwork.ozlabs.org/patch/710071/
https://patchwork.ozlabs.org/patch/710072/

Which all have many reviews / acks. Given the race between i915
and designware-i2c opened up by the last patch in this series
these not having been merged yet is a good thing, but patch 1-5
are ready for merging.

So Wolfram, what is the plan with these ? As said they are necessary
for the 2 i2c patches in this patch-set, so do you want the
entire set of 8 i2c patches to go through an other tree to avoid
inter tree dependencies ?

And if so, can we then have you're Acked-by for the 6 above too ?

Regards,

Hans
