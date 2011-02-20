From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Add i2c support
Date: Sun, 20 Feb 2011 15:57:19 -0800
Message-ID: <AANLkTikx0HbBaPeRi3o69wicVCEE-KgOBiw1F8tWi7AW@mail.gmail.com>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4D5B10E3.5030208@fluff.org>
	<AANLkTinZffOGSfOoNY4=8UzRDEVHHDdGXE26V3mbHm93@mail.gmail.com>
	<20110220233829.GM15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110220233829.GM15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 20, 2011 at 3:38 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
<snip>

>> > you know, there's a readsl() function that does this.
>> I think readsl can't handle the possibly unaligned buf pointer.
>
> it does. see arch/arm/lib/io-writesl.S for proof.
You're right, I traced the wrong definition of readsl/writesl

>> > this whole function gives me the creeps, is there any reason why
>> > we can't use the readsl or similar functions for this?
>> Same here - readsl can't handle the alignment requirements, readsb
>> can't =A0handle the required 32 bit register read, and the bytes in =
the
>> same word but after the end buf may not be part of buf, so byte writ=
es
>> to buf are required.
>
> You'll find it can, too. arch/arm/lib/io-readsl.S.
I still think readsl doesn't work here.  It may need to read 7 bytes,
requiring 2 calls to readl, but 1 word write and 3 byte writes to buf.
 Using readsl for the whole buffer would overwrite the 8th byte.  I
can use readsl for the main loop, but I will still need to write the
last 1-3 bytes separately.  I could use readl and memcpy to do the
last writes.
