From: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 0/2] Cadence I2C driver fixes
Date: Wed, 10 Dec 2014 17:14:42 +0530
Message-ID: <1418211884-5329-1-git-send-email-harinik@xilinx.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This series implements workarounds for some bugs in Cadence I2C controller.

- The I2C controller when configured in Master Mode generates invalid read transactions.
When HOLD bit is set and HW timeout occurs, invalid read transactions are
generated on the bus. This will affect repeated start conditions and large
data transfer condtions where transfer_size_register has to be updated again.
The transfer size register rolls over erroneously under these conditions.
Note that this HW timeout cannot be disabled even if the interrupt is unused.
Errata link: http://www.xilinx.com/support/answers/61664.html

-The I2C controller when configured in Master Mode is the missing master completion interrupt.
During repeated start condition, the driver has to set the HOLD bit for
the set of transfer being done together and clear the HOLD bit just before
the last transfer. But the controller does not indicate completion when
a read/receive transfer is done if the HOLD bit is set. This affects
all repeated start operation where a read/receive transfer is not
the last transfer.
Errata link: http://www.xilinx.com/support/answers/61665.html

To address the above,
- >252 byte transfers are done such that transfer_size never becomes zero.
- timeout register value is increased (even though the driver doesn't use this).
- A check is performed to see if there is any transfer following a
read/receive transfer in the set of messages using repeated start.
An error is returned in such cases because if we proceed, completion interrupt
is never obtained and a SW timeout will occur.

Harini Katakam (2):
  i2c: cadence: Handle > 252 byte transfers
  i2c: cadence: Check for errata condition involving master receive

 drivers/i2c/busses/i2c-cadence.c |  187 +++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 73 deletions(-)

-- 
1.7.9.5
