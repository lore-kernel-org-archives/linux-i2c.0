From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: add Renesas R-Car I2C driver
Date: Wed, 31 Oct 2012 14:21:42 +0800
Message-ID: <20121031062128.GA31555@verge.net.au>
References: <871uk04aa2.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2ctETiVdyKBd_MxY2Ts=1XMPa_cdEJRkQpEySL6du9oLmw@mail.gmail.com>
 <878vczd1hw.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2cs5pFpVjqa_MFCLTFqdCo6SSm-1Ep=WtJ7fpABzWEGD9w@mail.gmail.com>
 <20120828101259.409b410b@endymion.delvare>
 <874nnnct03.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2cuGiNnduVa+nnNV_02dYwfrSJoFGesiFBm6Q5U3SGQXpQ@mail.gmail.com>
 <877gred4u1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877gred4u1.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 27, 2012 at 11:44:25PM -0700, Kuninori Morimoto wrote:
> R-Car I2C is similar with SH7760 I2C.
> But the SH7760 I2C driver had many workaround operations, since H/W had bugs.
> Thus, it was pointless to keep compatible between SH7760 and R-Car I2C drivers.
> This patch creates new Renesas R-Car I2C driver.

Hi,

I am seeing the current section miss-matches, which appear to relate to
this patch, in linux/master (v3.6-rc3+).

make CONFIG_DEBUG_SECTION_MISMATCH=y
...
WARNING: vmlinux.o(.data+0x11798): Section mismatch in reference from the variable rcar_i2c_drv to the function .devinit.text:rcar_i2c_probe()
The variable rcar_i2c_drv references
the function __devinit rcar_i2c_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: vmlinux.o(.data+0x1179c): Section mismatch in reference from the variable rcar_i2c_drv to the function .devexit.text:rcar_i2c_remove()
The variable rcar_i2c_drv references
the function __devexit rcar_i2c_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
