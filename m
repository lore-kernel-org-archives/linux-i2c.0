From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [Bug 35572] eeprom module: modprobing hangs
Date: Thu, 02 Jun 2011 21:30:05 +0100
Message-ID: <d08817$5rsvf@azsmga001.ch.intel.com>
References: <bug-35572-10286@https.bugzilla.kernel.org/> <20110601144240.9525825b.akpm@linux-foundation.org> <201106021753.50961.markotahal@gmail.com> <20110602161742.1b22051a@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110602161742.1b22051a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Marek Otahal <markotahal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2 Jun 2011 16:17:42 +0200, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> For the long term, I think that the i2c implementation of i915 should
> be reworked. Having two i2c adapters per actual bus, one for hardware
> controlled and one for software controlled, is confusing and dangerous.
> And creating a bus on the fly in the middle of a transaction is just as
> bad. If you really can't instantiate only the one you need, then you
> should instantiate the software controlled one (i2c_bit_add_adapter),
> then update the algorithm to switch to hardware controlled where
> possible, and ultimately undo that update if the hardware controller
> turns out to be non-working. I can't write the code as I don't have any
> supported piece of hardware and I'm not familiar with the code, but I
> can help review any patch if you want.

Reading email, in reverse order...

Thanks Jean, I will try to do you've outlined.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
