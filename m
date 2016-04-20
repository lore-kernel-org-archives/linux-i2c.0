From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v6 10/19] i2c: octeon: Add support for cn78xx chips
Date: Wed, 20 Apr 2016 15:28:15 -0700
Message-ID: <5718027F.7050707@caviumnetworks.com>
References: <cover.1460387640.git.jglauber@cavium.com> <878b7035b447b6700abc7ec79c375df090067ebc.1460387640.git.jglauber@cavium.com> <20160420215218.GE1546@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160420215218.GE1546@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jan Glauber <jglauber@cavium.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On 04/20/2016 02:52 PM, Wolfram Sang wrote:
> On Mon, Apr 11, 2016 at 05:28:41PM +0200, Jan Glauber wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> cn78xx has a different interrupt architecture, so we have to manage
>> the interrupts differently.
>
> I'd appreciate if you could explain here why interrupts use NOAUTOEN and
> have to be manually en-/disabled? This is surely unusual.

It is quite nice, isn't it?

Since there were enable bits in both the interrupt controller *and* the 
I2C bus hardware, we had redundancy that could profitably be eliminated.

Now with the advent of the cn78xx, the system is much better.  This 
redundancy has been eliminated and interrupts are enabled only in the 
interrupt controller.

Fortunately, the kernel supplies us with convenience functions for 
manipulating these interrupt enable bits (enable_irq() and 
disable_irq()).  Since we don't want to irqs enabled when the driver is 
probed we have to set NOAUTOEN before calling request_irq().

Personally, I preferred the old way where each device had interrupt 
enable bits that could be controlled independently of the interrupt 
controller.  I have been told that I should abandon my preference for 
that type of antiquated architecture and welcome the brave new world of 
the unified interrupt enable bit.  Never the less, I still feel some 
nostalgia for the old way.

The good news is that it is not very much work to add software support 
for the cn78xx style interrupt enabling/masking.  The hooks we add can 
also be used to support the MSI-X interrupts in the Thunder support 
patch that follows.

David.


>
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>> ---
>>   drivers/i2c/busses/i2c-octeon.c | 131 ++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 120 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
>> index 0bb9f0b..fff1ac0 100644
>> --- a/drivers/i2c/busses/i2c-octeon.c
>> +++ b/drivers/i2c/busses/i2c-octeon.c
>> @@ -11,6 +11,7 @@
>>    * warranty of any kind, whether express or implied.
>>    */
>>
>> +#include <linux/atomic.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>> @@ -112,11 +113,18 @@ struct octeon_i2c {
>>   	wait_queue_head_t queue;
>>   	struct i2c_adapter adap;
>>   	int irq;
>> +	int hlc_irq;		/* For cn7890 only */
>>   	u32 twsi_freq;
>>   	int sys_freq;
>>   	void __iomem *twsi_base;
>>   	struct device *dev;
>>   	bool hlc_enabled;
>> +	void (*int_en)(struct octeon_i2c *);
>> +	void (*int_dis)(struct octeon_i2c *);
>> +	void (*hlc_int_en)(struct octeon_i2c *);
>> +	void (*hlc_int_dis)(struct octeon_i2c *);
>
> I'd prefer having 'enable' and 'disable' written out, but I leave that
> to you.
>
>> +	atomic_t int_en_cnt;
>> +	atomic_t hlc_int_en_cnt;
>>   };
>>
