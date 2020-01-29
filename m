From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH][next][V2] i2c: xiic: fix indentation issue
Date: Wed, 29 Jan 2020 08:06:32 +0000
Message-ID: <f8c236de-4ed6-49dc-e5b7-283ebb859199@axentia.se>
References: <20200127102303.44133-1-colin.king@canonical.com>
 <2dd84ab2-a7a3-fdd8-6bd6-07f1b3d5cd00@xilinx.com>
 <20200127120535.GC1847@kadam>
 <89661e5e-7662-81a5-ec36-57367825de5e@canonical.com>
 <35ed6501-3b26-36a9-d332-d4ed3366ebd8@axentia.se>
 <3b287fb5-e344-c13a-2803-09c2958b9b0d@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <3b287fb5-e344-c13a-2803-09c2958b9b0d@canonical.com>
Content-Language: en-US
Content-ID: <C71D27A5CDBB8849A01AB6970F676569@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, Michal Simek <michal.simek@xilinx.com>, Johan Hovold <johan@kernel.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2020-01-29 00:10, Colin Ian King wrote:
> On 28/01/2020 21:45, Peter Rosin wrote:
>> On 2020-01-27 13:08, Colin Ian King wrote:
>>> On 27/01/2020 12:05, Dan Carpenter wrote:
>>>> On Mon, Jan 27, 2020 at 12:03:02PM +0100, Michal Simek wrote:
>>>>> On 27. 01. 20 11:23, Colin King wrote:
>>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>>
>>>>>> There is a statement that is indented one level too deeply, remove
>>>>>> the extraneous tab.
>>>>>>
>>>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>>>> ---
>>>>>> V2: fix type in commit message
>>>>>> ---
>>>>>>  drivers/i2c/busses/i2c-xiic.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
>>>>>> index b17d30c9ab40..90c1c362394d 100644
>>>>>> --- a/drivers/i2c/busses/i2c-xiic.c
>>>>>> +++ b/drivers/i2c/busses/i2c-xiic.c
>>>>>> @@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
>>>>>>  		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
>>>>>>  		if (time_after(jiffies, timeout)) {
>>>>>>  			dev_err(i2c->dev, "Failed to clear rx fifo\n");
>>>>>> -				return -ETIMEDOUT;
>>>>>> +			return -ETIMEDOUT;
>>>>>>  		}
>>>>>>  	}
>>>>>>  
>>>>>>
>>>>>
>>>>> As was suggested by Peter you should also add Fixes: <sha1> ("patch
>>>>> subject")
>>>>>
>>>>
>>>> It's not really a bugfix, it's just a cleanup.
>>>
>>> I'm surprised i wasn't asked for a bug number too.
>>
>> Very funny.
> 
> Apologies for being flippant. I didn't mean to offend. My bad #1.

Apology accepted, no hard feelings. Don't worry about it, and sorry on my
part for a possible overreaction!

Cheers,
Peter
