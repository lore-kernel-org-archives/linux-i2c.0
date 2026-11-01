Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.40.28.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562121;
	b=QIMJNoN4aaCM4GMoQgJfYXPJ2n7aeLDfEOkHeSd1892XGzvEDOFH8972b6JfByombcFe
	 AKBsbE/Y6x844A7kbuAJs65EGH8fMNaoOczUC2kgOj/iQfFhxyl/F3gGzEbWKBW8/ImQM
	 nmpm8Hl8iacbX3zGVLQ6CyDzCHb557diCwquyFSp8JJ245NaF7X3r0XFV/OkiQ61fYtHb
	 KYUGTz+Rj2tT6ghChzYYzX2gS9IUs6jwRd4DOtlhKZsxAu1aXlV9oM1hRTUuYVbk3lzFU
	 mbeGZb7OnE5DO7xsA6rYfaUKJMuRuS/kTS04A6gaPO3X7XKcJLFXuXXckc7ifOf0TFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562121;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer:
	 X-Virus-Scanned;
	bh=bBylbvWlpVHPWQ1IE74iw1Uih2Flc14W+RBbEvUlcDw=;
	b=5eddRUsFWGJ5aEIQRXsS6BTSme427SDDYIp3Ule85IU/LYTKnV+IJ4N3mH3J1/0+Fnlp
	 uvVzmmVduE1JMWesGB+5X478vvcLIZvhC464L1ayzyexky80fvah68OwlAP3CifRezNl0
	 bPjmhkAaDMpN517SuR6PzF34fNiDYM66niPy5+mRrbL89CSUDsbFZ2Qf8G+jM43kxyQfv
	 /m5unw+ZIbzEYzv4Szo9ph9Ctp5J9dbgzWTICsdpxaxK1zhgcY2FxakQvTn804cRh2jdZ
	 pX2yhdnGQhX21QU0HAOHy+YVJOODMq68XUjxJdxziD+uSEm2k8HlbF+nxRk6bord6NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rxw.at;
	spf=pass smtp.mailfrom=rxw.at;
	dkim=pass header.d=rxw.at header.i=@rxw.at header.a=rsa-sha256 header.s=default1911 header.b=hCf6PYuv;
	arc=none smtp.remote-ip=188.40.28.6
Received: from www226.your-server.de (www226.your-server.de [188.40.28.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0A606A325
	for <linux-i2c@vger.kernel.org>; Sun,  1 Nov 2026 19:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C0A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rxw.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rxw.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rxw.at header.i=@rxw.at header.a=rsa-sha256 header.s=default1911 header.b=hCf6PYuv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rxw.at;
	s=default1911; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bBylbvWlpVHPWQ1IE74iw1Uih2Flc14W+RBbEvUlcDw=;
	b=hCf6PYuvQcjE/cbwboEiNepI3fMMRBI8qQ4Mul2RYhks+yS0812hO1M8HzmfUhF8qxH26lwbk9e
	BWkl8qTTC/x/OceK/KIgWZemAWvtdxTj9qO9uPrcKnEspHo1M1hCQuv7ZueU5MtMCz5t3vaCXSAm1
	IcbPA929wGuxbJwSPMcc7woBcvYxJJ70Bvk2IvoUfnD+E8MqwWZjfvQHiN9R95mYXI3+KI+mttEzM
	3CTs4C63GJfond8iVLyB1E73bfpinJlROI4oo+tb1DilUgBo1IhT6UeB1UGdiNz/flhLjmfW/pYRD
	mpjtE+Jpk/1mV0ZSdXd0v3rmL3s98ojtOc/A==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www226.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <info@rxw.at>)
	id 1xNbRE-00096g-1q;
	Sun, 01 Nov 2026 20:41:56 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <info@rxw.at>)
	id 1xNbRE-000PZg-1K;
	Sun, 01 Nov 2026 20:41:56 +0100
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
Date: Sun, 1 Nov 2026 20:41:45 +0100
Cc: linux-i2c@vger.kernel.org,
 jdelvare@suse.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <3452295A-3E61-48D0-A30F-DFCFDDE89C28@rxw.at>
References: <D815B63F-4029-47E1-9FE9-8CF040AA962A@rxw.at>
 <d0a0316b-955c-4fc0-8185-89163d65d3e7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)
X-Virus-Scanned: Clear (ClamAV 1.4.6/28171/Sun Nov  1 07:27:34 2026)

Hey !

Thanks for the tips. I've added the debug output to the i2c-smbus modul.=20=


This revealed that if the slot addresses are not consecutive=E2=80=94such =
as DIMM1 =3D 0x50 and DIMM2 =3D 0x52=E2=80=94DIMM2 is not recognized.

In my case, `slot_count` =3D 2 and `dimm_count` =3D 2.=20
As a result, the loop =E2=80=9Cfor (n=3D0; n < slot_count ....=E2=80=9D =
terminates at address 0x51, and Slot 2 is not found.

Instead of =E2=80=9Cfor (n =3D 0; n < slot_count && dimm_count; n++),=E2=80=
=9D I changed the loop to =E2=80=9Cfor (n =3D 0; n < 8 && dimm_count; =
n++)=E2=80=9C.=20

This ensures that all DIMMs are detected, regardless of their =
configuration.


Attached is my extension for debug output of i2c-smbus.c


static void i2c_register_spd(struct i2c_adapter *adap, bool =
write_disabled)
{
	int n, slot_count =3D 0, dimm_count =3D 0;
	u16 handle;
	u8 common_mem_type =3D 0x0, mem_type;
	u64 mem_size;
	bool instantiate =3D true;
	const char *name;

	while ((handle =3D dmi_memdev_handle(slot_count)) !=3D 0xffff) {

		pr_info("spd-debug-01: slot_count=3D%d\n", slot_count);

		slot_count++;

		/* Skip empty slots */
		mem_size =3D dmi_memdev_size(handle);

		pr_info("spd-debug-02: mem_size=3D0x%llx\n", mem_size);

		if (!mem_size)
			continue;

		/* Skip undefined memory type */
		mem_type =3D dmi_memdev_type(handle);

		pr_info("spd-debug-03: mem_type=3D0x%hx\n", mem_type);

		if (mem_type <=3D 0x02)		/* Invalid, Other, =
Unknown */
			continue;

		if (!common_mem_type) {
			/* First filled slot */
			common_mem_type =3D mem_type;
		} else {
			/* Check that all filled slots have the same =
type */
			if (mem_type !=3D common_mem_type) {
				dev_warn(&adap->dev,
					 "Different memory types mixed, =
not instantiating SPD\n");
				return;
			}
		}

		pr_info("spd-debug-04: dimm_count=3D%d\n", dimm_count);

		dimm_count++;
	}

	/* No useful DMI data, bail out */
	if (!dimm_count)
		return;

	/*
	 * The max number of SPD EEPROMs that can be addressed per bus =
is 8.
	 * If more slots are present either muxed or multiple busses are
	 * necessary or the additional slots are ignored.
	 */
	slot_count =3D min(slot_count, 8);

	/*
	 * Memory types could be found at section 7.18.2 (Memory Device =
=E2=80=94 Type), table 78
	 * =
https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.6.0=
.pdf
	 */
	switch (common_mem_type) {
	case 0x12:	/* DDR */
	case 0x13:	/* DDR2 */
	case 0x18:	/* DDR3 */
	case 0x1B:	/* LPDDR */
	case 0x1C:	/* LPDDR2 */
	case 0x1D:	/* LPDDR3 */
		name =3D "spd";
		break;
	case 0x1A:	/* DDR4 */
	case 0x1E:	/* LPDDR4 */
		name =3D "ee1004";
		break;
	case 0x22:	/* DDR5 */
	case 0x23:	/* LPDDR5 */
		name =3D "spd5118";
		instantiate =3D !write_disabled;
		break;
	default:
		dev_info(&adap->dev,
			 "Memory type 0x%02x not supported yet, not =
instantiating SPD\n",
			 common_mem_type);
		return;
	}

	pr_info("spd-debug-05: slot_count=3D%d dimm_count=3D%d\n", =
slot_count, dimm_count);

	/*
	 * We don't know in which slots the memory modules are. We could
	 * try to guess from the slot names, but that would be rather =
complex
	 * and unreliable, so better probe all possible addresses until =
we
	 * have found all memory modules.
	 */
	for (n =3D 0; n < slot_count && dimm_count; n++) {
		struct i2c_board_info info;
		unsigned short addr_list[2];

		memset(&info, 0, sizeof(struct i2c_board_info));
		strscpy(info.type, name, I2C_NAME_SIZE);
		addr_list[0] =3D 0x50 + n;
		addr_list[1] =3D I2C_CLIENT_END;

		pr_info("spd-debug-06: slot_count=3D%d n=3D%d =
dimm_count=3D%d, addr_list[0]=3D0x%hx, addr_list[1]=3D0x%hx\n", =
slot_count, n, dimm_count, addr_list[0], addr_list[1]);

		if (!instantiate)
			continue;

		if (!IS_ERR(i2c_new_scanned_device(adap, &info, =
addr_list, NULL))) {
			dev_info(&adap->dev,
				 "Successfully instantiated SPD at =
0x%hx\n",
				 addr_list[0]);
			pr_info("spd-debug-07: NEW_DEV OK\n");
			dimm_count--;
		} else {
			pr_info("spd-debug-07: NEW_DEV ERROR\n");
		}
	}
}


Here is the output for verification:

sudo dmesg | grep spd-debug

[    0.886154] spd-debug-01: slot_count=3D0
[    0.886156] spd-debug-02: mem_size=3D0x200000000
[    0.886157] spd-debug-03: mem_type=3D0x1a
[    0.886158] spd-debug-04: dimm_count=3D0
[    0.886159] spd-debug-01: slot_count=3D1
[    0.886160] spd-debug-02: mem_size=3D0x200000000
[    0.886161] spd-debug-03: mem_type=3D0x1a
[    0.886161] spd-debug-04: dimm_count=3D1
[    0.886162] spd-debug-05: slot_count=3D2 dimm_count=3D2
[    0.886163] spd-debug-06: slot_count=3D2 n=3D0 dimm_count=3D2, =
addr_list[0]=3D0x50, addr_list[1]=3D0xfffe
[    0.886467] spd-debug-07: NEW_DEV OK
[    0.886468] spd-debug-06: slot_count=3D2 n=3D1 dimm_count=3D1, =
addr_list[0]=3D0x51, addr_list[1]=3D0xfffe
[    0.886693] spd-debug-07: NEW_DEV ERROR

i2cdetect -y 0
    0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: 30 -- -- -- -- 35 UU UU -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --=20



Attached is my modification to ensure all DIMMs are detected:

for (n =3D 0; n < 8 && dimm_count; n++) {


Here is the output for verification:

sudo dmesg | grep spd-debug

[    0.867821] spd-debug-01: slot_count=3D0
[    0.867823] spd-debug-02: mem_size=3D0x200000000
[    0.867824] spd-debug-03: mem_type=3D0x1a
[    0.867825] spd-debug-04: dimm_count=3D0
[    0.867826] spd-debug-01: slot_count=3D1
[    0.867826] spd-debug-02: mem_size=3D0x200000000
[    0.867827] spd-debug-03: mem_type=3D0x1a
[    0.867828] spd-debug-04: dimm_count=3D1
[    0.867829] spd-debug-05: slot_count=3D2 dimm_count=3D2
[    0.867830] spd-debug-06: slot_count=3D2 n=3D0 dimm_count=3D2, =
addr_list[0]=3D0x50, addr_list[1]=3D0xfffe
[    0.868118] spd-debug-07: NEW_DEV OK
[    0.868118] spd-debug-06: slot_count=3D2 n=3D1 dimm_count=3D1, =
addr_list[0]=3D0x51, addr_list[1]=3D0xfffe
[    0.868279] spd-debug-07: NEW_DEV ERROR
[    0.868280] spd-debug-06: slot_count=3D2 n=3D2 dimm_count=3D1, =
addr_list[0]=3D0x52, addr_list[1]=3D0xfffe
[    0.868550] spd-debug-07: NEW_DEV OK

sudo i2cdetect -y 0

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: 30 -- -- -- -- 35 UU UU -- -- -- -- -- -- -- --=20
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --=20
50: UU -- UU -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
70: -- -- -- -- -- -- -- --   =20

                       =20
                   =20

I adapted the i2c_smbus module for my own use, and it works. It seems to =
me that others have the same problem, as there are several posts online =
about slots not having consecutive addresses starting at 0x50=E2=80=94that=
 is, there are gaps in between.

A note regarding possible side effects: On boards where DMI reports more =
enabled modules than are addressable on the bus, up to 8 addresses are =
now tried instead of slot_count.=20

Is this a general change, or a DMI quirk specific to my hardware?

What would be the best way to solve this issue in general?

Best regards, Robert from Austria










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

