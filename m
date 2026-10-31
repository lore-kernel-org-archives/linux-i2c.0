Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483522;
	b=jJWbb/cftcRPVnzuV1AEUw2tV6D1vedOQ0JmDEmVS+eKI+ocUIKQ5NiXaVMlKTYCq10R
	 Z8hbgC+8bgTN5rprZud8AlwaB3TFzwVYrTAmApfFk/6q60lM0HH10hjBHRX+4rFBgzpOy
	 9LFS6c5e6VcJc94IOA4dPq/6VoH5R6xnEYKyUKz2uAecD63Kwp1Xkvsz8Z3wYLptCs6A0
	 nolNHYM1lUMSUDxg3L1N8KRogj57mya42NJJe/2zDAnmxPc3MAH+ad+TWwK+wPGeqX5wO
	 tjvWXqKjORCFsPrg9MDNXrv8cEKlv/HaakPzxjs5jdEvAKU5mI+Fwa2IeuZY2VsjINg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NSprcKir/rSdpHefeOFgJeo6kkvpwIOuGs6oxeCEbjA=;
	b=lr8lj42QUB7R+jOwLXHYCrK/NjN6PFeouX7vTDTNkokxRFLaOdNGuh3c7eJ2bLyNupBy
	 C+vHHKQpZdJRGN2r0QguZxNP5lEBQ7tJkow8VHm3fwoe9t+ArTTVOEEYRlthGT/C7DC4Z
	 YNXpiF7RtSs4W3LKy1UNVkG2GkfbkmHQqIbwoOtkaalbNxUyPoYk84XGm7HrFMMzogsKK
	 /JwfgaN7KQL7Z8cyfZBqLVfGectturfgYWB4d6y8xfOwNgLfWimBWQytjXnyg9jCkn5kF
	 CmHTaz6GoqAuEyNYe3uiVBqeXnh+Rty/fkxkD65nIcEQbwPyikYl+FCPvjbSV4dVNHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ahQr6ATP;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD2606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 21:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BD2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ahQr6ATP
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso21750195e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483521; x=1794088321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSprcKir/rSdpHefeOFgJeo6kkvpwIOuGs6oxeCEbjA=;
        b=ahQr6ATPESn7wsXyiHkTCOqhIgHEa2GBvP5hBD9ozQLxPHotLJMd0dqzwjA8YTWFaD
         bhyoq+ZTbU4/hwE6lbxq3EHp5SveAovIe5TXhE8rO7HyXvsy3Jo45LPrGq8pIsBpjhsr
         g9qwlUygrjmBwjicSU52qFZ/YgjxeEAcD2xI6y1Th29exKnmmsp/6GJ7uJOLcP/YA5bW
         0RFRFhlDmZlAu08q8j0sd435+X6tG6nZ+kuwTsO+drxEsOV3eGoq7qwRqNcpjUaah3BR
         08cUW3lHGz85pjCoePh1DzkRMJYKuu99wWiOQ7VeLcGUwxqDsQcMYjcCzst69rF62bae
         o0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483521; x=1794088321;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSprcKir/rSdpHefeOFgJeo6kkvpwIOuGs6oxeCEbjA=;
        b=KkCIysbZ04Yj5CGnAx0/BOdUNSDd75dNoXXFNFKGUS3x00Ts6bxESheeE4gpG6Ww5/
         vZDMXwc+i1P8caot/7AWUjTF/nPivFzkZQ6abRUGXKgrhrZaFafCVMQDgQkZF6HONXk8
         hMJWevPNeG53wkBdIPqJIHny+YoCF2pliuInp6YpkDU4epz4TgKJ9D8IOt7MyeNZ1NtI
         a+HCMlKO3XfwpfHWcBXZYm5JHkgQp1jN2PIMpZzB9pE9EU3Gx9B3UOgsYwuHYKNWLakW
         dMXSNeSxxphiFttZJThH68F8S8bosJHCEdVpLChwzmLCD2p/ZpxIikGvgkv2DcIm1GKI
         AM0w==
X-Forwarded-Encrypted: i=1; AKwUvBzVjK1xLKQocDYqqzZXqJvEdIsrq8pMwAz5DvUr3SvrHm7FaF7Md3iqRxLYWZB5EQXFxaNyLqOzm+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXJUdgHRks7pboSXteG7CvXkNnqiy9+ug1CIUniSjPgrUJm2LK
	4SALH5HxS7ayJ2dPJBuL/BLVn41hk9YgBAmx8xaUcIxJI/3rshl+BOPV/ODsRA==
X-Gm-Gg: AYBFou3uog61EccNOEBfUHhHoJKzMO9yVW+MjxulRNXF5dmGEgC1cJmBUx1tMyRK10V
	16o3Cmw5aLzltA8V2+1syBabUILgIlrBk5Ou9HhTG+Ph4wgTiBl+QgGPyhSqcGGxlSQ6hFinOV4
	X8tc1DDCyD2x9AdG4+FhIAA3prJAncu+KnmWYvQOlVDfUqRqslwtG5EQvROi2MGsvAOc/m4Tp4P
	sdL0jBllUTtN+d/C4/VLip0SGA/r8fUvCJd5o/zQTxZ0BXJz+58QmtYVqM9chpc78NxEZT+E5sD
	MR3RC7qvd+kWksIkXeFhJIEAtUSbr8YozM0j/PR/0/NCCzK+bxAFB6Kkb8nLLGmHvalKtb8Wnzo
	D3oFmmcZq6DeW2qsYe8ErRQ8WfyK5ghHbMKlzMIVKxWwTmOeTd4Z4UG2dzXooPiPJOE4pdBtzYK
	Ztnu1Bz/Q990OJpdg0UHlaml3NJvoqHoISOOwwRVDk+vGyMGMJ8XwPFGOjfukFNchWFYXD0xG5W
	Oa7P8zgdxmV8oyTOOmYBPJ0kbBbcNY8p7thYle++qc0Lg9+07AXCvB8lhohTiSUKKdN4fyir1qp
	jPpJ8Cuk61avkhhSqaokWkE7GufCJOAtY6LmG/WI3FTUFTVaALxdES2+rRvMKgd5CBV+4NQORwc
	kzabI/r+iKbiG3oAeoDLThFW83AS64IvV5bt2X0vUdlSkhnfVLD52tvfonUaJ//aPWO0=
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4ac1932b43amr144608475e9.31.1793483520309;
        Sat, 31 Oct 2026 14:52:00 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:cc00:9d7c:44e5:5736:dc8b? (p200300ea8f2fcc009d7c44e55736dc8b.dip0.t-ipconnect.de. [2003:ea:8f2f:cc00:9d7c:44e5:5736:dc8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2950sm228787265e9.8.2026.10.31.14.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 14:51:59 -0700 (PDT)
Message-ID: <d0a0316b-955c-4fc0-8185-89163d65d3e7@gmail.com>
Date: Sat, 31 Oct 2026 22:51:57 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i2c: SPD EEPROM of DIMM2 on Dell OptiPlex 3050 is at 0x52, but
 auto-registration uses 0x51
To: RXW Info <info@rxw.at>, linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de
References: <D815B63F-4029-47E1-9FE9-8CF040AA962A@rxw.at>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <D815B63F-4029-47E1-9FE9-8CF040AA962A@rxw.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31.10.2026 21:07, RXW Info wrote:
> 
> 
> Hello !
> 
> My name is Robert Wührer, from Austria. 
> 
> On two identical Dell OptiPlex 3050 machines (2 DIMM slots, each
> populated with 2x 8 GB DDR4), the SPD EEPROM of the module in DIMM2
> is not registered automatically at boot. hardinfo2 therefore shows
> SPD data for DIMM1 only.
> 
> Findings:
> - The SPD of DIMM1 is at 0x50 and bound to ee1004 (UU in i2cdetect).
> 
> - The SPD of DIMM2 responds at 0x52, not at 0x51, and no device is
>   registered there.
> 
> - decode-dimm also finds only one DIMM slot. 
> 
> - Swapping all modules between slots and between both machines makes
>   no difference, so it is neither module- nor machine-specific.
> 
> - Same behaviour on Fedora, Debian and Parted Magic.
> 
> - Manual registration works:
>   echo ee1004 0x52 > /sys/bus/i2c/devices/i2c-0/new_device
> 
> - My assumption (please correct me): the SPD devices are registered
>   consecutively starting at 0x50 based on the DMI type 17 entries, so
>   the second slot ends up at 0x51. On this board the second slot
>   seems to be wired to 0x52 instead.
> 
> - I have not tested older kernels, so I cannot say whether this is
>   a regression.
> 
> Request: would a DMI quirk for this board be acceptable, or could the
> address mapping be determined differently? I am happy to test patches.
> 
> Thank you and best regards, Robert
> 
> ——
> 
> 
> System: Dell OptiPlex 3050, BIOS 09/06/2024, Version 1.32.0
> 
> Kernel: 7.2.12+deb14-amd64
> 
> 
> dmidecode -s system-product-name: OptiPlex 3050
> 
> 
> root@debian1:~# lspci -nn | grep -i smbus
> 00:1f.4 SMBus [0c05]: Intel Corporation 200 Series/Z370 Chipset Family SMBus [8086:a2a3]
> 
> 
> root@debian1:~# i2cdetect -l
> i2c-0	smbus     	SMBus I801 adapter at 0000:00:1f.4	SMBus adapter
> i2c-1	i2c       	i915 gmbus dpc                  	I2C adapter
> i2c-2	i2c       	i915 gmbus dpb                  	I2C adapter
> i2c-3	i2c       	i915 gmbus dpd                  	I2C adapter
> i2c-4	i2c       	AUX C/DDI C/PHY C               	I2C adapter
> i2c-5	i2c       	AUX D/DDI D/PHY D               	I2C adapter
> i2c-6	i2c       	AUX A/DDI E/PHY E               	I2C adapter
> 
> 
> root@debian1:~# dmesg | grep -iE "i801|ee1004|spd"
> [    1.019462] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    1.019488] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [    1.021106] i2c i2c-0: Successfully instantiated SPD at 0x50
> [    6.413081] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
> 
> 
> root@debian1:~# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                         08 -- -- -- -- -- -- -- 
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 30: 30 -- -- -- -- 35 UU UU -- -- -- -- -- -- -- -- 
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- -- 
> 50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 70: -- -- -- -- -- -- -- --                         
> 
> 
> root@debian1:~# dmidecode -t memory
> dmidecode 3.7
> Getting SMBIOS data from sysfs.
> SMBIOS 3.0.0 present.
> 
> Handle 0x0009, DMI type 16, 23 bytes
> Physical Memory Array
> 	Location: System Board Or Motherboard
> 	Use: System Memory
> 	Error Correction Type: None
> 	Maximum Capacity: 32 GiB
> 	Error Information Handle: Not Provided
> 	Number Of Devices: 2
> 
> Handle 0x000A, DMI type 17, 40 bytes
> Memory Device
> 	Array Handle: 0x0009
> 	Error Information Handle: Not Provided
> 	Total Width: 64 bits
> 	Data Width: 64 bits
> 	Size: 8 GiB
> 	Form Factor: DIMM
> 	Set: None
> 	Locator: DIMM1
> 	Bank Locator: Not Specified
> 	Type: DDR4
> 	Type Detail: Synchronous Unbuffered (Unregistered)
> 	Speed: 2400 MT/s
> 	Manufacturer: 80AD000080AD
> 	Serial Number: xxxxxxx
> 	Asset Tag: xxxxxxx
> 	Part Number: HMA81GU6AFR8N-UH    
> 	Rank: 1
> 	Configured Memory Speed: 2400 MT/s
> 	Minimum Voltage: Unknown
> 	Maximum Voltage: Unknown
> 	Configured Voltage: 1.2 V
> 
> Handle 0x000B, DMI type 17, 40 bytes
> Memory Device
> 	Array Handle: 0x0009
> 	Error Information Handle: Not Provided
> 	Total Width: 64 bits
> 	Data Width: 64 bits
> 	Size: 8 GiB
> 	Form Factor: DIMM
> 	Set: None
> 	Locator: DIMM2
> 	Bank Locator: Not Specified
> 	Type: DDR4
> 	Type Detail: Synchronous Unbuffered (Unregistered)
> 	Speed: 2400 MT/s
> 	Manufacturer: 80AD000080AD
> 	Serial Number: xxxxxxx
> 	Asset Tag: xxxxxxx
> 	Part Number: HMA81GU6AFR8N-UH    
> 	Rank: 1
> 	Configured Memory Speed: 2400 MT/s
> 	Minimum Voltage: Unknown
> 	Maximum Voltage: Unknown
> 	Configured Voltage: 1.2 V
> 
> 
> root@debian1:~# decode-dimms 
> # decode-dimms version 4.4
> 
> Memory Serial Presence Detect Decoder
> By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
> Jean Delvare, Trent Piepho and others
> 
> 
> Decoding EEPROM: /sys/bus/i2c/drivers/ee1004/0-0050
> Guessing DIMM is in                              bank 1
> Kernel driver used                               ee1004
> 
> ---=== SPD EEPROM Information ===---
> EEPROM CRC of bytes 0-125                        OK (0xBD97)
> # of bytes written to SDRAM EEPROM               384
> Total number of bytes in EEPROM                  512
> Fundamental Memory type                          DDR4 SDRAM
> SPD Revision                                     1.1
> Module Type                                      UDIMM
> EEPROM CRC of bytes 128-253                      OK (0x53D8)
> 
> ---=== Memory Characteristics ===---
> Maximum module speed                             2400 MT/s (PC4-19200)
> Size                                             8192 MB
> Banks x Rows x Columns x Bits                    16 x 16 x 10 x 64
> SDRAM Device Width                               8 bits
> Ranks                                            1
> Primary Bus Width                                64 bits
> AA-RCD-RP-RAS (cycles)                           17-17-17-39
> Supported CAS Latencies                          18T, 17T, 16T, 15T, 14T, 13T, 12T, 11T, 10T
> 
> ---=== Timings at Standard Speeds ===---
> AA-RCD-RP-RAS (cycles) as DDR4-2400              17-17-17-39
> AA-RCD-RP-RAS (cycles) as DDR4-2133              15-15-15-35
> AA-RCD-RP-RAS (cycles) as DDR4-1866              13-13-13-30
> AA-RCD-RP-RAS (cycles) as DDR4-1600              11-11-11-26
> 
> ---=== Timing Parameters ===---
> Minimum Cycle Time (tCKmin)                      0.833 ns
> Maximum Cycle Time (tCKmax)                      1.600 ns
> Minimum CAS Latency Time (tAA)                   13.750 ns
> Minimum RAS to CAS Delay (tRCD)                  13.750 ns
> Minimum Row Precharge Delay (tRP)                13.750 ns
> Minimum Active to Precharge Delay (tRAS)         32.000 ns
> Minimum Active to Auto-Refresh Delay (tRC)       45.750 ns
> Minimum Recovery Delay (tRFC1)                   350.000 ns
> Minimum Recovery Delay (tRFC2)                   260.000 ns
> Minimum Recovery Delay (tRFC4)                   160.000 ns
> Minimum Four Activate Window Delay (tFAW)        21.000 ns
> Minimum Row Active to Row Active Delay (tRRD_S)  3.300 ns
> Minimum Row Active to Row Active Delay (tRRD_L)  4.900 ns
> Minimum CAS to CAS Delay (tCCD_L)                5.000 ns
> Minimum Write Recovery Time (tWR)                15.000 ns
> Minimum Write to Read Time (tWTR_S)              2.500 ns
> Minimum Write to Read Time (tWTR_L)              7.500 ns
> 
> ---=== Other Information ===---
> Package Type                                     Monolithic
> Maximum Activate Count (MAC)                     Unlimited
> Post Package Repair                              One row per bank group
> Soft PPR                                         Supported
> Module Nominal Voltage                           1.2 V
> Thermal Sensor                                   No
> 
> ---=== Physical Characteristics ===---
> Module Height                                    32 mm
> Module Thickness                                 2 mm front, 1 mm back
> Module Reference Card                            A revision 2
> 
> ---=== Manufacturer Data ===---
> Module Manufacturer                              SK Hynix (former Hyundai Electronics)
> DRAM Manufacturer                                SK Hynix (former Hyundai Electronics)
> Manufacturing Location Code                      0x01
> Manufacturing Date                               2017-W01
> Assembly Serial Number                           xxxxxx
> Part Number                                      HMA81GU6AFR8N-UH    
> 
> 
> Number of SDRAM DIMMs detected and decoded: 1

You could do some printf-debugging to check where in i2c_register_spd() something
unexpected happens. First question would be whether dimm_count has the right value.
