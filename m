From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Thu, 7 Apr 2011 09:55:13 +0200
Message-ID: <20110407095513.4c0b708e@endymion.delvare>
References: <20110406095240.410b4e7e@endymion.delvare>
	<Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110406223123.GA5297-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
> On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
> 
> > Neither is the case.  For these subsystems, the PM dependencies _are_ 
> > known.
> 
> ...
> 
> > Now, I have no idea what the situation is with regard to I2C...
> 
> You definitely don't know *anything* about the relationships for I2C,
> especially in embedded systems.

Can you please elaborate? The i2c subsystem uses a standard
parent-children relationship. It seems fairly similar to USB for
example. The only special case I can think of is with bus multiplexing,
but it would be easy enough to switch off async suspend/resume in this
case.

Sonny, I would expect you to obtain the time saving by only switching
the i2c client device to async suspend/resume. wasn't it the case? i2c
bus device suspend/resume shouldn't matter, as the operation should be
handled by the hardware (e.g. PCI) layer.

Rafael, what happens if a parent is set to async suspend/resume but its
children aren't? Does it disable async altogether for the whole branch,
or does it mean that the branch is processed asynchronously as a whole
but its internal processing is serialized? Or something else?

-- 
Jean Delvare
