From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] I2C: mpc: insert DR read in i2c_fixup()
Date: Tue, 03 Jun 2014 08:49:59 +0200
Message-ID: <538D7017.40908@keymile.com>
References: <1400247398-23778-1-git-send-email-valentin.longchamp@keymile.com> <20140602162719.GI2654@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140602162719.GI2654@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/02/2014 06:27 PM, Wolfram Sang wrote:
> On Fri, May 16, 2014 at 03:36:38PM +0200, Valentin Longchamp wrote:
>> The mpc_i2c_fixup function is called when the bus is not released by a
>> slave. The function generates 9 pulses that should lead the slave
>> to release the bus.
>>
>> The sequence that generates the pulses disables/enables the I2C module
>> that controls the blocked bus. We have found out on the P2041 SoC that
>> this could cause the CPU to hang (for a short delay).
>>
>> To avoid this, this patch introduces a read to the I2CDR register
>> between the re-enablement of the I2C module in master mode and its
>> returning to the slave mode instead of the delay (the final delay,
>> between the pulses is kept), as proposed in procedure from the P2041
>> reference manual (16.6.2.3).
>>
>> Signed-off-by: Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> 
> Have you checked other manuals if this always has been the proposed
> procedure?

I have just checked the RMs of the Freescale CPUs I am familiar with, and it is
the same procedure:
- MPC8360E (PowerQUICC II Pro family): 15.5.7
- MPC8548E (PowerQUICC III family): 11.5.6

So I think this is the correct procedure for this module according to several RMs.

> 
>> ---
>>
>>  drivers/i2c/busses/i2c-mpc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index f539163..3655af7 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -107,6 +107,7 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>>  {
>>  	int k;
>> +	u8 dr;
> 
> Looks like we can drop this variable since the value read is not used?

That's correct it is not used. I have added it to make sure that this is not
"optimized" out but I guess the readb call is enough for this purpose ?

> 
>>  	u32 delay_val = 1000000 / i2c->real_clk + 1;
>>  
>>  	if (delay_val < 2)
>> @@ -115,7 +116,7 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>>  	for (k = 9; k; k--) {
>>  		writeccr(i2c, 0);
>>  		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
>> -		udelay(delay_val);
>> +		dr = readb(i2c->base + MPC_I2C_DR);
>>  		writeccr(i2c, CCR_MEN);
>>  		udelay(delay_val << 1);
>>  	}
>> -- 
>> 1.8.0.1
>>
