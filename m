From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: new style i2c client problem: probe () is not called
Date: Thu, 15 May 2008 11:41:12 +0200
Message-ID: <20080515114112.431f9a56@hyperion.delvare>
References: <g0bqa9$b3$1@ger.gmane.org> <20080513104921.GA4485@pengutronix.de>
	<g0bub0$eqh$1@ger.gmane.org>
	<20080513141337.20068339@hyperion.delvare>
	<g0c2qb$ue1$1@ger.gmane.org> <20080514212006.GA16881@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080514212006.GA16881-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Wed, 14 May 2008 22:20:06 +0100, Ben Dooks wrote:
> On Tue, May 13, 2008 at 03:45:29PM +0300, Darius wrote:
> > Thanks, there was the problem. I have modified i2c adapter driver to use 
> >   i2c_add_numbered_adapter() instead i2c_add_adapter() and pass to the 
> > adapter->nr = pdev->id. now probe is called.
> 
> I'm not so sure this 1:1 mapping of platform to i2c bus ID is such a
> good idea, what if you have two i2c controllers and want to swap the
> two of them around?

You are right that using the platform device ID as the bus number has
limitations. It seems that it has worked fine for everyone so far
though. I guess that most embedded platforms have only one type of I2C
controllers so there are no collisions. If a platform was to use
several types of I2C controllers, presumably requiring different
drivers, then the current strategy may lead to collisions. But then it
shouldn't be too difficult to work around it, by passing the correct
I2C bus number as platform data. I guess developers have been using the
platform device ID merely as a shortcut.

I'm not too sure what you mean with "swapping the i2c controllers"
though. Why would you want to do that? Maybe a concrete example would
help.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
