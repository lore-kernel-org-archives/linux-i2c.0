From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Sun, 6 Jan 2008 10:57:30 +0100
Message-ID: <20080106105730.372ac689@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712291905.15160.david-b@pacbell.net>
	<20080104231633.135f2875@hyperion.delvare>
	<200801041548.54825.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801041548.54825.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 4 Jan 2008 15:48:54 -0800, David Brownell wrote:
> On Friday 04 January 2008, Jean Delvare wrote:
> > This breaks drivers/media/video/mxb.c, drivers/media/video/dpc7146.c
> > and drivers/media/video/tvmixer.c. These 3 drivers walk the clients
> > list that your patch wants to remove.
> 
> Whoops.  Good thing I warned y'all that it was only lightly tested!
> Presumably this was the result of a "build every line of I2C code"
> test.

This is my default build mode ;) I'm doing changes to i2c all the time
so I want to know quickly if a given change breaks some driver.

> Those all seem to do the same thing:  list_for_each_entry() scan to
> find specific devices connected to their private adapter.

True.

> > I guess that we need to replace 
> > their code by something equivalent that would walk the driver model's
> > children list instead of i2c-core's internal one?
> 
> Like the device_for_each_child() scanning in the i2-core parts of
> that patch ... yes, that's probably the least invasive change for
> the moment.  Eventually I'd like to see the relevant code using
> new-style driver binding, but that seems a bit much to change at
> the moment.

That was pretty much my conclusion as well.

> Changing the users of i2c_adapter.clients could be safely done
> before removing that list (and its lock, ignored by most of
> those drivers if not all of them).  Which should simplify testing
> such changes by a bit.

Agreed, I'll write such patches later today and will send them to the
v4l list for review and testing.

-- 
Jean Delvare
