Received: from carlos6.mail.rambler.ru (carlos6.mail.rambler.ru [81.19.78.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A203E16A4
	for <linux-i2c@vger.kernel.org>; Sat, 26 Sep 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.78.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431766; cv=none; b=d1ZeZUsCReUVkbXUVaiJt22/IPO4XMkn8lM98Kc1fbf5lUwbJdxwSIyOzjpzoPgOAxG1YBzvTWCDEWS4kCS+041wgT9KissTnen4v3zzrvHe1Jaq8Hs+O9LcWVquqXWunB2RkJXR9NWb3Qx4oTlh9F4OVFiz1VcDjRctuNpcRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431766; c=relaxed/simple;
	bh=D+ISMBYV6pUagDgjydAaqBHgdBea+zvQkZpUowLW3Ho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WpzAqhGsjk+ttmcEwgarn6XVhYC8uS2Bq1t2BEROW9egJvGHK5Rb2oiftNCsLqCFe6dCIDmGO7HJGORlsnNOOVLJ/xcnfIwlv6Jgepau4unVCmV9OSJ6Y1soNkWXJUYRxCfNwwpjiLyc7WD7U4D7YcbNSTqa6FMjREu/EishugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru; spf=pass smtp.mailfrom=ro.ru; arc=none smtp.client-ip=81.19.78.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ro.ru
Received: from localhost (localhost [127.0.0.1])
	(Authenticated sender: alma0@ro.ru)
	by carlos6.mail.rambler.ru (Postfix) with ESMTPA id 5708041629CD;
	Sat, 26 Sep 2026 17:04:08 +0300 (MSK)
Message-ID: <d7e511c1-3062-48a9-b433-b88933f3660b@ro.ru>
Date: Sat, 26 Sep 2026 16:04:07 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Al Ma <AlMa0@ro.ru>
Subject: =?UTF-8?Q?Typo_correction=3A_Re=3A_Bug=231110749=3A_ee1004=3A_DDR4_?=
 =?UTF-8?Q?SPD_cannot_be_read=2C_decode-dimms_fails=2C_=E2=80=9CFailed_to_se?=
 =?UTF-8?B?bGVjdCBwYWdlIDAgKC02KeKAnQ==?=
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 1110749@bugs.debian.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
 <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
 <ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
 <812847a5-5630-4d26-8012-c816e6d1db32@ro.ru>
 <20260911135604.6c2451e7@endymion>
 <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <8d8740a4-6b9f-483b-9ea4-145293e63c25@ro.ru> <arPcZcu7S9vqE3JE@monoceros>
Content-Language: en-US
In-Reply-To: <arPcZcu7S9vqE3JE@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> $ echo "blacklist ee1004" | sudo tee /etc/modprobe.d/ee1004.conf
>> blacklist ee1004
>> $ sudo depmod -ae
>> depmod: WARNING: -e needs -E or -F
>> $ sudo update-initramfs -u
>> update-initramfs: Generating /boot/initrd.img-6.12.107+deb13-amd64
>>
>> Can the above warning be ignored?
> 
> I think yes. AFAIK that depmod step isn't needed and the wiki should be
> fixed.
> 
> Does that help?
> 

Here we go (after many reboots):

$ cat /etc/modprobe.d/ee1004.conf
blacklist ee1004
$ lsmod | grep ee1004
$ sudo dmesg | egrep "i2c|ee1004"
$ sudo decode-dimms
No EEPROM found, try loading the eeprom, at24 or or ee1004 module
$ sudo i2cdetect -y 0
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- 56 -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
$


It helps in the sense that the error message “ee1004 0-0056: Failed to select page 0 (-6)” is gone. It doesn't help in the sense that I still don't know how to programmatically read SPD-EEPROM of the modules installed on my system.

Alma
