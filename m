From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: [PATCH/RFC 0/4] hwmon: PMBus device driver
Date: Mon, 28 Jun 2010 14:56:50 -0700
Message-ID: <1277762214-15155-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@linux-foundation.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "Darrick J. Wong" <djwong@u>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for hardware monitoring features of PMBus devices.

The driver has not yet been tested with actual hardware. It is submitted for
early review and, hopefully, to get some test coverage. 

A PMBus device emulator is provided for reference, to show the level of testing
performed. I don't currently plan to submit this emulator in the final patchset.
If there is interest to have it included, and if someone is willing to review
the code, I'll be happy to clean it up and include it.

I will test the driver with real HW for BMR453 and LTC2978 as soon as I get
access to it. For other devices, I'll add a remark that support is untested,
unless I get feedback that a specific device was tested and is working. 

---
Open issues/questions:
- The driver adds new power monitoring attributes to the hwmon sysfs API.
  We'll either have to amend the API, or remove the added attributes.
- Driver automatically detects and adds sensors and flags up to a defined limit,
  and reports a BUG if the limit is exceeded. Not sure if that is an acceptable
  approach.
