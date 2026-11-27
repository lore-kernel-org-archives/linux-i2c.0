Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745678;
	b=gb/wropfuUci0nYBcZGQBg0CaIzMo5liBaSobxMWf/ubSCT6lBw5lOjJZSFgwlJXM8/R
	 QJcWzgp2GYBDAK40CXB+DrzpjK5SYBRK2+uZeQ0EGC8s0MT07f0AceWApMV4ky9oDv9s8
	 4bAJJy6TBmt8GnUFkDILCcr70Dogwlsud7rJrVXzFt0VtKmHbEw0TWkSCtW0KhPU7DyM6
	 BwcxDDeyDllb1tN5mQ/1W8m3Nq+EudYb2x06QecH5WYvRx0fkrlcPRE5Qa93DFy2I3dxM
	 SWIqkb4d1WbdBf5SrV+K5zcAdmBxg1ueRAZxmQPrxbthMXOZzfsIy3SX7eUu5hk3rNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745678;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G1B15ny8r70aWtqYGkWccyTxg3wcjdom6IsqnICi+1E=;
	b=aPIe/KPwy0RCh+nVvjeAp/1k5xhySsiSBy0+0qwk3pXRu8kQoTqowHSznqoIOhIlUwYo
	 8ARc/JvdwrNhySxvvWsGlCB6ngYZ7By0cFzF5ExkU34JdqG+aQ8DEup3oUNwOs5+Dbg1+
	 nvHuDnrzoOHKY3Sgqb9rG8RgL91hXJ7fG9FqBLMS++qQ7MsqGsjGo0oBSh7SWaKE4ZuPx
	 +vr1UA7F6MWGOYPTDfZRR50G5Yf5XM7x0ccoWzSn0TVc9vndzf9+nQi9IVx6maHwRb/OH
	 oPR2JA46sxROpROu0WityhQggVpQsgnSXI5Pk49+YMRzVmTtMBO8D9HaTpq7VAApEPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=myth5.com;
	spf=pass smtp.mailfrom=myth5.com;
	arc=none smtp.remote-ip=115.124.28.68
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840E606A31E;
	Fri, 27 Nov 2026 02:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8840E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=myth5.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myth5.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09420933|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0179708-0.0136425-0.968387;FP=12537866024497197795|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033024148021;MF=myth5@myth5.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.kB472c2_1795745656;
Received: from precision-5560(mailfrom:myth5@myth5.com fp:SMTPD_---.kB472c2_1795745656 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 10:14:25 +0800
From: "fangzhong.zhou" <myth5@myth5.com>
To: mika.westerberg@linux.intel.com
Cc: "fangzhong . zhou" <myth5@myth5.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Dell.Client.Kernel@dell.com,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Limit DLL0945 100 kHz quirk to Dell Precision  5560 and XPS 15 9510
Date: Fri, 27 Nov 2026 10:11:54 +0800
Message-ID: <20261127021203.35477-1-myth5@myth5.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120071924.GI229695@black.igk.intel.com>
References: <20261119143218.586632-2-pmenzel@molgen.mpg.de> <20261120071924.GI229695@black.igk.intel.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 20 Nov 2026 08:19:24 +0100, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> Hi,
>
> On Thu, Nov 19, 2026 at 03:32:16PM +0100, Paul Menzel wrote:
>> Commit 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
>> forces the I2C bus to 100 kHz for all devices with the ACPI ID DLL0945 to
>> work around a sluggish cursor on the Dell Precision 5560. But DLL0945 does
>> not identify a touchpad model. Dell uses it for touchpads from different
>> vendors:
>> 
>>     System                Touchpad
>>     Dell Precision 5560   ELAN 04F3:311C
>>     Dell XPS 15 9510      ELAN 04F3:311C (bugzilla #214597)
>>     Dell XPS 13 9310      Synaptics 06CB:CDE6
>> 
>> The ELAN touchpads are the ones known to need 100 kHz, but the Synaptics
>> touchpad of the Dell XPS 13 9310 is slowed down without need. Its DSDT
>> specifies 400 kHz, and Linux logs:
>> 
>>     i2c_designware i2c_designware.0: [Firmware Bug]: DSDT uses known not-working I2C bus speed 400000, forcing it to 100000
>> 
>> The touchpad scans every 7.1 ms (scan time field in the input report), and
>> i2c-hid reads wMaxInputLength (64 bytes) for each report. Tracing the I2C
>> transfers for 30 seconds of moving a finger on the touchpad shows:
>> 
>>                              100 kHz   400 kHz
>>     read time (median)        7.3 ms    2.5 ms
>>     bus busy                   87 %      36 %
>>     reports per second          111       140
>>     frames lost                18.6 %     0 %
>> 
>> At 100 kHz the host cannot keep up with the touchpad, and every fifth frame
>> is lost. At 400 kHz all frames arrive, and no sluggish cursor was noticed.
>> 
>> So, only apply the DLL0945 entry on the Dell Precision 5560 and XPS 15 9510
>> by pointing the entry's driver_data to a DMI table, which can be used to
>> restrict other entries in the same way.
>
> Yeah, we should really figure out how this works in Windows. I'm sure they
> don't have such a quirk list so maybe it's up to the vendor specific
> drivers to "tune" the bus to their needs whereas in Linux we obey the ACPI
> description.
>
>> Tested on the Dell XPS 13 9310.
>> 
>> - The `[Firmware Bug] … forcing it to 100000` line is gone from dmesg.
>> - Re-probed the touchpad’s I²C controller with debug output on, and it
>>   reports `Bus speed: Fast Mode (400 kHz)`. The touchpad came back up
>>   under hid-multitouch.
>> 
>> Fixes: 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214597
>> Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> Cc: Dell.Client.Kernel@dell.com
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>

From my subsequent testing, the cursor lag issue still appears when the
laptop is under high load or any other reasons, so my earlier patch did 
not fully resolve the problem.

I then replaced the original touchpad with a brand-new unit. After more
than one and a half months of continuous testing, the cursor lag has not
reappeared.

I will keep testing to confirm whether the issue is completely gone.
