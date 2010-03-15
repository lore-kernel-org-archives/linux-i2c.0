From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Mon, 15 Mar 2010 11:06:45 +0100
Message-ID: <20100315110645.1df3e4f0@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	<20100222225805.00432574@hyperion.delvare>
	<af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	<20100228120817.275ef279@hyperion.delvare>
	<af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
	<20100228211949.3297a0ff@hyperion.delvare>
	<af0693f01003020453m7ca6891bjca4833c7fa45f44d@mail.gmail.com>
	<20100312141901.04299a55@hyperion.delvare>
	<20100312172421.5b4907e6@hyperion.delvare>
	<af0693f01003150243u4d4d76e7t71b37ecd452896ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01003150243u4d4d76e7t71b37ecd452896ea-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 15 Mar 2010 11:43:48 +0200, Felix Rubinstein wrote:
> Hi Jean,
> 
> On Fri, Mar 12, 2010 at 6:24 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > FWIW, testing on my ICH3-M (SMBus block read), I get a delay between
> > bytes of 460 us. This is a maximum bus speed of 19.6 kHz. Same test on
> > an ICH5 reports a delay of 670 us, which would be 13.5 kHz max. I have
> > a hard time believing that you got delays below 100 us on your ICH9...
> >
> > Also note that, in both cases, the first delay is always much larger,
> > as the controller must send the beginning of the transaction up to the
> > second data byte. The SMBus block read is the worst case scenario, as
> > it must first send an address byte, the command byte, then the address
> > byte again (direction change), then it reads the block length and
> > finally the first data byte. This is 45 bits on the wire, not counting
> > the start conditions. I get a ~2380 us delay on ICH3-M and ~3420 us
> > delay on ICH5.
> >
> > So changing the code the way you suggested isn't trivial. Busy-waiting
> > for up to 3500 us for the first transaction isn't very appealing.
> > Busy-waiting for a total of 3500 + 670 * 31 (worst case) = 24270 us or
> > almost 25 ms, is hardly pleasant either, latency will suffer, it's
> > almost worse than software bit-banging. Now I have to agree that the
> > current implementation ("long" sleeps) isn't good either. Maybe the
> > msleep(0) approach would be the least evil... Oh well, at some point we
> > really want to switch to interrupts.
>
> Thanks for prompt reply :)
> I'll provided more number later on, once I get to it in the lab.
> I have it in my mind to dig into ICH9 data sheet (for the start) to
> add interrupt support.
> Btw, have anyone started it?

Oh yes, twice. Mark M. Hoffman tried first, with a brand new driver.
Then Ivo Manca (Cc'd) gave it a try, this time modifying the existing
driver.

The problem with Mark's implementation was that it lacked support for
block transactions, so we couldn't replace the original driver with
his. We did not want to maintain two drivers in parallel, and block
support was never added to the new driver, so Mark's driver did not go
anywhere.

The problem with Ivo's work was that the driver would lock up the bus in
some cases (I can't remember the details any longer, sorry) and we did
not manage to solve this bug. This issue blocked further integration,
and once again the efforts were lost. I can provide Ivo's latest
patches if you want to see what they looked like. With some work, it
should be possible to get them to apply again. I would much prefer
fixing Ivo's patches than starting from scratch again.

-- 
Jean Delvare
