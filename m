From: Darius <augulis.darius@gmail.com>
Subject: Re: [PATCH V11] I2C driver for IMX
Date: Mon, 11 Aug 2008 10:18:48 +0300
Message-ID: <489FE7D8.6070406@gmail.com>
References: <g66mel$v6s$1@ger.gmane.org>	<20080808115116.59d84d90@hyperion.delvare>
	<20080808100109.GA11503@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080808100109.GA11503@trinity.fluff.org>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Fri, Aug 08, 2008 at 11:51:16AM +0200, Jean Delvare wrote:
>> On Wed, 23 Jul 2008 10:20:12 +0300, Darius wrote:
>>> Description:
>>>
>>> Implementation of I2C Adapter/Algorithm Driver
>>> for I2C Bus integrated in Freescale's i.MXL and i.MX1 processors
>>>
>>> Changes from V10 version:
>>>
>>> - adapter class changed to I2C_CLASS_ALL
>> Not a smart move if you ask me. All embedded platforms are moving away
>> from I2C probing and now use I2C device description at the platform
>> level. I expect I2C_CLASS_ALL to be discarded in 2.6.28. Almost all
>> hwmon and rtc drivers have been converted to the new I2C device driver
>> matching scheme at this point, and the few remaining ones will
>> definitely be converted for 2.6.28, hopefully with all the other legacy
>> I2C drivers in the kernel tree.

Why I should leave i2c class hwmon? i.MX I2C driver is common I2C driver, suitable for almost every kind of I2C clients, not only hwmon.
For example digital camera and so on.

>>
>>> - changes regarding new IMX Clock API
>>>
>>> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
>>> ---
>> Ben, this driver has been through many iterations already. Maybe it's
>> time for you to pick it up?
> 
> Yes, I think it is pretty much ready. If a version without the changelog
> is submitted I will look at queueing it for the next merge window.

To merge this driver into kernel, we have to merge our and Pengutronix patches for ARCH_MXC first, because it depends on these patches.
This I2C driver is not only for MX1 processors but for all i.MX family from now. Therefore it needs platform data and header file from arch dir.
It does not compile before our ARCH_MXC patches are applied.

>  
>> -- 
>> Jean Delvare
>>
>> -------------------------------------------------------------------
>> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
>> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
>> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> 


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
