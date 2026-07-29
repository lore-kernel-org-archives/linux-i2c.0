Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914929AB1A
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325259; cv=none; b=qWEpMwYuL0ENWHOxJsRQbZeSHl1hEVYUZMpASlJcdQphhEiGtsCV0dG9HbTFU7mtZ0+sYfwQ4BBH6qeg9f5qaE+mKpqBmf3U9LtM64HWQvjpl3uXtDsXEbpszC9ggE9qk5WrOOtEQ0WfZFZadxjxRz89JwTLLmIsTaqw/HGk1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325259; c=relaxed/simple;
	bh=1ILedmnxZpakpCdjZKCC3sWp+t+p8i89yHNriC7BFl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW5gQfbB28aLgH1Tk7lrkmliM/HA3+W97AsMOfheudWNDBopOenx+5/ALQff4Iip3KR3BexPl2OQmlqcJqF3ZLwF64aHQ1AhAm+aLlrLqB1ifzZpC2MIui8o1zElJx2Y7oP9WHSmqfotKxoZoPw93QsazBtYYk51D7IMEB4FgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiB6aiCO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiB6aiCO"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb7ccb9f0so92327e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785325253; x=1785930053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HHS8LyYwcNUW10LvssA0fR3Rb5EpddNaHSJU6gUDkyY=;
        b=OiB6aiCOWqk247wURHqeP7duMWp3uA6KTVk4KsjrYyszafs9aGCgYnCwJbj34vKZFR
         6IQ9r76+zOk9ZMYpxJpJcH1rR98nEs7ojrEY9WYQgtX+yWi9Z/7hbpzfEi8QW9/c5Ird
         V4mtyy2mu6scOneyWuF6R4uBWNTnSA7B2nc8mJ82BSNeizj53UI0Eb4nLi1NQJDMsSK8
         HHpf5US8+AR5sKanX0VZiuopVy0r/OrlLsq1EeTOgG25C8HHihV7OPSRej/fVoOWAVMP
         9rxZEOSYV9VTpxKWXKvGO4dAIjktnLz/22qGs/cT/9+V0XXcG0zaJ7+ZPiNkCiUC7ddQ
         5e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325253; x=1785930053;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHS8LyYwcNUW10LvssA0fR3Rb5EpddNaHSJU6gUDkyY=;
        b=DCMYOZ/Gc8YDX0x/dTGpJUzVnhx8qrcNMgmxhpr5XdCro+5EW8H38sM3OiWy/W7zQt
         gZ5o4GK6RP672T8fHdx2MYuoPg6B+e8yZFcUVbFl7WFzTNBUnGuW1guoiJ6QNFOkS2A5
         eBwZ+aScLkSNAAsc/+4sEOSH3XKsxH3JkC9mBVFvulQET6I9e8pS+pyizIknrJjsyDZY
         IJwnaRCCgZW4iA7JHvI8T2dlXkYxUNvFluCyFD0ZDz6dcEouCDktiGO/ha1qIvawWEuq
         YtZIuLP3TxKRfhmyrUngxQOqCAFL6S45oAORX57R5HuUXsiKrXkuc5lsbEoGdZtPk8ZH
         neLg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7kdHeVWV4HR3bpKLyXjlr+j8WqtvA/DmltWyZTHbWahGCWv9kAA8fghHKQueLUTGsNK26IgZ3jzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Ct71T3CpyKcCwfwcjzTb3+7eTWW712SB4vUzSiQInqpQloMU
	J4TryoUTGIQPEoU41t5cA9JcvlnFuIvcaPDU19+JttcnLk4184dRjUoN2MUXCNGrxGk=
X-Gm-Gg: AR+sD13J5r2q0kjarv1DGCha27+oNNYUdmeG/+k3yNNr2AToaynBU/hejTajIP1kfCW
	trTH8giKuroStwhqXO2SNI8WS4n6jNYSHjSqKmCjZ3IvXKY8QaB+kR/6q/s0lxykJ55L81EOw5W
	ohbV6rcXSivob/Qm8zZrFL7lOPFPIH8iZo4xqiutoryOwMKJ7mNVF9opisNnBT6yN/S5mqxu/93
	pFtmbSFrO7Jvva/3T6uaXH49cUy5lFw5rJ+PtrC5Dfmu4l3yXxhW4A23pOBvDKCVbOn5jHDCdwB
	IGMUjzvlkU+TjNehOitoOzEE77A/lv/YPZAw5qv80lNBFgmpS91wn5V2jtQPfRvKVzVBePvv4u0
	l9Liics8GpkpI1WHmHMAQi96dkQwY8toBjdGGWlrs1Y4ZIB04rz1WC5u3aVWAqkroqGRpYGklFe
	ys05934vq9ItYKazkTqOMfURhgH8O9hkiZ/DJVLiJnaumQIEuzIBzjaQdq4Y7WI9CqHvEDjfnGM
	Il3lPTbkxAmabPjg4h7T8GnqrwT9zZM4qp/WmnRknE=
X-Received: by 2002:a05:6512:3d15:b0:5ae:bf3b:cb0 with SMTP id 2adb3069b0e04-5b2d02456eamr1174096e87.3.1785325252353;
        Wed, 29 Jul 2026 04:40:52 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f5d69dca2sm3969401fa.35.2026.07.29.04.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:40:51 -0700 (PDT)
Message-ID: <661db3cf-ddac-4252-8aa7-b7ba8c39c0ab@linaro.org>
Date: Wed, 29 Jul 2026 14:40:51 +0300
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
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-1-c3958f28b045@oss.qualcomm.com>
 <c7b0213d-a4c9-4ac8-be09-b449da457230@linaro.org>
 <CAFEp6-2VP1pVbKJEkPTOFdMn8kv=83CrP-MCYPDTN0BHURn2Jg@mail.gmail.com>
 <2b4b3fe3-9062-437b-8b4f-65a0b121d8ce@linaro.org>
 <CAFEp6-1zXcsXqez6dba_BT4YXnJU_YT8k7OQ+Cp-gnWL0n27Qg@mail.gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <CAFEp6-1zXcsXqez6dba_BT4YXnJU_YT8k7OQ+Cp-gnWL0n27Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic,

cc: Stephan, Konrad as participants of this old discussion:

* https://lore.kernel.org/linux-arm-msm/aL6Vp-3er71AJPJd@linaro.org/

On 7/28/26 13:26, Loic Poulain wrote:
> On Tue, Jul 28, 2026 at 11:38 AM Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org> wrote:
>>
>> Hi Loic,
>>
>> On 7/28/26 11:20, Loic Poulain wrote:
>>> Hi Vladimir,
>>>
>>> On Mon, Jul 27, 2026 at 9:21 PM Vladimir Zapolskiy
>>> <vladimir.zapolskiy@linaro.org> wrote:
>>>>
>>>> Hi Loic,
>>>>
>>>> On 7/27/26 12:21, Loic Poulain wrote:
>>>>> The msm8953 CCI timing table is internally inconsistent. Its Standard
>>>>
>>>> likely I was misunderstood in my v1 review comments, and I believe v3
>>>> will be needed...
>>>>
>>>> If there is just one master, or two masters set in equal speed mode,
>>>> then there is no such issue as "msm8953 CCI timing table is internally
>>>> inconsistent". In other words generally it shall be permitted to have
>>>> supply clock frequency intermixed speed modes for any CCI variant.
>>>
>>> The two masters sharing the supply clock are independently
>>> configurable in terms of mode, so we simply can't guarantee they will
>>> run in same mode.
>>
>> There should be no restriction or guarantee to configure the same mode
>> for two masters. The supply clock frequency is one for both masters,
>> but speed mode selection is based on its presense in the driver by
>> the CCI frequency.
>>
>> If there is no match in the driver for CCI clock frequency/speed mode,
>> return -EOPNOTSUPP for such master.
>>
>> Think of it, right now for each CCI hardware revision 3 'struct hw_params'
>> are provided by the driver, some of them match 19.2MHz frequency, some of
>> them match 37.5MHz frequency or intermixed for msm8953 case. Likely there
>> is no restriction to provide 6 'struct hw_params' for each CCI hardware
>> revision covering both 19.2MHz and 37.5MHz supply clock frequencies, then
>> any combination of speed modes can be configured on any CCI hardware for
>> two masters.
>>
>> The main point is that CCI clock frequency is not specific to CCI hardware,
>> but it is specific to 'struct hw_params' mode.
>>
>>>> I'll repeat the same point as given in v1, namely supply clock frequency
>>>> is not a property of CCI revision (therefore v1 1/3 or v2 2/3 is invalid),
>>>> it is a property of the mode settings. It's correct to remove 'cci_clk_rate'
>>>> from 'struct cci_data', and it will be correct to add (or parameterize in
>>>> any other way) 'cci_clk_rate' to 'struct hw_params'. Each instance of
>>>> 'struct hw_params' is strictly bound to a particular CCI clock frequency.
>>>>
>>>>> and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
>>>>> clock, but its Fast+ timings are essentially the v2 values, which are
>>>>> calibrated for 37.5 MHz. Since all masters share a single CCI clock,
>>>
>>> So, you're right that the supply clock frequency is a property of the
>>> mode/timing settings (though I'm not entirely sure timings are fully
>>> hardware rev agnostic). I don't dispute that.
>>> However, this reflects the current driver behavior. It's not
>>> incorrect, it is a simplified approach that uses a single frequency
>>> point across all operating modes of a given platform.
>>
>> The driver should be fixed/improved. Reverting the link between CCI
>> clock frequency and CCI hardware revision is invalid, it should not
>> be done.
>>
>>> I added a brief paragraph in the V2 cover letter to explain why it's
>>> out of scope.
>>>
>>> My argument is about scope. Today the driver has no mechanism to pick
>>> a rate per mode, a single CCI clock is shared by N masters (usually
>>> two) that can run in different modes simultaneously, so per-mode
>>> scaling requires (1) per-mode rate info in the params table, and (2)
>>> vote/arbitration logic to select the highest required rate and still
>>> apply correct timings for every master at that rate. Concretely, with
>>> one master in Standard and another in Fast+, you'd need a 37.5 MHz
>>> shared clock and a Standard-mode row calibrated for 37.5 MHz, which
>>
>> This is a limitation of the driver only. For a selected CCI revision
>> please add 'struct hw_params' for Standard mode / 37.5MHz supply clock
>> frequency, and the problem is solved.
>>
>>> the msm8953 table simply does not provide today. So this isn't a small
>>> tweak, it's a new capability backed by new table data. It would bring
>>> more fine tuned supply rate, but without huge benefit, as cci clock is
>>> gated most of the time due to runtime-pm.
>>>
>>>> But what if you have only one master?..
>>>
>>> It's not important here? we have N master (usually two) and have to
>>> deal with that.
>>
>> It is important in sense that any one master usecases are properly
>> supported.
>>
>>>> I think the msm8953 data is correct, it shall not be removed.
>>>
>>> The msm8953 table as it stands is internally inconsistent (without
>>> per-mode rate info), no single clock makes all three modes correct.
>>
>> It is so, because there is msm8953 data is incomplete. But the present
>> msm8953 data is correct.
>>
>>> Moreover, msm8953 is the same HW version as msm8996/sdm630, which
>>> already use cci_v2_data, there's no strong reason for msm8953 to keep
>>> a bespoke, half-and-half table.
>>>
>>
>> Okay, I read it as 'struct hw_params' data for msm8953 can be removed
>> and v2 data should be used for this CCI hardvare variant.
>>
>>>>> no single rate can satisfy all three modes with the current table, and
>>>>> the DT assigns 19.2 MHz, so Fast+ timings are wrong.
>>
>> If hypotetically 'struct hw_params' Fast+ timing for 19.2MHz supply
>> clock is added to the driver, this usecase will supported by the driver.
>> As for today the driver has a bug, no doubt.
>>
>>> This series intentionally does the minimal correct thing, aligning the
>>> timings with a single supply clock and enforcing that clock in the
>>> driver, which owns hw_params and has all the info to produce correct
>>> timing. It fixes reported devices misbehaving when no (or incorrect)
>>> assigned-clock-rate is set.
>>
>> Since we're discussing it, this fix is not the only one possible,
>> and the fix which returns the link between CCI hardware revision and
>> CCI supply clock frequency is an invalid fix.
>>
>>> Not saying what you propose is not do-able, and I clearly understand
>>> what you mean, but I'd prefer to land this simple
>>> alignment/enforcement first and treat per-mode clock scaling as a
>>> follow-up, rather than coupling a straightforward fix to a larger
>>> refactor. Please clearly Nack if you do not agree with this first
>>> step.
>>
>> Instead of a non-productive NAK I can provide a simple change adding
>> a proper link between speed mode and registers programming.
> 
> So I guess what you'd like is something along these lines:
> https://github.com/loicpoulain/linux/commit/fdacebb22d914ca64b0c3d4e257a913dc0cd16dd
> 

I shared another and personally more preferred variant yesterday:
* https://github.com/vzapolskiy/linux-lpc32xx/commit/e3dee612da90

The main differences:
* all CCI programming data is consolidated and removed from driver
   data specific to CCI revisions,
* as an immediate positive side effect 19.2MHz supply clock frequency
   is supported for v2 revision of CCI.

> My intention was simply to move this 'disruptive' change out of the
> series scope, as I don't believe this series itself is incorrect.
> 
> However, if you'd really rather have everything addressed in a single
> series, I'd be inclined to either pick/rework the series in that
> direction.
> 

If you find it possible to incorporate the change above, it would
be very much appreciated.

The next question to solve is to fix CCI mode programming for all
platforms with CCI v2 revision, which are obviously broken right
now, and partially are fixed by the change proposed by me above.

These platform .dtsi files contain CCI clock rate assignment:
* agatti.dtsi
* msm8916.dtsi
* msm8939.dtsi
* msm8953.dtsi
* msm8996.dtsi
* sdm630.dtsi
* sdm845.dtsi
* sm6350.dtsi

These platform .dtsi files do not contain CCI clock rate assignments:
* kodiak.dtsi
* lemans.dtsi
* milos.dtsi
* monaco.dtsi
* sc8280xp.dtsi
* sdm670.dtsi
* sm8250.dtsi
* sm8450.dtsi
* sm8550.dtsi
* sm8650.dtsi
* talos.dtsi

One proposed "fix" (note that formally it is not a fix, but it compliments
a today's flaw in the driver) is to add CCI clock rate assigments like this,
it seems Stephan and me support such an approach, its benefit is that it
does not require any driver changes:
* https://lore.kernel.org/linux-arm-msm/20260729112719.1151700-1-vladimir.zapolskiy@linaro.org

Another and likely more preferred approach suggested by Konrad is to
use OPP tables. If this one is selected, then, as Konrad said, it would
be needed to resurrect/rebase his series, it would be important to update
the dt binding documentation etc. Please note, that a forcible setting
of CCI clock rate over OPP mechanism can also be done independently on
top of my non-intrusive "read-only" change.

-- 
Best wishes,
Vladimir
