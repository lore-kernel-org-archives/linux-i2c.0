From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c-piix4: Better bus names
Date: Wed, 27 Jan 2016 17:03:08 +0200
Message-ID: <20160127150308.GA1778@lahna.fi.intel.com>
References: <20160127144033.749e3652@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53841 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933095AbcA0PGB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jan 2016 10:06:01 -0500
Content-Disposition: inline
In-Reply-To: <20160127144033.749e3652@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On Wed, Jan 27, 2016 at 02:40:33PM +0100, Jean Delvare wrote:
> The I2C bus names are supposed to be stable as they can be used by
> userspace to uniquely identify a specific I2C bus. So restore the
> original names for all legacy (pre-SB800) devices.

Good point. I missed the fact that these get exposed to userspace.

> 
> For SB800 devices and later, improve the names. "SDA" refers to the
> serial data pin of each SMBus port, it's an implementation detail the
> user doesn't need to know. Use "port" instead, which is easier to
> understand.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
