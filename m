From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c-piix4: Fix SB800 locking
Date: Mon, 25 Jan 2016 11:29:13 +0200
Message-ID: <20160125092913.GP2410@lahna.fi.intel.com>
References: <20160122141202.09c94802@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1859 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbcAYJbZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jan 2016 04:31:25 -0500
Content-Disposition: inline
In-Reply-To: <20160122141202.09c94802@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Jan 22, 2016 at 02:12:02PM +0100, Jean Delvare wrote:
> We need a single mutex for all 4 shared SMBus ports on the SB800. A
> per-port mutex doesn't protect us from concurrent access.
> 
> In theory the mutex should be per PCI device, however in practice we
> know that there's only ever a single instance of the device in a given
> system so we can use a global.
> 
> Also take the mutex during initialization, as first port may be already
> in use when second port is initialized.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

The patch looks correct to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks Jean for looking into this.
