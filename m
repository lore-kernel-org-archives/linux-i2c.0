Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298031195C;
	Sun, 19 Jul 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464796; cv=none; b=b7e0wZjj/sf2hcMcGdCKsac7OhqwspVTKjG5vgDMaNlPAGMfzFCsO1QI6KVN7FNvTmyt3q0ot6DGE5YeKANzqRWJofKzu439SJyQcdvbN76CA0Uh66u32RlrK2BYjiXpniIp3Wvz1uYF0mIumaLZtTo0pdznVoU0sKxIx5Q5SEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464796; c=relaxed/simple;
	bh=wDCMcLB4SqxcRXKam+IVHADVUrv5oiJOZc+uyxtIoDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbe8JL4fD3tK97Jj0a3LaXDshQOxzqoq7St8Y5XRA0OGrwbAZLXZkz2tAF723K6qWx8fMU6tGWCb7iuujJdlwRei93saqTQOGbhvKGpxpbqii7C5zIDOwmNY8AVHpp89Y5EAfQfphcd0DQZPV/AeMmz/B2fYHiHlVaCkVrQm9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=FMdNRXaT; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=FMdNRXaT; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=rQKuhDlI; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="FMdNRXaT";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="FMdNRXaT";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="rQKuhDlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784464781;
	bh=wDCMcLB4SqxcRXKam+IVHADVUrv5oiJOZc+uyxtIoDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FMdNRXaT1bAbjB98OVmFTn+D10E27y5PmHj2fBDyQ+LTLOJ+ImK7uA+rfIqxRDY2Z
	 yIxjdknk2iqBCsmgeVfaLGejdk0I6irCkTxhSaYLZSGJmpBlNQePTVItNgNg4inpdy
	 u/IVUqPPzwyYgjj5S9feLaVn8a9S8RBsna+GppksCRqVA3vbucZ4Cv/q63lhqmP9zV
	 xbnqQx/zwQbXWRbVQ9Q3mduiswZiN5Ve+uPACwxyO+49K7MGnI0LfiyHDz7guKzdy/
	 NMAbQ7cE1i613HtxxO3TuCNgemD1kh73KfO2/r8JAf0w3/BpKsXA4RTtsEjUyMQk4S
	 Ih7o8fEsgzAfg==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 74D83BC8C;
	Sun, 19 Jul 2026 14:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784464781;
	bh=wDCMcLB4SqxcRXKam+IVHADVUrv5oiJOZc+uyxtIoDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FMdNRXaT1bAbjB98OVmFTn+D10E27y5PmHj2fBDyQ+LTLOJ+ImK7uA+rfIqxRDY2Z
	 yIxjdknk2iqBCsmgeVfaLGejdk0I6irCkTxhSaYLZSGJmpBlNQePTVItNgNg4inpdy
	 u/IVUqPPzwyYgjj5S9feLaVn8a9S8RBsna+GppksCRqVA3vbucZ4Cv/q63lhqmP9zV
	 xbnqQx/zwQbXWRbVQ9Q3mduiswZiN5Ve+uPACwxyO+49K7MGnI0LfiyHDz7guKzdy/
	 NMAbQ7cE1i613HtxxO3TuCNgemD1kh73KfO2/r8JAf0w3/BpKsXA4RTtsEjUyMQk4S
	 Ih7o8fEsgzAfg==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 46FDCBBEE; Sun, 19 Jul 2026 14:39:41 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784464776;
	bh=wDCMcLB4SqxcRXKam+IVHADVUrv5oiJOZc+uyxtIoDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rQKuhDlIwuGM7EeDt9LonT33PGeAhZ/pNxR8sRZm6VIlWOzieTuXkbVTgT80DsUaR
	 vuCin1URC8iPqNHU+ntTjBmHCgI86X++kIBpp97lT/DbR2Cqlh/VZ972abPb9jRdcN
	 exvMBBi6UrOacaFZ7eLtECvafS6QSwIL+sBrjdPSajIJ1uKTI/XEgymSu4SkSL7gnM
	 2VkKQwcWGr9Td7+yMNvF8QnGo5bam0vdcd3anXnhBO+iHUes5iiM/3xwHbSXqNYfal
	 9FqwAD3EIvXgihrU51SPWNYQI8ICCHILhZ/9EL0IvP9167ZCWgVG3F9jGtyMDISvf9
	 kE0A5Lo0pwC4Q==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 02DC2BC11;
	Sun, 19 Jul 2026 14:39:34 +0200 (CEST)
Message-ID: <c0b47180-d3df-4b58-9311-d02734213716@lysator.liu.se>
Date: Sun, 19 Jul 2026 14:39:34 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/7] i2c: mux: add idle_state property to i2c_mux_core
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
 <20260713-i2c-mux-v11-2-72bb8af8ee8c@gmail.com>
 <e2d4fdf8-4dae-43dc-95ae-b9aa1884fdf5@lysator.liu.se>
 <alfZYOKCjf6CKN6i@gmail.com>
Content-Language: en-US, sv-SE
From: Peter Rosin <peda@lysator.liu.se>
In-Reply-To: <alfZYOKCjf6CKN6i@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

On 2026-07-15 21:02, Marcus Folkesson wrote:
> Hi Peter,
> 
> On Tue, Jul 14, 2026 at 01:29:01PM +0200, Peter Rosin wrote:
>> Hi Marcus,
>>
>> Sorry for the very late feedback.
>>
>> On 2026-07-13 09:19, Marcus Folkesson wrote:
>>> Muxes treat their channels differently when idle.
>>> Let the mux core have this information to make it available for
>>> internal use.
>>> Reuse the same state values used by CONFIG_MULTIPLEXER.
>>>
>>> Possible idle states are:
>>> - MUX_IDLE_AS_IS: Leave channels as is when idle
>>> - MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
>>> - <n>: Enable channel n when idle
>>>
>>> Default value is set to MUX_IDLE_AS_IS.
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> ---
>>>    drivers/i2c/i2c-mux.c   |  1 +
>>>    include/linux/i2c-mux.h | 26 ++++++++++++++++++++++++++
>>>    2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
>>> index 681a201c239b..edf16683dc83 100644
>>> --- a/drivers/i2c/i2c-mux.c
>>> +++ b/drivers/i2c/i2c-mux.c
>>> @@ -247,6 +247,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>>>    	muxc->select = select;
>>>    	muxc->deselect = deselect;
>>>    	muxc->max_adapters = max_adapters;
>>> +	muxc->idle_state = MUX_IDLE_AS_IS;
>>
>> This is insufficient. AS_IS is simply not an adequate default.
>>
>> For i2c-mux-gpmux, there is currently no way to dig out what
>> the idle state is, as it is not exposed by the mux subsystem. For
>> i2c-mux-gpio, the idle state depends on both the idle-state /and/
>> the i2c-mux-idle-disconnect props. For i2c-mux-pca954x the idle
>> state can be adjusted at runtime. Etc.
>>
>> In short, idle state handling is a bit diverse, and I think this
>> adds to that mess.
>>
>> I think it will be a bit of work to come up with a scheme for the
>> I2C mux core to accurately keep track of what the idle state is.
>> One way to deal with that is to introduce a new "unknown" value
>> that can be the default for all drivers that has not yet figured
>> out how to feed the correct idle state to the core.
>>
>> And that hints at why I think reusing the mux.h bindings #include
>> is bad. The mux subsystem simply has no need for an unknown state,
>> and adding that to mux.h is therefore out of place.
> 
> I see.
> 
> I think I will introduce a few defines in i2c-mux.c then;
> 
> 
> #define I2C_MUX_IDLE_UNKNOWN	(-1)
> #define I2C_MUX_IDLE_AS_IS      (-2)
> #define I2C_MUX_IDLE_DISCONNECT (-3)

Hi!

Please keep AS_IS as -1 and DISCONNECT as -2. Using different
values will make it difficult to get rid of the use of the
defines belonging to the mux subsystem in case the actual
value has crept into some .dtb or something like that.

Also, I think the right thing to do is to put these defines
in the i2c-mux.h header so that the drivers can find them.
I assume .c was a typo?

> [...]
> 
> struct i2c_mux_core {
> 
>      [...]
> 
> 	/*
> 	 * The mux state to use when not active.

This is not 100% accurate. The value stored here is never
actually used to set the idle state. The idle_state here is
only what the driver has declared that the idle_state is.
Perhaps word it like this instead?

	* The mux state used by the driver when idle.

Agreed, subtle difference, but...

In the future, drivers (most of them) could be changed to
use this variable to store the actual idle state. But, as
mentioned, that's not easy for i2c-mux-gpmux since the idle
state is under the control of the the mux subsystem in that
case.

Cheers,
Peter

> 	 * Possible idle states are:
> 	 *  - I2C_MUX_IDLE_UNKNOWN: Unknown idle state
> 	 *  - I2C_MUX_IDLE_AS_IS: Leave channels as is when idle
> 	 *  - I2C_MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
> 	 *  - <n>: Enable channel n (starting from 0) when idle"
> 	 *
> 	 * Default value is set to I2C_MUX_IDLE_UNKNOWN.
> 	 */
> 	int idle_state;
> 
>      [...]
> };
