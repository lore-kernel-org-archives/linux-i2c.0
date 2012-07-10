From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/3 v4] i2c-i801: Enable irq
Date: Tue, 10 Jul 2012 14:51:56 +0200
Message-ID: <20120710145156.306e611d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a respin of Daniel's patch set adding support for interrupts to
the i2c-i801 driver, incorporating the feedback from review and testing
results. I think it is ready to go upstream. Further cleanups,
optimizations and enablements can happen later.

Daniel Kurtz (2):
  i2c-i801: Enable irq for SMBus transactions
  i2c-i801: Enable irq for byte_by_byte transactions

Jean Delvare (1):
  i2c-i801: Enable interrupts on ICH5/7/8/9/10

-- 
Jean Delvare
