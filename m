From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: falling back to bit banging on pin 7 freeze boot
Date: Sat, 23 Apr 2011 13:09:29 +0200
Message-ID: <20110423130929.5934f41d@endymion.delvare>
References: <BANLkTim7xsZ5D7ifatLS7ifmOXxi9DG5Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTim7xsZ5D7ifatLS7ifmOXxi9DG5Ug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yermandu Patapitafious <yermandu.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 20 Apr 2011 14:12:16 -0300, Yermandu Patapitafious wrote:
> In .39 Im getting freeze on boot.

2.6.39 isn't released yet. When reporting problems with pre-releases,
please always mention the exact version you have been testing. You
should also always mention which hardware you're running on.

> 
> Stoped at
> [drm] GMBUS timed out, falling back to bit banging on pin 0 [i915 gmbus disabled]
> [drm] GMBUS timed out, falling back to bit banging on pin 6 [i915 gmbus reserved]
> [drm] GMBUS timed out, falling back to bit banging on pin 7 [i915 gmbus dpd]
> i2c.i2c-5 master_xfer[0]
> arch_local_irq_disable

There's nothing we can do for you, I'm afraid. Assuming that you didn't
see these timeouts in 2.6.38, please report to the i915 driver
maintainers. It might help if you are able to bisect and find out which
exact commit introduced the regression.

-- 
Jean Delvare
