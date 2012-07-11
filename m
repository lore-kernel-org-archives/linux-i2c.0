From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] PM / I2C: Convert platform I2C drivers to PM handling based on struct dev_pm_ops
Date: Wed, 11 Jul 2012 21:21:10 +0200
Message-ID: <201207112121.11046.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-i2c@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Peter Korsgaard <jacmet@sunsite.dk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Vitaly Wool <vitalywool@gmail.com>, Colin Cross <ccross@android.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

As per

http://marc.info/?l=linux-kernel&m=133996733422413&w=4

the following patches convert some platform I2C controller drivers to the PM
handling based on struct dev_pm_ops:

[1/7] i2c-at91: Use struct dev_pm_ops for power management
[2/7] i2c-bfin-twi: Use struct dev_pm_ops for power management
[3/7] i2c-ocores: Use struct dev_pm_ops for power management
[4/7] i2c-pnx: Use struct dev_pm_ops for power management
[5/7] i2c-puv3: Use struct dev_pm_ops for power management
[6/7] i2c-stu300: Use struct dev_pm_ops for power management
[7/7] i2c-tegra: Use struct dev_pm_ops for power management

I'd like to include them into my PM pull request for 3.6 if there are no
objections.

Thanks,
Rafael
