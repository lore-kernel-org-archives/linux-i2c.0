From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: I2C from interrupt context?
Date: Mon, 10 Nov 2008 23:57:34 -0800
Message-ID: <20081110235734.f7666725.akpm@linux-foundation.org>
References: <m3bpws8ln3.fsf@maximus.localdomain>
	<20081106.154754.02648408.davem@davemloft.net>
	<20081107101118.286f3713@hyperion.delvare>
	<m3bpwrbjxs.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m3bpwrbjxs.fsf-fiqtE+24Nu0B9AHHLWeGtNQXobZC6xk2@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 07 Nov 2008 17:05:35 +0100 Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org> wrote:

> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> 
> > The situation is far from perfect though. For one thing, I seem to
> > recall that Andrew Morton didn't like the approach taken in
> > i2c_transfer(). For another, i2c_smbus_xfer() was not yet modified so
> > at this point only I2C-level transactions can be non-sleeping,
> > SMBus-level transactions can't. But all this could be fixed by anyone
> > who cares about these specific issues.
> 
> Thanks, I'll look at it.

The problem (well: bug) is that in_atomic() returns false inside a
spinlock when CONFIG_PREEMPT=n.  The code as it stands can sleep
inside a spinlock, which is deadlockable if a scheduled-to task
tries to take the same spinlock.

There is no means like this by which a piece of code can determine
whether it can call schedule().  The pattern which we use in many many
places (most especially GFP_KERNEL/GFP_ATOMIC) is to pass a flag down
to callees telling them in some manner which context they were called from.
