From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next][V2] i2c: xiic: fix indentation issue
Date: Tue, 28 Jan 2020 23:10:59 +0000
Message-ID: <3b287fb5-e344-c13a-2803-09c2958b9b0d@canonical.com>
References: <20200127102303.44133-1-colin.king@canonical.com>
 <2dd84ab2-a7a3-fdd8-6bd6-07f1b3d5cd00@xilinx.com>
 <20200127120535.GC1847@kadam>
 <89661e5e-7662-81a5-ec36-57367825de5e@canonical.com>
 <35ed6501-3b26-36a9-d332-d4ed3366ebd8@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35ed6501-3b26-36a9-d332-d4ed3366ebd8@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Dan Carpenter <dan.carpenter@oracle.com>, Michal Simek <michal.simek@xilinx.com>, Johan Hovold <johan@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 28/01/2020 21:45, Peter Rosin wrote:
> On 2020-01-27 13:08, Colin Ian King wrote:
>> On 27/01/2020 12:05, Dan Carpenter wrote:
>>> On Mon, Jan 27, 2020 at 12:03:02PM +0100, Michal Simek wrote:
>>>> On 27. 01. 20 11:23, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> There is a statement that is indented one level too deeply, remove
>>>>> the extraneous tab.
>>>>>
>>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>>> ---
>>>>> V2: fix type in commit message
>>>>> ---
>>>>>  drivers/i2c/busses/i2c-xiic.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
>>>>> index b17d30c9ab40..90c1c362394d 100644
>>>>> --- a/drivers/i2c/busses/i2c-xiic.c
>>>>> +++ b/drivers/i2c/busses/i2c-xiic.c
>>>>> @@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
>>>>>  		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
>>>>>  		if (time_after(jiffies, timeout)) {
>>>>>  			dev_err(i2c->dev, "Failed to clear rx fifo\n");
>>>>> -				return -ETIMEDOUT;
>>>>> +			return -ETIMEDOUT;
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>>
>>>>
>>>> As was suggested by Peter you should also add Fixes: <sha1> ("patch
>>>> subject")
>>>>
>>>
>>> It's not really a bugfix, it's just a cleanup.
>>
>> I'm surprised i wasn't asked for a bug number too.
> 
> Very funny.

Apologies for being flippant. I didn't mean to offend. My bad #1.

> 
> I realize that you, the three complainers (Johan, Dan and Colin), together
> have almost 10000 commits. So, I feel a bit outranked.
> 
> However, this ridicule is unfair.
> 
> The problem here is that Colin sent a v2, ignoring my suggestion to add
> a fixes-tag without mentioning that my suggestion was in fact ignored
> (and why). That is a sure way to invite someone else to point out what
> seemed like an omission. Which happened. And then this farce ensued.

I can only apologize for not adding the fixes tag because I honestly
didn't see the fixes tag request until after the follow-ups. I didn't
indent to rile anyone on this and I didn't want to offend anyone by
purposely ignoring their requires. My bad #2.

> 
> So, Colin, take a long look in the mirror and direct your sarcasm in
> whatever direction you feel appropriate.

I did. And I was wrong. My bad #3.

> 
> I also maintain that noone writes code like this on purpose (at least
> not without some ulterior motive). This is the kind of stuff that cause
> problems and wastes time later when someone mis-reads the code. You three
> people, with all those commits, should know that. My point is that this
> is more than just cleanup and is indeed fixing a bug. Claiming otherwise
> is just silly. The compiler is not the only consumer of the code.

Whatever is needed to get fixes into the kernel. Some say it's a bug,
others don't. As long as it's fixed then I'm happy.  If in the process I
did the wrong thing I can only apologize profoundly and profusely.

Colin


> 
> Cheers,
> Peter
> 
