From: Juergen Fitschen <me@jue.yt>
Subject: I2C slave mode for i2c-at91 driver
Date: Tue, 17 Oct 2017 12:56:24 +0200
Message-ID: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from srv1.host37.de ([176.28.54.59]:44407 "EHLO srv1.host37.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932880AbdJQLcd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Oct 2017 07:32:33 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hello,


Currently I'm working on a driver adding I2C slave support to some 
Atmel / Microchip MPUs. I already patched the i2c-at91.c and made the 
i2c-slave-eeprom backend working on an ATSAMA5D27. But this is still in 
the prototype status. My next steps are cleaning up the code and sharing 
the patch with you for review and merge into Linux.

But before I do so, I would like to hear your thoughts on some design 
decisions I'm going to make to fulfill the Linux I2C slave interface 
description [1] as good as possible:

1) According to [1] the return value of the I2C_SLAVE_WRITE_RECEIVED 
event determines whether the received byte shall be ACKed or NACKed. The 
problem with the Atmel hardware is that it is not possible to manipulate 
the ACK bit of the current byte in flight; it will be ACKed 
automatically. It is only possible to (N)ACK the following byte(s) since 
some FIFO magic is going on inside the hardware.
Do you think it is a valid approach to ignore the return value and 
always ACK received bytes? Or would you rather set the behaviour for the 
following bytes? That would delay the desired ACK bit by at least one 
byte.

2) The Atmel hardware does not support master and slave concurrently. 
The data sheet [2] examples disable master mode before entering the 
slave mode. (cf. p. 1362) Furthermore send and receive registers and 
their FIFOs are shared.
How would you implement blocking master transactions while slave mode 
is enabled? I would return EBUSY if master_xfer is called.


Best regards,
  Juergen Fitschen


[1] https://www.kernel.org/doc/Documentation/i2c/slave-interface
[2] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
