From: "subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org" <subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org>
Subject: Re: SMBus of Sis650/961 P4 system not recognised
Date: Thu, 25 Sep 2008 11:49:19 +0100
Message-ID: <1222339759.10245.10.camel@localhost>
References: <1221391781.31885.22.camel@localhost>
	<20080920134329.5e1b2198@hyperion.delvare>
	<1221928948.32367.4.camel@localhost>
	<20080925103746.1f7bd810@hyperion.delvare>
Reply-To: subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080925103746.1f7bd810-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks; had not seen a reference to the separate tools package; now
compiled the i2ctools and ran i2cdetect:
------------------------------------------------------------------
  Installed I2C busses:
    i2c-0       smbus           SiS96x SMBus adapter at 0x0c00

WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: 10 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- 2d -- --
30: 30 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 49 -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 6a -- -- -- -- --
70: -- -- -- -- -- -- -- --
-------------------------------------------------------------------
So the bus is seen; 2d, 48, and 49 correspond to what Fanspeed reported
to be a Winbond W83L517D and two LM75, albeit that Fanspeed reported the
SMBus to be at $0B80 and i2cdetect reports it to be at $0c00.

Will post my question about how to get a driver istalled for the
W83L517D and used by lm-sensors in the other mailing list. Thanks for
your help Jean !


On Thu, 2008-09-25 at 10:37 +0200, Jean Delvare wrote:
> Hi Martin,
> 
> Please keep the i2c list Cc'd.
> 
> On Sat, 20 Sep 2008 17:42:27 +0100, subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org wrote:
> > your response is most appreciated. ! However after loading the 12c-dev
> > module successfully I cannot run i2cdetect as it seems not to be a part
> > of the latest lm-sensors (3.0.2) for 2.6 kernels.
> > 
> > What should I do to cure the absence of this detection utility ?
> 
> i2cdetect is part of the i2c-tools package:
> http://www.lm-sensors.org/wiki/I2CTools
> 


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
