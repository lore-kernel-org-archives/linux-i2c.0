From: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Subject: MAX1236 with smbus (CS5536 ACB0)
Date: Mon, 13 Oct 2008 03:20:48 +0200
Message-ID: <48F2A270.8060307@leipzig.freifunk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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

I want to connect a MAX1236 (ADC) [1] to a I2C/SMBus in a
PC-Engines/ALIX board to monitor some voltages.
This board have a AMD geode CPU with an an I2C companion (scx200_acb.c).

>   Installed I2C busses:
>     i2c-0       smbus           CS5536 ACB0
> root@OpenWrt:/# i2cdetect -F 0
> Functionalities implemented by /dev/i2c-0:
> I2C                              no
> SMBus Quick Command              yes
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                no
> SMBus Block Read                 no
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  yes
> I2C Block Read                   yes
> root@OpenWrt:/# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --    

but i cant access the MAX1236 on slave address 0x34.
(0x4c is the onbard LM90)

Does "I2C no" means the CS5536 is a plain smbus without i2c support?


Regards
Andreas

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
