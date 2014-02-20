From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Wed, 19 Feb 2014 17:39:07 -0800
Message-ID: <CALCETrVwSj3KGcPqQD2Kd9W5FCHyPWLukCVr0BZLdQc_Fgz4qA@mail.gmail.com>
References: <cover.1387588711.git.luto@amacapital.net> <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
 <20140219151626.GA13973@katana> <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
 <20140220035128.14da0f79.m.chehab@samsung.com> <3908561D78D1C84285E8C5FCA982C28F31DCC6F8@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31DCC6F8-P5GAC/sN6hlZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 19, 2014 at 11:03 AM, Luck, Tony <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> (I'm c/c Tony here, as he also shared the same concern that I had on a
>> previous feedback about using I2C to talk with the DIMM).
>
> Correct - I've heard the same issues that reads on I2C can be misinterpreted
> as writes ... and oops, you have a brick.

Is this true on DDR3 DIMMs, i.e. anything that's compatible with
LGA2011?  If you plug a DIMM into an LGA2011 board's memory slot,
then, one way or another, it's very likely that there will be TSOD
traffic, if for no other purpose than to determine that there is no
TSOD present.  TSOD traffic consists of reads and writes, both with
and without register numbers.  (Sorry, I can never remember the smbus
terminology here -- the relevant transactions are two-byte reads and
two-byte writes, both with a command specified and without one.  One
of the bits in the iMC SMBUS registers tells the controller which kind
of read to use to probe the thermometer.)

>
> What is the larger context/  What problem are we trying to solve?

NV-DIMM control registers are exposed via i2c, presumably because
trying to access them through the memory pins would be a giant mess.
So, one way or another, something needs to be able to initiate
transactions to access those registers.  BIOS will do some initial
setup, but the OS will need to poke at these registers, too.  (The
actual docs are covered by NDA.  I suspect that this will change if
the manufacturers ever want these things to be widely used, though,
since these things really want a full-featured kernel driver so that
things like pmfs will work cleanly.)

As a secondary benefit, having access to the TSOD and SPD is nice,
albeit far from critical.

AFAICT Intel actively working on NV-DIMM-related things, so maybe
Intel will contribute an engineer who help :)

--Andy

>
> -Tony



-- 
Andy Lutomirski
AMA Capital Management, LLC
