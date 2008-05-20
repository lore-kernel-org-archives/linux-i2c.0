From: Wilken Haase <Hibbelharry-Mmb7MZpHnFY@public.gmane.org>
Subject: Problem with unstable i2c communication with i810 bus driver
Date: Tue, 20 May 2008 02:48:25 +0200
Message-ID: <48321FD9.2010007@gmx.de>
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

Hi People,
i own a Samsung TV settopbox which is nice to use with linux, even while
its manufacturer samsung ships it with another operating system. The box
consists of a intel i815 chipset with integrated graphics, connected to
a focus enhancements fs454 scan converter which is controlled by i2c
commands and which must be setup correctly to produce a useable picture.

In the current state it kinda works. If i do a dump of the registers of
the fs454 I always get some bogus values back, even while most registers
are read out correctly. There is no visible pattern in what registers
give back wrong values, it differs from dump to dump. As another fact
writing to the chip is unstable, too. I often need to rewrite the values
2 or 3 times to get them in place.

I did test some different kernel versions up to the current 2.6.25 and i
saw a nice little increase in reliability but still its a piece off from
perfect.

Failures in writing are producing the following messages in syslog:

May 20 02:33:13 smt i2c-adapter i2c-1: sendbytes: NAK bailout.

Identified busses derived from the output of i2cdump are:

i2c-0    i2c           I810-DDC
i2c-1    i2c           I810-I2C
i2c-2    i2c           I810-GPIOC
i2c-3    smbus         SMBus I801 adapter at 1810
i2c-4    i2c           cx88[0]

The fs454 scan converter is located on I810-I2C.

I tried some different values for delays in i2c-i810.c like here:

/* delays */
#define CYCLE_DELAY             100
#define TIMEOUT                 100

But this didn't seem to offer advantages.

What else can i do ?
Any suggestions ?
If more information is needed feel free to drop me a mail, i will offer
any information as needed.

Thanks a lot !
Wilken Haase



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
