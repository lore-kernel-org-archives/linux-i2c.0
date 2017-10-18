From: tim@timakro.de
Subject: i2cset doesn't work on ASUS 22T1E via Nvidia GeForce 1050 Ti and
 HDMI
Date: Wed, 18 Oct 2017 19:57:10 +0000
Message-ID: <20171018195710.Horde.u1J8jQWW3eh6W_Ak590Rgg5@horde.bschusrv.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=_fywD_9yWzUjHIyBMc7QAjg1";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:53261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdJRT5L (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 15:57:11 -0400
Received: from mail-jessie.bs.de ([185.126.101.70]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 0Lr6Rz-1dZ8D82qBf-00egz4 for <linux-i2c@vger.kernel.org>; Wed, 18 Oct 2017
 21:57:09 +0200
Received: from horde-jessie.bs.de ([192.168.2.9] helo=horde-jessie)
        by mail-jessie.bs.de with esmtps (TLS1.0:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <tim@timakro.de>)
        id 1e4uSk-0004X4-B0
        for linux-i2c@vger.kernel.org; Wed, 18 Oct 2017 21:57:10 +0200
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

This message is in MIME format and has been PGP signed.

--=_fywD_9yWzUjHIyBMc7QAjg1
Content-Type: multipart/mixed; boundary="=_HafzU7DNy_NVsLdmQF10dg1"

This message is in MIME format.

--=_HafzU7DNy_NVsLdmQF10dg1
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Content-Disposition: inline

Dear devs,

I'm trying to write the EEPROM in my ASUS 22T1E monitor containing  
EDID data using i2cset. The monitor is connected via HMDI to a Nvidia  
GeForce 1050 Ti. Actually I have no idea if there is a EEPROM in my  
monitor, I just assumed it. My problem is that the value never changes  
when I try to write.

# i2cset -r 4 0x50 38 0xd1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
DANGEROUS! Writing to a serial EEPROM on a memory DIMM
may render your memory USELESS and make your system UNBOOTABLE!
I will write to device file /dev/i2c-4, chip address 0x50, data address
0x26, data 0xd1, mode byte.
Continue? [y/N] y
Warning - data mismatch - wrote 0xd1, read back 0x71

Also my GPU registers multiple buses, might it be related to that?

# i2cdetect -l
i2c-3	i2c       	NVIDIA i2c adapter 4 at 1:00.0  	I2C adapter
i2c-1	smbus     	ddbridge                        	SMBus adapter
i2c-4	i2c       	NVIDIA i2c adapter 6 at 1:00.0  	I2C adapter
i2c-2	smbus     	ddbridge                        	SMBus adapter
i2c-0	smbus     	ddbridge                        	SMBus adapter
i2c-5	i2c       	NVIDIA i2c adapter 7 at 1:00.0  	I2C adapter

Bus 4 seems to be the one containing the relevant data:

# i2cdetect 4
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-4.
I will probe address range 0x03-0x77.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Any ideas why this couldn't be working are welcome. Is it maybe not  
possible to write the EDID data on this specific monitor? Should I try  
this using a different GPU?

Regards,
     Tim Schumacher

--=_HafzU7DNy_NVsLdmQF10dg1
Content-Type: application/pgp-keys
Content-Description: PGP Public Key

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
=rDCs
-----END PGP PUBLIC KEY BLOCK-----
--=_HafzU7DNy_NVsLdmQF10dg1--

--=_fywD_9yWzUjHIyBMc7QAjg1
Content-Type: application/pgp-signature
Content-Description: PGP Digital Signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ57IWAAoJEKPWnj2poP80TpAP/2gbWslHw4Z4pYaylC9P96iT
Kubk4m9WqA0v5gAvNjsmVSU/7e0rLnfmPi//RsbtZ0rHEW25Ia2GZZsCh/ai66GH
D4k7EFzoQQt0GbeX83OfUrutcHAYwTra692yWmgPjqc8VmUJZzicxHOnk/GqGI37
GBRFcfXhaj7NZdCP/OMEZD6KW6f5WjQYUk3M4OoDX1DcSTmj5PupZSYhw2hK9029
CcPpKuE2uOmOus1Cl8p4YvGZHwnATDvLdnRCefncUaRjg1WYGIpRBLTo/kFw3lF4
+2fx+0hcyK77PZLzA3t/JtfiZDkpnVGE53cMX8SZo0YK8s0CazDj62EXDKwMnEHk
XYuG1yh+FvT8DM8pNSHGEKdAYvWPeSCCAFik14iUb/sfPvzEjacyW5oE9iDUwSMg
4EQtp3MY897h3odiVqNGErnkxWk+YrGIqfVCiF+bMSNeVRpo/sgH3GsRo/XC8qzN
oNrPY/Lqz/J+hl0nl5lLH25+wM/wXnjXpPqBhk8n+DzBXIjJ0Ii9Nx2skDWHsiyu
hzwxj23Fh5OxXfXCx8+kM+mYzJ8RIIzTdjzV9xl6XAotp3Vq4RGYl90uost5MrF9
6CGalX6Hst79GlI6pf6UMsJYg5AzMaF1JBGanaO4B9sVdJ9Ukbc41bB+uKvOYi3L
nSm4LGOcPvsDhAwMp7OX
=900Q
-----END PGP SIGNATURE-----

--=_fywD_9yWzUjHIyBMc7QAjg1--
