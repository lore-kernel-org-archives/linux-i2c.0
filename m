From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Add i2c support
Date: Wed, 23 Feb 2011 00:16:42 +0000
Message-ID: <20110223001642.GU15795@trinity.fluff.org>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4D5B10E3.5030208@fluff.org> <AANLkTinZffOGSfOoNY4=8UzRDEVHHDdGXE26V3mbHm93@mail.gmail.com> <20110220233829.GM15795@trinity.fluff.org> <AANLkTikx0HbBaPeRi3o69wicVCEE-KgOBiw1F8tWi7AW@mail.gmail.com> <AANLkTim0X=gUwYJmR+EAYjGamiJb7tgiVEjwqCEF0-L0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim0X=gUwYJmR+EAYjGamiJb7tgiVEjwqCEF0-L0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 20, 2011 at 04:28:46PM -0800, Colin Cross wrote:
> On Sun, Feb 20, 2011 at 3:57 PM, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wro=
te:
> > On Sun, Feb 20, 2011 at 3:38 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrot=
e:
> > <snip>
> >
> >>> > you know, there's a readsl() function that does this.
> >>> I think readsl can't handle the possibly unaligned buf pointer.
> >>
> >> it does. see arch/arm/lib/io-writesl.S for proof.
> > You're right, I traced the wrong definition of readsl/writesl
> >
> >>> > this whole function gives me the creeps, is there any reason wh=
y
> >>> > we can't use the readsl or similar functions for this?
> >>> Same here - readsl can't handle the alignment requirements, reads=
b
> >>> can't =A0handle the required 32 bit register read, and the bytes =
in the
> >>> same word but after the end buf may not be part of buf, so byte w=
rites
> >>> to buf are required.
> >>
> >> You'll find it can, too. arch/arm/lib/io-readsl.S.
> > I still think readsl doesn't work here. =A0It may need to read 7 by=
tes,
> > requiring 2 calls to readl, but 1 word write and 3 byte writes to b=
uf.
> > =A0Using readsl for the whole buffer would overwrite the 8th byte. =
=A0I
> > can use readsl for the main loop, but I will still need to write th=
e
> > last 1-3 bytes separately. =A0I could use readl and memcpy to do th=
e
> > last writes.
>=20
> Actually, the same problem applies to writesl.  If the buffer is not
> aligned, reading an entire word to get the partial word at the end of
> the buffer may cross a page boundary and fault.  I'll have to use
> writesl for the whole words and then handle the last partial word wit=
h
> memcpy and writel.

Hmm, that's an interesting one, however I suspect this is something
that will never happen as the kernel over-allocates (rounds up) buffers
when allocating memory blocks.

--=20
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
