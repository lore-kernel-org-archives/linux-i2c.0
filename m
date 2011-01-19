From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/2] Add support for Diolan U2C-12 USB/I2C adapter.
Date: Wed, 19 Jan 2011 13:26:36 -0800
Message-ID: <1295472398-705-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

v2 changes:
- Moved receive and transmit buffers to allocated driver memory
- diolan_usb_transfer() no longer requires buffer and length arguments
- Pass "struct i2c_diolan_u2c *" instead of "struct i2c_adapter *" to many of
  the internal usb access functions.
- Introduced diolan_usb_cmd(), diolan_usb_cmd_data(), and diolan_usb_cmd_data2()
  as front-end functions for actual commands.
- Function prefix is now diolan_ for all functions.
- Removed diolan_scan().
- Fixed race conditions in diolan_u2c_probe().
- Use i2c_{set,get}_adapdata instead of misusing adapter.algo_data.
- Driver name is now i2c-diolan-u2c (instead of i2c-u2c-usb).
- Added support for "frequency" module parameter to set i2c clock frequency
- Enabled I2C clock stretching support
- Support sending multiple commands in single usb transfer
- Several other minor changes to address review comments.
