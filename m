From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [I2C] informations + advice about messages handling
Date: Fri, 24 May 2013 14:10:10 +0200
Message-ID: <20130524141010.1b3590b4@endymion.delvare>
References: <CA78C307B8F06747967D122FC656B153986448@SERVEUR0.nvp.local>
	<CAK7N6vpg6QUAKODKO2Msr4+GTASLDpA2cG1teQV3yiwt7D4SSw@mail.gmail.com>
	<20130524094407.61d0ec42@endymion.delvare>
	<CAK7N6vqqG68c4vx1uBsNLF8zpSRQWwY5jERqjVYKE7NkEEzFSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7N6vqqG68c4vx1uBsNLF8zpSRQWwY5jERqjVYKE7NkEEzFSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mylene Josserand <Mylene.Josserand-207QzMZ2trZBDgjK7y7TUQ@public.gmane.org>, kernelnewbies <kernelnewbies-7JyXY6prKcjpASu1u0TL5ti2O/JbrIOy@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-mail <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 24 May 2013 16:29:36 +0530, anish singh wrote:
> On Fri, May 24, 2013 at 1:14 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wr=
ote:
> > On Fri, 24 May 2013 12:52:40 +0530, anish singh wrote:
> >> http://thread.gmane.org/gmane.linux.kernel/1410276
> >
> > This is for a specific case. The general case is handled by the
> > per-adapter mutex for years now. 2.6.32 should be just fine in this
> > respect.
>
> I may be mis-understanding here but when two client wants to
> communicate with same master and at the same
> time how does that happen?

In general clients (slaves in I2C terminology) do not initiate
transactions, it's the master's job.

> In the thread I mentioned client pulls the line low indicating that
> it wants to own the bus and waits for some time and then checks
> if the line is still low or not.If it is still low then it owns the b=
us
> and start transaction and if clients see otherwise it releases the
> bus and tries again after some time.How is that handled in the
> previous kernel?

That particular scenario is not handled by earlier kernels, but this is
a very special case. In most cases (including Myl=C3=A8ne's as far as I=
 can
see) it is not needed because there is a single master on the segment.
And even with multiple masters, I2C bus arbitration normally takes plac=
e
transparently. Only when the standard bus arbitration can't work for
some reason, the code you mentioned is needed.

--=20
Jean Delvare
