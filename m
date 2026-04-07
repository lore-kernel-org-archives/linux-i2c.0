Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223213A543C
	for <linux-i2c@vger.kernel.org>; Tue,  7 Apr 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559303; cv=none; b=sQ+8IBupcp5upnV28oL8ydGJZDe2lWtHN++zEtg1q0knoE7+TIqew6vba67saYRckcI0d6YUi+Y1rVlQOOdbv2leN4gWk1d4YwlIT9tlbtkU+a+U8tkaS0RaESoPIZWccPG8tw9CYcBfVhyhqAYBp6CGlwhyhuBVcrLjjZ9KNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559303; c=relaxed/simple;
	bh=E+QtEi8lfGe5OpFuzEbSz9wMM7zUAV8NQjdo6NrgAKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiJHujyBS5L7i1bCOOSQXLIxPWN4S+XMMi81Frx94eZklB6dcv7u8GNWF2NtMuvv+OgKzw1YhU26ih53IcDdG2/YXA5cEW0EhZnLTuzgInqZjIQ/ZLlWVtMudsbj6XL+3czm6SY3gWUkjfvao/G68+1CkjRI0TQb1nOqADUMDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1TNtDVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1TNtDVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA8CC2BCB1
	for <linux-i2c@vger.kernel.org>; Tue,  7 Apr 2026 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775559302;
	bh=E+QtEi8lfGe5OpFuzEbSz9wMM7zUAV8NQjdo6NrgAKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E1TNtDVzDnfUM2T0PI3UxEZxDESgYIFxvUKIr8spC35wcdtOZq2f2SZLmHdbH4Nzx
	 PEyYLRNEI8AfIJ+DhX8itZz6XVa1NPl2OjpdyJSSciwxFIXthn2TAReFojaGQlyFqc
	 qfNnRbF4HrB07v4yHRi5QyEYS5KA+jE3mt5vRMm2TADUSPbL92yMQXOlyOPSlIycmQ
	 Z+3H65P3/F/N+Zp8rS7IUuSVlI3oAlUg+hjQ2H168QAXEf/qrlTmoMU+qzW+2LsgsW
	 /EAQGzvzOVk+7znjuUtInLQyM6KiPhkSXR5f5NSPH1ky4Tlci31Kflhrg1GDpSM0MW
	 MXWUWz4Ifafiw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38c620f1699so52395401fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Apr 2026 03:55:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYPf3Qs2HOwTkREXCbBFDfBt+MMKfL2HvM4gst4IlXVzl2kLFZ
	uOaT7CVCwmSQg0yH2LXVzMvlnF6eKwSQO3SoY/wIc7GJVCaD9Z+eFUo5IR1jNy0JSYkJE3QHyWR
	7TMHM9C+b+YN5J9uVg3I4uWU6UHobi5xCGmOKVvyc+A==
X-Received: by 2002:a05:6512:3d10:b0:5a1:3f3f:a29b with SMTP id
 2adb3069b0e04-5a33754ed37mr5306605e87.6.1775559301312; Tue, 07 Apr 2026
 03:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404021920.359902-1-nissampa@cisco.com>
In-Reply-To: <20260404021920.359902-1-nissampa@cisco.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 7 Apr 2026 12:54:49 +0200
X-Gmail-Original-Message-ID: <CAMRc=MeViuN_osCsOXZraXJJU82HW01MhdwRT=sHdkYN2BrTRQ@mail.gmail.com>
X-Gm-Features: AQROBzC-ThEZAtaWZibgBAYFqjqD80YMmDHStSwuBokAAsstJt3o3LpC6glzt1s
Message-ID: <CAMRc=MeViuN_osCsOXZraXJJU82HW01MhdwRT=sHdkYN2BrTRQ@mail.gmail.com>
Subject: Re: [PATCH] at24: add SMBus fallback for adapters lacking I2C_FUNC_I2C
To: Nishanth Sampath Kumar <nissampa@cisco.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 4:19=E2=80=AFAM Nishanth Sampath Kumar
<nissampa@cisco.com> wrote:
>
> AMD PIIX4 SMBus adapters, present on AMD SP5/EPYC-based platforms
> (including Cisco 8000 series routers), support SMBUS_BYTE_DATA and
> SMBUS_WORD_DATA but lack I2C_FUNC_I2C and I2C_FUNC_SMBUS_I2C_BLOCK.
> This causes two distinct failures:
>
> 1. AT24_FLAG_ADDR16 EEPROMs (e.g. 24c64 syseeprom):
>    regmap_get_i2c_bus() returns -ENOTSUPP (-524) for reg_bits=3D16
>    because neither I2C_FUNC_I2C nor I2C_FUNC_SMBUS_I2C_BLOCK is set.
>    The driver probe fails entirely with:
>      at24 3-0055: probe with driver at24 failed with error -524
>
> 2. 8-bit addressed EEPROMs (e.g. 24c02 fan EEPROMs) behind a pca9548
>    mux on a PIIX4 child adapter: regmap selects regmap_i2c_smbus_i2c_bloc=
k
>    which fails at runtime even though SMBUS_BYTE_DATA is available.
>

Cc'ing Mark and Wolfram (regmap and i2c maintainers respectively) as
I'd like to get more eyes on this.

To me this looks like something that should be fixed at the regmap
level, not in an individual driver. This changeset defeats the entire
purpose of the previous regmap conversion - abstracting away the
implementation details of talking to the EEPROM over I2C.

Is there anything that would stop us from extending i2c regmap to
support buses without I2C_FUNC_I2C or I2C_FUNC_SMBUS_I2C_BLOCK?

Bart
