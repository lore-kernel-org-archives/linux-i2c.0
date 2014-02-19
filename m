From: Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Thu, 20 Feb 2014 03:51:28 +0900
Message-ID: <20140220035128.14da0f79.m.chehab@samsung.com>
References: <cover.1387588711.git.luto@amacapital.net>
 <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
 <20140219151626.GA13973@katana>
 <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

(I'm c/c Tony here, as he also shared the same concern that I had on a 
previous feedback about using I2C to talk with the DIMM).

Em Wed, 19 Feb 2014 09:30:46 -0800
Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org> escreveu:

> On Wed, Feb 19, 2014 at 7:16 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Fri, Dec 20, 2013 at 05:45:13PM -0800, Andy Lutomirski wrote:
> >> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
> >> contains DIMMs.  This will probe (and autoload modules!) for useful
> >> SMBUS devices that live on DIMMs.  i2c_imc calls it.
> >
> > Hmm, after thinking about it for a while and a couple of times, I get
> > the impression that the functionality of i2c_scan_dimm_bus() should
> > better be in userspace, i.e. a udev helper. I could imagine introducing
> > a new functionality macro I2C_FUNC_DIMM_BUS which can be detected in
> > userspace via i2c-dev. Based on that, the helper can do whatever
> > necessary. What do you think?
> >
> 
> Hmm.  So there would be udev rules that detect an I2C_FUNC_DIMM_BUS
> driver and probe it appropriately.
> 
> I'm not sure I like it.  It would mean that any future kernel code
> that wants to use things hanging off the dimm bus would need to stay
> in sync with the udev rules, and it would make things like sticking
> platform_data into the probed devices complicated or impossible.

As I said already a few times, my main concern with such patches is that it
could eventually cause really bad things, especially since we're using
experimental data collected on a system (or maybe on more than one, but
still a limited set of systems), to infere that the same behavior will
be valid for all.

Even assuming that you covered all existing systems, couldn't a BIOS 
or microcode upgrade do some changes that could increase the chances 
that the above-described problems to happen more likely? I'm afraid so.

Let me also cut-and-paste a few relevant parts taken from patch 4/4:

> >> +       It is possibly, although unlikely, that the use of this driver will
> >> +       interfere with your platform's RAM thermal management.
> >
> > This sounds scary and thus needs some more detail :) How does that show?
> > What can happen? Anything to take care of?
> >
> 
> Here's how this works, as far as I can figure it out:
> 
> The Sandy Bridge (and presumably Ivy Bridge) platforms make some
> effort to avoid overheating system DRAM, and they can dynamically
> adjust the refresh interval depending on DIMM temperature.  This
> happens in one of a few modes:

...

> OLTT (open loop thermal throttling):  the memory controller will
> estimate recent heat output based on access patterns and will adjust
> accordingly.  There are lots of registers related to this in the
> public docs, but the overall algorithm and purpose is not described
> anywhere that I've looked.  In this mode, something (SMI? P-code?) can
> still poll the TSOD, but it respects the POLL_EN bit.

...

> The interesting case is OLTT.  If we fail to twiddle the POLL_EN bit
> correctly, then, in principle, we could cause a problem.  I don't know
> what that problem would be -- the memory controller's P-code could
> malfunction with unknown results.  I've abused a test system quite a
> bit, and I've been completely unable to cause a problem, though.
>
> There may be other modes, too, but, if so, I can't find them.  Maybe
> some day there will be CLTT with i2c access.  If so, presumably the
> driver will need updating.

...

> * This is not documented at all AFAIK.  I figured it out by trial and error.

...

> >> +             udelay(70);
> >
> > usleep_range?
> 
> No -- see the comment just above this excerpt.  There's an erratum
> (which I can trigger on occasion but not reliably) that causes the i2c
> hardware to return bogus results if the system enters a sufficiently
> deep sleep while a transaction is running.  udelay prevents that.

Well, I've seen already very bad things happening on I2C.

For example, some I2C eeproms miss-understands 0-sized I2C bus read 
messages, even sent to other I2C chips. On such eeproms, sometimes,
instead of doing an eeprom read, they actually do an I2C write.

There are enough known reported cases of such troubles with TV boards
that we even added a contrib perl code at v4l2-utils to allow one to
try to restore the board's EEPROM content, in order to allow fixing an 
accidental card brick, due to an EEPROM content loss caused by this bug.

Of course, the user should have made a copy first of the content of the
eeprom, or to find, at the net, a valid content for his board. This is
easier said than done.

Knowing nothing about how the DIMMs are manufactured, I can think on an
hypothetical scenario where a manufacturer would test the DIMM timings
and other DIMM quality parameters on their production line, and fill an
I2C EEPROM at the DIMMS after those tests, in order to determine the safe
zone for a DIMM.

So, if such scenario is possible (someone with more experience with
DIMM production could help here?), then, in thesis, a badly timed read
(or an I2C read that would be interrupted by a SMI call that would also
touch at the same I2C bus) could damage the EEPROM content, bricking
the DIMM.

Well, what I'm trying to say is that, before implementing any solution
that reads data directly from the DIMM I2C bus (doesn't matter if in
userspace or Kernelspace), we should know for sure that this won't cause 
DIMM loses, either by overheating them or by causing a corruption on the
information that stores the DIMM size and timings on each DIMM slot.

So, I suggest to not commit any patches here, without a careful
review from an Intel engineer that would then be sure that:
- the BIOS will respect POLL_EN;
- there will be no way to accidentally write data at DIMM control eeproms;
- that current and newer microcode/firmware updates will keep such driver
  reliable in the long term.

That's said, as there are critical timings at the driver (so udelay is
needed), and a precise time can't be warranted in userspace - as the
userspace process may be interrupted during an userspace usleep() call - I
would very much prefer to have this implemented at Kernelspace level.

Regards,
Mauro
