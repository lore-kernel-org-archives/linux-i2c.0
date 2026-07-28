Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE83CB560
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231538; cv=none; b=lKdnE08HsNXUkRYaZu8JzuJnJv5WWYUJFvA8Apn1FAyQmX1nKe2yFhrJ3sIZu+u6T5bwW7sqyO+ynQ1r/8+HPWauqH9xClgU6DdwE/moW2ZprrB7HvUfhkItpaPFur/MmjTne0D6d2WREBtgXEfKoX24nsxzDhMxmm4/is0WQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231538; c=relaxed/simple;
	bh=uPCdmEuWap9j2y1lJw9pLUjltclzcbecB0peU1Gga/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ2qVXH2UIzY0NguUwuGmIdHMiF35rS7SzsXDoERJZ/vYk8kOhNi9N4jEHwE7MJSIx9K0pP7UMZZ4cuy7Zia4KdyfH2c3nY4ZKfiD3z4Pwj6d1jT4+GlpNv1jnD7H3duTTzH9ivezhWn1p+G0al/dxaBR/hrH7xZP4Gh3h1msMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWCfPdDo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWCfPdDo"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb906d6c6so105884e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785231535; x=1785836335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j3pHS4xBRTPH8EUGK6yrshCHccgqxfsAQjaiHzdqNCE=;
        b=UWCfPdDoDwmW7HI0XBVt6Q2XaqkXALqD389WuXhB0daQYG8/y2H9Q1MPqNr0iOwp54
         8nkftsuymjdrnvoDvCPQbsrq3jvj4LBs0XDOQDrlNNtV6ch0NHH7TdHlb4DaP1zY5y4J
         Zo/NzQXJPB+of+zuVM1b3DPP/u69WG8/gA6H2C8tZaeYqHADTTTI0zLa+WQWbjRGg0e7
         RvUdmGm5vhQm9KKqxbz/JlqgHrlYd9ruzo2VmvJhbAeZKCeg5kAUJWQLrJd0ZRMMKeiA
         ZG0r8GWVXNy0pC8XOM1MESojB5H3Af1pPCuQPrP4lMrz21qfXC9gJWiNjOC+nt27DiRp
         rzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231535; x=1785836335;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3pHS4xBRTPH8EUGK6yrshCHccgqxfsAQjaiHzdqNCE=;
        b=ALZt0nDVCPA5P9Ksk/3qwvFal8BRpNlJ01emREv9/JF2LeSePTjiqFsOFWyuU2cUUm
         fdPjv30thqL0Z6MscjvyDGrhSeBEaIHT9y+MqdT66CLtb1mVkbkkfdm4S+uQvAZqNBan
         20rkeqSViG8lv0dHu8JsCz04ucIMW2pTjCmYlkQ6p9zgR+jOtW3YHQ/COHrSP0EVLwJR
         XFyrDfRz0yaNsqORBwYFS1fNV61fFt/I7zXmM2hPqDGapg+x3dtLnL87ISZ0Fnof/Uzy
         IAmt1Rt5ypfjvIwDojCCemDJvLDjY/Xp/ui/16GsgMO1Jp/NjfGYUl2qQAn5iJdDPipz
         PRzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyeSKdtkAKisEuUOGPkNTRYEGQcyLiTkCbYvu+SQQZQ5vc9NWYH+4L7fBndOcpwGHCo5MTE4Hh0LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5smwxbxG0IFqyMW2jHlUCKUtD9hKdoGzYCNoBaWMZzslpR1N
	J1Kva5sE7G4OQtZcCe0s0CVaHMaDoCycHspQfRIh5P3AJLzeuXQw4apL+9EW13O/r40=
X-Gm-Gg: AR+sD11v54NWpJ0h8OkZY9PrMyiioSIloS0KyaVZ30tttV4rHJbSEYWCftHSx6Q9gpc
	sLsdqJfHJcFDQYxzLZJywI6kw3GGN1G4FFf2EoUZL2q77SffA9r1c7hyd/+kTt968LH21rAYAdV
	SPjsWo8Dx8B94S0UFBjYdstvj3aQPtU8+//uvkdL5+1vaRy1fzN7h2r0anxoq8h0NOUFMkeS8lD
	pcZCCgXIZ0TON8NBf1CHApoqXKUUgUOet7gV2Cx7Ym89D92DQHohvyB51p6xOqWSyiJEmd+Nmkf
	D9Hbq24GJ5VPhsL8C0m5YqXxlUhFzz6bZj5loYYS+BuNRhbM6NqgnDPD3wv/otkNVjkvBGoNLMP
	/POsC91fjb/UsB7Xl0LEnOXOVGIEoWRoNSEsAtMOvLCBqdBpjzofvjR2vYXfu1gUpMz6t9bJFNi
	66E80y7D0119CNGJBxgRcU54b+n2/uog0COwO+EOLlBgW3VcvP/YDiOuC2
X-Received: by 2002:a05:6512:10c5:b0:5b0:312:21ca with SMTP id 2adb3069b0e04-5b2d0244892mr417168e87.2.1785231534518;
        Tue, 28 Jul 2026 02:38:54 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be1f53d1sm1891092e87.66.2026.07.28.02.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 02:38:53 -0700 (PDT)
Message-ID: <2b4b3fe3-9062-437b-8b4f-65a0b121d8ce@linaro.org>
Date: Tue, 28 Jul 2026 12:38:53 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-1-c3958f28b045@oss.qualcomm.com>
 <c7b0213d-a4c9-4ac8-be09-b449da457230@linaro.org>
 <CAFEp6-2VP1pVbKJEkPTOFdMn8kv=83CrP-MCYPDTN0BHURn2Jg@mail.gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <CAFEp6-2VP1pVbKJEkPTOFdMn8kv=83CrP-MCYPDTN0BHURn2Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic,

On 7/28/26 11:20, Loic Poulain wrote:
> Hi Vladimir,
> 
> On Mon, Jul 27, 2026 at 9:21 PM Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org> wrote:
>>
>> Hi Loic,
>>
>> On 7/27/26 12:21, Loic Poulain wrote:
>>> The msm8953 CCI timing table is internally inconsistent. Its Standard
>>
>> likely I was misunderstood in my v1 review comments, and I believe v3
>> will be needed...
>>
>> If there is just one master, or two masters set in equal speed mode,
>> then there is no such issue as "msm8953 CCI timing table is internally
>> inconsistent". In other words generally it shall be permitted to have
>> supply clock frequency intermixed speed modes for any CCI variant.
> 
> The two masters sharing the supply clock are independently
> configurable in terms of mode, so we simply can't guarantee they will
> run in same mode.

There should be no restriction or guarantee to configure the same mode
for two masters. The supply clock frequency is one for both masters,
but speed mode selection is based on its presense in the driver by
the CCI frequency.

If there is no match in the driver for CCI clock frequency/speed mode,
return -EOPNOTSUPP for such master.

Think of it, right now for each CCI hardware revision 3 'struct hw_params'
are provided by the driver, some of them match 19.2MHz frequency, some of
them match 37.5MHz frequency or intermixed for msm8953 case. Likely there
is no restriction to provide 6 'struct hw_params' for each CCI hardware
revision covering both 19.2MHz and 37.5MHz supply clock frequencies, then
any combination of speed modes can be configured on any CCI hardware for
two masters.

The main point is that CCI clock frequency is not specific to CCI hardware,
but it is specific to 'struct hw_params' mode.

>> I'll repeat the same point as given in v1, namely supply clock frequency
>> is not a property of CCI revision (therefore v1 1/3 or v2 2/3 is invalid),
>> it is a property of the mode settings. It's correct to remove 'cci_clk_rate'
>> from 'struct cci_data', and it will be correct to add (or parameterize in
>> any other way) 'cci_clk_rate' to 'struct hw_params'. Each instance of
>> 'struct hw_params' is strictly bound to a particular CCI clock frequency.
>>
>>> and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
>>> clock, but its Fast+ timings are essentially the v2 values, which are
>>> calibrated for 37.5 MHz. Since all masters share a single CCI clock,
> 
> So, you're right that the supply clock frequency is a property of the
> mode/timing settings (though I'm not entirely sure timings are fully
> hardware rev agnostic). I don't dispute that.
> However, this reflects the current driver behavior. It's not
> incorrect, it is a simplified approach that uses a single frequency
> point across all operating modes of a given platform.

The driver should be fixed/improved. Reverting the link between CCI
clock frequency and CCI hardware revision is invalid, it should not
be done.

> I added a brief paragraph in the V2 cover letter to explain why it's
> out of scope.
> 
> My argument is about scope. Today the driver has no mechanism to pick
> a rate per mode, a single CCI clock is shared by N masters (usually
> two) that can run in different modes simultaneously, so per-mode
> scaling requires (1) per-mode rate info in the params table, and (2)
> vote/arbitration logic to select the highest required rate and still
> apply correct timings for every master at that rate. Concretely, with
> one master in Standard and another in Fast+, you'd need a 37.5 MHz
> shared clock and a Standard-mode row calibrated for 37.5 MHz, which

This is a limitation of the driver only. For a selected CCI revision
please add 'struct hw_params' for Standard mode / 37.5MHz supply clock
frequency, and the problem is solved.

> the msm8953 table simply does not provide today. So this isn't a small
> tweak, it's a new capability backed by new table data. It would bring
> more fine tuned supply rate, but without huge benefit, as cci clock is
> gated most of the time due to runtime-pm.
> 
>> But what if you have only one master?..
> 
> It's not important here? we have N master (usually two) and have to
> deal with that.

It is important in sense that any one master usecases are properly
supported.

>> I think the msm8953 data is correct, it shall not be removed.
> 
> The msm8953 table as it stands is internally inconsistent (without
> per-mode rate info), no single clock makes all three modes correct.

It is so, because there is msm8953 data is incomplete. But the present
msm8953 data is correct.

> Moreover, msm8953 is the same HW version as msm8996/sdm630, which
> already use cci_v2_data, there's no strong reason for msm8953 to keep
> a bespoke, half-and-half table.
> 

Okay, I read it as 'struct hw_params' data for msm8953 can be removed
and v2 data should be used for this CCI hardvare variant.

>>> no single rate can satisfy all three modes with the current table, and
>>> the DT assigns 19.2 MHz, so Fast+ timings are wrong.

If hypotetically 'struct hw_params' Fast+ timing for 19.2MHz supply
clock is added to the driver, this usecase will supported by the driver.
As for today the driver has a bug, no doubt.

> This series intentionally does the minimal correct thing, aligning the
> timings with a single supply clock and enforcing that clock in the
> driver, which owns hw_params and has all the info to produce correct
> timing. It fixes reported devices misbehaving when no (or incorrect)
> assigned-clock-rate is set.

Since we're discussing it, this fix is not the only one possible,
and the fix which returns the link between CCI hardware revision and
CCI supply clock frequency is an invalid fix.

> Not saying what you propose is not do-able, and I clearly understand
> what you mean, but I'd prefer to land this simple
> alignment/enforcement first and treat per-mode clock scaling as a
> follow-up, rather than coupling a straightforward fix to a larger
> refactor. Please clearly Nack if you do not agree with this first
> step.
  
Instead of a non-productive NAK I can provide a simple change adding
a proper link between speed mode and registers programming.

-- 
Best wishes,
Vladimir
