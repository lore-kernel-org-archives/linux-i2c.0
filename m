Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.40.28.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515857;
	b=vVVD6lwKgICs/umPXll8tygl2+EuZ/qLwHJpJ5e2Lu7E0bFjlQ15/PVlECYoDGIxDzI6
	 asCLga0ekD+M298LVhjJCab5+IBglZn3Z2/CpjsSvpBxrO8vR7BmnXY/dQiuTxPp9tmd3
	 vn7TQA25FBqskQIyKNE6Es86wSwS8lAVFMexQZWGBe/w1CWuWHAsCif2vgvZeKKsFhoKi
	 dmsy6/y/oo2lNKaSsIWEC/juvJr6w5QMqmJbMOlMu8Aq5Wt8/2EbNaWCNmmFHXH4lTkpH
	 G0lGn0xEQO8PThIRJ64GJzPPfJL4AnSO9kRepU27jsSm8mp9X5E+D8Z9gamjgUiJ8zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515857;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer:
	 X-Virus-Scanned;
	bh=MCean8fM0s+dBTIvEdZHKnm2Rk6ArhpXrWoOOrQa5I4=;
	b=uq3lPUgX+EcTqIMpqZvOptFLM8kgjF+qXj85hweNYf2R1tfzyHHswTBb7P+oC18siZ+v
	 aqeiD17l02E9yeaUr/n8jIP/jMnPgrEpJl6qEGMG6SEOgRStdQUWPn+DCjf+lYXKU6w5g
	 svinBCFAPhoUQvc9Cp/bXT6o2ZDALolX4sIyaxwjr29saEQMTpyyGFXni18PKStTEI83i
	 qEeE8mtU7Rw7jga499IJPi9VVdJTw3du3K6hrgo/wNDdGseBqjrE2hag8VFWxY2Kdsxq3
	 /zZZFlkNGhWOOE5U7hOmLAhue3/z+isDEHlXGuEmB3hIXrxTfkmyBLeE9GcFe5TRSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rxw.at;
	spf=pass smtp.mailfrom=rxw.at;
	dkim=pass header.d=rxw.at header.i=@rxw.at header.a=rsa-sha256 header.s=default1911 header.b=NGeHxoNU;
	arc=none smtp.remote-ip=188.40.28.6
Received: from www226.your-server.de (www226.your-server.de [188.40.28.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28D606A324
	for <linux-i2c@vger.kernel.org>; Sun,  1 Nov 2026 06:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC28D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rxw.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rxw.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rxw.at header.i=@rxw.at header.a=rsa-sha256 header.s=default1911 header.b=NGeHxoNU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rxw.at;
	s=default1911; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MCean8fM0s+dBTIvEdZHKnm2Rk6ArhpXrWoOOrQa5I4=;
	b=NGeHxoNUmdngZ4tLzzmD26YyKx9H5XygSZ+0ankXem+M8CJY0pFZxKIfBrTlaYK5eMkEXoTmaD+
	dghrjbjfEBHoOYaPokb0If+ZNfb3JBsTqz/bKZg6COR+cUS3Q5vttr5adtrTQe+ry5YI1PPthLEEZ
	zDXo43l7ay9QT/Pc3L7JF/U407E/EKbW/ggu3vmf8W9Qk6iDANEE9Wo4oI3iL6cPojMv4QMHpSlxL
	/zQZk5Q6IEEuIk6YXADf/dybzb29dAk3muROuQEj8Ej1qw6RLwMvquZauYVrjs7LKYb2Qd9NZVYPw
	aJ7HsIUITfl0LlU1AbVupGowbQgmSRHBea3A==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www226.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <info@rxw.at>)
	id 1xNPP3-0007zU-0X;
	Sun, 01 Nov 2026 07:50:53 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <info@rxw.at>)
	id 1xNPP2-0007gZ-2d;
	Sun, 01 Nov 2026 07:50:53 +0100
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: i2c: SPD EEPROM of DIMM2 on Dell OptiPlex 3050 is at 0x52, but
 auto-registration uses 0x51
From: RXW Info <info@rxw.at>
In-Reply-To: <d0a0316b-955c-4fc0-8185-89163d65d3e7@gmail.com>
Date: Sun, 1 Nov 2026 07:50:41 +0100
Cc: linux-i2c@vger.kernel.org,
 jdelvare@suse.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <15394197-9FF2-40D8-A450-F484BC13F383@rxw.at>
References: <D815B63F-4029-47E1-9FE9-8CF040AA962A@rxw.at>
 <d0a0316b-955c-4fc0-8185-89163d65d3e7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)
X-Virus-Scanned: Clear (ClamAV 1.4.6/28170/Sat Oct 31 07:24:42 2026)

Many thanks for your quick response. I'm still new to Linux. I'm =
learning how to create the i2c-smbus module myself using AI (Claude) and =
how to integrate the debug outputs.=20
I'll be in touch again.=20

Greeting Robert



> Am 31.10.2026 um 22:51 schrieb Heiner Kallweit <hkallweit1@gmail.com>:
>=20
> On 31.10.2026 21:07, RXW Info wrote:
>>=20
>>=20
>> Hello !
>>=20
>> My name is Robert W=C3=BChrer, from Austria.=20
>>=20
>> On two identical Dell OptiPlex 3050 machines (2 DIMM slots, each
>> populated with 2x 8 GB DDR4), the SPD EEPROM of the module in DIMM2
>> is not registered automatically at boot. hardinfo2 therefore shows
>> SPD data for DIMM1 only.
>>=20
>> Findings:
>> - The SPD of DIMM1 is at 0x50 and bound to ee1004 (UU in i2cdetect).
>>=20
>> - The SPD of DIMM2 responds at 0x52, not at 0x51, and no device is
>>  registered there.
>>=20
>> - decode-dimm also finds only one DIMM slot.=20
>>=20
>> - Swapping all modules between slots and between both machines makes
>>  no difference, so it is neither module- nor machine-specific.
>>=20
>> - Same behaviour on Fedora, Debian and Parted Magic.
>>=20
>> - Manual registration works:
>>  echo ee1004 0x52 > /sys/bus/i2c/devices/i2c-0/new_device
>>=20
>> - My assumption (please correct me): the SPD devices are registered
>>  consecutively starting at 0x50 based on the DMI type 17 entries, so
>>  the second slot ends up at 0x51. On this board the second slot
>>  seems to be wired to 0x52 instead.
>>=20
>> - I have not tested older kernels, so I cannot say whether this is
>>  a regression.
>>=20
>> Request: would a DMI quirk for this board be acceptable, or could the
>> address mapping be determined differently? I am happy to test =
patches.
>>=20
>> Thank you and best regards, Robert
>>=20
>> =E2=80=94=E2=80=94
>>=20
>>=20
>> System: Dell OptiPlex 3050, BIOS 09/06/2024, Version 1.32.0
>>=20
>> Kernel: 7.2.12+deb14-amd64
>>=20
>>=20
>> dmidecode -s system-product-name: OptiPlex 3050
>>=20
>>=20
>> root@debian1:~# lspci -nn | grep -i smbus
>> 00:1f.4 SMBus [0c05]: Intel Corporation 200 Series/Z370 Chipset =
Family SMBus [8086:a2a3]
>>=20
>>=20
>> root@debian1:~# i2cdetect -l
>> i2c-0 smbus      SMBus I801 adapter at 0000:00:1f.4 SMBus adapter
>> i2c-1 i2c        i915 gmbus dpc                   I2C adapter
>> i2c-2 i2c        i915 gmbus dpb                   I2C adapter
>> i2c-3 i2c        i915 gmbus dpd                   I2C adapter
>> i2c-4 i2c        AUX C/DDI C/PHY C                I2C adapter
>> i2c-5 i2c        AUX D/DDI D/PHY D                I2C adapter
>> i2c-6 i2c        AUX A/DDI E/PHY E                I2C adapter
>>=20
>>=20
>> root@debian1:~# dmesg | grep -iE "i801|ee1004|spd"
>> [    1.019462] i801_smbus 0000:00:1f.4: SPD Write Disable is set
>> [    1.019488] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
>> [    1.021106] i2c i2c-0: Successfully instantiated SPD at 0x50
>> [    6.413081] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, =
read-only
>>=20
>>=20
>> root@debian1:~# i2cdetect -y 0
>>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:                         08 -- -- -- -- -- -- --=20
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>> 30: 30 -- -- -- -- 35 UU UU -- -- -- -- -- -- -- --=20
>> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --=20
>> 50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --=20
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>> 70: -- -- -- -- -- -- -- --                        =20
>>=20
>>=20
>> root@debian1:~# dmidecode -t memory
>> dmidecode 3.7
>> Getting SMBIOS data from sysfs.
>> SMBIOS 3.0.0 present.
>>=20
>> Handle 0x0009, DMI type 16, 23 bytes
>> Physical Memory Array
>> Location: System Board Or Motherboard
>> Use: System Memory
>> Error Correction Type: None
>> Maximum Capacity: 32 GiB
>> Error Information Handle: Not Provided
>> Number Of Devices: 2
>>=20
>> Handle 0x000A, DMI type 17, 40 bytes
>> Memory Device
>> Array Handle: 0x0009
>> Error Information Handle: Not Provided
>> Total Width: 64 bits
>> Data Width: 64 bits
>> Size: 8 GiB
>> Form Factor: DIMM
>> Set: None
>> Locator: DIMM1
>> Bank Locator: Not Specified
>> Type: DDR4
>> Type Detail: Synchronous Unbuffered (Unregistered)
>> Speed: 2400 MT/s
>> Manufacturer: 80AD000080AD
>> Serial Number: xxxxxxx
>> Asset Tag: xxxxxxx
>> Part Number: HMA81GU6AFR8N-UH   =20
>> Rank: 1
>> Configured Memory Speed: 2400 MT/s
>> Minimum Voltage: Unknown
>> Maximum Voltage: Unknown
>> Configured Voltage: 1.2 V
>>=20
>> Handle 0x000B, DMI type 17, 40 bytes
>> Memory Device
>> Array Handle: 0x0009
>> Error Information Handle: Not Provided
>> Total Width: 64 bits
>> Data Width: 64 bits
>> Size: 8 GiB
>> Form Factor: DIMM
>> Set: None
>> Locator: DIMM2
>> Bank Locator: Not Specified
>> Type: DDR4
>> Type Detail: Synchronous Unbuffered (Unregistered)
>> Speed: 2400 MT/s
>> Manufacturer: 80AD000080AD
>> Serial Number: xxxxxxx
>> Asset Tag: xxxxxxx
>> Part Number: HMA81GU6AFR8N-UH   =20
>> Rank: 1
>> Configured Memory Speed: 2400 MT/s
>> Minimum Voltage: Unknown
>> Maximum Voltage: Unknown
>> Configured Voltage: 1.2 V
>>=20
>>=20
>> root@debian1:~# decode-dimms=20
>> # decode-dimms version 4.4
>>=20
>> Memory Serial Presence Detect Decoder
>> By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
>> Jean Delvare, Trent Piepho and others
>>=20
>>=20
>> Decoding EEPROM: /sys/bus/i2c/drivers/ee1004/0-0050
>> Guessing DIMM is in                              bank 1
>> Kernel driver used                               ee1004
>>=20
>> ---=3D=3D=3D SPD EEPROM Information =3D=3D=3D---
>> EEPROM CRC of bytes 0-125                        OK (0xBD97)
>> # of bytes written to SDRAM EEPROM               384
>> Total number of bytes in EEPROM                  512
>> Fundamental Memory type                          DDR4 SDRAM
>> SPD Revision                                     1.1
>> Module Type                                      UDIMM
>> EEPROM CRC of bytes 128-253                      OK (0x53D8)
>>=20
>> ---=3D=3D=3D Memory Characteristics =3D=3D=3D---
>> Maximum module speed                             2400 MT/s =
(PC4-19200)
>> Size                                             8192 MB
>> Banks x Rows x Columns x Bits                    16 x 16 x 10 x 64
>> SDRAM Device Width                               8 bits
>> Ranks                                            1
>> Primary Bus Width                                64 bits
>> AA-RCD-RP-RAS (cycles)                           17-17-17-39
>> Supported CAS Latencies                          18T, 17T, 16T, 15T, =
14T, 13T, 12T, 11T, 10T
>>=20
>> ---=3D=3D=3D Timings at Standard Speeds =3D=3D=3D---
>> AA-RCD-RP-RAS (cycles) as DDR4-2400              17-17-17-39
>> AA-RCD-RP-RAS (cycles) as DDR4-2133              15-15-15-35
>> AA-RCD-RP-RAS (cycles) as DDR4-1866              13-13-13-30
>> AA-RCD-RP-RAS (cycles) as DDR4-1600              11-11-11-26
>>=20
>> ---=3D=3D=3D Timing Parameters =3D=3D=3D---
>> Minimum Cycle Time (tCKmin)                      0.833 ns
>> Maximum Cycle Time (tCKmax)                      1.600 ns
>> Minimum CAS Latency Time (tAA)                   13.750 ns
>> Minimum RAS to CAS Delay (tRCD)                  13.750 ns
>> Minimum Row Precharge Delay (tRP)                13.750 ns
>> Minimum Active to Precharge Delay (tRAS)         32.000 ns
>> Minimum Active to Auto-Refresh Delay (tRC)       45.750 ns
>> Minimum Recovery Delay (tRFC1)                   350.000 ns
>> Minimum Recovery Delay (tRFC2)                   260.000 ns
>> Minimum Recovery Delay (tRFC4)                   160.000 ns
>> Minimum Four Activate Window Delay (tFAW)        21.000 ns
>> Minimum Row Active to Row Active Delay (tRRD_S)  3.300 ns
>> Minimum Row Active to Row Active Delay (tRRD_L)  4.900 ns
>> Minimum CAS to CAS Delay (tCCD_L)                5.000 ns
>> Minimum Write Recovery Time (tWR)                15.000 ns
>> Minimum Write to Read Time (tWTR_S)              2.500 ns
>> Minimum Write to Read Time (tWTR_L)              7.500 ns
>>=20
>> ---=3D=3D=3D Other Information =3D=3D=3D---
>> Package Type                                     Monolithic
>> Maximum Activate Count (MAC)                     Unlimited
>> Post Package Repair                              One row per bank =
group
>> Soft PPR                                         Supported
>> Module Nominal Voltage                           1.2 V
>> Thermal Sensor                                   No
>>=20
>> ---=3D=3D=3D Physical Characteristics =3D=3D=3D---
>> Module Height                                    32 mm
>> Module Thickness                                 2 mm front, 1 mm =
back
>> Module Reference Card                            A revision 2
>>=20
>> ---=3D=3D=3D Manufacturer Data =3D=3D=3D---
>> Module Manufacturer                              SK Hynix (former =
Hyundai Electronics)
>> DRAM Manufacturer                                SK Hynix (former =
Hyundai Electronics)
>> Manufacturing Location Code                      0x01
>> Manufacturing Date                               2017-W01
>> Assembly Serial Number                           xxxxxx
>> Part Number                                      HMA81GU6AFR8N-UH   =20=

>>=20
>>=20
>> Number of SDRAM DIMMs detected and decoded: 1
>=20
> You could do some printf-debugging to check where in =
i2c_register_spd() something
> unexpected happens. First question would be whether dimm_count has the =
right value.

