From: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] i2c-isch: Decrease delay in the loop checking the BUSY
 state of the bus
Date: Tue, 24 Jan 2012 09:46:41 +0100
Message-ID: <20120124084641.GA25825@hposo>
References: <1327060014-7604-1-git-send-email-olivier@sobrie.be>
 <20120123162620.031ade7f@endymion.delvare>
Reply-To: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120123162620.031ade7f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Salut Jean,

On Mon, Jan 23, 2012 at 04:26:20PM +0100, Jean Delvare wrote:
> On Fri, 20 Jan 2012 12:46:54 +0100, Olivier Sobrie wrote:
> > Generally it is not needed to wait for 1 msec, the SMBus get often ready
> > in less than 200 usecs.
> 
> The code change looks OK but the patch description not really. The loop
> you're changing is waiting for command completion, it isn't checking
> for bus business, regardless of what the comment in the code says. What
> about:
> 
> i2c-isch: Decrease delay in command completion check loop
> 
> If this is OK with you I'll apply your patch with this description.

It's OK for me. Sorry for the wrong description.
Indeed yours looks better !

> > msleep(1) can wait up to 20 msecs... It has a significant impact when
> > there is a burst of transactions on the bus.
> 
> To be honest I didn't know about usleep_range(). Probably the same
> change could apply to a number of polled SMBus controller drivers,
> starting with i2c-i801. I'll give it a try...

Indeed I saw there are a lot of msleep(1) in the i2c drivers.
As I only have an intel SMBus I cannot test it for others i2c busses.
I choose to use usleep_range() as the documentation located in
Documentation/timers/timers-howto.txt of the kernel tree says to use
this function in the case of a sleep between 10us and 20ms...

> Of course it's nowhere as good as switching the drivers to be
> interrupt-driven. Did you check if you patch had any impact in terms of
> CPU load? I'm also curious what happens on systems without high
> resolution timer support, as apparently usleep_range() is implemented
> in terms of these. I admit I am surprised that usleep_range() is
> unconditionally available given that.

I didn't check the CPU load. But I assume there will be no difference
in my case as the timer is generally fired only one time.
For info, I tested this change with a touchscreen device for which I've
to perform a lot of i2c_smbus_read_byte() to read touch data.
I'll have a look at the CPU load. By the way if you've a good idea how
to have relevant measures I'm interested in.

Concerning the system without hrtimers support, I just did a test and
the performances decrease! It introduces again a long delay... which is
not the case if I do a udelay(100)...

Thanks for your comments and have a nice day!

-- 
Olivier Sobrie
