Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61F3DCD8D
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274053; cv=none; b=KREOvqRr4vN8cKe8e+tZPRdK2r/PnFcd2g11nGqVI8K+Nfx1HflwjlLXd0lTzh5fhO5UE5zI/JRrRQcVpbh/368sRfCh+14iyM9e1gtwxRqXcR7rZkh+ri4QgWRmqLcOHUwzZ6T7Q061i483DH7XzuaR6b9IprsZnErVPJrgJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274053; c=relaxed/simple;
	bh=m0/sC2lpO7s7kazM/Kgba267MijE4BUKMXJY+PfAtRE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQUgpdpe8v0BlENI0jlr6dP5Ir+BYoedEF/RLKHx/80GKvB+dzKxTvO3iernd0O59m3R0t4DYpTKZyO+Mfuw5N87QaU9s7owdF8qtCY7beL5uH1FifjGuqKgmI/Ykr3bNNgsAUbjbfdrSMzXNG54mYWcm4gC9twPrZD4HZ/afJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB5ayV/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB5ayV/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2171F000E9
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784274048;
	bh=OF/GIgG8fd5MLypU751MI0BaYGz3S/78pJ8DfriQZUQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=eB5ayV/2HJwIapbSUqAY75bIddLWRgi1d3rsCSoWI6oDB2Gy0LDiiUhX3VXVBHdkg
	 9EFW1jkymRmMQficxHl1bkO5Pq/SIDRUSPgpb+xBS0qrKlrIKM91z6v8JcoVR86NTU
	 LS9Tt0c1MpJqA2rn4ASQ1g3jKkm6UQBHs8vlJTfyZkgkPG9fB2cxSYeqOSXEd5kNgZ
	 4/opNxM6ciHm2tq/8c5fAtannMxRyqyU4Ve5FJh8+uSt+cUl36MnXtQJ4cjdxCBAEg
	 2rfG96g4wigkprQxXyA7yoguS8pzNjYamrc9Fn0Zt/66mQOsYNGTvr+GOJP/SmuBOn
	 6h3nKwrhjr78w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeae771c49so8664854e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 00:40:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpjntS5o3YHvOc5zksLViiD3KgfpehLz1YyWwpNZbFiGMXgQkQBFwKhB7MgMtcT9i443zMe54YTzgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJS+8Wawks8SU6D2AlXjy+WqLWNShOmrRY7r0oKh9iTfxGjwvw
	+e/SIY/kB8USx0MzfuB1CSRG718rQtD7HZdpnEHoehH0rKHhTBulM4UsHm4hpYzp/0ykwupOgSS
	vKcSuO8WKKE9ow6xv0851yTkVVZqI6MGWyZgGd8wxtw==
X-Received: by 2002:a05:6512:134c:b0:5ae:b9fb:1582 with SMTP id
 2adb3069b0e04-5b28f9a58c1mr290750e87.40.1784274046572; Fri, 17 Jul 2026
 00:40:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:40:44 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:40:44 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <alkn8HBmu_aDjKHK@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716113055.41319-1-hardikprakash.official@gmail.com>
 <CAMRc=MdN4AYdS8mz9JbVc8fCz7MOik+Dsthb-BviVtX3h987rQ@mail.gmail.com> <alkn8HBmu_aDjKHK@ashevche-desk.local>
Date: Fri, 17 Jul 2026 02:40:44 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeMi7MjeX7uunV-=7XqKSimUd+obmiz2DmUHzrkGnK9iA@mail.gmail.com>
X-Gm-Features: AUfX_mz4kaPBjaCp-Q4-hplPXgATNakbKl0srkjAAPrMHQl0-Hr7xhqfK7EiIKM
Message-ID: <CAMRc=MeMi7MjeX7uunV-=7XqKSimUd+obmiz2DmUHzrkGnK9iA@mail.gmail.com>
Subject: Re: [PATCH v12] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>, linux-gpio@vger.kernel.org, 
	wsa@kernel.org, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com, linux-i2c@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 20:50:24 +0200, Andy Shevchenko
<andriy.shevchenko@intel.com> said:
> On Thu, Jul 16, 2026 at 07:10:47AM -0700, Bartosz Golaszewski wrote:
>> On Thu, 16 Jul 2026 13:30:55 +0200, Hardik Prakash
>> <hardikprakash.official@gmail.com> said:
>> > I2C controllers may have child devices with GpioInt resources that
>> > depend on GPIO controllers being fully initialized. If the I2C
>> > controller probes and enumerates children before the referenced GPIO
>> > controller has completed probe, GPIO interrupts may not be properly
>> > configured, leading to device failures.
>> >
>> > On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
>> > AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
>> > pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
>> > AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
>> > fail with lost arbitration errors:
>> >
>> >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>> >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>> >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>> >   2.348157  lost arbitration
>> >
>> > Add a dependency check that walks ACPI child devices and defers probe
>> > until any referenced GPIO controller is bound.
>> >
>> > Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
>> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> > Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
>> > Assisted-by: Claude:claude-sonnet-5
>> > Assisted-by: DeepSeek:deepseek-v4-pro
>> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
>> > ---
>>
>> Looks good to me.
>>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
> But this is wrong. It's a patch over v11 (basically it's a diff v11..v12).
>

Hanging my head in shame as I admit I've barely glanced over the diff that
looked much smaller now. Will pay more attention next time.

Bart
