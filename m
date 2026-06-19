Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4B10F0;
	Fri, 19 Jun 2026 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827729; cv=none; b=mBAg+Sf40WWZNga9snHIiyn3bTXmTeZWgPtGLiYxd3Y1yuBPYn9xu8mHHCJVx4idTf72dZtClgTmp8IMzpIRF+u2QYr9ET7gCTDiMZT9uZlAJ/GoYPGa967fBH/OZNpHXp88ZpEohyxOjj0YipZU0BREbyq/q03zA2eyi6J3MZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827729; c=relaxed/simple;
	bh=dI998SF+I4QRfqKw1iSDEAXPwaFAd5s2gQe8ONaQk/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8yhwnOYD/7mBFQ1y5MgCfd6JDZM0CY5F7CKMn+NsbaLJu9wgNzVcFU8azGCVHqDDQe/JtUGbmk4SHULw6zkH3TCpkEUei9WloPKF9UlODBv1ThPN7ax0hFAaApvhQfaYSobb/Qht5FKSJ1m80tdPs6Xt1cekRCclMYK3l6vlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyoqhv5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyoqhv5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4F21F000E9;
	Fri, 19 Jun 2026 00:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781827728;
	bh=FBTOWtRpm5mdCXnJQ+yGzLNYeUt9QGflnFgYSAchR8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyoqhv5LYRLDh+iokdpfKHoMWlkjpRlbCzj446bWFOQI+TnCbUOWyXiw3EPHllxpB
	 P2SiZDen+eYb+9EbumEDhY4ISpwKirh2gUF4o+nk2jmVEDnzdcvjj+es7RId7hQ5gf
	 /g6xGkArF5ESYrJoR3/Dbrr08wBditxnkYgHWffZeiaeEMehy9F5IG47XZHdepZ+Zt
	 GEKJqk5grntsg9Ed7q0dCZT/u4VJZR8T142f7sDUoI7R73W7WYY3+hjmzfAuzUYwJv
	 iMtBcA7eFmshns52QyV0fqmWl7wcduHl4YcqT0W4gdrSn9DA4MX13C4bHKKS4VjVbG
	 dMoOcShGMj6Tg==
Date: Fri, 19 Jun 2026 02:08:43 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abhijeeth Babu <babu.jeeth@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force ELAN1300 touchpads to 100 kHz
Message-ID: <ajSIc9fcALRaYhRq@zenone.zhora.eu>
References: <20260617192611.125513-1-babu.jeeth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617192611.125513-1-babu.jeeth@gmail.com>

Hi Abhijeeth,

On Thu, Jun 18, 2026 at 12:56:11AM +0530, Abhijeeth Babu wrote:
> The ELAN1300 touchpad with HID ID 04F3:3104 on the ASUS VivoBook
> X513UA_KM513UA exhibits severe pointer jumps and erratic movement when
> the I2C bus operates at 400 kHz.
> 
> The system DSDT describes the touchpad using an I2cSerialBusV2 resource
> with a speed of 0x00061A80, corresponding to 400 kHz, on the
> AMDI0010:03 controller.
> 
> At this speed, libinput repeatedly reports:
> 
> kernel bug: Touch jump detected and discarded
> 
> Add ELAN1300 to i2c_acpi_force_100khz_device_ids so that it operates at
> 100 kHz.
> 
> Before the change, nine touch-jump events were recorded, with additional
> messages suppressed by libinput's rate limiter. With the bus forced to
> 100 kHz, no touch-jump events have been observed and the touchpad operates
> normally.
> 
> The affected system uses BIOS X513UA.319 dated 2023-05-09.
> 
> Signed-off-by: Abhijeeth Babu <babu.jeeth@gmail.com>

merged to i2c/i2c-for-7.3.

Thanks,
Andi
