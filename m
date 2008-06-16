From: Darius <augulis.darius@gmail.com>
Subject: Re: [i2c] [PATCH V6] I2C driver for IMX
Date: Mon, 16 Jun 2008 11:32:22 +0300
Message-ID: <g358q6$m2f$1@ger.gmane.org>
References: <g0ts5c$mm$2@ger.gmane.org>
	<20080601220941.GB6226@fluff.org.uk>	<4851139B.9000105@gmail.com>
	<20080615235601.GB30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080615235601.GB30539@fluff.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Thu, Jun 12, 2008 at 03:16:27PM +0300, Darius wrote:
>>>> +static struct platform_driver i2c_imx_driver = {
>>>> +	.probe	= i2c_imx_probe,
>>>> +	.remove	= i2c_imx_remove,
>>>> +	.driver	= {
>>>> +		.name	= DRIVER_NAME,
>>>> +		.owner	= THIS_MODULE,
>>>> +	}
>>>> +};
>>> No suspend/resume support? See above note on ordering.
>>>
>> There are nothing to do in suspend/resume routines, because no possibility to turn off I2C clock.
>> I2C module itself is disabled every time when data is not transmited.
>> Seems, that there are only few I2C drivers (at91, blackfin, pnx) with suspend/resume suport.
>> Most drivers has not suspend/resume support.
> 
> It depends, does the hardware keep the peripheral state during
> suspend?

yes, all registers remains unchanged.

> 
>> Should I declare empty suspend/resume routines with return 0; only?
> 
> No, the system ignores NULL suspend/resume entries.

also, I'll don't implement suspend, because no reason to do so.
I have next patch version with other your comments corrected.

>  
>> _______________________________________________
>> i2c mailing list
>> i2c@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/i2c
> 



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
