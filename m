From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: i2c-tools 3.1.1 has been released
Date: Thu, 20 Feb 2014 15:41:11 +0100
Message-ID: <20140220154111.637f2838@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

More than 2 years after the previous release, i2c-tools 3.1.1 is finally
available. It is based on the stable branch, so it only contains fixes,
minor improvements and documentation updates, nothing fancy.

The most visible changes are as follow:
 * Manual pages were added for decode-dimms, decode-vaio, eeprog,
   eeprom and eepromer (thanks to Jaromir Capik)
 * decode-dimms was improved, in particular DDR3 support but also SDR
   and DDR2 support
 * i2c-stub-from-dump tolerance on input dump format was improved

Enjoy,
-- 
Jean Delvare
Suse L3 Support
