Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C54B5CD4;
	Wed,  9 Sep 2026 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953315; cv=none; b=N9zV186rTVZaFw/gpKZn6BS3tZV+AelB6LYqenp574u95nr9/fFgeLmfYZt98+CySaHw6tCcycZICdgst3Hp8qL4soyN6ohLezfJn2lZXB9gwbrzVZH8Ph7qBP2+H99mKxhxOldy3ALPxHcABJHs+7UlgcWkJafiVyXsYcRLzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953315; c=relaxed/simple;
	bh=YB87it622ts0toxfTmNSOhFVdA1wmPUd38htUOzhqS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tuizTS2MkwiiOG9pL0SI+ZfoBg49YtEEzMwgbvv/olbZwwWJPji+rVqCOu/buIpNElp7sePkTwXvzSIn0k1RbY9o/XsvlWIUS5qK1Y3gJyA9lK0NwjPWgrwzM0ZUNisVwWxJJZvgdh4UTeNrIuYAFtMyzsCrqzwb31botW4k6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu/Q0a2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu/Q0a2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BAD1F00A3E;
	Wed,  9 Sep 2026 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953314;
	bh=dLkrsZhSPD5byjJojvFEbgMv/u3HdJBRsDXxbO13uuU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=hu/Q0a2c/94vSoN3eubujXsH+Ha9fKuOy0oCLxT1ZRPz45hC1zUSlyb3lBjUyisB2
	 5yBsVvwi4FxZ3N7fZmVYpc/iTz4QzpJOx812TEuKmOeEXHvAjA5CCQVD/f1cM51jna
	 bwKSFIKIKqWO7lYiiKW1dxAiTrZQMZUjKdPEmSqA7cY5yV4nwak41CQDN880KhycsG
	 elpBloiUKHpA0ZI0DpfP5nMbjRZAgod79uxff+W/PKsuGn7zlmZq1aDDIVpoMVYYth
	 f9XXTMOgDoKywv1Fi8Ny45JTDeaSqNlZftT1pAZKUrrIP5jQbQHrBmlOLs76DDdCBX
	 rmxcfD5ccPT1g==
Message-ID: <6530a61b-5a41-4375-9bcb-a50558d7c75d@kernel.org>
Date: Wed, 9 Sep 2026 12:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Acer Swift SFG14-01 Camera Support not working on Linux
To: AHMAD YASEEN <ahmadrandhawa01@gmail.com>, loic.poulain@oss.qualcomm.com,
 rfoss@kernel.org, vladimir.zapolskiy@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-media@vger.kernel.org
References: <CAFJ6yro2PRQAsNwDMRmU8sve6nrXXWVruStgyYVRMcYeksdufQ@mail.gmail.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <CAFJ6yro2PRQAsNwDMRmU8sve6nrXXWVruStgyYVRMcYeksdufQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2026 08:41, AHMAD YASEEN wrote:
> We can provide the kernel boot logs, kernel configuration, baseline
> and live device trees, minimal CCI1 patch, and Windows hardware IDs
> and driver-profile details. Serial number/SNID information can be
> provided privately to Acer.
> 
> Our immediate objective is to bring up the correct CCI controller and
> obtain a repeatable RGB sensor chip-ID before proceeding to capture
> and libcamera integration.

The RGB sensor and _should_ be on the same CCI and CSIPHY as the other 
x1e platforms.

Windows actually discloses alot of the information you need.

cd /mnt/windows; find . -name "*sensor*.bin" -print

For me on the Dell Inspiron that show ov02e10.bin and hm1092.bin for the 
RGB and Greyscale sensors respectively.

So you don't necessarily need Acer to provide information though, it'd 
be nice.

You should add a dump of your DSDT here:

https://github.com/aarch64-laptops/build/tree/master/misc

Same one ?

https://github.com/aarch64-laptops/build/tree/master/misc/acer-sfa14-11

...

You have a USB camera no ?

DSDT Device(WCAM)

https://github.com/aarch64-laptops/build/blob/57a8b779e1ad1f08fb5c05b74c6d2d5975706a92/misc/acer-sfa14-11/dsdt.dsl#L50015

Device (WCAM)
                     {
                         Name (_ADR, One)  // _ADR: Address
                         Name (_PLD, Package (0x01)  // _PLD: Physical 
Location of Device
                         {
                             ToPLD (
                                 PLD_Revision           = 0x2,
                                 PLD_IgnoreColor        = 0x1,
                                 PLD_Red                = 0x0,
                                 PLD_Green              = 0x0,
                                 PLD_Blue               = 0x0,
                                 PLD_Width              = 0x0,
                                 PLD_Height             = 0x0,
                                 PLD_UserVisible        = 0x1,
                                 PLD_Dock               = 0x0,
                                 PLD_Lid                = 0x1,
                                 PLD_Panel              = "FRONT",
                                 PLD_VerticalPosition   = "UPPER",
                                 PLD_HorizontalPosition = "CENTER",
                                 PLD_Shape              = "UNKNOWN",
                                 PLD_GroupOrientation   = 0x0,
                                 PLD_GroupToken         = 0x0,
                                 PLD_GroupPosition      = 0x0,
                                 PLD_Bay                = 0x0,
                                 PLD_Ejectable          = 0x0,
                                 PLD_EjectRequired      = 0x0,
                                 PLD_CabinetNumber      = 0x0,
                                 PLD_CardCageNumber     = 0x0,
                                 PLD_Reference          = 0x0,
                                 PLD_Rotation           = 0x0,
                                 PLD_Order              = 0x0,
                                 PLD_VerticalOffset     = 0xFFFF,
                                 PLD_HorizontalOffset   = 0xFFFF)

                         })
                     }

Switch on host controller for usb_2 and the USB should should power it. 
At a guess its probably a UVC video device.

---
bod
