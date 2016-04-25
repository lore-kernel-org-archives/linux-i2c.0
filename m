From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Mon, 25 Apr 2016 12:04:47 -0300
Message-ID: <571E320F.1020607@intel.com>
References: <5707B9B4.6020402@alitech.com>
 <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
 <571E04BA.3030301@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50695 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459AbcDYPEv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 11:04:51 -0400
In-Reply-To: <571E04BA.3030301@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, Christian Ruppert <christian.ruppert@alitech.com>



On 04/25/2016 08:51 AM, Jarkko Nikula wrote:

[ ... ]

>> @@ -413,8 +416,16 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>>       struct i2c_msg *msgs = dev->msgs;
>>       u32 ic_con, ic_tar = 0;
>>
>> -    /* Disable the adapter */
>> -    __i2c_dw_enable(dev, false);
>> +    if (dev->enabled) {
>> +        u32 ic_status;
>> +
>> +        /* check ic_tar and ic_con can be dynamically updated */
>> +        ic_status = dw_readl(dev, DW_IC_STATUS);
>> +        if (ic_status & DW_IC_STATUS_ACTIVITY
>> +            || !(ic_status & DW_IC_STATUS_TX_EMPTY)) {
>> +            __i2c_dw_enable(dev, false);
>> +        }
>> +    }
>>
> Worth to double check this. I see bit 1 means TX FIFO not full and bit 2
> is TX FIFO completely empty.

the conditions to be able to update IC_TAR dynamically are:

   - Adapter isn't doing any TX/RX operation (IC_STATUS[5] == 0) and
   - There are no entries in TX FIFO (IC_STATUS[2] == 1)

So... yeah, the condition above seems wrong. I should be reading bit 5, 
not bit 1. Thanks! However:

IC_STATUS[5] signals activity for master mode
IC_STATUS[6] signals activity for slave mode
IC_STATUS[0] is IC_STATUS[5]|IC_STATUS[6]

And this controller is never in slave mode, only master mode, so it 
should be equivalent.

I wonder if I even have to check bit 5 since AFAICS we wouldn't be able 
to even call this function if there were any operation on tx/rx.

>
> Otherwise I'm fine with the patch as long as it works for Christian.
>

Anyway, I'll re-test with bit 5 checked and send an update.


Lucas De Marchi
