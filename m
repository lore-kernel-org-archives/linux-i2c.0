Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4445C6F7;
	Tue,  6 Oct 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294256; cv=none; b=J0b5Zg5eMX+b5w1hrjjdpGSESQ7wToVHx3+ZrhZD7CnDd0J2OxRw60wQ6uI8qX0g1nZvvT0sKmhGodXNLkk8KXfYyDFFwK0HfvBveSncPkL/Bujh2U02r7gb/gjQHVJ6jpvXQvfS1uv7/LeEn7i/iceNW/4Z2V5VBfv6fFfqwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294256; c=relaxed/simple;
	bh=Zt0bdOBPA8dmWgU5ONDLL8zAtEPO24VrWMtL0RB7Wls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVwMHad7i9wlVx54dW051lQ6oMZYajFalcGb4QVfH4li16S52XLbvDV9P6MkSGRNZWQIDDdQRYiz0UGpJju3Hds/ITSp5p2JsLwtmvxD/U0S+1V0IQYvHODQxyBs3rj6vfezAXl+xtfxlm8EfZ+FxQnTahwJ6vQ0Dlkuf5WZjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDpj8AgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDpj8AgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFCB1F000FF;
	Tue,  6 Oct 2026 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791294254;
	bh=vdrdHKe5zrnvY3ZqJBJ6V4F335WxUSRWLrLw5yayRaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WDpj8AgRB2zANACesdtZzXafOdX8uIhPkGdWe5JU/72r740QlFrfPKU9i52v1sFok
	 q4RX8NodFrKBDvZ/PhRJGQSiXXJYVFFuVb2F9Ti0uS6jhoP9MZsecUuWVEy3Fc9jif
	 C7ZmwIpSbtVz8S93cPdm7AiVJa0UaO3RKspFnPfqxZY7GWx6MyG5g2tAzTUn4vOOpj
	 1UknckZAwoA84iWs4GNXvoXZkxEMCu7ibYWk6GUFwMOB6lrijlthPAGx1iX8JpvThU
	 bB/CdjWSGbdjhKy4IJGKhfAtvanahy6j35VkcL7w5VX5ZMpntVPMos14wgS7n8HEHE
	 +FoB6evTDjI6Q==
Date: Tue, 6 Oct 2026 15:44:11 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: prinn.dev@pm.me
Cc: Mika Westerberg <westeri@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force ASUE140D touchpads to 100 kHz
Message-ID: <asT6nqQMz13beDyW@zenone.zhora.eu>
References: <20261004-i2c-acpi-asue140d-100khz-v1-1-cc2dbad00470@pm.me>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-i2c-acpi-asue140d-100khz-v1-1-cc2dbad00470@pm.me>

Hi Harinn,

next time, please...

On Sun, Oct 04, 2026 at 05:59:53PM +0700, Harinn via B4 Relay wrote:
> From: Harinn <prinn.dev@pm.me>
> 
> The ASUE140D touchpad on the ASUS Zenbook UX3404VC (BIOS UX3404VC.303)
> starts lagging shortly after boot when the bus runs at the 400 kHz the
> DSDT asks for, and only recovers after rebinding i2c-hid. Forcing
> 100 kHz fixes it.
> 
> Signed-off-by: Harinn <prinn.dev@pm.me>

... try to use your full name and ...

> ---
>  drivers/i2c/i2c-core-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 8f3bdd50186e..e5b27375af31 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	 * the device works without issues on Windows at what is expected to be
>  	 * a 400KHz frequency. The root cause of the issue is not known.
>  	 */
> +	{ "ASUE140D", 0 },

... develop your patches on top of the -next branch or i2c/i2c.
Your patch has a little conflict I had to fix.

I pushed your patch in i2c/i2c.

Thanks,
Andi

>  	{ "DLL0945", 0 },
>  	{ "ELAN0678", 0 },
>  	{ "ELAN06FA", 0 },
