From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 14:32:58 +0200
Message-ID: <20080715143258.2bef9c1e@hyperion.delvare>
References: <20080715125702.48c9569b@hyperion.delvare>
	<952972.59634.qm@web27607.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <952972.59634.qm-WQsacCdWWGLGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: xpage_de-LWAfsSFWpa4@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 12:22:05 +0000 (GMT), Nick Teen wrote:
> --- Jean Delvare wrote:
> > > > * What i2c bus driver are you using?
> > > 
> > > i2c_i801                9008  0
> > > i2c_dev                 8164  0
> > 
> > Hmm, did you connect something to a SMBus header on your
> > motherboard?
> > Or are you talking to an I2C chip on your motherboard?
> 
> I try to run linux on my iptv box. 0x5d is a I2C talking PIC on the frontpanel.
> 
> > > > * How do you know for sure what actually goes on
> > the bus?
> > > 
> > > Milksop GPL Reflasher - 0.20 - (c)2002
> > andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org
> > > with CheapI2C
> > 
> > Err, what is this exactly? Hardware? Software? Please
> > explain your setup in details.
> 
> I've attached SDA, SCL of my device using a cmos 4050 to my parport.
> Take a look: http://ivtv.writeme.ch/tiki-index.php?page=Monitoring+I2C+Bus

If that's all the details you can provide, then you're on your own,
sorry. I won't spend the whole day extracting every bit of information
from you.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
