Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72E313295
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618426; cv=none; b=KO9ctr6oLibOUiNKFkBSDU6VHAkPGXH2wbvaHjHxE+eFVqlhFmgQ/sHxXWxM3Bf6iubSOSt2ULrbuUxyYQoZ9KugfYDIj+na+spWOmN1k3VpizIwZ76rFJD7BWl6uHR3hIniwuksdS53LJRNg+XAmFsiB1znN6HFxN1su0hmmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618426; c=relaxed/simple;
	bh=iYk18bX7cRzr0uBEytpgIQTDx3Sgm8mS05n6bJfcUrs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CEzVonQfoNU4acYW1sjEfAjdPLE6CWSqUDRtv6XJJQpf4edGaZKvETTcx9RHr+RbirZGs6w2oOhEWeK7rBvelMkGDoVz67PEIaOiMe4XNK952RoNxdQoYfqePbLLl2gk4KHvCKZ0sXeDbsJgeAkwbSBdgeXgmxhl8xsI+v6cnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=lHKFJgAD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="lHKFJgAD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so3171644a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769618424; x=1770223224; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYk18bX7cRzr0uBEytpgIQTDx3Sgm8mS05n6bJfcUrs=;
        b=lHKFJgADm9tyGKkB2Bboes1J/ZIyyziOl+/Lg36VOjmwAUzt+C0LACvG0wZz8qgl/U
         PM6AE6QLSN19WbZs6KnS8EHe3Yp6CjzC6AmLID02NOzm/S0P90TPEhQGuRREDqYqJ9HA
         nicms5CzV4meOzjfigTODNJ24XOWeO0VCAPyMbMs7HAzJ6IvKWqVk/9FB30nsolvm7VR
         Q4w+ompDxprtU4fkQmHl/7eiU8Mr9tvLprZx4a7WiGWfJvsw/FHB58jFJhHSJRmMIkSY
         PPclUwurZ+N49eK1DWSF164HQy6mZPuGTW6H7m5lsQZ4KG8tqrp1EdJaSdhY7zwz/Xpp
         nbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769618424; x=1770223224;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYk18bX7cRzr0uBEytpgIQTDx3Sgm8mS05n6bJfcUrs=;
        b=gXpb724b8WvYP7C7J0QwDs2T+K4DVkHkQDenLrDb68iXnkPipAsfIqqA38gZHN0+ru
         vUuDeZgCjItCn1i+U8o5h5jPoHMezokH/cbSsymuaYHc7BSmOs+O4ti5PO8LSgYEInRJ
         c3RWRTkocRjhc+7HWVAWkcfvns5b2nzIOOlcvlgDBgHf+kRCFl+cvCGyltiPGsxjU54h
         J2SsxhQGbV1LqiQMKnqiE6XEpl20zBN5vpMnJFyOrMuOsBa4UMgdK+ERQJOAYdzqt3Mq
         8yjgRLn1ZbyQkbWx+HwMePcPYXLO0WR79F89LR0BfZUP9jEY4lD7DEflQqYcjJqSPZOo
         RLOw==
X-Forwarded-Encrypted: i=1; AJvYcCU8acOFyU9ABoYghkQw9jq5L3onTNwhQFGp1hR7AZqKJL9NiF8jTYbXxKAMjJmbYVyOb09czjmoiQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7OhqOqwBD4poYCoY/pTApn6KmVsCG9N/ZGbdtxfccvwfaknR
	g6bpVyaWuh3N7taXY1b96AkZRaNFMEb87y9cCoCsY8p9n3/JcPAmnwU+6+17p4nRvDs=
X-Gm-Gg: AZuq6aJrhGcuhKO802wmwe0zP9Gxi3EUL3F/LyUjN+ES/WYCkquv2d8iFUceq1HwBUZ
	Q7u6VnUlJMerUtNtDhxyAji1U8vJeM/savFgN87Yu3SsdUTgdr2/ExqBFlAhDRLQTZHKbmhuwk+
	5wIrWOaL0afFxkulcYDP2K/KvuVA/GnF9fx3zFdnjSkEy/ek/fSWtq44OzQerEyQZ9btQm4kikC
	npMAa9wTcSbJkVThtUthaGHZ3BHoHBeYRcSVus3dJVep86zQ+JRc3M7l/ae73Q4mFqRzI1qzEkA
	q4j7gzi96n3CsFH/kIHTaNAsEqqZxjrvTbZPm9bkzQzDTlSXjdQ5ZyCZh2RB2W31ksB4QqBJQhP
	6oz4k4t43mwVc4zDKiyruLTTJSf/zPqwtz9E/kSKyNVHtR0hvuUFVKos4NlsIfov3gELporscvD
	0+Hcno+FKcMQeLm+c9b4zRm8xjcLU6cM8MLNfew9wmGg41rQ==
X-Received: by 2002:a17:90b:3c11:b0:352:c995:808a with SMTP id 98e67ed59e1d1-353fecda875mr5481744a91.14.1769618423968;
        Wed, 28 Jan 2026 08:40:23 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8700:e32a:245f:3d9c:239d:6b19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm5993765a91.12.2026.01.28.08.40.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:40:23 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <aXoul5n9sA1UmqoS@smile.fi.intel.com>
Date: Wed, 28 Jan 2026 08:40:11 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 info@mocean-labs.com,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2D1B484-CBF0-4763-908C-DF293332D2B1@nexthop.ai>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
 <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
 <5dc423be-c1f4-4a59-abcc-807f63b25f3f@amd.com>
 <aXoul5n9sA1UmqoS@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 28, 2026, at 7:43=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>=20
> On Wed, Jan 28, 2026 at 04:00:30PM +0100, Michal Simek wrote:
>> On 1/28/26 15:45, Andy Shevchenko wrote:
>>> On Wed, Jan 28, 2026 at 03:34:02PM +0100, Andrew Lunn wrote:
>>>> On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
>>>>> On 1/28/26 11:37, Krzysztof Kozlowski wrote:
>>>>>> On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain =
wrote:
>>>>>>> The xiic driver is designed to operate without explicit clock =
configuration
>>>>>>=20
>>>>>> And if you change this in the driver, then you change bindings?
>>>>>>=20
>>>>>> You miss here explanation based on hardware - how does the =
hardware work
>>>>>> if nothing ticks it clocks?
>>>>>=20
>>>>> Hardware obviously have clock input which needs to be connected. =
Without it
>>>>> it won't work.
>>>>=20
>>>> Should ACPI potential limitations be making the DT description less
>>>> accurate?
>>>>=20
>>>> Would it not be better that the driver has an DT binding and an =
ACPI
>>>> binding? Where there are common properties, common functions can be
>>>> used to retrieve them. However, if ACPI lacks usable clocks, use =
the
>>>> of_ method to get the clock from DT, and skip it for ACPI.
>>>=20
>>> Why should we use of_ methods? If this is required we can check the =
type of
>>> fwnode and act accordingly, but I think this should go deeper into =
some
>>> treewide available helpers, because now some drivers repeat the =
mantra.
>>>=20
>>> But how do the driver get the clock frequency (if needed for some =
register
>>> settings and/or calculations)? DT seems to have well established =
property
>>> 'clock-frequency' for that. Can we consider it as "ACPI binding" as =
well?
>>=20
>> "clock-frequency" property in i2c is used for selecting i2c speed =
100/400kHz.
>>=20
>> Clock frequency in this driver is about describing clock coming to IP =
itself.
>> Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
>=20
> Ah, I see, then is_of_node() probably is the compromise how to deal =
with
> this setup.
>=20

Thanks for all the feedback!

So, if everyone agrees, I can make the changes to:

- Remove the DT bindings change.
- Make the driver fetch the clock only on OF by checking is_of_node().

Does this sound acceptable?

Best regards,
Abdurrahman


