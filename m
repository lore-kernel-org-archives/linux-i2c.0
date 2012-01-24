From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-isch: Decrease delay in the loop checking the BUSY
  state of the bus
Date: Tue, 24 Jan 2012 10:58:38 +0100
Message-ID: <20120124105838.08c2a652@endymion.delvare>
References: <1327060014-7604-1-git-send-email-olivier@sobrie.be>
	<20120123162620.031ade7f@endymion.delvare>
	<20120124084641.GA25825@hposo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120124084641.GA25825@hposo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Jan 2012 09:46:41 +0100, Olivier Sobrie wrote:
> On Mon, Jan 23, 2012 at 04:26:20PM +0100, Jean Delvare wrote:
> > The code change looks OK but the patch description not really. The loop
> > you're changing is waiting for command completion, it isn't checking
> > for bus business, regardless of what the comment in the code says. What
> > about:
> > 
> > i2c-isch: Decrease delay in command completion check loop
> > 
> > If this is OK with you I'll apply your patch with this description.
> 
> It's OK for me. Sorry for the wrong description.
> Indeed yours looks better !

OK, changed. I have queued your patch for kernel 3.4, it will be in
linux-next until then. If adjustments are needed, feel free to send an
update.

http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/i2c-isch-decrease-delay-in-command-completion-check-loop.patch

> > To be honest I didn't know about usleep_range(). Probably the same
> > change could apply to a number of polled SMBus controller drivers,
> > starting with i2c-i801. I'll give it a try...
> 
> Indeed I saw there are a lot of msleep(1) in the i2c drivers.
> As I only have an intel SMBus I cannot test it for others i2c busses.
> I choose to use usleep_range() as the documentation located in
> Documentation/timers/timers-howto.txt of the kernel tree says to use
> this function in the case of a sleep between 10us and 20ms...

And quite rightly so. Note that usleep_range() did not exist when most
of these drivers were originally written, so the use of msleep(1) is by
default and not a design decision. Using usleep_range() is certainly
the right thing to do in most of them these days (or convert them to
use interrupts, of course.)

> (...)
> I didn't check the CPU load. But I assume there will be no difference
> in my case as the timer is generally fired only one time.

In my own tests, the CPU load seems to increase slightly, most probably
because I use i2c_smbus_read_byte_data() which is a longer transaction
than yours so the timer is fired several times (2 or 3) per
transaction. If I change the range from (100, 200) to (250, 500) then
I'm almost back to the original CPU load figures, modulo measurement
noise, with almost the same speed benefit.

As the optimal range depends on the SMBus frequency and the transaction,
it seems a little difficult to optimize. We can settle on a per-driver
range, and anyone not happy with it will have to work on interrupt
support ;)

> For info, I tested this change with a touchscreen device for which I've
> to perform a lot of i2c_smbus_read_byte() to read touch data.
> I'll have a look at the CPU load. By the way if you've a good idea how
> to have relevant measures I'm interested in.

I am using the i2c-dev driver + i2cdump (from the i2c-tools package) on
an arbitrary SMBus slave on my SMBus. I'm measuring the time it takes
to dump all the register space:

# modprobe i2c-dev
# time for i in `seq 1 10` ; do i2cdump -y 8 0x2f b > /dev/null ; done

real	0m5.139s
user	0m0.016s
sys	0m0.118s

This was with the original i2c-i801 driver. "real" tells me how fast
register reads actually are (2560 reads in 5.139 s -> 2 ms/read on
average), and "sys" how much they cost in terms of CPU. "user" can be
ignored. With usleep_range(100, 200) I get:

real	0m1.448s
user	0m0.006s
sys	0m0.150s

So you can see it's much faster (0.57 ms/read) but costs more CPU. With
usleep_range(250, 500) I get:

real	0m1.587s
user	0m0.003s
sys	0m0.124s

That's 0.62 ms/read. And finally with usleep_range(400, 700) I get:

real	0m2.043s
user	0m0.007s
sys	0m0.118s

The speed/CPU tradeoff is visible, and I think I'll go with
usleep_range(250, 500).

Of course if you want more accurate measurements you want to do more
iterations and probably use better statistical analysis than the sum I
did.

> Concerning the system without hrtimers support, I just did a test and
> the performances decrease! It introduces again a long delay... which is
> not the case if I do a udelay(100)...

But udelay() is busy-waiting so it would have an unacceptable CPU cost
especially on large transactions. Question is, is usleep_range(100,
200) without hrtimers support slower than msleep(1)? If not then we're
fine. If it is slower then that would be a bug in the implementation of
usleep_range(), as it really shouldn't be each driver's job to check
for this individually.

-- 
Jean Delvare
