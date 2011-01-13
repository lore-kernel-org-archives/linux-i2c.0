From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [pull] Please pull bjdooks' i2c git
Date: Thu, 13 Jan 2011 10:43:42 -0800
Message-ID: <AANLkTikMFYnHdzBX34-YO1APRLvrnFgkDyN13WpJO8Ox@mail.gmail.com>
References: <E1Pd9Bg-0001Lb-SI@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1Pd9Bg-0001Lb-SI@ben-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 12, 2011 at 2:29 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
>
> Ben Dooks (7):
> =A0 =A0 =A0Merge branch 'for-2638/i2c/mv64xx' into for-linus/i2c-2638
> =A0 =A0 =A0Merge branch 'for-2638/i2c/omap' into for-linus/i2c-2638
> =A0 =A0 =A0Merge branch 'for-2638/i2c/iop' into for-linus/i2c-2638
> =A0 =A0 =A0Merge branch 'for-2638/i2c/ocores' into for-linus/i2c-2638
> =A0 =A0 =A0Merge branch 'for-2638/i2c/intel' into for-linus/i2c-2638
> =A0 =A0 =A0Merge branch 'for-2638/i2c/nomadik' into for-linus/i2c-263=
8
> =A0 =A0 =A0Merge branch 'for-2638/i2c/bfin2' into for-linus/i2c-2638

Btw, this is where octopus merges are just very nice.

IOW, just do

      git merge for-2638/i2c/mv64xx for-2638/i2c/omap for-2638/i2c/iop
for-2638/i2c/ocores for-2638/i2c/intel for-2638/i2c/nomadik
for-2638/i2c/bfin2

and it actually ends up looking much better.

Of course, it does make bisecting a bit harder, but when you have lots
of branches with just one or two commits each, and they are pretty
independent (so a bug in one is unlikely to be mistaken for a bug in
another), octopus really is the way to go.

Anyway, pulled.

                 Linus
