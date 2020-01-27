From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH][next][V2] i2c: xiic: fix indentation issue
Date: Mon, 27 Jan 2020 13:11:28 +0100
Message-ID: <3b71a397-3539-1081-54e0-a7b63bc9ed26@xilinx.com>
References: <20200127102303.44133-1-colin.king@canonical.com>
 <2dd84ab2-a7a3-fdd8-6bd6-07f1b3d5cd00@xilinx.com>
 <20200127120535.GC1847@kadam>
 <89661e5e-7662-81a5-ec36-57367825de5e@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89661e5e-7662-81a5-ec36-57367825de5e@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 27. 01. 20 13:08, Colin Ian King wrote:
> On 27/01/2020 12:05, Dan Carpenter wrote:
>> On Mon, Jan 27, 2020 at 12:03:02PM +0100, Michal Simek wrote:
>>> On 27. 01. 20 11:23, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> There is a statement that is indented one level too deeply, remove
>>>> the extraneous tab.
>>>>
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>> V2: fix type in commit message
>>>> ---
>>>>  drivers/i2c/busses/i2c-xiic.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
>>>> index b17d30c9ab40..90c1c362394d 100644
>>>> --- a/drivers/i2c/busses/i2c-xiic.c
>>>> +++ b/drivers/i2c/busses/i2c-xiic.c
>>>> @@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
>>>>  		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
>>>>  		if (time_after(jiffies, timeout)) {
>>>>  			dev_err(i2c->dev, "Failed to clear rx fifo\n");
>>>> -				return -ETIMEDOUT;
>>>> +			return -ETIMEDOUT;
>>>>  		}
>>>>  	}
>>>>  
>>>>
>>>
>>> As was suggested by Peter you should also add Fixes: <sha1> ("patch
>>> subject")
>>>
>>
>> It's not really a bugfix, it's just a cleanup.
> 
> I'm surprised i wasn't asked for a bug number too.

ok. Up2you.

Thanks,
Michal
