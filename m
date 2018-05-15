From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Date: Tue, 15 May 2018 12:36:50 +0200
Message-ID: <87286831-408c-b542-46e9-fe8aba151d5f@axentia.se>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
 <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
 <20180515085833.4z4cvsxoqqbny53q@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515085833.4z4cvsxoqqbny53q@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-05-15 10:58, Wolfram Sang wrote:
> Hi Peter,
> 
>>>> In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
>>>> transfer i2c messages. The number of actual transferred messages is
>>>> returned and saved to 'status'. If 'status' is negative, that means an
>>>> error occurred during the transfer process. In that case, the value of
>>>> 'status' is an error code to indicate the reason of the transfer failure.
>>>> In most cases, i2c_transfer() can transfer 'num' messages with no error.
>>>> And so 'status' == 'num'. However, due to unexpected errors, it is probable
>>>> that only partial messages are transferred by i2c_transfer(). As a result,
>>>> 'status' != 'num'. This special case is not checked after the invocation of
>>>> i2c_transfer() and can potentially lead to unexpected issues in the
>>>> following execution since it is expected that 'status' == 'num'.
>>>>
>>>> This patch checks the return value of i2c_transfer() and returns an error
>>>> code -EIO if the number of actual transferred messages 'status' is not
>>>> equal to 'num'.
>>>>
>>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>>
>>> Applied to for-current, thanks!
>>>
>>
>> I meant to comment here but got side-tracked and never got around to it.
>> But see e.g. [1] and [2] for drivers that will not be happy with this
>> change. Maybe there are more of those? I did a scan of the drivers in
>> algos/ and busses/, but there are drivers all over the tree that
>> implements .master_xfer that I have not audited. Who knows what further
>> problems this patch will reveal? So, maybe we should be a bit
>> conservative and only WARN as a first step?
> 
> I came to the conclusion: yes and no.
> 
> I think this patch is correct, so it is good to have. But true, it will
> expose if other drivers have implemented the return value wrongly. So, I
> removed this patch from for-current and plan to include it in for-next
> instead if we can agree on that being a good way forward. That will
> allow for one full cycle of testing and fixing the issues found. And
> hopefully I have time to write a small coccinelle rule to find if
> constant values are returned in a function declared as master_xfer.

That would be a good thing. Maybe a long term goal is to simply return
zero on success for .master_xfer, because currently the only expected
success value is the number of messages sent, but the caller is in all
likelihood already aware of that count, so it all seems rather like
something that is just pointless and easy to get wrong...

>> PS. Also busses/i2c-rcar.c seems like it might return a short "success"
>> for some sequence of events. But I'm not sure about that one...
> 
> What do you mean with "short success for some sequence" here?

By "short" I mean not all requested messages transferred. By "success"
I mean non-negative.

I.e. when I look at rcar_i2c_master_xfer(), it sets things up for all
messages to be transferred, starts things off and waits for completion
(or timeout). But the driver is too involved for it to be easy to say
that either all messages are transferred or a negative error is
returned. I never managed to see that anyway.

And the function has that "ret = num - priv->msgs_left;" statement
indicating that whomever wrote it thought it perfectly ok to return
such a "short success" (which noone is expecting).

So, I'm simply uncertain about that .master_xfer implementation, that's
all.

Cheers,
Peter
