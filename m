From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Mon, 23 Sep 2013 14:44:06 -0700
Message-ID: <5240B626.9050904@freescale.com>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com> <20130923071012.GD3051@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923071012.GD3051@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/23/2013 12:10 AM, Wolfram Sang wrote:
> 
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index b80c768..55dce43 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -106,7 +106,12 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>>  {
>>  	int k;
>> -	u32 delay_val = 1000000 / i2c->real_clk + 1;
>> +	u32 delay_val;
>> +#ifdef CONFIG_PPC_85xx
>> +	delay_val = 65536 / (fsl_get_sys_freq() / 2000000);	/* 64K cycle */
>> +#else
>> +	delay_val = 1000000 / i2c->real_clk + 1;
>> +#endif
> 
> Please, no unnecessary #ifdefs in code. We have 'struct mpc_i2c_data'
> already.
> 

I am not pround of this change. Please elaborate how to use mpc_i2c_data
to separate the mpc85xx from the rest.

York
