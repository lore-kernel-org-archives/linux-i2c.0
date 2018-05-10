From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Date: Thu, 10 May 2018 15:36:21 +0200
Message-ID: <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510111658.sxf3mvye5q6ihxa7@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-05-10 13:16, Wolfram Sang wrote:
> On Sat, May 05, 2018 at 08:02:21AM -0500, Wenwen Wang wrote:
>> In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
>> transfer i2c messages. The number of actual transferred messages is
>> returned and saved to 'status'. If 'status' is negative, that means an
>> error occurred during the transfer process. In that case, the value of
>> 'status' is an error code to indicate the reason of the transfer failure.
>> In most cases, i2c_transfer() can transfer 'num' messages with no error.
>> And so 'status' == 'num'. However, due to unexpected errors, it is probable
>> that only partial messages are transferred by i2c_transfer(). As a result,
>> 'status' != 'num'. This special case is not checked after the invocation of
>> i2c_transfer() and can potentially lead to unexpected issues in the
>> following execution since it is expected that 'status' == 'num'.
>>
>> This patch checks the return value of i2c_transfer() and returns an error
>> code -EIO if the number of actual transferred messages 'status' is not
>> equal to 'num'.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> 
> Applied to for-current, thanks!
> 

I meant to comment here but got side-tracked and never got around to it.
But see e.g. [1] and [2] for drivers that will not be happy with this
change. Maybe there are more of those? I did a scan of the drivers in
algos/ and busses/, but there are drivers all over the tree that
implements .master_xfer that I have not audited. Who knows what further
problems this patch will reveal? So, maybe we should be a bit
conservative and only WARN as a first step?

Yes, I know that I suggested this, sorry for not following up with this
in a more timely fashion...

Cheers,
Peter

[1] https://lkml.org/lkml/2018/5/9/871
[2] https://lkml.org/lkml/2018/5/9/877

PS. Also busses/i2c-rcar.c seems like it might return a short "success"
for some sequence of events. But I'm not sure about that one...
