From: Darius <augulis.darius@gmail.com>
Subject: Re: [PATCH V3] I2C driver for IMX
Date: Thu, 10 Apr 2008 15:31:57 +0300
Message-ID: <ftl1i0$e5n$1@ger.gmane.org>
References: <ftf8ud$pl6$1@ger.gmane.org>	<20080410120141.4d220d27@hyperion.delvare>	<ftkqk1$hsa$1@ger.gmane.org>	<200804101333.52241.jbe@pengutronix.de>
	<20080410122404.GE26575@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080410122404.GE26575@flint.arm.linux.org.uk>
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

Russell King - ARM Linux wrote:
> On Thu, Apr 10, 2008 at 01:33:51PM +0200, Juergen Beisert wrote:
>> On Thursday 10 April 2008 12:33, Darius wrote:
>>>> Then I guess that we want to add support to the i2c-mpc driver rather
>>>> than adding another driver to the kernel tree?
>>> I prefer to use separate driver for imx i2c inteface.
>>> if it's not needed for all, I'll leave it for my private needs.
>>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> As I did with my imx i2c driver last year....Yes, this I2C controller is 
>> mostly the same than the one in the MPC family and mostly the same the ones 
>> we can find in the MCX family (i.MX21/27, i.MX31?). But it seems there is 
>> noone who is able to write such a generic driver.
> 
> Which basically means everyone gets to write their own IMX I2C driver.
> What a brilliant advert for open source software. ;(
> 

why not to submit this my driver into kernel? i2c driver is not so big 
fat thing, kernel size will not increase dramatically, even mpc has 
similar hardware and similar driver.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
