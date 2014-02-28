From: Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Fri, 28 Feb 2014 16:15:06 -0300
Message-ID: <20140228161506.62889d46@samsung.com>
References: <cover.1387588711.git.luto@amacapital.net>
 <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
 <20140219151626.GA13973@katana>
 <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
 <20140220035128.14da0f79.m.chehab@samsung.com>
 <3908561D78D1C84285E8C5FCA982C28F31DCC6F8@ORSMSX106.amr.corp.intel.com>
 <CALCETrVwSj3KGcPqQD2Kd9W5FCHyPWLukCVr0BZLdQc_Fgz4qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CALCETrVwSj3KGcPqQD2Kd9W5FCHyPWLukCVr0BZLdQc_Fgz4qA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Em Wed, 19 Feb 2014 17:39:07 -0800
Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org> escreveu:

> On Wed, Feb 19, 2014 at 11:03 AM, Luck, Tony <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >> (I'm c/c Tony here, as he also shared the same concern that I had on a
> >> previous feedback about using I2C to talk with the DIMM).
> >
> > Correct - I've heard the same issues that reads on I2C can be misinterpreted
> > as writes ... and oops, you have a brick.
> 
> Is this true on DDR3 DIMMs, i.e. anything that's compatible with
> LGA2011?  If you plug a DIMM into an LGA2011 board's memory slot,
> then, one way or another, it's very likely that there will be TSOD
> traffic, if for no other purpose than to determine that there is no
> TSOD present.  TSOD traffic consists of reads and writes, both with
> and without register numbers.  (Sorry, I can never remember the smbus
> terminology here -- the relevant transactions are two-byte reads and
> two-byte writes, both with a command specified and without one.  One
> of the bits in the iMC SMBUS registers tells the controller which kind
> of read to use to probe the thermometer.)

An update on that: I double-checked with a DIMM manufacturer.
I was told that some DIMM models have write protect circuits but
others don't.

So, yeah, accessing it could eventually brick the DIMM, depending 
on the DIMM model, if such driver won't block I2C write ops or
if the BIOS is also trying to access the bus at the same time.

Regards,
Mauro
