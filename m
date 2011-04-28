From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: append hardware lock with bus lock
Date: Thu, 28 Apr 2011 15:37:24 +0100
Message-ID: <20110428143724.GQ17290@n2100.arm.linux.org.uk>
References: <1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com> <20110428102212.2d8d607c@endymion.delvare> <BANLkTin6jguQue_0Y74jGPnmhCcvWLBjHg@mail.gmail.com> <20110428161625.5eaacb85@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110428161625.5eaacb85-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 28, 2011 at 04:16:25PM +0200, Jean Delvare wrote:
> Are you suggesting that the hardware lock wouldn't mind being taken
> twice by the AP side? If it is the case, then indeed the software mutex
> is still needed to prevent it from happening.
> 
> That being said... I guess that avoiding a priority inversion is a good
> enough reason to always take the rt_mutex, regardless of the hardware
> lock implementation.
> 
> So, this patch is
> 
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> I guess it makes more sense for me to let Ben apply it, as the other
> two patches in the series are for him too. This will avoid a dependency
> between our trees.

Only change I'd suggest is passing adapter to the hardware_lock/unlock
methods.  Having no arguments what so ever in generic code for this kind
of stuff looks rather strange and limiting.
