From: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: at24: writing with SMBUS and no I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
Date: Wed, 5 Mar 2014 10:33:05 -0800
Message-ID: <20140305183305.GS27140@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello -

I have a system that uses SMBUS, but without the
I2C_FUNC_SMBUS_WRITE_I2C_BLOCK functionality.  As it is today at24.c
will only support read-only mode for this case.

Looking at at24_eeprom_write() the comments indicate it only supports
page writes as the alternative is too slow.  This decision seems to be
the root of why SMBUS without I2C_FUNC_SMBUS_WRITE_I2C_BLOCK gives the
read-only situation.

The notion of "slow" seems a bit arbitrary to me.  Is there some other
technical reason or gotcha hiding here that you know of?

Would a nicely written patch that adds write support for this case be
acceptable?  I have not written it yet, but would like to.

Cheers,
Curt
