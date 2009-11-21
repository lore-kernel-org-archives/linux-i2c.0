From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
Date: Sat, 21 Nov 2009 18:59:47 +0000
Message-ID: <20091121185947.GD13956@n2100.arm.linux.org.uk>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk> <E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk> <63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63386a3d0911210927u47c7d6d6i65fc7d60563f8db2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Nov 21, 2009 at 06:27:54PM +0100, Linus Walleij wrote:
> If you have this up for testing anyway, would it be advisable to take this
> opportunity to also switch i2c-pnx over to using struct dev_pm_ops?

These patches are only compile-tested, and that's partly why there's soo
many of them - each one does one transformation, which makes it easy to
review for correctness.

I'm also hoping that Kevin will test them on later PNX hardware so that
they can be submitted.
