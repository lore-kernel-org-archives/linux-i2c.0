From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 5/7] decode-dimms: Manufacturer names from Jedec JEP106AJ
Date: Thu, 15 Nov 2012 12:52:09 +0100
Message-ID: <20121115125209.2fa48109@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add manufacturer names from Jedec document JEP106AJ.
---
 eeprom/decode-dimms |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-11-15 11:11:22.000000000 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 11:45:52.020974740 +0100
@@ -64,7 +64,7 @@ $revision =~ s/ \([^()]*\)//;
  "Lattice Semi.", "NCR", "Wafer Scale Integration", "IBM",
  "Tristar", "Visic", "Intl. CMOS Technology", "SSSI",
  "MicrochipTechnology", "Ricoh Ltd.", "VLSI", "Micron Technology",
- "Hynix Semiconductor Inc. (former Hyundai Electronics)", "OKI Semiconductor", "ACTEL", "Sharp",
+ "SK Hynix (former Hyundai Electronics)", "OKI Semiconductor", "ACTEL", "Sharp",
  "Catalyst", "Panasonic", "IDT", "Cypress",
  "DEC", "LSI Logic", "Zarlink (former Plessey)", "UTMC",
  "Thinking Machine", "Thomson CSF", "Integrated CMOS (Vertex)", "Honeywell",
@@ -293,7 +293,11 @@ $revision =~ s/ \([^()]*\)//;
  "Accord Software & Systems Pvt. Ltd.", "Active-Semi Inc.", "Denso Corporation", "TLSI Inc.",
  "Shenzhen Daling Electronic Co. Ltd.", "Mustang", "Orca Systems", "Passif Semiconductor",
  "GigaDevice Semiconductor (Beijing) Inc.", "Memphis Electronic", "Beckhoff Automation GmbH",
- "Harmony Semiconductor Corp (former ProPlus Design Solutions)", "Air Computers SRL", "TMT Memory"]
+ "Harmony Semiconductor Corp (former ProPlus Design Solutions)", "Air Computers SRL", "TMT Memory",
+ "Eorex Corporation", "Xingtera", "Netsol", "Bestdon Technology Co. Ltd.", "Baysand Inc.",
+ "Uroad Technology Co. Ltd. (former Triple Grow Industrial Ltd.)", "Wilk Elektronik S.A.",
+ "AAI", "Harman", "Berg Microelectronics Inc.", "ASSIA, Inc.", "Visiontek Products LLC",
+ "OCMEMORY", "Welink Solution Inc."]
 );
 
 $use_sysfs = -d '/sys/bus';

-- 
Jean Delvare
