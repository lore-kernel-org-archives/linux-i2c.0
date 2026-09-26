Received: from carlos3.mail.rambler.ru (carlos3.mail.rambler.ru [81.19.78.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E034751B
	for <linux-i2c@vger.kernel.org>; Sat, 26 Sep 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.78.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431470; cv=none; b=AqgInj21Ry+n5KI3AokF3XqWITB0CIwtqREJO1vCMmcKiGybtEbEN772V3uwn/Miat07V9pl+Dvd5cTlXo+necI6xHuyYY7fSyt2+iSadX3e3JDirtz3LkOaEnwMjdHZzB7wFwxZoNQM1fUlE5Fvc5kBiBe0ZSOhnaJqROXnBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431470; c=relaxed/simple;
	bh=uzcH4qU2Be4W2R3f6INMHI43lML3O5/kTiwOOLP5NL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/A4XKFdcNr1pl4OfBeQJAshkVdJ6TQFcAcoB4qwsmtjjPzU5A1k3eqCg5c8BtIw+/AKImSYVd9gjG9IfCONvxSh62P4dhpKhXsebph7U4WBe1H1Yny/IbFTjct0Dpn9NGYygltYFjGnOANfpayLm8U9SEqx4ygu3tnFOroJp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru; spf=pass smtp.mailfrom=ro.ru; arc=none smtp.client-ip=81.19.78.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ro.ru
Received: from localhost (localhost [127.0.0.1])
	(Authenticated sender: alma0@ro.ru)
	by carlos3.mail.rambler.ru (Postfix) with ESMTPA id 7CEC6D236AF;
	Sat, 26 Sep 2026 16:59:41 +0300 (MSK)
Message-ID: <e9e4f8c9-9fe9-44fb-900d-d2aa6aa197e6@ro.ru>
Date: Sat, 26 Sep 2026 15:59:40 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Bug=231110749=3A_ee1004=3A_DDR4_SPD_cannot_be_read?=
 =?UTF-8?Q?=2C_decode-dimms_fails=2C_=E2=80=9CFailed_to_select_page_0_=28-6?=
 =?UTF-8?B?KeKAnQ==?=
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
From: Al Ma <AlMa0@ro.ru>
In-Reply-To: <arPcZcu7S9vqE3JE@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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


It helps in the sense that the error messages are gone. Is doesn't help in the sense that I still don't know how to programmatically read SPD-EEPROM of the modules installed on my system.

Alma
