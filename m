From: "Oskar Schirmer" <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: 23 May 2014 13:17:22 +0000
Message-ID: <20140523131722.GA28143@curry>
References: <20140521113029.GT2708@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140521113029.GT2708@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org,  Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, May 21, 2014 at 13:30:29 +0200, Wolfram Sang wrote:
> I recently discovered that the I2C core of the S6000 is basically a
> Designware IP core. For the latter we have a frequently used and updated
> i2c driver while the S6000 driver seems to bitrot. My wish is to remove
> the s6000 driver in favor of the DesignWare one. My question is if there
> is someone who could test such a change on real hardware?
> Grepping through sources, it looks to me like the only candidate in
> mainline is the s6105, yet its defconfig doesn't even have I2C
> activated? Can we remove this driver right away? Am I missing something?

Removing drivers without a replacement tested and running
doesn't make much sense, except one chooses to drop support
for the whole S6 thing right away. Which I don't support.

best regards,
  Oskar
