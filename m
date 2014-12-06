From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 0/2] i2c-designware: Baytrail bus locking driver
Date: Sat, 06 Dec 2014 12:51:24 +0900
Message-ID: <54827D3C.3080401@pobox.com>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com> <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417478973-25522-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 14/12/02 9:09, David E. Box wrote:
> Select Intel Baytrail platforms support PMIC's whose i2c bus may be controlled
> exclusively by platform hardware. This patch set adds support for i2c bus
> locking to the designware core and provides a driver module for managing
> the lock on these platforms. Since the lock on these systems isn't enumerable
> outside of the i2c platform driver, the locking functions are assigned at
> compile time.

Have you ever look into the hwspinlock framework?  It seems to me that
such an exclusive operation between CPUs and external hardware blocks
is exactly what hwspinlock is for.  Further more hwspinlock takes care
of exclusiveness between SMP cores.

Ideally I would expect i2c-designware to have hwspinlock lock/unlock
API calls on one I2C transaction, but it's not necessarily the case.
Introducing such platform hooks (acquire_lock and release_lock) and
keeping actual exclusive operataion outside the driver might be good
for various usecases/platforms.

   Shinya
