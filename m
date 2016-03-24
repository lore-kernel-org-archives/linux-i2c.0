From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 04/13] eeprom: at24: make locking more fine-grained
 (fwd)
Date: Thu, 24 Mar 2016 17:30:10 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1603241729220.2534@hadrien>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:5842 "EHLO
	mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834AbcCXQaS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:30:18 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, kbuild-all@01.org

If this is correct, it seems quite subtle.

julia

---------- Forwarded message ----------
Date: Fri, 25 Mar 2016 00:25:33 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 04/13] eeprom: at24: make locking more fine-grained

CC: kbuild-all@01.org
In-Reply-To: <1458830767-23816-5-git-send-email-bgolaszewski@baylibre.com>
TO: Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Bartosz,

[auto build test WARNING on next-20160324]
[cannot apply to v4.5-rc7 v4.5-rc6 v4.5-rc5 v4.5]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/eeprom-support-for-at24cs-and-at24mac/20160324-230008
:::::: branch date: 85 minutes ago
:::::: commit date: 85 minutes ago

>> drivers/misc/eeprom/at24.c:356:3-9: preceding lock on line 312

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 9e24d3f64066d8452c1ab00486a5a4878a30b7b1
vim +356 drivers/misc/eeprom/at24.c

2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  306  	if (!at24->use_smbus) {
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  307  		int i = 0;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  308
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  309  		msg.addr = client->addr;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  310  		msg.flags = 0;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  311
9e24d3f6 drivers/misc/eeprom/at24.c Bartosz Golaszewski 2016-03-24 @312  		mutex_lock(&at24->wrbuf_lock);
9e24d3f6 drivers/misc/eeprom/at24.c Bartosz Golaszewski 2016-03-24  313
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  314  		/* msg.buf is u8 and casts will mask the values */
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  315  		msg.buf = at24->writebuf;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  316  		if (at24->chip.flags & AT24_FLAG_ADDR16)
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  317  			msg.buf[i++] = offset >> 8;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  318
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  319  		msg.buf[i++] = offset;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  320  		memcpy(&msg.buf[i], buf, count);
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  321  		msg.len = i + count;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  322  	}
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  323
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  324  	/*
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  325  	 * Writes fail if the previous one didn't complete yet. We may
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  326  	 * loop a few times until this one succeeds, waiting at least
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  327  	 * long enough for one entire page write to work.
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  328  	 */
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  329  	timeout = jiffies + msecs_to_jiffies(write_timeout);
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  330  	do {
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  331  		write_time = jiffies;
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  332  		if (at24->use_smbus_write) {
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  333  			switch (at24->use_smbus_write) {
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  334  			case I2C_SMBUS_I2C_BLOCK_DATA:
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  335  				status = i2c_smbus_write_i2c_block_data(client,
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  336  						offset, count, buf);
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  337  				break;
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  338  			case I2C_SMBUS_BYTE_DATA:
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  339  				status = i2c_smbus_write_byte_data(client,
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  340  						offset, buf[0]);
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  341  				break;
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  342  			}
a839ce66 drivers/misc/eeprom/at24.c Christian Gmeiner   2014-10-09  343
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  344  			if (status == 0)
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  345  				status = count;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  346  		} else {
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  347  			status = i2c_transfer(client->adapter, &msg, 1);
9e24d3f6 drivers/misc/eeprom/at24.c Bartosz Golaszewski 2016-03-24  348  			mutex_unlock(&at24->wrbuf_lock);
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  349  			if (status == 1)
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  350  				status = count;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  351  		}
2ce5b34f drivers/i2c/chips/at24.c   David Brownell      2008-08-10  352  		dev_dbg(&client->dev, "write %zu@%d --> %zd (%ld)\n",
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  353  				count, offset, status, jiffies);
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  354
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  355  		if (status == count)
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14 @356  			return count;
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  357
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  358  		/* REVISIT: at HZ=100, this is sloooow */
2b7a5056 drivers/i2c/chips/at24.c   Wolfram Sang        2008-07-14  359  		msleep(1);

:::::: The code at line 356 was first introduced by commit
:::::: 2b7a5056a0a7ff17d5d2004c29c852a92a6bd632 i2c: New-style EEPROM driver using device IDs

:::::: TO: Wolfram Sang <w.sang@pengutronix.de>
:::::: CC: Jean Delvare <khali@mahadeva.delvare>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
