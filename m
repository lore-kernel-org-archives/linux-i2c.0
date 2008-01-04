From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Fri, 4 Jan 2008 15:48:54 -0800
Message-ID: <200801041548.54825.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712291905.15160.david-b@pacbell.net>
	<20080104231633.135f2875@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080104231633.135f2875-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 04 January 2008, Jean Delvare wrote:
> Hi David,
> 
> On Sat, 29 Dec 2007 19:05:14 -0800, David Brownell wrote:
> > Remove further duplication between i2c core and driver model:  the
> > per-adapter list of clients (adapter->clients,  client->list) and
> > its lock (adapter->clist_lock) duplicate adapter->dev.children.
> >  
> > LIGHTLY TESTED ... goes on top of two patches from Jean's I2C queue,
> > 
> > 	i2c-remove-redundant-i2c_adapter-list.patch
> > 	i2c-remove-redundant-i2c_driver-list.patch
> > 
> > Continuing in that naming scheme, this might be called
> > 
> > 	i2c-remove-redundant-i2c_client-list.patch
> > 
> > ---
> >  drivers/i2c/i2c-core.c |  189 ++++++++++++++++++++++---------------------------
> >  drivers/i2c/i2c-dev.c  |   33 ++++----
> >  include/linux/i2c.h    |    4 -
> >  3 files changed, 102 insertions(+), 124 deletions(-)
> 
> This breaks drivers/media/video/mxb.c, drivers/media/video/dpc7146.c
> and drivers/media/video/tvmixer.c. These 3 drivers walk the clients
> list that your patch wants to remove.

Whoops.  Good thing I warned y'all that it was only lightly tested!
Presumably this was the result of a "build every line of I2C code"
test.

Those all seem to do the same thing:  list_for_each_entry() scan to
find specific devices connected to their private adapter.


> I guess that we need to replace 
> their code by something equivalent that would walk the driver model's
> children list instead of i2c-core's internal one?

Like the device_for_each_child() scanning in the i2-core parts of
that patch ... yes, that's probably the least invasive change for
the moment.  Eventually I'd like to see the relevant code using
new-style driver binding, but that seems a bit much to change at
the moment.

Changing the users of i2c_adapter.clients could be safely done
before removing that list (and its lock, ignored by most of
those drivers if not all of them).  Which should simplify testing
such changes by a bit.

- Dave
