From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/7] i2c: designware-baytrail: Take punit lock on bus
 acquire
Date: Sun, 15 Jan 2017 16:11:03 +0100
Message-ID: <84cabe1f-1129-19b9-f0ed-6ec5f189bb29@redhat.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
 <20170108134427.8392-4-hdegoede@redhat.com>
 <20170112184545.sejbzawnesu6zj5i@ninjato>
 <5aa8a3ab-a527-1f3b-0cf6-92fd4691ddc8@redhat.com>
 <20170115114529.jxwcadse23gdykx5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbdAOPLI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 15 Jan 2017 10:11:08 -0500
In-Reply-To: <20170115114529.jxwcadse23gdykx5@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Hi,

On 15-01-17 12:45, Wolfram Sang wrote:
> Hi Hans,
>
>> So Wolfram, what is the plan with these ? As said they are necessary
>> for the 2 i2c patches in this patch-set, so do you want the
>> entire set of 8 i2c patches to go through an other tree to avoid
>> inter tree dependencies ?
>
> Thanks for the heads up. So, my plan was that I send a pull request for
> 4.10 any minute now, and start pulling in patches for 4.11 based on
> shiny new rc4 from tomorrow on. And your series would have been one of
> the fist to get merged because I think it is ready.
>
> Reading this though, my feeling is now that it should be merged via some
> other tree so you can get these nasty issues fixed without too many
> dependencies. An immutable branch for me to pull in would be great,
> though.
>
> Makes sense?

Sounds fine to me, step one is to get consensus on how to deal with
coordinating the kernel directly accessing to the pmic-i2c-bus vs punit
accesses which also end up needing to use the same i2c-bus from the
punit side.

Once I've a patch-set everyone likes I will start talking to people
to coordinate the merging, I believe it is probably best for all this
to be merged through the drm-intel tree. But we'll see about that
when the patch-set is ready.

Regards,

Hans
