From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH 1/3] Added empty directories for hardware sensors
Date: Mon, 2 Mar 2009 11:12:35 +0100
Message-ID: <20090302101235.GD3223@buzzloop.caiaq.de>
References: <20090226095718.GA24575@buzzloop.caiaq.de> <1235654648-3450-1-git-send-email-daniel@caiaq.de> <20090228124048.GB18336@buzzloop.caiaq.de> <5d5443650903012122p795d51cdr18c1a79c606cd496@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d5443650903012122p795d51cdr18c1a79c606cd496-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Trilok,

On Mon, Mar 02, 2009 at 10:52:38AM +0530, Trilok Soni wrote:
> >> This adds empty directories and the neccessary entries to Makefile=
s and
> >> Kconfigs in order to provide a place for hardware sensors which ar=
e not
> >> meant to be based in drivers/hwmon.
> >>
> >> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> >> ---
> >> =A0How about this approach? Take it as RFC ...
> >
> > Any oppinion on this, anyone? I'm currently writing a driver for an
> > accelerometer and will have the same uncertainty of where to put it=
 in
> > the end.
>=20
> Better to submit this patch to LKML too, as it adds new directory. Fo=
r

Did that yesterday :)

> accelerometer, few patches were submitted as "Industrial IO" framewor=
k
> from Jonathan Cameron. If you grep in LKML archive you will get the
> idea, also another place for accelerometer could be drivers/hwmon
> directory too if it fits in your driver requirements.

I realized that there is a driver for this accellerometer device
already, it's just not usable with i2c/spi accessors. I'll discuss that
now on the lkml, the question that started the thread is hence only
left open for the ambient light sensors (my own one and the tps2550 in
drivers/i2c/chips).

Daniel
