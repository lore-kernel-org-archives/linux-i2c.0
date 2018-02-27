From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
Date: Tue, 27 Feb 2018 15:02:01 +0530
Message-ID: <b3f7a353-7d04-bdb9-0d68-176c38a0b9a3@caviumnetworks.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
 <20180227090416.gxgof6fyzdeshtmf@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227090416.gxgof6fyzdeshtmf@katana>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: George Cherian <george.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 02/27/2018 02:34 PM, Wolfram Sang wrote:
> On Tue, Feb 27, 2018 at 10:30:31AM +0530, George Cherian wrote:
>> Hi Wolfram,
>>
>> Thanks for the review.
>>
>> On 02/27/2018 01:52 AM, Wolfram Sang wrote:
>>>
>>> On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
>>>> I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
>>>> Essentially the driver should be checking the bus state before sending
>>>> the next transaction.
>>>
>>> Yes.
>>>
>>>> In case the next transaction is initiated while the
>>>> bus is busy, the prior transactions stop condition is not achieved.
>>>
>>> I didn't fully get why you can't check the BUSY bit and wait a little
>>> just before you push out the next message?
>> Yes, I am checking for the BUSY bit and looping.
> 
> Yes, but *after* the STOP, not *before* the next message. I haven't
> fully understood why you don't do this before the next message is about
> to be sent. That might save you some busy looping, or?
Yes, Thanks for the clarification. You are right It is better to
check before next message. I will make required changes and post the patch.
>

Regards
-George
