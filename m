Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067512BB1D;
	Sat, 23 May 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779559042; cv=none; b=bc3Are96wbWX4uToBFYvxIke3zpmu7eSC4LgTNc9+EGhrnKeh7NAV1ayGYRvWnVNvsHS3gtyxvbP6eD/mVPcBa4VBSTHa0oSS+XgbtbSxSQQa8+7tuWM5OcCX2XuiHK7uWWXJByrac0pO79igHZpSj56E3vWSHwmnC4+GU6aXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779559042; c=relaxed/simple;
	bh=dG8m2Fc0j6LzN9SMfsdDp1y1HNxo/JPVWQkXUNkG5Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjnMjkZJU7LcsS6wANbx8c+xmyLP1P0yjiilJgWS/ryM3+I1can3ozUuGX86Q9IHpCQojbQpkrM7JU/ctn4VUxT+I2pnkDNHtJqhC4rfm234HTxR5Uz1mfi8R7+iEoKJodEQrQ13YY82n9vIDgy8GE1/2a76hqt19liKZnWaPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtU/sp75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtU/sp75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE811F000E9;
	Sat, 23 May 2026 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779559040;
	bh=G/RetKAJRSwpWdu1PDP+KMyGok8pM1UY/4YpGi6zfmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtU/sp75ffhhDIzl9v0McwLqsOf6oNmOyLfs/pi7yL+Fv19bosCzAGfcGX7VVV7Zz
	 hIBbQYsunmbS7gKEjTFOT3ULTBU/EaHT0DNtPRdukH4h+52dq2eb0QDWLTtBrJno+L
	 av4i8h66h4qPOGlb48H5RMnA5hkzhVzhurv8t7NbA0bxWata3twnBhS0VinEL/6Nyh
	 ILKjME8w/hkSWmTqN3BaTzQZA1OJkwZXN/Nv47y53eMoyt1yA8pk0Vg1xLmsbiq9U8
	 900q3ciXfP99GXsVPbVO98jgQos3Y7DikhZiVh9Rv83yKBuf2ghXJA1+VoAHxDBgYS
	 wMQi3jvMydFaw==
Message-ID: <5e467847-34b3-4d29-a09a-18f6fa8641a5@kernel.org>
Date: Sat, 23 May 2026 12:57:18 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/1] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>,
 linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com,
 mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
 linus.walleij@linaro.org
References: <20260523174440.9629-1-hardikprakash.official@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260523174440.9629-1-hardikprakash.official@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/23/26 12:44 PM, Hardik Prakash wrote:
> Patch 1/2 (pinctrl-amd GPIO IRQ fix) is already in Linus Walleij's
> tree. 

Is patch 1 still needed with this approach?

> This replaces patch 2 with a generic solution suggested by
> Mario Limonciello.
> 
> The root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd
> completes. Dynamic debug tracing confirmed the race:
> 
>    0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>    0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>    0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>    2.348157  lost arbitration
> 
> Previous attempts to fix this via initcall promotion (subsys_initcall,
> fs_initcall, arch_initcall) all failed because the race is not about
> when the driver registers but about when probe completes. The GPIO chip
> becomes visible to the system via gpiochip_add_data() before
> amd_gpio_probe() finishes, and i2c-designware probes AMDI0010:02 in
> that window.
> 
> This patch adds a generic check that walks ACPI child devices, finds
> any GpioInt resources, and defers probe if the referenced GPIO
> controllers are not yet fully bound. No DMI matching required.
> 
> v6:
>   - Replace DMI-specific deferral with generic GpioInt dependency check
>     walking ACPI child devices (suggested by Mario Limonciello)
> 
> v5:
>   - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
>   - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)
> 
> v4:
>   - Rebase onto Linus Walleij's tree (patch 1 already there)
>   - Use --base so series is correctly 1/1 (Andy Shevchenko)
>   - Add subsys_initcall test results (Mario Limonciello)
> 
> v3:
>   - Fix variable declaration style in dw_i2c_needs_amd_gpio_dep (Andy Shevchenko)
>   - Add BugLink tag (Andy Shevchenko)
>   - CC AMD engineers (Andy Shevchenko)
> 
> v2:
>   - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev()
>   - Use device_is_bound() under device_lock() with explanatory comments
>   - Add Assisted-by tags per coding-assistants.rst
> 
> Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> Related: https://bugzilla.kernel.org/show_bug.cgi?id=221454
> 
> Hardik Prakash (1):
>    i2c: designware: defer probe if child GpioInt controllers are not
>      bound
> 
>   drivers/i2c/busses/i2c-designware-platdrv.c | 157 ++++++++++++++++++++
>   1 file changed, 157 insertions(+)
> 
> base-commit: 3812a9e84265a5cdd90d29fe8d97a023e91fb945
> 

