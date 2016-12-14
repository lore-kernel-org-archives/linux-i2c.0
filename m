From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH V4] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Wed, 14 Dec 2016 10:59:08 +0200
Message-ID: <3ee59b87-f497-2a26-8f67-10464d55aa84@linux.intel.com>
References: <1481623414-19220-1-git-send-email-tnhuynh@apm.com>
 <1481628337.7188.63.camel@linux.intel.com>
 <CANQ9TuCuxsMKzfQ=14ppo-5kWnWXc=VK08ca7+dJL2xG_tkd_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANQ9TuCuxsMKzfQ=14ppo-5kWnWXc=VK08ca7+dJL2xG_tkd_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>
List-Id: linux-i2c@vger.kernel.org

On 12/14/2016 05:20 AM, Tin Huynh wrote:
> On Tue, Dec 13, 2016 at 6:25 PM, Andy Shevchenko
>>> +     param = i2c_dw_read_comp_param(dev);
>>> +     tx_fifo_depth = ((param >> 16) & 0xff) + 1;
>>> +     rx_fifo_depth = ((param >> 8)  & 0xff) + 1;
>>> +     if (!dev->tx_fifo_depth) {
>>> +             dev->tx_fifo_depth = tx_fifo_depth;
>>> +             dev->rx_fifo_depth = rx_fifo_depth;
>>> +             dev->adapter.nr = id;
>>> +     } else if (tx_fifo_depth > 1) {
>>
>> This makes sense now, though I would add a comment here and use >= 2 to
>> reflect datasheet.
>>
>>                 /*
>>                  * Choose minimum values between HW and interface
>>                  * driver provided.
>>                  */
>>
> I will implement as your comment. However , because adding 1 to the
> value , can i use > 2  or >=3 ?

either > 1 or >= 2 since register value 0x01 from HW means FIFO depth 2 
and register value 0x00 is reserved.

-- 
Jarkko
