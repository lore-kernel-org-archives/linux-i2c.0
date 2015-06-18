From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Thu, 18 Jun 2015 12:22:33 -0400
Message-ID: <5582F049.8070407@ti.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <558288B0.1020706-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/18/2015 05:00 AM, Sekhar Nori wrote:
> On Thursday 18 June 2015 02:23 PM, Alexander Sverdlin wrote:
>> According to KeyStone Architecture I2C User Guide,
>>
>>                           module clock frequency
>> master clock frequency = ----------------------
>>                           (ICCL + 6) + (ICCH + 6)
>>
>> i.e. "d" in i2c_davinci_calc_clk_dividers() should be fixed and
>> not dependent from module clock prescaler PSC on these SoCs.
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> ---
>>
>> RFC: If someone from TI has an idea how to improve the coverage of future Keystone
>> revisions -- hints/patches are welcome. The current ID check is based on
>> Davinci/Keystone datasheets and is at least working on real Keystone II.
>
> + Murali who works on Keystone devices in TI.

+ Grygorii

+ Grygorii has been involved in the Keystone related enhancement and 
reviewing prior patches. Need to have his ack for this change

Murali
>
>>
>>   drivers/i2c/busses/i2c-davinci.c |   10 ++++++++++
>>   1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index 4a110af..3d78f6a 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -60,6 +60,8 @@
>>   #define DAVINCI_I2C_IVR_REG	0x28
>>   #define DAVINCI_I2C_EMDR_REG	0x2c
>>   #define DAVINCI_I2C_PSC_REG	0x30
>> +#define DAVINCI_I2C_ICPID1_REG	0x34
>> +#define DAVINCI_I2C_ICPID2_REG	0x38
>>   #define DAVINCI_I2C_FUNC_REG	0x48
>>   #define DAVINCI_I2C_DIR_REG	0x4c
>>   #define DAVINCI_I2C_DIN_REG	0x50
>> @@ -203,6 +205,9 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>>   	 * where if PSC == 0, d = 7,
>>   	 *       if PSC == 1, d = 6
>>   	 *       if PSC > 1 , d = 5
>> +	 *
>> +	 * Note:
>> +	 * d is always 6 on Keystone I2C controller
>>   	 */
>>
>>   	/* get minimum of 7 MHz clock, but max of 12 MHz */
>> @@ -211,6 +216,11 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>>   		psc++;	/* better to run under spec than over */
>>   	d = (psc >= 2) ? 5 : 7 - psc;
>>
>> +	if (davinci_i2c_read_reg(dev, DAVINCI_I2C_ICPID2_REG) == 0x2206) {
>> +		dev_dbg(dev->dev, "Keystone SoC detected\n");
>> +		d = 6;
>> +	}
>
> I think its better to use a different compatible string for i2c on
> keystone devices rather than using a fixed hardcoded IP version.
>
> Thanks,
> Sekhar
>


-- 
Murali Karicheri
Linux Kernel, Keystone
