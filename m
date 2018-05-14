From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/2] i2c: core-smbus: fix a potential uninitialization
 bug
Date: Mon, 14 May 2018 22:31:07 +0200
Message-ID: <ac843580-884e-b0fc-60af-8d73ba099100@axentia.se>
References: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
 <20180510111737.b6g7s2nnf6froote@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510111737.b6g7s2nnf6froote@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-05-10 13:17, Wolfram Sang wrote:
> On Sat, May 05, 2018 at 07:57:10AM -0500, Wenwen Wang wrote:
>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>> which are used to save a series of messages, as mentioned in the comment.
>> According to the value of the variable 'size', msgbuf0 is initialized to
>> various values. In contrast, msgbuf1 is left uninitialized until the
>> function i2c_transfer() is invoked. However, msgbuf1 is not always
>> initialized on all possible execution paths (implementation) of
>> i2c_transfer(). Thus, it is possible that msgbuf1 may still be
>> uninitialized even after the invocation of the function i2c_transfer(),
>> especially when the return value of ic2_transfer() is not checked properly.
>> In the following execution, the uninitialized msgbuf1 will be used, such as
>> for security checks. Since uninitialized values can be random and
>> arbitrary, this will cause undefined behaviors or even check bypass. For
>> example, it is expected that if the value of 'size' is
>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>> value read from msgbuf1 is assigned to data->block[0], which can
>> potentially lead to invalid block write size, as demonstrated in the error
>> message.
>>
>> This patch initializes the first byte of msgbuf1 with 0 to avoid such
>> undefined behaviors or security issues.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> 
> From what I can tell, this patch is not needed anymore after patch 2 is
> applied. Correct?

AFAIU, it is only needed if there are bugs elsewhere. I.e. it's for extra
protection. If all drivers implement .master_xfer correctly, msgbuf1 will
be filled in and the return value will be the number of messages (i.e. 2)
OR you get a negative return value and the msgbuf1 content will not matter.

The patch does not magically fix all possible driver bugs, so in that
sense this patch is still "needed".

Also - again AFAIU - there is no known bug that actually gets caught by
this extra check.

Cheers,
Peter
