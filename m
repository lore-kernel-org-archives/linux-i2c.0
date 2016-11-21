From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: fix rx fifo depth tracking
Date: Mon, 21 Nov 2016 12:40:32 +0200
Message-ID: <20161121104032.GH1446@lahna.fi.intel.com>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753657AbcKUKo6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Nov 2016 05:44:58 -0500
Content-Disposition: inline
In-Reply-To: <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Nov 18, 2016 at 07:40:10PM +0000, Russell King wrote:
> When loading the TX fifo to receive bytes on the I2C bus, we incorrectly
> count the number of bytes:
> 
> 	rx_limit = dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);
> 
> 	while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
> 		if (rx_limit - dev->rx_outstanding <= 0)
> 			break;
> 		rx_limit--;
> 		dev->rx_outstanding++;
> 	}
> 
> DW_IC_RXFLR indicates how many bytes are available to be read in the
> FIFO, dev->rx_fifo_depth is the FIFO size, and dev->rx_outstanding is
> the number of bytes that we've requested to be read so far, but which
> have not been read.
> 
> Firstly, increasing dev->rx_outstanding and decreasing rx_limit and then
> comparing them results in each byte consuming "two" bytes in this
> tracking, so this is obviously wrong.
> 
> Secondly, the number of bytes that _could_ be received into the FIFO at
> any time is the number of bytes we have so far requested but not yet
> read from the FIFO - in other words dev->rx_outstanding.
> 
> So, in order to request enough bytes to fill the RX FIFO, we need to
> request dev->rx_fifo_depth - dev->rx_outstanding bytes.
> 
> Modifying the code thusly results in us reaching the maximum number of
> bytes outstanding each time we queue more "receive" operations, provided
> the transfer allows that to happen.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
