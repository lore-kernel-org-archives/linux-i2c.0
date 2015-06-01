From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/2 i2c-tools] sensors-detect: Manufacturer name changes
 from JEP106AQ
Date: Mon, 1 Jun 2015 09:55:09 +0200
Message-ID: <20150601095509.747e6074@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

5 manufacturer names were updated from JEP106AK to JEP106AQ.
---
 eeprom/decode-dimms |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2015-06-01 09:19:01.931673815 +0200
+++ i2c-tools/eeprom/decode-dimms	2015-06-01 09:54:06.958469718 +0200
@@ -60,7 +60,7 @@ $revision =~ s/ \([^()]*\)//;
  "RCA", "Raytheon", "Conexant (Rockwell)", "Seeq",
  "NXP (former Signetics, Philips Semi.)", "Synertek", "Texas Instruments", "Toshiba",
  "Xicor", "Zilog", "Eurotechnique", "Mitsubishi",
- "Lucent (AT&T)", "Exel", "Atmel", "SGS/Thomson",
+ "Lucent (AT&T)", "Exel", "Atmel", "STMicroelectronics (former SGS/Thomson)",
  "Lattice Semi.", "NCR", "Wafer Scale Integration", "IBM",
  "Tristar", "Visic", "Intl. CMOS Technology", "SSSI",
  "MicrochipTechnology", "Ricoh Ltd.", "VLSI", "Micron Technology",
@@ -99,7 +99,7 @@ $revision =~ s/ \([^()]*\)//;
  "Century", "Hal Computers", "Rohm Company Ltd.", "Juniper Networks",
  "Libit Signal Processing", "Mushkin Enhanced Memory", "Tundra Semiconductor", "Adaptec Inc.",
  "LightSpeed Semi.", "ZSP Corp.", "AMIC Technology", "Adobe Systems",
- "Dynachip", "PNY Electronics", "Newport Digital", "MMC Networks",
+ "Dynachip", "PNY Technologies Inc. (former PNY Electronics)", "Newport Digital", "MMC Networks",
  "T Square", "Seiko Epson", "Broadcom", "Viking Components",
  "V3 Semiconductor", "Flextronics (former Orbit)", "Suwa Electronics", "Transmeta",
  "Micron CMS", "American Computer & Digital Components Inc", "Enhance 3000 Inc", "Tower Semiconductor",
@@ -127,7 +127,7 @@ $revision =~ s/ \([^()]*\)//;
  "HADCO Corporation", "Corsair", "Actrans System Inc.", "ALPHA Technologies",
  "Silicon Laboratories, Inc. (Cygnal)", "Artesyn Technologies", "Align Manufacturing", "Peregrine Semiconductor",
  "Chameleon Systems", "Aplus Flash Technology", "MIPS Technologies", "Chrysalis ITS",
- "ADTEC Corporation", "Kentron Technologies", "Win Technologies", "Tachyon Semiconductor (former ASIC Designs Inc.)",
+ "ADTEC Corporation", "Kentron Technologies", "Win Technologies", "Tezzaron Semiconductor (former Tachyon Semiconductor)",
  "Extreme Packet Devices", "RF Micro Devices", "Siemens AG", "Sarnoff Corporation",
  "Itautec SA (former Itautec Philco SA)", "Radiata Inc.", "Benchmark Elect. (AVEX)", "Legend",
  "SpecTek Incorporated", "Hi/fn", "Enikia Incorporated", "SwitchOn Networks",
@@ -177,7 +177,7 @@ $revision =~ s/ \([^()]*\)//;
  "SiCon Video", "NanoAmp Solutions", "Ericsson Technology", "PrairieComm",
  "Mitac International", "Layer N Networks", "MtekVision", "Allegro Networks",
  "Marvell Semiconductors", "Netergy Microelectronic", "NVIDIA", "Internet Machines",
- "Peak Electronics", "Litchfield Communication", "Accton Technology", "Teradiant Networks",
+ "Memorysolution GmbH (former Peak Electronics)", "Litchfield Communication", "Accton Technology", "Teradiant Networks",
  "Scaleo Chip (former Europe Technologies)", "Cortina Systems", "RAM Components", "Raqia Networks",
  "ClearSpeed", "Matsushita Battery", "Xelerated", "SimpleTech",
  "Utron Technology", "Astec International", "AVM gmbH", "Redux Communications",
@@ -189,7 +189,7 @@ $revision =~ s/ \([^()]*\)//;
  "Potentia Power Systems", "C-guys Incorporated", "Digital Communications Technology Incorporated", "Silicon-Based Technology",
  "Fulcrum Microsystems", "Positivo Informatica Ltd", "XIOtech Corporation", "PortalPlayer",
  "Zhiying Software", "Parker Vision, Inc. (former Direct2Data)", "Phonex Broadband", "Skyworks Solutions",
- "Entropic Communications", "Pacific Force Technology", "Zensys A/S", "Legend Silicon Corp.",
+ "Entropic Communications", "I'M Intelligent Memory Ltd (former Pacific Force Technology)", "Zensys A/S", "Legend Silicon Corp.",
  "sci-worx GmbH", "SMSC (former Oasis Silicon Systems)", "Renesas Electronics (former Renesas Technology)", "Raza Microelectronics",
  "Phyworks", "MediaTek", "Non-cents Productions", "US Modular",
  "Wintegra Ltd", "Mathstar", "StarCore", "Oplus Technologies",

-- 
Jean Delvare
SUSE L3 Support
