Received: from goedel.dlitz.net (smtp-out.goedel.dlitz.net [167.88.50.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8333BBC8
	for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.88.50.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651943; cv=none; b=F+pw0QUogTcH4b2NaAEHzn/c1+oGnjxo6tgs0Ja8FVUtuXXuNp+Be4Po6yVKYW8DOSkAq2DGpY4stbw0F8EdXQ1bN1MqBsY8gsg968JFzoGkbXn3PJ2vE044qAHzyPr3Xz09wcdiHQ5sYt4jrES8WWXQGlC2FMGG+qT+DR4kL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651943; c=relaxed/simple;
	bh=pEZuI8QTZTwvnP3SR7HxzTRT13beemV+EK8cYsZNaAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8Jh87bHCjRIiI/gknJzEz1OGKV8jYWcy+mxSDW906d4haXL3aTRC9BusWxnwdLRp2Rtg/b48f2xfB6mJYXONlnS3aq6g71VIC1kA4//WTZVyRWF9vuU3SG+Oj410EWizee1ulaYuU7DvC4J/P/R8+XxfR23naXXmLeTLkc69go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dlitz.net; spf=pass smtp.mailfrom=dlitz.net; dkim=pass (2048-bit key) header.d=dlitz.net header.i=@dlitz.net header.b=LOhrF1h3; arc=none smtp.client-ip=167.88.50.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dlitz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dlitz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dlitz.net header.i=@dlitz.net header.b="LOhrF1h3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlitz.net;
 i=@dlitz.net; q=dns/txt; s=rsa.20220303; t=1769651927; h=date : from :
 to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=duuQr5jX+rkLbUBM+TaBjQ12Ax+Y2qb/fJrL5ab6eDM=;
 b=LOhrF1h3Ja8fPx4Mf6tl2q/C4B5PX33t6NbtP3mtuyFjQy510qXQDh3JJeyD4vD16Vv4w
 F1FdBd7Jq3RPKJPebD+oZsMAmf0U3A5qM2c+twH0/2SoCqfDOepMS6TGv+oQdnraP3QoQfM
 cWnwGVBL4wcMn5ucejWhkPLelhx/wOb3DMkmeh+BuUylxvAdc2nRIT0Px8cc7alDdzbuvxn
 5G7Mabv3K1ANpnds8TWtRks8fyliC6qREbbqv1L9oGheBeTuiFeJqKtUWO4WznR8TIvp7XR
 sIZINQBfamLbQBFWIIaZS7Msa+TwxQKjYXH8fu9JzIB2djB7CYzZMUodJx6g==
Received: from rivest.dlitz.net (rivest.dlitz.net [IPv6:2602:fed2:712e:ff43::1])
	by goedel.dlitz.net (Postfix) with ESMTPSA id C670E2AB1A8E;
	Thu, 29 Jan 2026 01:58:47 +0000 (UTC)
Received: from syra.dlitz.net (unknown [IPv6:fd64:29b:1:ff10:ee:0:a9f:105])
	by rivest.dlitz.net (Postfix) with ESMTPSA id 4AB9FC4B1B;
	Wed, 28 Jan 2026 18:58:45 -0700 (MST)
Received: by syra.dlitz.net (Postfix, from userid 1000)
	id 3494FEF85E4F; Wed, 28 Jan 2026 18:58:36 -0700 (MST)
Date: Wed, 28 Jan 2026 18:58:36 -0700
From: Darsey Litzenberger <dlitz@dlitz.net>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Jean Delvare <jdelvare@suse.de>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: Re: [PATCH v2 0/6] decode-dimms: Implement DDR5 decoding
Message-ID: <aXq19uxerWI5SvcX@syra.dlitz.net>
X-Homepage: https://www.dlitz.net/
X-OpenPGP: url=https://www.dlitz.net/go/gpgkey/;
 id=19E11FE8B3CFF273ED174A24928CEC1339C25CF7; preference=sign
References: <20251106021356.208986-1-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3pryehbembrny5bp"
Content-Disposition: inline
In-Reply-To: <20251106021356.208986-1-s.horvath@outlook.com.au>


--3pryehbembrny5bp
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 06, 2025 at 02:14:57AM +0000, Stephen Horvath wrote:
>Hi, this series of patches adds DDR5 support to decode-dimms.
[snip]

I fed the eeprom for one of my RAM sticks into decode-dimms with your 
patches applied, and it seems to output a number of suspicious values 
(at least to me, as someone completely unfamiliar with the JEDEC specs).

This is for a 48 GiB DDR5-5600 ECC SODIMM, not actually made by Micron, 
but a clone sold on eBay[1], so it's possible that its SPD data aren't 
exactly what they should be.  The module is supposedly equivalent to the 
Kingston KSM56T46BD8KM-48HM, which has these specs[2]:

     CL(IDD)                                           46 cycles
     Row Cycle Time (tRCmin)                           48ns(min.)
     Refresh to Active/Refresh Command Time (tRFCmin)  295ns(min.)
     Row Active Time (tRASmin)                         32ns(min.)
     Row Precharge Time (tRPmin)                       16ns(min.)

decode-dimms with your patches says this (with my comments):

>---=== SPD EEPROM Information ===---
>EEPROM CRC of bytes 0-509                        OK (0xB3D5)
># of bytes written to SDRAM EEPROM               1024
>Total number of bytes in EEPROM                  1024
>Fundamental Memory type                          DDR5 SDRAM
>SPD Revision                                     1.0
>Module Type                                      SODIMM
>
>---=== Memory Characteristics ===---
>Maximum module speed                             5600 MT/s (PC5-22400)

That should be PC5-44800, not PC5-22400.  Maybe you're forgetting to 
double the clock speed due to DDR doing two transfers per cycle?

>Size                                             40 GB

It should be 48 GiB, not 40.  dmidecode correctly shows it as "48 GB".

>Banks x Rows x Columns x Bits                    32 x 17 x 10 x 32
>SDRAM Device Width                               8 bits
>Ranks                                            2
>Rank Mix                                         Symmetrical
>Primary Bus Width                                32 bits
>Bus Width Extension                              4 bits
>AA-RCD-RP-RAS (cycles)                           46-45-45-90
>Supported CAS Latencies                          50T, 46T, 42T, 40T, 36T, 32T, 30T, 28T, 26T, 22T
>
>---=== Timings at Standard Speeds ===---
>AA-RCD-RP-RAS (cycles) as DDR5-5600              46-45-45-90
>AA-RCD-RP-RAS (cycles) as DDR5-5200              46-42-42-84
>AA-RCD-RP-RAS (cycles) as DDR5-4800              40-39-39-77
>AA-RCD-RP-RAS (cycles) as DDR5-4400              40-36-36-71
>AA-RCD-RP-RAS (cycles) as DDR5-4000              36-32-32-64
>AA-RCD-RP-RAS (cycles) as DDR5-3600              30-29-29-58
>AA-RCD-RP-RAS (cycles) as DDR5-3200              28-26-26-52
>
>---=== Timing Parameters ===---
>Minimum Cycle Time (tCKmin)                      0.357 ns
>Maximum Cycle Time (tCKmax)                      1.000 ns
>Minimum CAS Latency Time (tAA)                   16.000 ns
>Minimum RAS to CAS Delay (tRCD)                  16.000 ns
>Minimum Row Precharge Delay (tRP)                16.000 ns
>Minimum Active to Precharge Delay (tRAS)         32.000 ns
>Minimum Active to Auto-Refresh Delay (tRC)       48.000 ns
>Minimum Recovery Delay (tRFC1)                   0.410 ns
>Minimum Recovery Delay (tRFC2)                   0.220 ns
>Minimum Recovery Delay (tRFCsb)                  0.190 ns
>Minimum Four Activate Window Delay (tFAW)        11.428 ns (32 cycles)
>Minimum Row Active to Row Active Delay (tRRD_L)  5.000 ns (8 cycles)
>Minimum CAS to CAS Delay (tCCD_L)                5.000 ns (8 cycles)
>Minimum Write Recovery Time (tWR)                30.000 ns
>Minimum Write to Read Time (tWTR_S)              2.500 ns (4 cycles)
>Minimum Write to Read Time (tWTR_L)              10.000 ns (16 cycles)

Are those sub-nanosecond timing values reasonable?  I'm not familiar 
with the JEDEC specs so I don't know if tRFC1/tRFC2/tRFCsb should be 
that much smaller than the specified tRFCmin, but the discrepancy looks 
suspicious to me.

>---=== Other Information ===---
>Package Type                                     Monolithic
>Post Package Repair                              One row per bank
>Soft PPR Undo/Lock                               Not Supported
>MBIST PPR                                        Not Supported
>Module Nominal Voltage                           1.1 V
>Thermal Sensor                                   No
>
>---=== Common Information ===---
>SPD Module Info Revision                         1.0
>SPD Manufacturer                                 IDT
>PMIC0 Manufacturer                               Richtek Power
>
>---=== Physical Characteristics ===---
>Module Height                                    32 mm
>Module Thickness                                 2 mm front, 2 mm back
>Module Reference Card                            E revision 0
>
>---=== Manufacturer Data ===---
>Module Manufacturer                              Micron Technology
>DRAM Manufacturer                                Micron Technology
>Manufacturing Location Code                      0x01
>Manufacturing Date                               2025-W44
>Assembly Serial Number                           0xFE0E0000
>Part Number                                      MB48G56S80M2R8.RtR
>Revision Code                                    0x11
>DRAM Stepping                                    G
>
>
>Number of SDRAM DIMMs detected and decoded: 1

Here's a hexdump of the SPD EEPROM, and I've included the dmidecode 
output as an attachment.

--[snip]--
00000000: 3010 1203 0501 2062 0000 0000 9002 0000  0..... b........
00000010: 0000 0000 6501 f203 7aad 0000 0000 803e  ....e...z......>
00000020: 803e 803e 007d 80bb 3075 9a01 dc00 be00  .>.>.}..0u......
00000030: 0000 0000 0000 d400 0000 d400 0000 d400  ................
00000040: 0000 d400 0000 8813 0888 1308 204e 2010  ............ N .
00000050: 2710 a42c 2010 2710 c409 044c 1d0c 0000  '.., .'....L....
00000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000000c0: 1000 80b3 8015 8a8c 8220 0000 0000 0000  ......... ......
000000d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000000e0: 0000 0000 0000 1111 0481 082a 0000 0000  ...........*....
000000f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000001f0: 0000 0000 0000 0000 0000 0000 0000 d5b3  ................
00000200: 802c 0125 44fe 0e00 004d 4234 3847 3536  .,.%D....MB48G56
00000210: 5338 304d 3252 382e 5274 5220 2020 2020  S80M2R8.RtR
00000220: 2020 2020 2020 2011 802c 4734 3233 3330         ..,G42330
00000230: 3134 3933 0000 0000 0000 0000 0000 0000  1493............
00000240: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000003f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
--[snip]--

[1] https://web.archive.org/web/20260129012956/https://www.ebay.ca/itm/205158078392
[2] https://www.kingston.com/datasheets/KSM56T46BD8KM-48HM.pdf

-- 
Darsey Litzenberger <dlitz@dlitz.net>

--3pryehbembrny5bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="48gb-ram-spd-eeprom.bin.xxd"

00000000: 3010 1203 0501 2062 0000 0000 9002 0000  0..... b........
00000010: 0000 0000 6501 f203 7aad 0000 0000 803e  ....e...z......>
00000020: 803e 803e 007d 80bb 3075 9a01 dc00 be00  .>.>.}..0u......
00000030: 0000 0000 0000 d400 0000 d400 0000 d400  ................
00000040: 0000 d400 0000 8813 0888 1308 204e 2010  ............ N .
00000050: 2710 a42c 2010 2710 c409 044c 1d0c 0000  '.., .'....L....
00000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000000c0: 1000 80b3 8015 8a8c 8220 0000 0000 0000  ......... ......
000000d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000000e0: 0000 0000 0000 1111 0481 082a 0000 0000  ...........*....
000000f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000001f0: 0000 0000 0000 0000 0000 0000 0000 d5b3  ................
00000200: 802c 0125 44fe 0e00 004d 4234 3847 3536  .,.%D....MB48G56
00000210: 5338 304d 3252 382e 5274 5220 2020 2020  S80M2R8.RtR     
00000220: 2020 2020 2020 2011 802c 4734 3233 3330         ..,G42330
00000230: 3134 3933 0000 0000 0000 0000 0000 0000  1493............
00000240: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000003f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................

--3pryehbembrny5bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmidecode-memory.txt"

# dmidecode 3.6
Getting SMBIOS data from sysfs.
SMBIOS 3.7.0 present.

Handle 0x0013, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 64 GB
	Error Information Handle: 0x0012
	Number Of Devices: 2

Handle 0x0016, DMI type 17, 92 bytes
Memory Device
	Array Handle: 0x0013
	Error Information Handle: 0x0015
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: Unknown
	Set: None
	Locator: DIMM 0
	Bank Locator: P0 CHANNEL A
	Type: Unknown
	Type Detail: Unknown

Handle 0x0018, DMI type 17, 92 bytes
Memory Device
	Array Handle: 0x0013
	Error Information Handle: 0x0017
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 48 GB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM 0
	Bank Locator: P0 CHANNEL B
	Type: DDR5
	Type Detail: Synchronous Unbuffered (Unregistered)
	Speed: 5600 MT/s
	Manufacturer: Micron Technology
	Serial Number: FE0E0000
	Asset Tag: Not Specified
	Part Number: MB48G56S80M2R8.RtR            
	Rank: 2
	Configured Memory Speed: 5600 MT/s
	Minimum Voltage: 1.1 V
	Maximum Voltage: 1.1 V
	Configured Voltage: 1.1 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Unknown
	Module Manufacturer ID: Bank 1, Hex 0x2C
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 48 GB
	Cache Size: None
	Logical Size: None


--3pryehbembrny5bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmidecode-memory-u.txt"

# dmidecode 3.6
Getting SMBIOS data from sysfs.
SMBIOS 3.7.0 present.

Handle 0x0013, DMI type 16, 23 bytes
	Header and Data:
		10 17 13 00 03 03 06 00 00 00 04 12 00 02 00 00
		00 00 00 00 00 00 00

Handle 0x0016, DMI type 17, 92 bytes
	Header and Data:
		11 5C 16 00 13 00 15 00 FF FF FF FF 00 00 02 00
		01 02 02 04 00 00 00 03 04 00 05 00 00 00 00 00
		00 00 00 00 00 00 00 00 02 04 00 06 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00
	Strings:
		44 49 4D 4D 20 30 00
		DIMM 0
		50 30 20 43 48 41 4E 4E 45 4C 20 41 00
		P0 CHANNEL A
		55 6E 6B 6E 6F 77 6E 00
		Unknown
		55 6E 6B 6E 6F 77 6E 00
		Unknown
		55 6E 6B 6E 6F 77 6E 00
		Unknown
		55 6E 6B 6E 6F 77 6E 00
		Unknown

Handle 0x0018, DMI type 17, 92 bytes
	Header and Data:
		11 5C 18 00 13 00 17 00 48 00 40 00 FF 7F 0D 00
		01 02 22 80 40 E0 15 03 04 00 05 02 00 C0 00 00
		E0 15 4C 04 4C 04 4C 04 03 08 00 06 80 2C 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		0C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00
	Strings:
		44 49 4D 4D 20 30 00
		DIMM 0
		50 30 20 43 48 41 4E 4E 45 4C 20 42 00
		P0 CHANNEL B
		4D 69 63 72 6F 6E 20 54 65 63 68 6E 6F 6C 6F 67
		79 00
		Micron Technology
		46 45 30 45 30 30 30 30 00
		FE0E0000
		4D 42 34 38 47 35 36 53 38 30 4D 32 52 38 2E 52
		74 52 20 20 20 20 20 20 20 20 20 20 20 20 00
		MB48G56S80M2R8.RtR            
		55 6E 6B 6E 6F 77 6E 00
		Unknown


--3pryehbembrny5bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="decode-dimms.txt"

# Using big-endian 16-bit hex dump
# decode-dimms version 4.4

Memory Serial Presence Detect Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
Jean Delvare, Trent Piepho and others


Decoding EEPROM: ../48gb-ram-spd-eeprom.bin.xxd

---=== SPD EEPROM Information ===---
EEPROM CRC of bytes 0-509                        OK (0xB3D5)
# of bytes written to SDRAM EEPROM               1024
Total number of bytes in EEPROM                  1024
Fundamental Memory type                          DDR5 SDRAM
SPD Revision                                     1.0
Module Type                                      SODIMM

---=== Memory Characteristics ===---
Maximum module speed                             5600 MT/s (PC5-22400)
Size                                             40 GB
Banks x Rows x Columns x Bits                    32 x 17 x 10 x 32
SDRAM Device Width                               8 bits
Ranks                                            2
Rank Mix                                         Symmetrical
Primary Bus Width                                32 bits
Bus Width Extension                              4 bits
AA-RCD-RP-RAS (cycles)                           46-45-45-90
Supported CAS Latencies                          50T, 46T, 42T, 40T, 36T, 32T, 30T, 28T, 26T, 22T

---=== Timings at Standard Speeds ===---
AA-RCD-RP-RAS (cycles) as DDR5-5600              46-45-45-90
AA-RCD-RP-RAS (cycles) as DDR5-5200              46-42-42-84
AA-RCD-RP-RAS (cycles) as DDR5-4800              40-39-39-77
AA-RCD-RP-RAS (cycles) as DDR5-4400              40-36-36-71
AA-RCD-RP-RAS (cycles) as DDR5-4000              36-32-32-64
AA-RCD-RP-RAS (cycles) as DDR5-3600              30-29-29-58
AA-RCD-RP-RAS (cycles) as DDR5-3200              28-26-26-52

---=== Timing Parameters ===---
Minimum Cycle Time (tCKmin)                      0.357 ns
Maximum Cycle Time (tCKmax)                      1.000 ns
Minimum CAS Latency Time (tAA)                   16.000 ns
Minimum RAS to CAS Delay (tRCD)                  16.000 ns
Minimum Row Precharge Delay (tRP)                16.000 ns
Minimum Active to Precharge Delay (tRAS)         32.000 ns
Minimum Active to Auto-Refresh Delay (tRC)       48.000 ns
Minimum Recovery Delay (tRFC1)                   0.410 ns
Minimum Recovery Delay (tRFC2)                   0.220 ns
Minimum Recovery Delay (tRFCsb)                  0.190 ns
Minimum Four Activate Window Delay (tFAW)        11.428 ns (32 cycles)
Minimum Row Active to Row Active Delay (tRRD_L)  5.000 ns (8 cycles)
Minimum CAS to CAS Delay (tCCD_L)                5.000 ns (8 cycles)
Minimum Write Recovery Time (tWR)                30.000 ns
Minimum Write to Read Time (tWTR_S)              2.500 ns (4 cycles)
Minimum Write to Read Time (tWTR_L)              10.000 ns (16 cycles)

---=== Other Information ===---
Package Type                                     Monolithic
Post Package Repair                              One row per bank
Soft PPR Undo/Lock                               Not Supported
MBIST PPR                                        Not Supported
Module Nominal Voltage                           1.1 V
Thermal Sensor                                   No

---=== Common Information ===---
SPD Module Info Revision                         1.0
SPD Manufacturer                                 IDT
PMIC0 Manufacturer                               Richtek Power

---=== Physical Characteristics ===---
Module Height                                    32 mm
Module Thickness                                 2 mm front, 2 mm back
Module Reference Card                            E revision 0

---=== Manufacturer Data ===---
Module Manufacturer                              Micron Technology
DRAM Manufacturer                                Micron Technology
Manufacturing Location Code                      0x01
Manufacturing Date                               2025-W44
Assembly Serial Number                           0xFE0E0000
Part Number                                      MB48G56S80M2R8.RtR            
Revision Code                                    0x11
DRAM Stepping                                    G


Number of SDRAM DIMMs detected and decoded: 1

--3pryehbembrny5bp--
