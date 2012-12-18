From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] driver i2c-nforce2: fix pointer CodingStyle issues
Date: Tue, 18 Dec 2012 11:23:55 +0100
Message-ID: <20121218112355.69369ee1@endymion.delvare>
References: <1355778259-8445-1-git-send-email-laurent.navet@gmail.com>
	<20121218105223.0184d4a3@endymion.delvare>
	<CAH7P7Nhz2FpBct4afvAXU2Zgi-yA4TkJj7CtYMaW7pXr6weZig@mail.gmail.com>
	<20121218100906.GB2612@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121218100906.GB2612-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 18 Dec 2012 11:09:06 +0100, Wolfram Sang wrote:
> 
> > i have planned fixing these too, do you prefer one patch fixing all or
> > multiple patches (one per error/warning type )?
> 
> One patch, definately.

Yes please :)
> You can skip the 80 char thing.

For PCI device IDs, agreed.

> Are you also able to build-test the changes?

Most certainly yes, this driver has almost no dependencies. I will
build-test it anyway.


-- 
Jean Delvare
