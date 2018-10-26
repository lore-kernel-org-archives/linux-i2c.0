From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Date: Fri, 26 Oct 2018 15:21:31 +0200
Message-ID: <CAK8P3a08jhpUZyiGsUVUFggi1C88SAqYHG7CY1GysZN7iwm5gw@mail.gmail.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
 <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
 <20181025180720.1790f6a1@bbrezillon> <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
 <20181025183005.3c0fa452@bbrezillon> <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
 <20181026095707.3cd9b511@bbrezillon> <CAK8P3a0_En6e6ORvNqxprBcsT3+NmFO8nFnQ3nNiv-5Hq2LjrQ@mail.gmail.com>
 <20181026144647.11926142@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026144647.11926142@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@he>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 26, 2018 at 2:46 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Fri, 26 Oct 2018 12:01:52 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Oct 26, 2018 at 9:57 AM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > > On Fri, 26 Oct 2018 09:43:25 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > On Thu, Oct 25, 2018 at 6:30 PM Boris Brezillon
> > > > <boris.brezillon@bootlin.com> wrote:
> > > > > On Thu, 25 Oct 2018 18:13:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > > > > > On Thu, 25 Oct 2018 17:30:26 +0200
> >
> > This is apparently not allowed on ARC when 'buffer' is
> > unaligned. I think what we need here is to use
> > put_unaligned() instead of the pointer dereference.
> > For architectures that can do unaligned accesses,
> > the result is the same, but for ARC it will fix the problem.
>
> Okay, so writesl()/readsl() should deal with unaligned pointers, and
> default implementations should be fixed. I guess you'll send a patch to
> use put/get_unaligned().

That's one way of doing it, though thinking about it some more,
this can also introduce overhead on machines that don't support
unaligned buffers and only work on drivers that are guaranteed
to see fully aligned data.

We could also override these specifically for ARC, and risk
running into the same problem elsewhere, rather than be sure
to fix everyone while risking to introduce noticeable performance
regressions in existing drivers.

> > > > One way to address this might be to always bounce any
> > > > messages that are less than a cache line through a
> > > > (pre-)kmallocated buffer, and require any longer messages
> > > > to be cache capable. This could also solve the issue with
> > > > readsl(), but it would be a rather confusing user interface.
> > > >
> > > > Another option might be to have separate interfaces for
> > > > "short" and "long" messages at the API level and have
> > > > distinct rules for those: short would always be bounced
> > > > by the i3c code, and long puts restrictions on the buffer
> > > > location.
> > >
> > > Hm, let's keep the API simple. I'll just mandate that all payload bufs
> > > passed to i3c_master_send_ccc_cmd_locked() be dynamically allocated.
> >
> > Ok. What about i2c commands sent to the same i3c controller
> > then?
>
> Still not taken care of.
>
> > Do we need to copy those to satisfy the requirements
> > of the i3c layer?
>
> I guess we should. The question is, should we do that unconditionally
> or should we try to optimize thins with something like:
>
>         if (!virt_addr_valid(xfer->buf) ||
>             object_is_on_stack(xfer->buf))
>                 /* Alloc bounce buf. */
>         else
>                 /* Use provided buf. */

There may be too many cases that we need to handle here that
are not DMA capable. To be on the safe side, I'd probably always
copy all data that is not a multiple of fully aligned cache lines,
as well as pointers that fails to meet some other requirements
(stack, vmalloc, kmap, ...)

        Arnd
