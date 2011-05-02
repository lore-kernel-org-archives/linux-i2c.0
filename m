From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix null dereference bug in i2c_davinci_calc_clk_dividers
Date: Mon, 02 May 2011 07:38:16 -0400
Message-ID: <4DBE97A8.4010302@criticallink.com>
References: <1303579895-9441-1-git-send-email-michael.williamson@criticallink.com> <20110502093601.GW15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110502093601.GW15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, chaithrika-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mr. Dooks,

On 5/2/2011 5:36 AM, Ben Dooks wrote:

> On Sat, Apr 23, 2011 at 01:31:35PM -0400, Michael Williamson wrote:
>> The davinci-i2c bus driver currently supports being probed with a NULL
>> platform_data structure by using a default configuration when none is
>> provided.  However, the i2c_davinci_calc_clk_dividers does not
>> check the provided platform_data for NULL prior to using it, so
>> the support is incomplete.
>>
>> Rather than have each runtime call check for NULL and avoid future
>> problems, copy a pointer to the default data to the device structure
>> during the probe.  This should be OK, as the information in this
>> structure is not modified by the driver.
>>
>> Tested on a MityDSP-L138 module (OMAP-L138 based SOM).
>>
>> Signed-off-by: Micahel Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-davinci.c |   12 +++++-------
>>  1 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index 5795c83..1db8fc9 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -163,8 +163,7 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
>>  	flag |=  DAVINCI_I2C_MDR_NACK;
>>  	/* write the data into mode register */
>>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>> -	if (pdata)
>> -		generic_i2c_clock_pulse(pdata->scl_pin);
>> +	generic_i2c_clock_pulse(pdata->scl_pin);
>
> This looks like a change in the behaviour of the code, since if there was
> no pdata supplied we now can try generic_i2c_clock_pulse() with what is
> probably gpio pin 0.
>


- There is a check in generic_i2c_clock_pulse() that does not allow for scl_pin
pin = 0. I didn't realize gpio pin 0 was a valid gpio when looking at it.  Seems
like this is an issue as well?

- I think this code is always getting called.  I don't think there are any
platforms that would work using a NULL pdata as i2c_davinci_calc_clk_dividers
would bomb. I don't see any platforms in mach-davinci that provide NULL
i2c platform_data.  Perhaps I'm not looking hard enough.

>>  	/* Send STOP */
>>  	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>>  	flag |= DAVINCI_I2C_MDR_STP;
>> @@ -235,10 +234,11 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>>   */
>>  static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>>  {
>> -	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
>> +	struct davinci_i2c_platform_data *pdata;
>>  
>> -	if (!pdata)
>> -		pdata = &davinci_i2c_platform_data_default;
>> +	if (!dev->dev->platform_data)
>> +		dev->dev->platform_data = &davinci_i2c_platform_data_default;
>> +	pdata = dev->dev->platform_data;
>
> Hmm, not going to work well if the driver is a module, as you'll unload
> the module, leave the default pointer in and then re-load later at a
> possibly different address with the old pointer in.
>   


I hadn't thought of (or tested) the load->unload->reload scenario. 
Subtle (well, to me anyway).  Thanks for pointing that out.  Appreciate
your cycles on review.

>>  	/* put I2C into reset */
>>  	davinci_i2c_reset_ctrl(dev, 0);
>> @@ -313,8 +313,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>>  	u16 w;
>>  	int r;
>>  
>> -	if (!pdata)
>> -		pdata = &davinci_i2c_platform_data_default;
>>  	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
>>  	if (pdata->bus_delay)
>>  		udelay(pdata->bus_delay);
>> -- 
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
