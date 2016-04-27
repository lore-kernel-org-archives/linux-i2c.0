From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Wed, 27 Apr 2016 10:47:11 +0300
Message-ID: <57206E7F.5000603@linux.intel.com>
References: <5707B9B4.6020402@alitech.com>
 <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
 <571E04BA.3030301@linux.intel.com> <571E320F.1020607@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571E320F.1020607@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, Christian Ruppert <christian.ruppert@alitech.com>
List-Id: linux-i2c@vger.kernel.org

On 04/25/2016 06:04 PM, Lucas De Marchi wrote:
>
>
> On 04/25/2016 08:51 AM, Jarkko Nikula wrote:
>
> [ ... ]
>
>>> @@ -413,8 +416,16 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
>>> *dev)
>>>       struct i2c_msg *msgs = dev->msgs;
>>>       u32 ic_con, ic_tar = 0;
>>>
>>> -    /* Disable the adapter */
>>> -    __i2c_dw_enable(dev, false);
>>> +    if (dev->enabled) {
>>> +        u32 ic_status;
>>> +
>>> +        /* check ic_tar and ic_con can be dynamically updated */
>>> +        ic_status = dw_readl(dev, DW_IC_STATUS);
>>> +        if (ic_status & DW_IC_STATUS_ACTIVITY
>>> +            || !(ic_status & DW_IC_STATUS_TX_EMPTY)) {
>>> +            __i2c_dw_enable(dev, false);
>>> +        }
>>> +    }
>>>
>> Worth to double check this. I see bit 1 means TX FIFO not full and bit 2
>> is TX FIFO completely empty.
>
> the conditions to be able to update IC_TAR dynamically are:
>
>    - Adapter isn't doing any TX/RX operation (IC_STATUS[5] == 0) and
>    - There are no entries in TX FIFO (IC_STATUS[2] == 1)
>
> So... yeah, the condition above seems wrong. I should be reading bit 5,
> not bit 1. Thanks! However:
>
It reads above, bit 2 instead of 1 for TX FIFO checking and then either 
bit 5 or 0 for activity checking.

I'd say it's probably better to check bit 5 instead of bit 0 even bit 0 
is or'ed from bits 5 and 6. I don't know how possible slave support and 
slave being active will play here so it's best to follow spec.

-- 
jarkko
