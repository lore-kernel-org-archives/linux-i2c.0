From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: i2c Device Detection
Date: Thu, 16 Dec 2010 15:46:49 +0000
Message-ID: <20101216154649.GD20097@trinity.fluff.org>
References: <AANLkTi=arobgyX-FgCV572AbY3N+6pRgsM+Fr2moQ2i6@mail.gmail.com> <20101216163613.0c80ec04@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101216163613.0c80ec04-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Gerard Pierre <gbinhex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 16, 2010 at 04:36:13PM +0100, Jean Delvare wrote:
> Bonjour Gerard,
> 
> On Thu, 16 Dec 2010 09:20:00 -0500, Gerard Pierre wrote:
> > Being relatively new to i2c I wanted to verify that my conclusion
> > reached from doing some initial reading on i2c device detection is
> > accurate:
> > 
> > Based on the nature of an i2c bus there is no automatic detection of
> > an i2c device "plugged into" a system in the kernel. For example, an
> > embedded Linux system boots up and 10 minutes later someone attaches a
> > smart battery to the running system (to a bus that also has a smart
> > battery charger, for example) - there is no way to automatically
> > detect the device and run some initialization code in a device driver
> > every time the battery gets connected to the i2c bus, correct?
> 
> Correct. You'll need a side-band mechanism for the notification. For
> example, inserting the battery could push on a switch, triggering an
> interrupt.

Yes, something like a gpio-key driver could for gpios or similar, as you
could have a userspace daemon waiting on input. Or you could do something
similar which launches a userspace helper, or your own in-kernel thing
if you really wanted.

Depends on userland, how much work you want to do, etc.
 
> An alternative would be to poll continuously for the slave I2C address
> of the battery, but that would be horrible performance-wise and thus
> better avoided.

Depends on the controller and how often you want to poll for it being
there... most modern systems with hardware i2c blocks can send an address
with just one interrupt (and all you're looking for is an ack)

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
