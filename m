From: Martin Hisch <martin.hisch.ext-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
Date: Tue, 27 Jan 2015 15:14:39 +0000 (UTC)
Message-ID: <loom.20150127T155921-844@post.gmane.org>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com> <1417610126-7957-2-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Harini Katakam <harinik@...> writes:

> 
> The I2C controller sends a NACK to the slave when transfer size register
> reaches zero, irrespective of the hold bit. So, in order to handle transfers
> greater than 252 bytes, the transfer size register has to be maintained at a
> value >= 1. This patch implements the same.
> The interrupt status is cleared at the beginning of the isr instead of
> the end, to avoid missing any interrupts - this is in sync with the new
> transfer handling.
> 
> Signed-off-by: Harini Katakam <harinik@...>
> ---
> 
> v2:
> No changes
> 


Hi,
just had a look to the ISR code and found:

	/* wait while fifo is full */
	while (cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) 
	    (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))

this means, that (16 x 9 bit / SCL freq) is being waited in the ISR.
At 400 kHz SCL freq, this is 360 us. Is that a valid 
workaround in respect to realtime behaviour?
