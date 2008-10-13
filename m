From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Mon, 13 Oct 2008 09:25:48 +0200
Message-ID: <20081013092548.3d58a320@hyperion.delvare>
References: <48F2A270.8060307@leipzig.freifunk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48F2A270.8060307-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andreas,

On Mon, 13 Oct 2008 03:20:48 +0200, Andreas Seidler wrote:
> I want to connect a MAX1236 (ADC) [1] to a I2C/SMBus in a
> PC-Engines/ALIX board to monitor some voltages.
> This board have a AMD geode CPU with an an I2C companion (scx200_acb.c).
> 
> >   Installed I2C busses:
> >     i2c-0       smbus           CS5536 ACB0
> > root@OpenWrt:/# i2cdetect -F 0
> > Functionalities implemented by /dev/i2c-0:
> > I2C                              no
> > SMBus Quick Command              yes
> > SMBus Send Byte                  yes
> > SMBus Receive Byte               yes
> > SMBus Write Byte                 yes
> > SMBus Read Byte                  yes
> > SMBus Write Word                 yes
> > SMBus Read Word                  yes
> > SMBus Process Call               no
> > SMBus Block Write                no
> > SMBus Block Read                 no
> > SMBus Block Process Call         no
> > SMBus PEC                        no
> > I2C Block Write                  yes
> > I2C Block Read                   yes
> > root@OpenWrt:/# i2cdetect -y 0
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
> > 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 70: -- -- -- -- -- -- -- --    
> 
> but i cant access the MAX1236 on slave address 0x34.
> (0x4c is the onbard LM90)

Maybe it's not wired properly?

If it is wired properly, then another possibility is that the MAX1236
is doing clock stretching beyond what the CS5536 supports...

> Does "I2C no" means the CS5536 is a plain smbus without i2c support?

Yes and no. It means that the scx200_acb driver runs the CS5536 in
SMBus mode without plain I2C support. But there is also the scx200_i2c
driver (which I would love to see go away in favor of i2c-gpio but
that's another story) which can use the same pins as GPIO to do plain
I2C. If I read the MAX1236 datasheet properly, it uses transactions
which aren't part of the SMBus set, so you may need to use the
scx200_i2c driver, depending on what exactly you need to do with the
MAX1236. There are still a few SMBus transactions which should work
though, and that may be enough.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
