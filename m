From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: Wed, 11 Jun 2014 10:51:54 +0200
Message-ID: <20140611085154.GA9892@minime.bse>
References: <20140521113029.GT2708@katana>
 <20140523131722.GA28143@curry>
 <537F8652.1090807@zankel.net>
 <20140524154727.GA20634@curry>
 <20140527223557.GA9594@minime.bse>
 <20140609220635.GA3329@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140609220635.GA3329@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marc Gauthier <marc-66fqrpuXKgGB+jHODAdFcQ@public.gmane.org>, Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 10, 2014 at 12:06:35AM +0200, Wolfram Sang wrote:
> On Wed, May 28, 2014 at 12:35:57AM +0200, Daniel Gl=F6ckner wrote:
> > At work we still have the overlay as part of the board support pack=
age
> > we created for the s6105. But I'd prefer to talk to someone at Stre=
tch
> > first before handing out copies. Unfortunately I'm on vacation righ=
t
> > now and will be without internet access from tomorrow to Sunday.
>
> Ping. Is that the only known platform for the s6000?

The only platform we know of.

These chips were showcased as H.264 encoders, so it is more likely
to find them inside cameras, DVRs, and studio equipment. But there
is no H.264 IP block inside the chips and their instruction set is
generic (actually runtime reconfigurable), so they are not restricted
to video processing.

  Daniel
