Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772768;
	b=l2UlK8b7xpZdA1ymXAZvGnvY4/BlXj7sW9Oo+BAVd3HB7lF6/FUXRHlwBl3HqRlL+mPt
	 0Dy2YF359Wc7fF1WrBpp/HG3z1XzTguIUm/SK9q+WkW0wzBRsQHXjGv7US121cOZi/nJD
	 XsNIfC+FmV8Qpt3y+pVrvn7IjQY6+vdpfBlhxSOuwgjIwMG2DhJ16LRox5LhuxH3G+VMA
	 9oAoxvG3k02bx1BQ8azwldMPksgRAUJC0BbpDdta/rCSYJmgex974pmKDC2EmD02ZN/W8
	 gD/TlTFnMOeKM4FOJuVfqS+VcUmZaSEhjyBTA8B1Dfz/TeoTmstdcJ65qcNvzYQBIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772768;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=3Y5xW9zL7afkUZwasjtlFb9Ki7bYkdZcTDdq3Crlcdg=;
	b=dTSSWsZrKv6dFwJ8wZRV0Ae055RB56ycHVuHedGpVrGMma0kY2HZLROXIZ+D+FYPolf7
	 5nB9hSjfmS6bqhd99Ch6mpDT0vvN4UCZxYFNXPVLDT9HuhM5yMpgUcxOLKiCkc8CrMSzs
	 TdlL44tPF6tgjcdYLNWiaEO/tvMrDYl9G+HsGR5FcV0WeO+2qhiTOa9AMxvdgg79IKXJf
	 Eh5WVWXuPPDZahToS3LsuppQpJqo0m9V3y74vbNYV0G/067IkKzAL54Kct1jb8zpUk0QU
	 sQ6jc1RHKAA6IHSnfSinUWMP0nWugqlgmdlYrentM+SeNUPuxBRZ3/GkLgjnBSSsTAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=b+fvNiyz;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADFB606A31C;
	Fri, 27 Nov 2026 09:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=b+fvNiyz
Received: from [141.14.220.44] (g44.guest.molgen.mpg.de [141.14.220.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 392454C1A256EC;
	Fri, 27 Nov 2026 10:45:27 +0100 (CET)
Message-ID: <7dac94da-c783-4a17-b0de-32b3bf257cf3@molgen.mpg.de>
Date: Fri, 27 Nov 2026 10:45:25 +0100
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
Subject: Re: [PATCH] i2c: acpi: Limit DLL0945 100 kHz quirk to Dell Precision
 5560 and XPS 15 9510
To: Fangzhong Zhou <myth5@myth5.com>, mika.westerberg@linux.intel.com
Cc: Mika Westerberg <westeri@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Dell.Client.Kernel@dell.com, linux-i2c@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119143218.586632-2-pmenzel@molgen.mpg.de>
 <20261120071924.GI229695@black.igk.intel.com>
 <20261127021203.35477-1-myth5@myth5.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261127021203.35477-1-myth5@myth5.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1795772727; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=3Y5xW9zL7afkUZwasjtlFb9Ki7bYkdZcTDdq3Crlcdg=; 
	b=b+fvNiyzLPgmEh6XKNTNCS1HPav55zvqgYZRMIVBK++S66PnLwsxH/TeE8UiZBmPPj3A/uGzZF0w
	aB+3J08f5EQcOOpJgH6Wtdzqcmw/BWb47fhcLs/M+UwrIQa4c6pYm3ObV+Ogz+LsZYB+KB3r4WYBsG
	3SDVxgwKERLncwLJv+F92lOnC0wf/PZfVW2m6wh262JgDwh8oDr3RK0UqdBqUvEGo9P5iIipXYSOw2
	kT2/XIOrqado+lrKMkx6f3ynWDAxxZq5o1fd/cZz9xIEQN2urWFyWlS6OrTFTQXeAhT99D9pp0sVbd
	VbIiB3E5rIE+wv0UnMAadJOJRzWSdZtQ==

Dear Fangzhong,


Am 27.11.26 um 03:11 schrieb fangzhong.zhou:
> On Fri, 20 Nov 2026 08:19:24 +0100, Mika Westerberg wrote:

>> On Thu, Nov 19, 2026 at 03:32:16PM +0100, Paul Menzel wrote:
>>> Commit 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
>>> forces the I2C bus to 100 kHz for all devices with the ACPI ID DLL0945 to
>>> work around a sluggish cursor on the Dell Precision 5560. But DLL0945 does
>>> not identify a touchpad model. Dell uses it for touchpads from different
>>> vendors:
>>>
>>>      System                Touchpad
>>>      Dell Precision 5560   ELAN 04F3:311C
>>>      Dell XPS 15 9510      ELAN 04F3:311C (bugzilla #214597)
>>>      Dell XPS 13 9310      Synaptics 06CB:CDE6
>>>
>>> The ELAN touchpads are the ones known to need 100 kHz, but the Synaptics
>>> touchpad of the Dell XPS 13 9310 is slowed down without need. Its DSDT
>>> specifies 400 kHz, and Linux logs:
>>>
>>>      i2c_designware i2c_designware.0: [Firmware Bug]: DSDT uses known not-working I2C bus speed 400000, forcing it to 100000
>>>
>>> The touchpad scans every 7.1 ms (scan time field in the input report), and
>>> i2c-hid reads wMaxInputLength (64 bytes) for each report. Tracing the I2C
>>> transfers for 30 seconds of moving a finger on the touchpad shows:
>>>
>>>                               100 kHz   400 kHz
>>>      read time (median)        7.3 ms    2.5 ms
>>>      bus busy                   87 %      36 %
>>>      reports per second          111       140
>>>      frames lost                18.6 %     0 %
>>>
>>> At 100 kHz the host cannot keep up with the touchpad, and every fifth frame
>>> is lost. At 400 kHz all frames arrive, and no sluggish cursor was noticed.
>>>
>>> So, only apply the DLL0945 entry on the Dell Precision 5560 and XPS 15 9510
>>> by pointing the entry's driver_data to a DMI table, which can be used to
>>> restrict other entries in the same way.
>>
>> Yeah, we should really figure out how this works in Windows. I'm sure they
>> don't have such a quirk list so maybe it's up to the vendor specific
>> drivers to "tune" the bus to their needs whereas in Linux we obey the ACPI
>> description.
>>
>>> Tested on the Dell XPS 13 9310.
>>>
>>> - The `[Firmware Bug] … forcing it to 100000` line is gone from dmesg.
>>> - Re-probed the touchpad’s I²C controller with debug output on, and it
>>>    reports `Bus speed: Fast Mode (400 kHz)`. The touchpad came back up
>>>    under hid-multitouch.
>>>
>>> Fixes: 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214597
>>> Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>> Cc: Dell.Client.Kernel@dell.com
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
> 
> From my subsequent testing, the cursor lag issue still appears when the
> laptop is under high load or any other reasons, so my earlier patch did
> not fully resolve the problem.
> 
> I then replaced the original touchpad with a brand-new unit. After more
> than one and a half months of continuous testing, the cursor lag has not
> reappeared.
> 
> I will keep testing to confirm whether the issue is completely gone.

Thank you for your update. Do you know, what is different exactly in the 
brand-new unit? Revision or firmware?

And just to be sure, you indeed have an ELAN touchpad, right?


Kind regards,

Paul
