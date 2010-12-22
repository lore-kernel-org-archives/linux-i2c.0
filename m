From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH 2/2] i2c: Factor out runtime suspend checks from PM operations
Date: Wed, 22 Dec 2010 22:08:59 +0100
Message-ID: <201012222208.59577.rjw@sisk.pl>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com> <AANLkTi=KOq65TS299rB=K961=mVXnriyqNxdHzJey5rD@mail.gmail.com> <20101222152550.GA16099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101222152550.GA16099-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday, December 22, 2010, Mark Brown wrote:
> On Wed, Dec 22, 2010 at 08:40:23PM +0530, Rabin Vincent wrote:
> 
> > Shouldn't you be deleting the pm_runtime_* stuff from here?  There is
> > already done in pm_generic_restore() iff the callback exists and returns
> > zero.
> 
> I guess; it's not clear why this is being done by the bus at all or how
> it interacts with the legacy stuff.

It is done, because when the driver's ->resume() or ->restore() brings the
device up (which should have happened if it returned 0), we need to mark
the device as "active" for runtime PM.

Since __pm_generic_resume() does that, it's not necessary to do it in the
bus type callbacks (in the "legacy" case we known that runtime PM is not
supported).

Thanks,
Rafael
