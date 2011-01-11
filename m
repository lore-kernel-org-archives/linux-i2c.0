From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.38
Date: Tue, 11 Jan 2011 11:17:58 +0000
Message-ID: <20110111111758.GH6541@sirena.org.uk>
References: <20110110222145.31c40d8e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110110222145.31c40d8e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 10, 2011 at 10:21:45PM +0100, Jean Delvare wrote:
> Hi Linus,
> 
> Please pull i2c subsystem updates for Linux 2.6.37 from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus
> 
> Not much this time around... Only the new generic I2C multiplexer using
> the GPIO API is worth mentioning.

It'd be good to also get the conversion to use the pm_generic_ stuff in
- that ends up fixing some bugs with the interaction between runtime and
system suspend and at least means that it's no longer the responsibility
of the I2C code to sort them out in future.  Linus merged the PM tree
bits for that already.
