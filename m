From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/7] Improvements to decode-dimms
Date: Thu, 15 Nov 2012 11:52:31 +0100
Message-ID: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Here is a patch series improving decode-dimms:
* Show timings at all standard DDR and DDR2 speeds.
* Code refactoring.
* New manufacturer names from JEP106AJ.
* Smarter decoding of manufacturer names.

-- 
Jean Delvare
