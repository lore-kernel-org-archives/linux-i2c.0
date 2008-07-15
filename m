From: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Subject: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 08:29:27 +0000 (GMT)
Message-ID: <884255.29098.qm@web27605.mail.ukl.yahoo.com>
Reply-To: xpage_de-LWAfsSFWpa4@public.gmane.org
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

> I don't remember any similar problem, so no idea either. I can only
> suspect that your bus driver is doing something wrong. So please give
> us the detail of your setup:
> 
> * Which version of i2c-dev.h are you using?

libi2c-dev, 3.0.0-1 (debian)

> * What architecture are you working on?

i386

> * Which kernel version are you using?

2.6.24.2

> * What i2c bus driver are you using?

i2c_i801                9008  0
i2c_dev                 8164  0
smsc47m1                9700  0
smsc47m192             14656  0

> * How do you know for sure what actually goes on the bus?

Milksop GPL Reflasher - 0.20 - (c)2002 andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org
with CheapI2C


I hope this helps... writing words & bytes works fine.

Regards,

Nick


      __________________________________________________________
Gesendet von Yahoo! Mail.
Dem pfiffigeren Posteingang.
http://de.overview.mail.yahoo.com

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
