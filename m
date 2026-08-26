Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B3361DA7;
	Wed, 26 Aug 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753352; cv=none; b=PYEOwPUAL9qvF3sU6OpLXHSC8a7+SjYUE2NZXpJM9XbPfwnq9cqmyRDj2YfJpEyAb206rUizmVgUvweJoPgQtaMGpF3JrOD5LZ06J5L4uMYDi0+B+P8W0joVzTPSTKRI1ObS7DMQQbBD9+EZD179bAHhmINYzBKSMvD6PLkDgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753352; c=relaxed/simple;
	bh=qd/k45PDOeaWIMY7RY7wAaBtaQcu3Q+5gYHbfIRt0AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKOAcpcsi5A3E744uwoIu9c+t8ZEjwZlmSLcGUZEw3q3rkL7x/anjWyp40epHfVLVa5iczyvwntW3hMhS1n5VeI0SgnDM1ryZ0VmIb7Xvf94PlbVCdXGgIX+db+JrlwiRXjkgX9FFTjnrqHEJM5dSRfEOo9G2F6DolJZP6BxWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCejeG0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCejeG0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBD81F000E9;
	Wed, 26 Aug 2026 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787753349;
	bh=TNBvO+ky0/3VWJnTsxbu78ogNLbMq/8VlOuUXVeNmoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCejeG0vCtFknqu4WX0iSTUrFlrVK2jfDvpCHnR9lMB4LXEg1eq6ylerAkO8BiKDs
	 C9bgbPHtQq166hmFzaEwE+ziBevHgmdnvYK96Y5uBC6gGIQsnpYXSq1hDUSsNcRabY
	 BNXtRy01rbxODxp07uDiOVBVpLS3MZUQmvh/RbxXZvfn0QKoOwNyRHz9t5Q1CLR8m/
	 W6mtgsRkCvCYgYWDIQWMlRTV7j7AObZg9qox5M5uuenaK/ezA1Kjufquki4p6cd/aX
	 8m8GnZ60d14RrDpxPA/A13+mB1dZPkjhn8USGisHyJkoC3ZT+db7ojyREIDYhJNkkv
	 sQ09IFTmcllMA==
Date: Wed, 26 Aug 2026 16:09:05 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: YuXin Xiao <xiaoyueyoqwq@gmail.com>
Cc: westeri@kernel.org, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] i2c: acpi: Add DELL0A86 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <ao7yggBh5-MiEIDm@zenone.zhora.eu>
References: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
 <20260824181559.146133-1-xiaoyueyoqwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824181559.146133-1-xiaoyueyoqwq@gmail.com>

Hi YuXin,

Please, next time don't send successive versions as in reply-to.

On Tue, Aug 25, 2026 at 02:15:59AM +0800, YuXin Xiao wrote:
> The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
> 13 5310 intermittently exhibits excessive smoothing when the I2C bus
> runs at 400 kHz. During an affected period pointer movement becomes
> severely sluggish and sticky for tens of seconds.
> 
> The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
> to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
> is already done for other touchpads exhibiting the same excessive
> smoothing problem.
> 
> With the quirk applied, the kernel reports that the firmware requested
> 400 kHz and that the bus is forced to 100 kHz. The problem did not recur
> during extended heavy use, including an S4 hibernate/resume cycle.
> 
> An independent 2021 report from another Dell Inspiron 13 5310 user
> describes the same intermittent sticky behavior and identifies the same
> DELL0A86 / 04F3:3185 touchpad.
> 
> Link: https://www.reddit.com/r/linuxquestions/comments/nsso5b/help_needed_with_sticky_touchpad_spoiling_brand/
> 
> Assisted-by: Codex:ChatGPT-5.6-Sol
> Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)
> 

Please don't leave a blank line in between tags.

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: YuXin Xiao <xiaoyueyoqwq@gmail.com>
> ---
> Changes in v4:
> - Add an independent public report for the same model, device, and symptom.
> - No code changes.

Please, don't omit the rest of the changelog. I want to see v2,
v3 and v4.

Anyway, I merged your patch in i2c/i2c.

Thanks,
Andi

>  drivers/i2c/i2c-core-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 8f3bdd5..3af0e05 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	 * the device works without issues on Windows at what is expected to be
>  	 * a 400KHz frequency. The root cause of the issue is not known.
>  	 */
> +	{ "DELL0A86", 0 },
>  	{ "DLL0945", 0 },
>  	{ "ELAN0678", 0 },
>  	{ "ELAN06FA", 0 },
> -- 
> 2.53.0
> 
