From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/6] i2cset changes
Date: Mon, 14 Feb 2011 10:06:07 -0800
Message-ID: <1297706773-26389-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The following series of patches removes the obsolete means to specify the value mask,
improves parameter error detection for the i2cset command, and cleans up the code a bit.

Note: Patch revision in headline was updated only if the individual patch is either new
or was changed.

v2:
- Split single patch into multiple individual patches
- Included code review feedback

v3:
- For block commands, check for number of arguments only after checking if pec
  is supported.
- Report "Too many arguments" instead of "Bad number of arguments".
- Committed blank replacement patch separately
- Check valid range for data value mask (patch #6)
