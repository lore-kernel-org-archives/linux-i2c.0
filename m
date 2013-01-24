From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c-nforce2: fix coding style issues
Date: Thu, 24 Jan 2013 08:27:24 +0100
Message-ID: <20130124072723.GI8364@nekote.pengutronix.de>
References: <1357826862-4975-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1357826862-4975-1-git-send-email-laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 10, 2013 at 03:07:42PM +0100, Laurent Navet wrote:
> avoid these checkpatch.pl issues :
> - ERROR: "foo * bar" should be "foo *bar"
> - ERROR: switch and case should be at the same indent
> - ERROR: "(foo*)" should be "(foo *)"
> - ERROR: do not use assignment in if condition
> - ERROR: space required before the open parenthesis '('
> - WARNING: suspect code indent for conditional statements
> - WARNING: quoted string split across lines
> - WARNING: space prohibited between function name and open parenthesis '('
> - WARNING: line over 80 characters
> also add spaces around some "+", "=", "*"
> 
> Signed-off-by: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks, applied to for-next.
