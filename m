From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 12:57:02 +0200
Message-ID: <20080715125702.48c9569b@hyperion.delvare>
References: <884255.29098.qm@web27605.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <884255.29098.qm-WOTGQye7mknGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 08:29:27 +0000 (GMT), Nick Teen wrote:
> > I don't remember any similar problem, so no idea either. I can only
> > suspect that your bus driver is doing something wrong. So please give
> > us the detail of your setup:
> > 
> > * Which version of i2c-dev.h are you using?
> 
> libi2c-dev, 3.0.0-1 (debian)
> 
> > * What architecture are you working on?
> 
> i386
> 
> > * Which kernel version are you using?
> 
> 2.6.24.2
> 
> > * What i2c bus driver are you using?
> 
> i2c_i801                9008  0
> i2c_dev                 8164  0

Hmm, did you connect something to a SMBus header on your motherboard?
Or are you talking to an I2C chip on your motherboard?

> smsc47m1                9700  0

Not related to i2c at all...

> smsc47m192             14656  0

An i2c chip driver, unrelated to your problem.

> 
> > * How do you know for sure what actually goes on the bus?
> 
> Milksop GPL Reflasher - 0.20 - (c)2002 andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org
> with CheapI2C

Err, what is this exactly? Hardware? Software? Please explain your
setup in details.

> I hope this helps... writing words & bytes works fine.


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
