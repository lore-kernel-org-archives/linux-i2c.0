From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v3] i2c: core: helper function to detect slave mode
Date: Thu, 26 Jan 2017 11:49:59 +0000
Message-ID: <5c2049cc-05aa-1f5b-65af-4df1147ed56a@synopsys.com>
References: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
 <20170125204537.i66nykln4fkxqryy@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125204537.i66nykln4fkxqryy@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vz@mleia.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 25-Jan-17 20:45, Wolfram Sang wrote:
> 
>> + * i2c_slave_mode_detect - detect operation mode
> 
> I'd rather name it 'i2c_detect_slave_mode'

I will do a V4 with this change.

> 
>> + * @dev:  The device owning the bus
>> + *
>> + * This checks the device nodes for an I2C slave by checking the address
>> + * used.
>> + *
>> + * Returns true if an I2C slave is detected, otherwise returns false.
> 
> Both paragraphs could be a little more explicit. It is not about
> "slaves" or "clients" in general, but about those entries which make the
> current master act as a slave, too.
> 

Ok, I see your point of view. I will reword it also.

> The code looks good to me, so we are close to go!
> 
> Thanks,
> 
>    Wolfram
> 

Great! Thanks
