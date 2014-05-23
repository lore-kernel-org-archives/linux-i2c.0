From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: Fri, 23 May 2014 17:57:13 +0400
Message-ID: <CAMo8Bf+ApZUWB27zkCTBy7MLVaf3r4GiMFhFftocmJOScVSQww@mail.gmail.com>
References: <20140521113029.GT2708@katana>
	<20140523131722.GA28143@curry>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140523131722.GA28143@curry>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 23, 2014 at 5:17 PM, Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org> wrote:
> Removing drivers without a replacement tested and running
> doesn't make much sense, except one chooses to drop support
> for the whole S6 thing right away. Which I don't support.

Oscar, do you mean that you don't support the platform or that
you don't support its removal?

I'm pretty sure it's broken now, since there's no hardware to test on
and even no compiler for it (IIRC a recent attempt to get a toolchain
overlay for s6000 failed, see
http://lists.linux-xtensa.org/pipermail/linux-xtensa/Week-of-Mon-20130617/001099.html
).

-- 
Thanks.
-- Max
