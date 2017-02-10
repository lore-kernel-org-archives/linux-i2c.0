From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] i2c: designware: Fix regression when dynamic TAR update
 is disabled
Date: Fri, 10 Feb 2017 13:38:37 +0700
Message-ID: <110f9081-ddba-82c2-6ba3-f92bc36d0bc3@amd.com>
References: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
 <1486670858.2133.436.camel@linux.intel.com>
 <1486676048.14478.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486676048.14478.4.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "Nehal-Bakulchandra.Shah@amd.com" <Nehal-Bakulchandra.Shah@amd.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>
List-Id: linux-i2c@vger.kernel.org



On 2/10/17 04:34, De Marchi, Lucas wrote:
> On Thu, 2017-02-09 at 22:07 +0200, Andy Shevchenko wrote:
>> On Fri, 2017-02-10 at 01:20 +0530, Shah Nehal-Bakulchandra wrote:
>>> The following commit causes a regression when dynamic TAR update is
>>> disabled:
>>>
>>>      commit 63d0f0a6952a1a02bc4f116b7da7c7887e46efa3 ("i2c:
>>> designware:
>>>      detect when dynamic tar update is possible")
>>
>> Please, leave just 12 characters, it still enough.
>>
>>> In such case, the DW_IC_CON_10BITADDR_MASTER is R/W, and is changed
>>> by the logic that's trying to detect  dynamic TAR update.The original
>>> value of DW_IC_CON_10BITADDR_MASTER bit should be restored.
>
> You are right, thanks for the fix.  This may also explains why
> 0317e6c (i2c: designware: do not disable adapter after transfer) caused problems
> and ended up being reverted.  Could you try that on your hardware?

After looking at the patch (i2c: designware: do not disable adapter after transfer),
we see that it modifies the i2c_dw_xfer_init(). However, this function is never
called on our platform. So, this patch would not have any effects.

At this points, my understanding is there are probably two options here:

1) Keep the commit 63d0f0a6952a (i2c: designware: detect when dynamic tar update
    is possible) and apply V2 of this patch in 4.10. We might need to back-port the change
    to v4.9 stable as well.

2) Revert the 63d0f0a6952a (i2c: designware: detect when dynamic tar update is possible) in 4.10,
    and also in v4.9 stable as well.

Thanks,
Suravee

> The dynamic tar update detection was only done as preparation work to allow not
> disabling the adapter, which is reverted.  We may also just revert this commit
> instead of fixing the logic.
>
>
> thanks
> Lucas De Marchi
>
