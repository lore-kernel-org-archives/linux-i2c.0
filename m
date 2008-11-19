From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Date: Wed, 19 Nov 2008 16:16:32 +0100
Message-ID: <20081119161632.2d0bde9e@hyperion.delvare>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809231532.40083.david-b@pacbell.net>
	<20081118091546.421d6b78@hyperion.delvare>
	<200811181401.34809.david-b@pacbell.net>
	<Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0811190140510.11673-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Wed, 19 Nov 2008 01:51:08 -0800 (PST), Trent Piepho wrote:
> On Tue, 18 Nov 2008, David Brownell wrote:
> > ---
> > drivers/i2c/busses/i2c-gpio.c |   10 ++
> > drivers/i2c/i2c-core.c        |  155 ++++++++++++++++++++++++++++++++++++++++
> > include/linux/i2c.h           |   14 +++
> > 3 files changed, 179 insertions(+)
> 
> Can this be made optional?  Seeing as nothing uses it yet and it increases a
> brunch of core structs' sizes.

Did you actually check the size increase? struct i2c_driver is added
one pointer, so 4 or 8 bytes, hardly worth mentioning. struct
i2c_adapter is added 72 bytes on x86-64, to 1360 bytes initially so an
increase of less than 6%. Is this really such a big issue? I doubt it.
You don't have that many i2c_adapters registered on any given system
for it to really matter, methinks.

Making it optional would have its problems as well. Either the drivers
which implement or make use of SMBus alert would have to depend on said
option being enabled, or you'd have to put #ifdefs in all these drivers
to work both with and without the option. Neither option is really
appealing IMHO.

-- 
Jean Delvare
