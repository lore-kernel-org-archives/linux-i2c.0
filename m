From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/6] i2cset changes
Date: Sun, 13 Feb 2011 12:17:20 -0800
Message-ID: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The following series of patches removes the obsolete means to specify the value mask,
improves parameter error detection for the i2cset command, and cleans up the code a bit.

I switched to git for patch management, thus the patch diffs were created with
"git format-patch" instead of "svn diff". Hope that doesn't cause any problems.

v2:
- Split single patch into multiple individual patches
- Included code review feedback
