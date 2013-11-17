From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on one bus, and mux bus
  naming
Date: Sun, 17 Nov 2013 21:41:02 +0100
Message-ID: <20131117214102.236ae09a@endymion.delvare>
References: <5287B9E4.1020107@roeck-us.net>
	<20131116214116.3d035b76@endymion.delvare>
	<20131116214318.1d101d35@endymion.delvare>
	<20131117185624.GA23639@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131117185624.GA23639-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Sun, 17 Nov 2013 10:56:24 -0800, Guenter Roeck wrote:
> I managed to do it without changing the API; see patch below.
> This results in
> 
> i2c-0/name:MPC adapter at 0xfff703000
> i2c-1/name:MPC adapter at 0xfff703100
> i2c-10/name:i2c-2-mux-75 (chan_id 7)
> i2c-11/name:i2c-2-mux-76 (chan_id 0)
> i2c-12/name:i2c-2-mux-76 (chan_id 1)
> i2c-13/name:i2c-2-mux-76 (chan_id 2)
> i2c-14/name:i2c-2-mux-76 (chan_id 3)
> i2c-15/name:i2c-2-mux-76 (chan_id 4)
> i2c-16/name:i2c-2-mux-76 (chan_id 5)
> i2c-17/name:i2c-2-mux-76 (chan_id 6)
> i2c-18/name:i2c-2-mux-76 (chan_id 7)
> i2c-19/name:i2c-0-mux (chan_id 1)
> i2c-2/name:i2c-0-mux (chan_id 0)
> i2c-20/name:i2c-0-mux (chan_id 2)
> i2c-21/name:i2c-0-mux (chan_id 3)
> i2c-22/name:i2c-0-mux (chan_id 4)
> i2c-23/name:i2c-0-mux (chan_id 5)
> i2c-24/name:i2c-0-mux (chan_id 6)
> i2c-25/name:i2c-0-mux (chan_id 7)
> i2c-3/name:i2c-2-mux-75 (chan_id 0)
> i2c-4/name:i2c-2-mux-75 (chan_id 1)
> i2c-5/name:i2c-2-mux-75 (chan_id 2)
> i2c-6/name:i2c-2-mux-75 (chan_id 3)
> i2c-7/name:i2c-2-mux-75 (chan_id 4)
> i2c-8/name:i2c-2-mux-75 (chan_id 5)
> i2c-9/name:i2c-2-mux-75 (chan_id 6)
> 
> This retains the old mux name if the mux is not an i2c device, and adds
> the i2c device address if it is. This solves the problem for me.
> 
> Comments ?

This "for me" worries me a bit. You basically restored the uniqueness
for the multiple I2C-based multiplexer case. But for multiple
GPIO-based multiplexers, for example, the name confusion still exists.
If we are going to address this problem, I believe we should do so in a
way which doesn't need revisiting in a couple months. You are changing
adapter names people or tools may be relying on, we really don't want
to do this too often.

We could use the first GPIO pin number as the unique identifier for the
GPIO case. However I2C addresses and GPIO pin numbers could collide...
So we'd need separate name spaces, too.

I agree this makes things even more complicated than they are right
now, but I can't think of any other way that would be both robust and
durable.

-- 
Jean Delvare
