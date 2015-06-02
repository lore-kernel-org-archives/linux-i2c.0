From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/6] i2c: at91: add support to FIFOs and alternative command
Date: Tue, 2 Jun 2015 15:18:30 +0200
Message-ID: <cover.1433250713.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ChangeLog

v3:
- fix braces {} coding style issue
- split the alternative command patch into 2 patches: the first one fixes
  a race condition whereas the second one is the actual alternative command
  patch

v2:
- fix typo in comment for AT91_TWI_SVEN.
- document new device tree bindings like "atmel,fifo-size".
- explicitly set the has_alt_cmd boolean to false to already existing chip
  configs.
- use the BIT() macro to define the register bits and do a little cleanup in a
  dedicated patch.
- reword some comments to better explain why the TXCOMP interrupt is no longer
  enabled in at91_do_twi_transfer() but later in
  at91_twi_write_data_dma_callback() to avoid a race condition when DMA is used.
- remove useless TXCOMP interrupt enable line in at91_twi_write_next_byte()
  since this interrupt is also enabled by at91_do_twi_transfer() for PIO
  transfers.

v1:
This series of patches adds support of two new features which will be
introduced with Atmel sama5d2x SoC.

First, the alternative command mode eases the sending of STOP conditions.
Before starting an I2C transaction, the size data to be transfered is
written into the new Alternative Command Register. For each byte transferred,
the I2C controller decreases this counter and automatically sends a STOP
condition when the counter value reaches 0, that is to say when the last byte
of the transaction has been sent/received. So there is no longer need to set
the STOP bit into the Control Register.

Then the use of FIFOs allows to reduce number I/O accesses: for instance,
the TX FIFO allows to write up to 4 data in a single access to the Transmit
Holding Register. Also the RX FIFO allows to read up to 4 data in a single
access to the Receive Holding Register. Currently only DMA transfers take
advantage of FIFOs.

Cyrille Pitchen (6):
  i2c: at91: use BIT() macro to define register bits
  i2c: at91: update documentation for DT bindings
  i2c: at91: fix a race condition when using the DMA controller
  i2c: at91: add support for new alternative command mode
  i2c: at91: print hardware version
  i2c: at91: add support to FIFOs

 Documentation/devicetree/bindings/i2c/i2c-at91.txt |  29 +-
 drivers/i2c/busses/i2c-at91.c                      | 354 +++++++++++++++++----
 2 files changed, 321 insertions(+), 62 deletions(-)

-- 
1.8.2.2
