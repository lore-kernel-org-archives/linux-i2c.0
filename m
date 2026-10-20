Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462846;
	b=gjCWBBz5eSRK3/wUTsJgzUexlMRRI4fYh26OrVhXIrFIHWrugr1cgdjbwh100m6w1Kaj
	 XhLz9C375vlcz5XlBNxGdqqJVdmaYPoFvmg/BYo+uHMYan1jLjzEgGqRo/FBcekxfxyIz
	 McoWVV5ssh6RLCJWJBRpg55yIofGX1lJpZJcm119KbUqJcbAxnnw+ytDAVs1fGaePEK++
	 HykAuiQyfVg9x0f2eIRHhaEo9UM8dUnIU3yAqmm2coPVVcgd2Hx/LkJ8koPQ8Bbu/mqrT
	 +as0mLUYJyJklK027WBYI4njEsAXTuzRJMXG4KpgOyaUuWY17OM7iEDmn2zo7tpLZSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462846;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=O7U0HqiaHhO1m0861+/gW/QJicAZ/PhQcq0hpT521/s=;
	b=YIPFDWXgE8ww99dhO1GVhdxGlk8ZMOM2+CTz5E5z1JEZ+8nuOwVVl+hJHJznILUKADfX
	 gQfDrT61zeDL52gBWj78vMdsXUvFctzAeE/d8i+52Oixa3Y75D+a26JbmaiXdPnWDAoqW
	 fCfKfeI6W1xfQvAuOi49q9tWYVotYgWIRYw5lZOSwRykqv5GrSUfbwS35CFjL2jnSs0gH
	 AdSt64o2gHgc8JdeVgreGmFQS8LvAfHVuMb6555eKI6lt9q2WLgP4vIeXdPBqfs3TrPQU
	 q44+5GzB4pvtwwm/AuNJdiIphniI2nPgnErwvQcdxvMi+SNcUNvjjl+MAd8j6fhKTqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="PrJl/E5X";
	arc=none smtp.remote-ip=210.79.60.31
Received: from mail-m6031.netease.com (mail-m6031.netease.com [210.79.60.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE6606A31C;
	Tue, 20 Oct 2026 02:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0FE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=PrJl/E5X
Received: from [172.16.12.99] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 51a2dc0ed;
	Tue, 20 Oct 2026 10:20:34 +0800 (GMT+08:00)
Message-ID: <fb24d2a7-0077-4560-83aa-f957551a3f6d@rock-chips.com>
Date: Tue, 20 Oct 2026 10:20:33 +0800
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
Subject: Re: [PATCH] i2c: rk3x: Disable the controller between transfers
To: Shawn Lin <shawn.lin@rock-chips.com>, Alexey Charkov <alchark@flipper.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
References: <20261015-i2c-rk3x-disable-v1-1-81625845c175@flipper.net>
 <bfe8baa4-e740-4908-9d2a-4defc5240a82@rock-chips.com>
 <CAKTNdwFYxPeaG6pZn3SYoR6cPAtON37ajo4nZpPE0Hm=y2c6Lg@mail.gmail.com>
 <9c18acc0-2b4b-4f19-9928-de1632718f15@rock-chips.com>
Content-Language: en-US
From: David Wu <david.wu@rock-chips.com>
In-Reply-To: <9c18acc0-2b4b-4f19-9928-de1632718f15@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1571c494409cckunm07388fb3343522
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQxlNSVZCQkxLTUkeTU
	8aS01WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PrJl/E5XisJvbfnc9+7tFf7oJI4BEsiNbiAl0y2cjIN4VdvW/WveXgzocZyORanuMX2zpU5gwWVyhhTbk+L2WN0QnwTuLnk1hh3AWY2XGlycbMmy1KwTuOWL95oanpwe0obe/IwColaKBCbgHQQ21acbKqTqJjhQYwNE77MWbRI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=O7U0HqiaHhO1m0861+/gW/QJicAZ/PhQcq0hpT521/s=;
	h=date:mime-version:subject:message-id:from;

Hi Alexey,

There's no deterministic way to reproduce this, looping suspend/resume 
seems to be able to trigger it eventually. The problem case is IEN != 0 
while pclk is already disabled: the irq handler doesn't re-enable pclk, 
so it can't actually clear the interrupt, and you get "irq in 
STATE_IDLE" printing forever. So the extra IEN write here is just a 
belt-and-suspenders safeguard.

在 2026/10/20 08:48, Shawn Lin 写道:
> Hi
> 
> 在 2026/10/20 星期二 0:50, Alexey Charkov 写道:
>> Hi Shawn,
>>
>> On Fri, Oct 16, 2026 at 4:33 AM Shawn Lin <shawn.lin@rock-chips.com> 
>> wrote:
>>>
>>> Cc: + David
>>>
>>> 在 2026/10/15 星期四 22:00, Alexey Charkov 写道:
>>>> The driver leaves the controller enabled once a transfer completes, and
>>>> an enabled controller keeps tracking the bus. If the lines collapse 
>>>> under
>>>> it while idle, as happens when a target's supply is switched off while
>>>> its bus pull-ups stay powered, its state machine wedges driving SDA 
>>>> low.
>>>> Every later transfer then times out, since the timeout path only 
>>>> requests
>>>> a STOP and never disables the controller, and the stuck state even
>>>> survives a kexec.
>>>>
>>>> Clear the enable bit once each transfer is done, successful or not, so
>>>> that the controller does not watch an idle bus and starts every 
>>>> transfer
>>>> from a clean state.
>>>>
>>>
>>> I checked the vendor kernel tree and saw another case that you perhaps
>>> need to fold something similar below into your patch, along with your
>>> disabling controller?
>>>
>>>       In some case，log like this:
>>>
>>>       [   12.393926] rk3x-i2c ff150000.i2c: irq in STATE_IDLE, ipd = 
>>> 0x51
>>>       [   12.416592] rk3x-i2c ff150000.i2c: irq in STATE_IDLE, ipd = 
>>> 0x51
>>>
>>>       The i2c clock is disabled, so the pending irq clean is not
>>>       worked. Disable the interrupt after the i2c jobs were done,
>>>       the error log would not happen.
>>>
>>>
>>> /* Disable i2c all irqs */
>>> #define IEN_ALL_DISABLE   0
>>>
>>> i2c_writel(i2c, IEN_ALL_DISABLE, REG_IEN);i2c_writel(i2c,
>>> IEN_ALL_DISABLE, REG_IEN);
>>
>> Thanks for looking into this! Do you happen to have a reproducer or
>> any additional info on how this state gets triggered? I haven't run
>> into it in my setups - did I just get lucky? :)
>>
> 
> Unfortunately, I don't. That came from what I found when checking
> the vendor kernel commit to see how we handled your case.
> 
> So I have looped David who made the internal submision for the same case
> as yours 8 years ago and hope him could have a comment here.
> 
>> I see the same write of 0 to REG_IEN just above my changed lines for
>> the case if (time_left == 0), which makes sense because a
>> too-long-running transfer might eventually complete and trigger the
>> interrupt with the controller disabled, unless the interrupt is
>> disabled too. For other cases I'd be interested to know what can raise
>> the interrupt.
>>
>> Best regards,
>> Alexey
>>
> 
> 
