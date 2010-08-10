From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Wed, 11 Aug 2010 00:44:18 +0100
Message-ID: <20100810234417.GA28671@trinity.fluff.org>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com> <20100420000621.GK32401@fluff.org.uk> <AANLkTikJ6XDywcBA5O0mC85jQEIWxZ9NOALIQOjcGCDJ@mail.gmail.com> <AANLkTinNXxzCoH+b3=xA92sW8GCqqO4iY+_yVwBFLMqG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinNXxzCoH+b3=xA92sW8GCqqO4iY+_yVwBFLMqG-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 10, 2010 at 08:56:27AM -0700, Kevin Hilman wrote:
> Ben,
>=20
> On Mon, Jun 21, 2010 at 1:16 PM, Kevin Hilman
> <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> > On Mon, Apr 19, 2010 at 5:06 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wr=
ote:
> >> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
> >>> This series of davinci I2C driver updates and fixes is targetted =
for
> >>> 2.6.35. =A0It has been tested in davinci git on multiple davinci =
SoCs.
> >>>
> >>> Ben, since these changes are isolated to the davinci driver only,=
 if
> >>> you prefer I can merge them upstream along with my davinci change=
s for
> >>> 2.6.35.
> >>
> >> I'll get them into -next when I rebase it.
> >
> > Ben, this series never made it in for 2.6.35.
> >
> > I've now rebased this against v2.6.35-rc3 and it's available here:
> >
> > =A0 git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-dav=
inci.git
> > davinci-i2c
> >
> > Please pull for 2.6.36. =A0Thanks.
>=20
> OK, it's now been two merge windows that these have been
> ignored/forgotten.  Can you let me know what is the plan for these?

pulled into current i2c-next, will send in the next day or so.

--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
