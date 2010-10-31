From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping  global state
Date: Sun, 31 Oct 2010 10:56:29 +0100
Message-ID: <20101031105629.109dd2e2@endymion.delvare>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	<20101030182458.0849f295@endymion.delvare>
	<20101030230052.GP21564@trinity.fluff.org>
	<1288480327.4570.2.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288480327.4570.2.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 30 Oct 2010 19:12:07 -0400, David Woodhouse wrote:
> On Sun, 2010-10-31 at 00:00 +0100, Ben Dooks wrote:
> >=20
> > > I'd rather stick to (C). Using non-ASCII characters is asking for
> > > trouble, and this doesn't add value.
> >=20
> > IIRC, and IANAL, (C) is not sufficient in certain areas (such as th=
e UK)
> > to declare copyright. It needs to be either the word Copyright in f=
ull,
> > or the proper 'c' in circle. Both is of coures better.=20

"Copyright" is there, so we're all set.

"Copyright (C)" has been used for decades and was never reported to be
insufficient.

> This is the 21st century =E2=80=94 we really don't have to stick to A=
SCII any
> more.

=2E.. says the guy who was unable to send a properly formatted patch to=
 me
yesterday. They had no charset info, and "file" says "ISO-8859 mail
text".

Yeah, I know, sent from your phone, blah, whatever, this just confirms
my point that using non-ASCII chars is asking for trouble.

Let me summarize:

* You send patches directly to Linus instead of having them reviewed by
  the people listed in MAINTAINERS.
* You do that on the last day of the merge window, and I've never even
  heard of these patches before.
* Your patches are far from perfect.
* You dare make things even more complex by adding charset issues into
  the mix.

Seriously, if you were not who you are, I'd just give up and ignore
your patches altogether.

--=20
Jean Delvare
