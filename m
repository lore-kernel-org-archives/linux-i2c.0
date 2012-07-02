From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/8 v3] i2c: i801: check INTR after every transaction
Date: Mon, 2 Jul 2012 17:16:20 +0200
Message-ID: <20120702171620.5628d044@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-4-git-send-email-djkurtz@chromium.org>
	<20120627180724.762f854a@endymion.delvare>
	<20120701232051.308c03d1@endymion.delvare>
	<CAGS+omDV_ynBL-PN0qmLmDRiHGbQFf+TwqC2-+KJY8zy9FDhrA@mail.gmail.com>
	<20120702120814.47d71bc5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120702120814.47d71bc5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2 Jul 2012 12:08:14 +0200, Jean Delvare wrote:
> On Mon, 2 Jul 2012 09:19:24 +0800, Daniel Kurtz wrote:
> > My understanding is that the INTR wait is really waiting for the
> > entire transaction to complete (ie., including i2c STOP condition),
> > not just the byte transfer phase.
> 
> This is my understanding as well, but I'm fairly certain that this is
> the case of the BUSY flag as well. I think BUSY gets cleared at the
> same time INTR (or any of the error status bits) gets set. Which is why
> I think checking BUSY is redundant. As a matter of fact, we ignore BUSY
> completely in i801_block_transaction_byte_by_byte(), so I see no reason
> why we couldn't do the same in i2c_transaction().

To be complete, I made some testing and error bits can be set before
BUSY is cleared. I spotted several transitions 0x41 -> 0x45 -> 0x44
when accessing non-existent devices. On success, I never witnessed INTR
and BUSY being set at the same time, transition is always 0x41 -> 0x42.

-- 
Jean Delvare
