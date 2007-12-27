From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Thu, 27 Dec 2007 15:06:42 -0800
Message-ID: <200712271506.43069.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712271353.05857.david-b@pacbell.net>
	<57e2b00712271409n6c98f76o45116cd92b01f396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <57e2b00712271409n6c98f76o45116cd92b01f396-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 27 December 2007, Byron Bradley wrote:
> On Dec 27, 2007 9:53 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > On Thursday 27 December 2007, Byron Bradley wrote:
> > > On Dec 16, 2007 5:23 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > > > This adds a i2c_new_dummy() primitive to help work with devices
> > > > that consume multiple addresses, which include many I2C eeproms
> > > > and at least one RTC.
> > > >
> > > > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > >
> > > For the S35390A RTC driver I called i2c_new_dummy() in the probe
> > > function in a similar style to the at24 eeprom driver. This failed
> > > because the probe function is called inside an i2c_attach_device()

You mean i2c_attach_client() ...

> > > which has already locked &adap->clist_lock. When you call the
> > > i2c_new_dummy() function it will itself call i2c_attach_device() but
> > > it will never be able to acquire &adap->clist_lock.
> >
> > Right ... make the s35390a driver be a new-style driver.
> >
> > ...
> >
> > So if you're ambitious and don't want to just make that RTC
> > driver be a new-style driver, you could just get rid of that
> > functionality duplication.  (Me, I'd take the easier route and
> > just make it be a new-style driver!)
> 
> I believe this is already a new-style driver. It uses the RTC
> framework, the module init calls i2c_add_driver() and the struct
> i2c_driver provides a .probe and a .remove function.

Indeed; sorry, I skimmed over that stacktrace too quickly.


> Is there something else that I'm missing?

I'm not sure yet.  I certainly tested that updated at24 driver
with lockdep active, and it didn't report such a warning.  It's
possible lockdep on that platform isn't fully functional yet;
I'll see if that problem triggers on a different arch (after
some intentional misconfiguration to call this utility).

One thing that looks odd in your stack trace is that it shows
i2c_attach_client() calling mutex_lock_nested(), which is most
certainly not what it does in rc6-git-current ... in fact, a
nested call is made (rather curiously) only in i2c_transfer().

Do you have other I2C patches that may be causing problems?

- Dave
