From: Hermann Pitton <hermann-pitton-KvP5wT2u2U0@public.gmane.org>
Subject: Re: [2.6.31] ir-kbd-i2c oops.
Date: Wed, 30 Sep 2009 01:26:23 +0200
Message-ID: <1254266783.2657.11.camel@localhost>
References: <200909160300.28382.pluto@agmk.net>
	 <20090916085701.6e883600@hyperion.delvare>
	 <200909161003.33090.pluto@agmk.net>
	 <20090929161629.2a5c8d30@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090929161629.2a5c8d30-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: =?UTF-8?Q?Pawe=C5=82?= Sikora <pluto-PIIpFW8S9c0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LMML <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Am Dienstag, den 29.09.2009, 16:16 +0200 schrieb Jean Delvare:
> On Wed, 16 Sep 2009 10:03:32 +0200, Pawe=C5=82 Sikora wrote:
> > On Wednesday 16 September 2009 08:57:01 Jean Delvare wrote:
> > > Hi Pawel,
> > >=20
> > > I think this would be fixed by the following patch:
> > > http://patchwork.kernel.org/patch/45707/
> >=20
> > still oopses. this time i've attached full dmesg.
>=20
> Any news on this? Do you have a refined list of kernels which have th=
e
> bug and kernels which do not? Tried 2.6.32-rc1? Tried the v4l-dvb
> repository?
>=20
> Anyone else seeing this bug?

I can see you ask the other way round, but just in case, I don't have
that bug neither on some self compiled 2.6.30 with recent mercurial
v4l-dvb on some outdated Fedora nor on a=20

Linux localhost.localdomain 2.6.30.5-43.fc11.x86_64 #1 SMP Thu Aug 27
21:39:52 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux

with my recently purchased older Pinnacle 310i.

Hm, there are different versions of that card, to have it mentioned,
obviously also with different remotes, and I can't tell how to identify
them.

> Your kernel stack trace doesn't look terribly reliable and I am not
> able to come to any conclusion. The crash is supposed to happen in
> ir_input_init(), but the stack trace doesn't lead there. I am also
> skeptical about the +0x64/0x1a52, ir_input_init() is a rather small
> function and I fail to see how it could be 6738 bytes in binary size.
> Might be that the bug caused a stack corruption. Building a debug
> kernel may help.

Cheers,
Hermann
