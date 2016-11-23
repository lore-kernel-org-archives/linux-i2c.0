From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: fix rx fifo depth tracking
Date: Wed, 23 Nov 2016 16:13:46 +0200
Message-ID: <08de7de6-6854-4968-26a6-36da2d68b408@linux.intel.com>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
 <20161121104032.GH1446@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21969 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935052AbcKWONv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 23 Nov 2016 09:13:51 -0500
In-Reply-To: <20161121104032.GH1446@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 21.11.2016 12:40, Mika Westerberg wrote:
> On Fri, Nov 18, 2016 at 07:40:10PM +0000, Russell King wrote:
>> When loading the TX fifo to receive bytes on the I2C bus, we incorrectly
>> count the number of bytes:
>>
>> 	rx_limit = dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);
>>
>> 	while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
>> 		if (rx_limit - dev->rx_outstanding <= 0)
>> 			break;
>> 		rx_limit--;
>> 		dev->rx_outstanding++;
>> 	}
>>
>> DW_IC_RXFLR indicates how many bytes are available to be read in the
>> FIFO, dev->rx_fifo_depth is the FIFO size, and dev->rx_outstanding is
>> the number of bytes that we've requested to be read so far, but which
>> have not been read.
>>
>> Firstly, increasing dev->rx_outstanding and decreasing rx_limit and then
>> comparing them results in each byte consuming "two" bytes in this
>> tracking, so this is obviously wrong.
>>
>> Secondly, the number of bytes that _could_ be received into the FIFO at
>> any time is the number of bytes we have so far requested but not yet
>> read from the FIFO - in other words dev->rx_outstanding.
>>
>> So, in order to request enough bytes to fill the RX FIFO, we need to
>> request dev->rx_fifo_depth - dev->rx_outstanding bytes.
>>
>> Modifying the code thusly results in us reaching the maximum number of
>> bytes outstanding each time we queue more "receive" operations, provided
>> the transfer allows that to happen.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
