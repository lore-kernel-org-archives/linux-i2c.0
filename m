From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BUG] i2c-designware silently fails on long transfers
Date: Mon, 21 Nov 2016 10:43:29 +0000
Message-ID: <20161121104329.GB1041@n2100.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <20161121102901.GF1446@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53130 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbcKUKnk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Nov 2016 05:43:40 -0500
Content-Disposition: inline
In-Reply-To: <20161121102901.GF1446@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 21, 2016 at 12:29:01PM +0200, Mika Westerberg wrote:
> On Fri, Nov 18, 2016 at 07:35:42PM +0000, Russell King - ARM Linux wrote:
> > Another mitigation would be to lower the I2C bus frequency on Juno from
> > 400kHz to 100kHz, so that there's 4x longer IRQ latency possible.
> > However, even that isn't going to be reliable - even going to 100kHz
> > isn't going to allow the above case to be solved - the interrupt is
> > delayed by around 2ms, and it takes about 1.4ms to send/receive 16 bytes
> > at 100kHz.  (9 * 16 / (100*10^3)).
> > 
> > So, I think all hope is lost for i2c-designware on Juno to cope with
> > reading the EDID from TDA998x reliably.
> 
> :-(
> 
> I wonder if we can get it work more reliably by using DMA (provided that
> there are DMA channels available for I2C in Juno)? That would allow the
> hardware to perform longer reads without relying on how fast the
> interrupt handler is able to empty the Rx FIFO.

It would need to DMA to the Tx FIFO to keep it filled - it triggers the
stop condition when the Tx FIFO empties.  From what I can see in the
driver, the Tx FIFO not only takes the data but also a "command" to tell
the hardware what to do.

The Rx FIFO would also need DMA to avoid it overflowing due to high
interrupt latency.

I don't know what state DMA is in on the Juno, or even whether it has
DMA - it has a PL330 DMA controller, but I see nothing in the DT files
making use of it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
