From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: OMAP: send i2c message ignoring NAK
Date: Tue, 3 Jul 2012 10:12:09 +0200
Message-ID: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: shubhrajyoti-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I'm using the second i2c channel to connect to HDMI transmitter
sii9022a. In order to get EDID information from the attached monitor
the sii9022a chip passes i2c request direct to the monitors i2c bus.
To return to sii9022a mode one has to write data to HDMI transmitter,
but this data won't be acknowledged. Because of this i2c produces
timeout permanently (omap_i2c omap_i2c.2: controller timed out), so no
communication is possible. The last bits I see on the scope are the
i2c address of sii9022a. The CPU automatically end the transfer.

The HDMI chip has i2c address 0x72 (8-bit notation) and EDID channel
0xa0 (8-bit notation). AFAIK there is only one device at a time on the
bus, i.e. as soon as I switch sii9022a to access monitor only 0xa0
responds to the queries. And I need to send a message to 0x72 ignoring
normal i2c conditions in order to turn it back in normal mode.

The driver for this HDMI transmitter can be found here:
http://gitorious.org/efikamx/linux-kernel.git
(drivers/video/mxc/siihdmi.c)

How can I send this write request without awaiting for ACK?

Yegor
