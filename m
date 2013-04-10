From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/6] decode-dimms: Fix and improve DDR3 support
Date: Wed, 10 Apr 2013 22:13:30 +0200
Message-ID: <20130410221330.213ca5be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Today I have been working on decode-dimms' DDR3 support and came up
with 2 fixes and 4 improvements:

[1/6] Fix tRAS value
[2/6] Fix core timings rounding
[3/6] Store time bases, don't print them
[4/6] Use fine time base
[5/6] Repeat core timings as time values
[6/6] Print core timings at all supported standard speeds

Note : if anyone has SPD data for DDR3-1866 or DDR3-2133, please send
them to me so that I can test my code better.

-- 
Jean Delvare
