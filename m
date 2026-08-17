Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FB3F9A11;
	Mon, 17 Aug 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965538; cv=none; b=oBlAlpVjomxhYvfSDf1YL7R3r6tW2YvkUgN0cBTLQ+hOZlFSTZr2Kp6JDyUelIzAvDsWIo0nS4ybytViCL8lwmQTAvsvGEcJtWpxQOFcueUTyEqITdvWM/9lg93ls9rnNGF7ypdkVR3MOBpJNEnjl2wBo1c1PZcelfs6N5vWREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965538; c=relaxed/simple;
	bh=duwy+4kai9rYQ8+StMMTQqaYsUK+fckrp2Q6YyrmxfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5333dJO4l4zjZceR6iTiL+Sdh2HPkMf6HEVCWG1/WjekXCEfH5ZpEL+NQtjTW18QN3UAmOCh3UFul+6YR5/6Fwg1yoY5FAy8bA/P9PdOGwtOcbizl9RPjFbuQOYvzZF1fex2ZvAGwqafaTrIaL5VG6Q/YbMZVntkm2LnMdIoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=e/1X2jUq; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="e/1X2jUq"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hNqtT4nDRz4Bwb;
	Mon, 17 Aug 2026 13:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786965153;
	bh=duwy+4kai9rYQ8+StMMTQqaYsUK+fckrp2Q6YyrmxfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/1X2jUqAzdhzz6C42NkObxMq9b8KTzza4iEJfI+2WAxgZSMOCPctrMszsqH4jYMk
	 6oWiM7lLpUcodryG7XGx2zIR/fOwZcuoyr2SoYQZVLae8iVNAoAc3gAt6Gd8RpOPyx
	 PJXtyhsYZGVwJHhURqH+gexOaHSng5rwwXSH71rjrgLcM7aCB6Zd8t52marwltVp+x
	 6nsip8xeAUDBLH7wUSdvskfZ9tNMHhopooUk3RkA0nCtPrclPFMjaPd5nlqbTd2T2X
	 YWF1uHtH2aPiBw53vi3qPO9N6HfvuVNux2kMCj1sF1A9J8xYWvm5ejG5SMfZIFKCsu
	 egfJBxN9cxHGw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hNqtT43fZz4Bh6;
	Mon, 17 Aug 2026 13:12:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hNqtQ4dggz8sfv;
	Mon, 17 Aug 2026 13:12:30 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 548585FA63;
	Mon, 17 Aug 2026 13:12:25 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7c410f84-86f2-48e7-bee9-4c5c038bd115@leemhuis.info>
Date: Mon, 17 Aug 2026 13:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: johannes.goede@oss.qualcomm.com,
 Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-gpio@vger.kernel.org, wsa@kernel.org, brgl@bgdev.pl,
 basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
 chaitanya.kumar.borah@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 trantiendat29042005@gmail.com
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu>
 <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local>
 <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
 <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info>
 <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
 <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
 <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info>
 <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
 <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
 <9095d7c8-92fe-4163-98f8-a53bbcefd6cb@leemhuis.info>
 <CANTFpSV9jguMzmfN7STb7XANYdn8i34bVmpT=0NdJ_o=3_Y1CQ@mail.gmail.com>
 <1bca212d-fe9c-4666-8ac1-743f8c9ef1c5@oss.qualcomm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <1bca212d-fe9c-4666-8ac1-743f8c9ef1c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178696514601.4135322.18443439930888126347@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 548585FA63
X-NC-CID: YwKnitW0Q7dW3XtRrbO8nnnwVCT9iucau4Ve/zuYSitGPZDK61U=

On 8/17/26 11:51, johannes.goede@oss.qualcomm.com wrote:
> On 14-Aug-26 12:09 PM, Hardik Prakash wrote:
>> On Wed, 13 Aug 2026, Thorsten Leemhuis wrote:
>>> Hardik, could you submit a revert to the lists? And then I'll provide my
>>> Tested-by and ask Linus to directly pick this up?
>>
>> Sent: https://lore.kernel.org/all/20260814100719.9548-1-hardikprakash.official@gmail.com/
>>
>> Verified on my end that it builds clean, boots clean, and correctly
>> restores the original Yoga 7 race (expected tradeoff) without
>> introducing anything else.

Hans, thx for looking into this.
> Thank you for submitting a revert for this. Note it looks like Torvalds himself
> beat you to it and already reverted this for 7.2 final :)

Yeah, I pointed Linus to this and a few others issues and then he
reverted the change directly:
https://lore.kernel.org/all/628bbf10-29f1-4e9e-b23b-4c47657433b9@leemhuis.info/

> I hit another problem caused by this now reverted change, where the PMIC
> i2c bus would not show up on many Intel BYT/CHT devices. I wrote a fix for
> this (attached) on top of the now reverted commit.

FWIW, meanwhile "Tran Tien Dat" (now CCed) with -next ran into a problem
on a MSI Modern 14 H D13MG that the revert seems to have resolved. But
the symptoms were different: the two DesignWare I2C controllers in that
machine apparently deferred probe forever and are never retried:

16.429266 platform i2c_designware.1: deferred probe pending: (reason
unknown)
16.429286 platform i2c_designware.0: deferred probe pending: (reason
unknown)

For details, see: https://bugzilla.kernel.org/show_bug.cgi?id=221889

Ciao, Thorsten

> I think my fix might also have helped for the broken touchpad issue from this
> thread, but I believe there is a better way to fix all this, so IMHO it is
> good that this was reverted.
> 
> If I understand things correctly the problem the reverted fix was trying
> to fix is i2c-transfer errors happening before the GPIO controller driver
> is ready.
> 
> The i2c-core will not initiate transfers itself, so the problem is that
> the i2c-hid driver is initiating transfers before the GPIO controller
> is setup.
> 
> The i2c-hid driver does actually request the interrupt itself, so we can
> simply wait for that to succeed inside the i2c-hid code. ATM the i2c-hid
> code starts with an i2c-connectivity check because some ACPI tables list
> non existing I2C-HID devices.
> 
> But we could make the i2c-hid driver start with first requesting its IRQ
> and if that fails bail (with -EPROBE_DEFER) before doing any i2c-transfers.
> 
> And then do the i2c-connectivity test after requesting the IRQ. So basically
> swap the order of i2c-connectivity test vs IRQ requesting.
> 
> The IRQ requesting should then use the IRQF_NO_AUTOEN flag to keep the IRQ
> disabled at first and explicitly enable it later when the rest of the driver
> setup is done.
> 
> Hardik, can you take a shot at coding up the suggested i2c-hid(-core) changes
> and test to see if this fixes the original Yoga 7 race in a cleaner manner ?
> 
> Regards,
> 
> Hans
> 

