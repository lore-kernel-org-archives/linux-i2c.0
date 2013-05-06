From: Dave Joubert <dave.joubert-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Proposed utility
Date: Mon, 6 May 2013 20:32:56 +0000 (UTC)
Message-ID: <loom.20130506T220518-384@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, I am new to the list.

I have written a utility server based on the code in i2cset and i2cget and
some socket code from Stevens, and I would a utility like it to become part
of the official tree.

It is a socket server, launched like this:
i2cserver I2Cbus I2Cdeviceaddress TCPportno
which then responds to ASCII commands via the socket such as
i2cset 0x00 0xff or i2cget 0x13 b

Because the binary is only launched once and the device only has to be
opened once, it is much faster than issuing individual i2cset and i2cget
commands.

This is especially useful when used with say node.js (or any language /
shell) than does not have an I2C library built in.

I would be happy to send the C source and a sample shell script to anybody
on the list. I am not by inclination a C programmer. and if this became part
of the official tree it would need someone else to maintain it.

My current use case is Raspberry PI + node.js (or Tcl) and MCP23017 chips

Dave Joubert
