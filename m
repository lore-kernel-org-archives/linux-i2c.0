From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-piix4: Better bus names
Date: Sun, 31 Jan 2016 09:46:29 +0100
Message-ID: <20160131094629.42e430ac@endymion.delvare>
References: <20160127144033.749e3652@endymion.delvare>
	<20160129101749.GB2053@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35185 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbcAaIqd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 31 Jan 2016 03:46:33 -0500
In-Reply-To: <20160129101749.GB2053@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Fri, 29 Jan 2016 11:17:49 +0100, Wolfram Sang wrote:
> On Wed, Jan 27, 2016 at 02:40:33PM +0100, Jean Delvare wrote:
> > The I2C bus names are supposed to be stable as they can be used by
> > userspace to uniquely identify a specific I2C bus. So restore the
> > original names for all legacy (pre-SB800) devices.
> > 
> > For SB800 devices and later, improve the names. "SDA" refers to the
> > serial data pin of each SMBus port, it's an implementation detail the
> > user doesn't need to know. Use "port" instead, which is easier to
> > understand.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Christian Fetzer <fetzer.ch@gmail.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> 
> Changed the subject to "don't regress on bus names" and applied to
> for-current, thanks!

Thanks.

> Jean, could you use the "i2c: <driver>: <subject>" (check git log for
> examples) pattern for your future patches? Thanks!

OK, I will do that.

-- 
Jean Delvare
SUSE L3 Support
