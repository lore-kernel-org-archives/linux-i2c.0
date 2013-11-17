From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on one bus, and mux bus
  naming
Date: Sun, 17 Nov 2013 21:31:23 +0100
Message-ID: <20131117213123.57920de0@endymion.delvare>
References: <5287B9E4.1020107@roeck-us.net>
	<20131116214116.3d035b76@endymion.delvare>
	<5288FB94.6000304@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5288FB94.6000304-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 17 Nov 2013 09:23:32 -0800, Guenter Roeck wrote:
> I think it would still be unique name, as long as the parent adapter number
> is well defined (which it hopefully is). At least with the change I can
> 1) identify the mux and 2) walk back in the tree of i2c adapters to find
> the root. Using above example, I know that i2c-2-mux (chan_id 0) is on bus 2.
> Bus 2 is i2c-0-mux (chan_id 0), so I know it is connected to bus 0.
> 
> Am I missing something ?

You're not missing anything. It is indeed possible to "resolve" the
name to uniqueness. My only concern is that someone has to do it, and
for example libsensors currently doesn't. The configuration file parser
would have to be extended to do that resolution in order to fully
support chip-instance-specific configuration statements on multiplexed
topologies. Same goes for i2c-tools: normally you can pass the bus by
name instead of number, but with the need to resolve the name of muxed
branches, this no longer works.

I'm not saying this is a blocker problem, just something to keep in
mind.

-- 
Jean Delvare
