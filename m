From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: PNX4008: fix i2c-pnx.c build errors
Date: Fri, 20 Nov 2009 14:24:29 +0000
Message-ID: <20091120142429.GD16920@n2100.arm.linux.org.uk>
References: <20091120135932.GA16920@n2100.arm.linux.org.uk> <f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel@arm.linux.org.uk> <20091120142128.GE4808@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091120142128.GE4808-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 20, 2009 at 02:21:29PM +0000, Ben Dooks wrote:
> On Fri, Nov 20, 2009 at 11:03:29AM +0000, Russell King - ARM Linux wrote:
> > ... caused by a missing include.
> 
> hi, thought this was fixed by the last fix set I sent which went in post
> 2.6.32-rc8.

Ok, I'll rebase my master branch and drop this change.
