From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: pxa i2c unit busy caused unrecoverable phone hang problem
Date: Sun, 3 May 2009 23:33:51 +0100
Message-ID: <20090503223351.GC5750@fluff.org.uk>
References: <fd6b62c10904270057w610239dflfd228f949c0649b2@mail.gmail.com> <20090427120810.20af38b8@hyperion.delvare> <49F58A01.6060401@compulab.co.il> <fd6b62c10904270641p1dc6d86awc271dcc10a1f6b0@mail.gmail.com> <fd6b62c10904270832w54c77fb3kdff9981d949ff54b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fd6b62c10904270832w54c77fb3kdff9981d949ff54b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ?????? <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, yi.ru-SckdOjWYlhYAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 27, 2009 at 11:32:26PM +0800, ?????? wrote:
> Hi,
> 
> As a compromise,we hope make the phone system free to run even the i2c
> subsystem become busy already.Then there maybe time to choose some
> useful way to solve that. The console can not input when phone hang
> now.
> 
> So we try to make the sleep time in i2c layer long enough,but the
> result not well,because there are many threads waiting for i2c bus
> operation.The key threads such as serial console could not get chance
> to run,or cannot interact with user timely.
> 
> Anyone could give a hand about this?

Generally, if you're increasing sleep times, then you've either got
an electrical issue with the bus, or there is a device on there which
is causing the bus to be slowed down.

Firstly, electrical issues:

1) Verify by measuring the clock pulses on the bus that it is
   running at the rate you expcet it to be. It can be very
   embarasing stating that your bus is 100KHz, when your hardware
   engineer's scope is saying 100Hz.

2) Are the rise times on either of SCL or SCA excessive? The bus
   relies on something pulling these lines inactive, and if there
   is either insufficient pull-up resitance (4.7 - 10K for 100KHz
   is iirc recommend) or too much capacitance then the bus can be
   held up waiting for these signals to reach inactive after they
   have been asserted

3) Are all the chips soldered on correctly and in the correct
   orientation?

4) Has the board been tested and known to work?

5) Get a logic analyser and watch the traffic, look for how long
   it takes to complete a transaction and how often they are being
   issued.


Another issue is are there any 'soft' devices on the bus, such as
a power management microcontroller. If there are any devices that
have (or have to) have firmware to work, do they have the correct
firmware and has this firmware been verified to work?

My last real PXA work was ~2.6.9, but it was working fine then. I
currently don't have any PXA devices with working kernels to do
any testing of a current kernel.
 
> Thanks in advance again.
> 
> --Yize
> 
> 2009/4/27 ?????? <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > thanks your reply ,Jean and Mike
> >
> > Winston Churchill ??- "The best argument against democracy is a five-minute conversation with the average voter."
> >
> > 2009/4/27 Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> >>
> >>
> >> Jean Delvare wrote:
> >> > On Mon, 27 Apr 2009 15:57:45 +0800, ?????? wrote:
> >> >> We use Marvell's pxaXXX chip,and the i2c unit often become BUSY status .As
> >> >> normal operation,the Unit-Busy will become free quickly,but sometimes
> >> >> UNIT-BUSY forever.For there are very frequent i2c operations,the cell-phone
> >> >> become hang soon,nothing could be done but remove the battery and reboot.
> >> >>
> >> >> So could you give a suggestion? ??Is there any useful way to protect from
> >> >> entering this abnormal UNIT-BUSY i2c status or recover from that?
> >>
> >> PXA I2C controller often reports BUSY when one of the I2C lines are held low.
> >> Verify you have proper pull-ups and that devices connected to I2C bus behave in
> >> a sane way.
> >
> > Yes,we do.The unrecoverable problem is UNIT-BUSY,we still be confused by the root cause.Now we guess there are two types of answers:
> >
> > 1) Another master left I2C busy in abnormal status after operation
> > 2) Protocol conflict violation caused by messages transfer,such as the?? too large?? message or wrong operation.Most of the time,I2C works fine.
> >
> > We thought there would be some reset mechasim in that bad situation,but not.
> > There are many threads waiting for the mutex lock while the current operating one is trying,trying,and trying,,,but I2C Unit Busy block all.
> >
> > -- Yize
> >>
> >> > I don't know anything about PXA platforms, there's nothing I can do for
> >> > you, sorry.
> >> >
> >>
> >> --
> >> Sincerely yours,
> >> Mike.
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
