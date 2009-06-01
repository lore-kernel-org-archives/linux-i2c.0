From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C patch merging for embedded systems
Date: Mon, 1 Jun 2009 18:49:47 -0400
Message-ID: <8bd0f97a0906011549k305aeaa8u8c5fe6563862335e@mail.gmail.com>
References: <8bd0f97a0905312242k451f5492g1a9b3e6d7f7899a3@mail.gmail.com>
	 <20090601224702.GJ14476@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090601224702.GJ14476-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 1, 2009 at 18:47, Ben Dooks wrote:
> On Mon, Jun 01, 2009 at 01:42:27AM -0400, Mike Frysinger wrote:
>> going by MAINTAINERS, Ben Dooks watches over embedded platforms. =C2=
=A0does
>> that mean you'll merge patches posted (e.g. the Blackfin I2C driver)=
,
>> or should i merge them through the Blackfin tree ? =C2=A0or will Jea=
n still
>> do this via his quilt ?
>
> Even if they are going via the blackfin tree, they need to have been
> reviewed on ther i2c list by at-least myself and anyone else interest=
ed
> in these.

i wasnt proposing not sending them out (in fact, ive already posted
them all).  reviewing is fine, but that doesnt help actually getting a
patch merged.

> For driver additions, I would prefer if they went via me so that we
> don't end up with merge fun in the Kconfig of Makefiles.

ok, i'll expect you to merge them then and wont try through my tree.
in the future, i'll tweak the to/cc to include you.  thanks!
-mike
