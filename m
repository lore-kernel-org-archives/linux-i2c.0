From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from PM operations
Date: Thu, 13 Jan 2011 21:28:57 +0100
Message-ID: <201101132128.57839.rjw@sisk.pl>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com> <201101050928.53979.rjw@sisk.pl> <20110113211751.62e878d8@endymion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110113211751.62e878d8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Abhijeet Dharmapurikar <adharmap-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, January 13, 2011, Jean Delvare wrote:
> Hi Rafael,
> 
> On Wed, 5 Jan 2011 09:28:53 +0100, Rafael J. Wysocki wrote:
> > On Wednesday, January 05, 2011, Mark Brown wrote:
> > > On Tue, Jan 04, 2011 at 03:07:37PM -0800, Abhijeet Dharmapurikar wrote:
> > > > Mark Brown wrote:
> > > 
> > > >> device op. The PM core provides pm_generic_ functions implementing this
> > > >> behaviour - use them to reduce coupling with future PM updates.
> > > 
> > > > pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?
> > > 
> > > Yes, there's a patch in -next for this already so this patch would need
> > > to either wait for later in the merge window or go in via the PM tree
> > > with the preceeding one (the original version of this patch was posted
> > > as part of a series with the export patch).
> > 
> > I would take it, but I'm still waiting for a word from Jean.
> 
> Sorry for the long silence, I was on vacation. I've just applied this
> patch, and I will send it to Linus tomorrow.

Great, thanks!

Rafael
