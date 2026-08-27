Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E593252917
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816763; cv=none; b=fHRffv9fEk33B+lFHcpKhZnn9oHtHVXWLxbnC8eHFws2v7RqDlk9djHI9ElP3rvkGMmvSgQTtGKAdDpHaWUNe1AqbqzLOn3WZnGkXAeCvReI87AsrG7I8nEyEgxPh6D6x6QYDK1FB23q8UbPjI4SM6NAohbqvaGyC9QBM8ufmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816763; c=relaxed/simple;
	bh=Pjvhgu2/AEvgKnflUCPPraKj9JOKej2+U3fUV/BsjuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnz5D33UMxnLQe025v92By5j/GkKTcZRLqL6NZh25VQ+f4m5OXtL548g5QA/XeR8++h+3Fn8uly+kPQCdFPVrOtsEY1TS0s921T7php0vpNlZUgzDoDiIR6fvNSXlDcRYyF5Y87OuEEpTviv1fB23raNUil8MKZ0EuInkvveQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuoXgVEZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuoXgVEZ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so534557a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787816760; x=1788421560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbRs574snZvpW2X/HQOkQ+OUsJHTgB/OYJACP1nJVIU=;
        b=AuoXgVEZ/M55/kMohZOzkYGfpVdnkPFazAbo8t81J18OKUbh8/Nen8HKdeG2eiXGAw
         4o9Y/XgnP5453MfFoJPiooJAz0vNfFaj1ckf/T16RJX7AHsSscDGPC0L88X2NyOkSM4L
         uo65/QBTzYXeAktzxbOAeZ5PsljFikrDhK3yHfo5h07c17snqEUAwNnXmHhj/32tTrRf
         qQx/s/We5Fmn7WLUrAlYxnDSfz4XmWy9VI5ELG1NMpbp6cds+xwyxhSp+ZFZuI9fx2jR
         p6/TMqnh1Hjy4Db0/dPYnwknAIszOoZXJ9F1qjsk1BgmyjOztmt8eiLGPqd7iyZUmcEF
         GHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787816760; x=1788421560;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbRs574snZvpW2X/HQOkQ+OUsJHTgB/OYJACP1nJVIU=;
        b=Wx7CrJJuy+agYVSFiD8wRjuZxQVj7+QkvmTP6VCM+Y4tdon/ca/DUZpVdg2A6m0KCe
         LH5gn0zAsyWhcM/7yCHGDi5j7CSjqqZzArCG422zGthHI+Io+Q/XcdMWb9YoRsvpQnRw
         2rq1KVIOuNV2ety8+b/TmWcypKPga58iJPoXZL3lBxc2K4XsVxIdGkTihtx3GtO7BBjx
         92HC18d/8IjOJAsTgRcxK5DyXsTrCIYP4TQ0roIn6U4GPq1qcY3LcfCBKejMWPYyI85v
         uaxuxzsF2S3OhMHYEe9SKyl54KMZEfCFUc0UG7w7tKcHUTA2KGtGCyFBQRzrzFGbgnEj
         1Mdg==
X-Forwarded-Encrypted: i=1; AHgh+Rqb9n3kzsjDv3x3H9EZ/lS8iyTaFRH/k3ucVWgHd947BPs6FkmFFRfZ933ZwOmOOqN8dd0cpdrp5mo=@vger.kernel.org
X-Gm-Message-State: AFuF++kSDZiBMvrcIR3KMPCi5NOq03sZsR+O3YSh8GoAmRyfmZCvCEgT
	1L2u/5K8seZ2tp+Xq+/0NtO6XgfY5NeMTFLzalDKU39S4AiqF3N/iwQ2
X-Gm-Gg: AR+sD136oR3OH5oXIk4wJsQOtHP5eLO/9b2Hia7pVRRpx63/PDtu/znzpOl6UtTtFCk
	lUKYk8hyOB9g11BOn9O78A6GFDtywcIu5vDzM0VpiU3X/wft+nmaUDGLbhfjSDnRXs5Ij2nLOno
	wPYVrtdHnHihN7vEyX8QfUs21+v8rnAfu8koLrRBaasq7swcaZSrpD36NKxjSyx2ICnoJ2ZeTQt
	+EvsmkqpJRi0bDQuD9gDJKs2y6PFkhZyH6PRBzMJQf8DNRwdzZ2BpJrDH/+yz2r5QyjJMfd0WFL
	RARjPnmWfDd1twaG1Qqgg+Lc/WRkCifgaUvhHxapaA37l7HsutqHfbKiLGjgC+ZPPrjcv+2hDCa
	vSPjoATv2mZ6iIbp9W1Qr3I3ylkxSJ6vmFj9EPq0uOeinO+TiPvCLKBXxA3y5zc/5lY0NFptJ9U
	An7RbKQ9BiYGbVa3MyhtuPvER6ve09vwJ8N0T3pgqTEb5mFII5dpEOMZIHHbKgwg==
X-Received: by 2002:a05:6a00:8d0:b0:84e:2722:5d9e with SMTP id d2e1a72fcca58-85371cb27e1mr24732639b3a.1.1787816760362;
        Thu, 27 Aug 2026 00:46:00 -0700 (PDT)
Received: from [198.18.0.1] ([23.26.139.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cd7c162sm1680320b3a.33.2026.08.27.00.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:45:59 -0700 (PDT)
Message-ID: <11e2734c-2856-4fc2-8209-7410571dbbbf@gmail.com>
Date: Thu, 27 Aug 2026 15:46:00 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: acpi: Add DELL0A86 to
 i2c_acpi_force_100khz_device_ids
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: andi.shyti@kernel.org, westeri@kernel.org, linux-i2c@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
 <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
 <20260824102221.GE893316@black.igk.intel.com>
 <ao_Xu-43lnM6I7Pn@ashevche-desk.local>
Content-Language: en-US
From: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
In-Reply-To: <ao_Xu-43lnM6I7Pn@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

Sure. The relevant DSDT excerpt is below.

    Scope (_SB.PC00.I2C1)
    {
        ...

        Device (TPD0)
        {
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PC00.I2C1",
                    0x00, ResourceConsumer, _Y55, Exclusive,
                    )
            })

            CreateWordField (SBFB, \_SB.PC00.I2C1.TPD0._Y55._ADR, BADR)
            CreateDWordField (SBFB, \_SB.PC00.I2C1.TPD0._Y55._SPE, SPED)

            Method (_INI, 0, NotSerialized)
            {
                ...

                HID2 = TPDH
                BADR = TPDB
                If ((TPDS == Zero))
                {
                    SPED = 0x000186A0
                }

                If ((TPDS == One))
                {
                    SPED = 0x00061A80
                }

                If ((TPDS == 0x02))
                {
                    SPED = 0x000F4240
                }
            }

            Name (ITPN, "DELL0A86")
            Method (_HID, 0, NotSerialized)
            {
                Return (ITPN)
            }

            ...

            Method (_CRS, 0, NotSerialized)
            {
                ...

                If ((TPDM == Zero))
                {
                    Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFG))
                }

                Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFI))
            }
        }
    }

The speed values are 100 kHz, 400 kHz and 1 MHz respectively. On this
machine Linux receives 400 kHz from ACPI, which is also confirmed by the
kernel log when the quirk is applied:

    DSDT uses known not-working I2C bus speed 400000, forcing it to 100000

And for now my PC touchpad has continued to work normally since applying the quirk, and the issue has still not recurred. :)

Thanks,
YuXin

在 2026/8/27 14:22, Andy Shevchenko 写道:
> On Mon, Aug 24, 2026 at 12:22:21PM +0200, Mika Westerberg wrote:
>> +Andy
>>
>> On Sun, Aug 23, 2026 at 08:33:10PM +0800, xiaoyueyoqwq wrote:
>>> The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
>>> 13 5310 intermittently exhibits excessive smoothing when the I2C bus
>>> runs at 400 kHz. During an affected period pointer movement becomes
>>> severely sluggish and sticky for tens of seconds.
> Just for the confirmation (no need to include in the commit message) can
> you share the DSDT excerpt of the device in question?
>
> (acpidump -o tables.dat; acpixtract tables.dat; iasl -d dsdt.dat; # open dsdt.dsl)
>
>>> The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
>>> to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
>>> is already done for other touchpads exhibiting the same excessive
>>> smoothing problem.
>>>
>>> With the quirk applied, the kernel reports that the firmware requested
>>> 400 kHz and that the bus is forced to 100 kHz. The problem did not recur
>>> during extended heavy use, including an S4 hibernate/resume cycle.
> ...
>
>>> +	{ "DELL0A86", 0 },
>>>  	{ "DLL0945", 0 },
>>>  	{ "ELAN0678", 0 },
>>>  	{ "ELAN06FA", 0 },
> At some point this should be switched to C99 initialisers and dropped unused
> driver_data.
>
