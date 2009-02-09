From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: add "reset" sysfs entry for adapters.
Date: Mon, 9 Feb 2009 16:37:05 +0100
Message-ID: <20090209153705.GE7975@enneenne.com>
References: <1233933798-17673-1-git-send-email-giometti@linux.it> <20090209145546.GO8032@fluff.org.uk> <20090209150255.GA7975@enneenne.com> <20090209162838.7cfeee94@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090209162838.7cfeee94-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 09, 2009 at 04:28:38PM +0100, Jean Delvare wrote:
> On Mon, 9 Feb 2009 16:02:55 +0100, Rodolfo Giometti wrote:
> > On Mon, Feb 09, 2009 at 02:55:46PM +0000, Ben Dooks wrote:
> > > On Fri, Feb 06, 2009 at 04:23:17PM +0100, Rodolfo Giometti wrote:
> > > > It could happen that an i2c adapter may lock the bus due due
> > > > electrical problems, so the user may recover this stale state by using:
> > > > 
> > > > 	$ echo 1 > /sys/class/i2c-adapter/i2c-0/reset
> > > > 
> > > > Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> > > 
> > > There doesn't seem to be any locking to stop issuing a reset during
> > > an extant transaction... should the controller driver deal with
> > > cancelling any outstanding transactions?
> > 
> > I think this should be done inside each adapter driver since it's
> > an adapter specific issue.
> > 
> > If you see next patch of this patchset you can see that the adapter
> > i2c-pxa aborts any transfer currently under way during reset.
> 
> I disagree. An i2c bus driver should never get stuck in the middle of a
> transaction (that is, with i2c_adapter->bus_lock held.) If a
> transaction fails, the driver should timeout and return. Thus I think
> Ben is right and it would make a lot of sense to have function
> write_adapter_reset take i2c_adapter->bus_lock. This guarantees that
> all bus drivers will get locking right and won't allow resetting in the
> middle of a (non-stuck) transaction.

Ok, I'll modify the code as you suggested ASAP.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
