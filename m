From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: New home for DS1682 driver
Date: Wed, 7 Oct 2009 11:50:17 +0200
Message-ID: <20091007115017.6941faa7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Grant,

Driver ds1682 needs a new home, as drivers/i2c/chips will be gone soon.
Do you have a preference for where it should go?

As the device includes an EEPROM, the driver could go in
drivers/misc/eeprom, but OTOH the EEPROM in question is so small that
this can hardly be considered the main feature of the driver. So maybe
just drivers/misc?

-- 
Jean Delvare
