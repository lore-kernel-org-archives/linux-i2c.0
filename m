From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-tools 3.1.0 has been released
Date: Sun, 4 Dec 2011 20:53:54 +0100
Message-ID: <20111204205354.090a0eda@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

I have just released i2c-tools 3.1.0. The detailed list of changes in
this version can be found in file CHANGES:
http://www.lm-sensors.org/browser/i2c-tools/tags/V3-1-0/CHANGES

The most important changes are:
* Support for block writes added to i2cset
* at24 driver support added to decode-dimms
* Slightly improved DDR SDRAM support in decode-dimms

The rest is small cleanups, as you would expect after 1 year without a
release.

-- 
Jean Delvare
