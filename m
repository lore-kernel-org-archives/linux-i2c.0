From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
Date: Sat, 17 Feb 2018 17:09:40 +0200
Message-ID: <1518880180.22495.379.camel@linux.intel.com>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
         <1518879773.22495.378.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25292 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeBQPJo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Feb 2018 10:09:44 -0500
In-Reply-To: <1518879773.22495.378.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, tim@krieglstein.org, jarkko.nikula@linux.intel.com, preid@electromag.com.au, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2018-02-17 at 17:02 +0200, Andy Shevchenko wrote:
> On Sat, 2018-02-17 at 14:25 +0100, Dominik Brodowski wrote:
> 
> > on v4.16-rc1+, sound does not work any more on my Dell XPS 13;
> > suspend-to-RAM hangs as well. I have bisected this problem down to
> > commit ca382f5b38f3; reverting this on top of Linus' latest
> > (1e3510b2b053)
> > fixes these issues.
> > And a few snippets from a broken kernel dmesg:
> > 
> > 	i2c_designware: probe of INT3432:00 failed with error -38
> > 	i2c_designware: probe of INT3433:00 failed with error -38
> 
> ENOSYS here at probe time, taking into account the commit you think is
> a
> culprit, can be passed from gpiod_get() calls only.
> 
> > Ideas on how to fix this properly?
> 
> Enable CONFIG_DEBUG_GPIO first and share through some service the
> dmesg.
> (it might be good idea to add 'ignore_loglevel initcall_debug' to the
> kernel command line)

And tell if the following patch helps.

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -644,7 +644,7 @@ static int i2c_dw_init_recovery_info(struct
dw_i2c_dev *dev)
        gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
        if (IS_ERR(gpio)) {
                r = PTR_ERR(gpio);
-               if (r == -ENOENT)
+               if (r == -ENOENT || r == -ENOSYS)
                        return 0;
                return r;
        }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
