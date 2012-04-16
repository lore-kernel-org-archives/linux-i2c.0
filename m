From: Andriy Gapon <avg-+43SdJ71VxTsG83rWm+8vg@public.gmane.org>
Subject: decode-dimms: Module Configuration Type not reported for DDR2/3
Date: Tue, 17 Apr 2012 00:09:08 +0300
Message-ID: <4F8C8A74.90804@icyb.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-VIET-VPS
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


It seems that Module Configuration Type ("ECC", "No Parity", etc) is not
reported for DDR2 and DDR3 module types.  Not sure if resolution could be as
easy as adding sdram_module_configuration_type() calls in the corresponding
decode procedures.

-- 
Andriy Gapon
