From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: ignore active clients detaching during
 adapter removal.
Date: Thu, 28 May 2009 10:22:21 +0200
Message-ID: <20090528102221.2e9b4cf5@hyperion.delvare>
References: <1233840973-13268-4-git-send-email-giometti@linux.it>
	<200902051602.44036.david-b@pacbell.net>
	<20090206102220.GF28554@enneenne.com>
	<20090206131520.232b53c3@hyperion.delvare>
	<20090206125907.GA8581@enneenne.com>
	<20090206221519.5fc3d2b9@hyperion.delvare>
	<20090209130642.GV7975@enneenne.com>
	<20090210120839.23592e38@hyperion.delvare>
	<20090218164812.GA11217@enneenne.com>
	<20090528095054.03fc2df3@hyperion.delvare>
	<20090528075835.GH20243@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090528075835.GH20243-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 28 May 2009 09:58:36 +0200, Rodolfo Giometti wrote:
> On Thu, May 28, 2009 at 09:50:54AM +0200, Jean Delvare wrote:
> > * I really would like to get rid of the "virtual" term that has been
> >   repeatedly abused. Bus segments behind multiplexers are very real.
> 
> Actually I use the term "virtual" regarding to the adapters not to the
> bus segments. In fact the new devices created are not "real" adapters
> but "virtual" ones.

The confusion comes from the fact that struct i2c_adapter should have
been named struct i2c_segment, as this is what it really represents.
But back when it was decided, multiplexing wasn't considered so the
developers thought "controller", "adapter" and "segment" were the same
thing.

Ideally we should rename i2c_adapter to i2c_segment, but this seems a
little intrusive for a rather thin benefit.

-- 
Jean Delvare
