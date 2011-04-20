From: Yermandu Patapitafious <yermandu.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: falling back to bit banging on pin 7 freeze boot
Date: Wed, 20 Apr 2011 14:12:16 -0300
Message-ID: <BANLkTim7xsZ5D7ifatLS7ifmOXxi9DG5Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In .39 Im getting freeze on boot.

Stoped at
[drm] GMBUS timed out, falling back to bit banging on pin 0 [i915
gmbus disabled]
[drm] GMBUS timed out, falling back to bit banging on pin 6 [i915
gmbus reserved]
[drm] GMBUS timed out, falling back to bit banging on pin 7 [i915 gmbus dpd]
i2c.i2c-5 master_xfer[0]
arch_local_irq_disable


-- 
yermandu
