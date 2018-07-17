From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Date: Tue, 17 Jul 2018 17:27:01 +0800
Message-ID: <b8d7c7aa-dbde-3037-4a1b-691bcf045131@electromag.com.au>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
 <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
 <20180717090920.zy6lkeqlcewhrfs5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717090920.zy6lkeqlcewhrfs5@ninjato>
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 17/07/2018 17:09, Wolfram Sang wrote:
> Hi Phil,
> 
>>> -	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
>>> +	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
>>>    	if (IS_ERR(gpio)) {
>>>    		r = PTR_ERR(gpio);
>>>    		if (r == -ENOENT || r == -ENOSYS)
>>>
>>
>> This was intentional. The gpio we use to drive the i2c line is implemented in an
>> FPGA and signals a buffer attached to the GPIO to drive scl OPEN drain. The GPIO is output
>> only.
> 
> So, it is not possible to read SCL status then? Hmm, currently a working
> get_scl is required...
> 
>> The gpio setup can still specify the the GPIO be allocated OPEN drain if someone wishes
>> to use a "smarter" gpio.
>>
>> So while the scl is open drain, there may be hardware in between that isn't.
>> What would the correct way be to deal with that now?
> 
> Well, I don't know much about this IP core and how/where it is used. I
> just wonder what happens if another user comes along using an
> open-drain GPIO. Is that possible?
> 
> I assume it is the same with SDA? Non open-drain? Output only?
> 

Just had a closer look at how it's setup here.
Maybe the following helps.

The designware core is routed thru the fpga fabric.
Which provides and SCL SDA output enable pin.

Recovery gpio are provided by a FPGA gpio IO core.
This core has a fixed output and fixed input.

Here's the relevant bit on how it's all combined.
PWR_SDA_a / PWR_SCL_a are the signals to the outside world.
All the other signals are internal

   I2c0_Dat_s <= PWR_SDA_a;
   I2c0_Clk_s <= PWR_SCL_a;
   PWR_SDA_a <= '0' when  (I2c0_Dat_Oe_s = '1') else 'Z';

This bit of logic combines the i2c core and gpios.
   PWR_SCL_a <= '0' when ((I2c0_Clk_Oe_s = '1') or (PWR_SCL_rec_s = '0')) else 'Z';

     , pio_io_in_port(1)                   => PWR_SCL_a
     , pio_io_in_port(2)                   => PWR_SDA_a

     , pio_io_out_port(1)                  => PWR_SCL_rec_s

pio_io_out_port port is the fixed config for output
pio_io_in_port is the fixed config for input

The gpio input / outputs exist in the same ip core.

PWR_SCL_rec_s is the recovery clock gpio signal. It needs to be driven high / low.
There's no concept of HiZ internally in the FPGA.

If there was some kinda of OpenDrain gpio driver that modelled a FET driven by a push pull GPIO I guess
it could be made to work.

-- 
Regards
Phil Reid
