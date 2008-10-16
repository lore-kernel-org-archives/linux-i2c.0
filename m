From: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Thu, 16 Oct 2008 20:12:48 +0200
Message-ID: <gd8070$f4e$1@ger.gmane.org>
References: <48F2A270.8060307@leipzig.freifunk.net>	<20081013092548.3d58a320@hyperion.delvare>	<gd3fe5$11e$1@ger.gmane.org>
	<20081015101736.34e1c11e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015101736.34e1c11e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
> On Wed, 15 Oct 2008 03:01:56 +0200, Andreas Seidler wrote:
>> I can access this ADC wired to a i2c-ibm_iic (build-in IBM PPC_P405)
> 
> That's not the question. Maybe the chip was wired properly on that
> system and not on the CS5563 system.
> 
> You can also try i2cdetect -r and see if it makes a difference.

I'm afraid not.


>>> If it is wired properly, then another possibility is that the MAX1236
>>> is doing clock stretching beyond what the CS5536 supports...
>> and this is my second problem: i cant read the A/D-converted values from
>> userspace (eg. with i2cget) without spezial code or kernel module?
> 
> I'm not sure if i2cget can work with this device. The transactions used
> by the MAX1236 are raw reads and writes which aren't too
> SMBus-friendly, but it you don't care too much about performance,
> i2cget may still work depending on how you read the datasheet. I
> suggest that you give it a try on the IBM PPC system where you know the
> chip is properly wired.
> 
> i2cget 0 0x34 0x81 w
> 
> should give you the raw value of the 1st ADC channel. You'll have to
> byte-swap it because SMBus specifies that words go on the wire LSB
> first.

good to know about the byte-swap with smbus!


btw:I played around with this ADC on my i2c-ibm_iic:

root@OpenWrt:/# i2cget -y 0 0x34 0x21 w

i get this values of channel 0:

OV:	0x00f0 (11110000)
1,6V:	0xaef5 (1010111011110101)
3,2V:	0x5efb (101110111111011)

but how to get the converted 12 bit value?



Regards
Andreas


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
