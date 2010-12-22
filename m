From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] [PATCH 2/2] i2c: Factor out runtime suspend checks
	from PM operations
Date: Wed, 22 Dec 2010 15:25:51 +0000
Message-ID: <20101222152550.GA16099@opensource.wolfsonmicro.com>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1292855593-30608-2-git-send-email-broonie@opensource.wolfsonmicro.com> <AANLkTi=KOq65TS299rB=K961=mVXnriyqNxdHzJey5rD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=KOq65TS299rB=K961=mVXnriyqNxdHzJey5rD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 22, 2010 at 08:40:23PM +0530, Rabin Vincent wrote:

> Shouldn't you be deleting the pm_runtime_* stuff from here?  There is
> already done in pm_generic_restore() iff the callback exists and returns
> zero.

I guess; it's not clear why this is being done by the bus at all or how
it interacts with the legacy stuff.
