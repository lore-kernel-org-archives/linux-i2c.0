From: "Wen, Quan (Robert@HPS Perf Engineering, Beijing)"
	<robert.wen-VXdhtT5mjnY@public.gmane.org>
Subject: decode-dimms: DDR4 support?
Date: Tue, 8 Apr 2014 08:43:40 +0000
Message-ID: <E93091193EC1264AA3168017B83225F44C64E7C3@G9W0708.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi, 

Is there a DDR4 support plan for the decode-dimms script? 
I just ran into an error with the latest version of the script when decoding the SPD from a DDR4-2133 DIMM.

$ decode-dimms -X spd1.txt
# decode-dimms version 5929 (2011-02-16 14:58:38 +0100)
 
Memory Serial Presence Detect Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
Jean Delvare, Trent Piepho and others
 
 
Decoding EEPROM: spd1.txt
 
---=== SPD EEPROM Information ===---
EEPROM CRC of bytes 0-125                       OK (0x5CD3)
# of bytes written to SDRAM EEPROM              256
Total number of bytes in EEPROM                 512
Fundamental Memory type                         Unknown (0x0c)
 
---=== Manufacturing Information ===---
Manufacturer                                    Invalid
Custom Manufacturer Data                        0C 04 0C 04 0C 04 0C 04 ("????????")
Manufacturing Location Code                     0x0C
Part Number                                     Undefined

Thanks,
Robert
