From: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Wed, 15 Oct 2008 03:01:56 +0200
Message-ID: <gd3fe5$11e$1@ger.gmane.org>
References: <48F2A270.8060307@leipzig.freifunk.net>
	<20081013092548.3d58a320@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081013092548.3d58a320-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare schrieb:
> Hi Andreas,
> 
> On Mon, 13 Oct 2008 03:20:48 +0200, Andreas Seidler wrote:
>> I want to connect a MAX1236 (ADC) [1] to a I2C/SMBus in a
>> PC-Engines/ALIX board to monitor some voltages.
>> This board have a AMD geode CPU with an an I2C companion (scx200_acb.c).
>>
>>[...]
>> but i cant access the MAX1236 on slave address 0x34.
>> (0x4c is the onbard LM90)
> 
> Maybe it's not wired properly?

I can access this ADC wired to a i2c-ibm_iic (build-in IBM PPC_P405)


> If it is wired properly, then another possibility is that the MAX1236
> is doing clock stretching beyond what the CS5536 supports...

and this is my second problem: i cant read the A/D-converted values from
userspace (eg. with i2cget) without spezial code or kernel module?


>> Does "I2C no" means the CS5536 is a plain smbus without i2c support?
> 
> Yes and no. It means that the scx200_acb driver runs the CS5536 in
> SMBus mode without plain I2C support. But there is also the scx200_i2c
> driver (which I would love to see go away in favor of i2c-gpio but
> that's another story) which can use the same pins as GPIO to do plain
> I2C. 

Thank you for this info!
Know i found "the story" in this thread too (http://lkml.org/lkml/2007/4/14/59)
with more infos.

now i tested scx200_i2c:
root@OpenWrt:/# insmod scx200_gpio
scx200_gpio: no SCx200 gpio present
root@OpenWrt:/# insmod scx200_i2c
scx200_i2c: no SCx200 gpio pins available

(i hope thats no problem of the openwrt-distro...)


are SCx200 GPIO pins supported by i2c_gpio?
(http://lkml.org/lkml/2007/4/19/22)

should it work with my Geode/LX800 companion?


> If I read the MAX1236 datasheet properly, it uses transactions
> which aren't part of the SMBus set, so you may need to use the
> scx200_i2c driver, depending on what exactly you need to do with the
> MAX1236.

I only want to monitor some voltages in my wind-/solarpower system and draw some
nice charts - nothing spezial.



Regards
Andreas


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
