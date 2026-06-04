Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7E36A373;
	Thu,  4 Jun 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616858; cv=none; b=pGDTOi0UxZVgBh+T99ljYWjyXbcIYqSK0I+c8+uK5x8PHulzjOZ6nPHs4v8jfvw+JtCDzf6+FYryQVGwqJB8w38pGgL3aUqPmxb9anu6pbIdht1YxDR0x9rUECYjvAo3EHgoubNTSRkqfHSCSj5luJg8IkZ1scxnMlrlHZXBGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616858; c=relaxed/simple;
	bh=bxtu/4qq5NoqN2OGBuN2mNIqsutMWDYlDnt5yWdXBmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efBIAq4w2Su2etDungET9qr095eLfL/itk0AeoRehgpvtGBgbWYw4p7k0HRyLtgVbAcsCc+7Xs7QdAoRyjZcnwslR8rTJbJXQ3nFaOyW8PIbKYCsVtthYWlY3RVHhxhmjv5vVP+D5sHGTeb8PVEOnuDDxZRwTVwHr/0UDuAUlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVQj+Y24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVQj+Y24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3EF1F00893;
	Thu,  4 Jun 2026 23:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616856;
	bh=KzkDBb8+rkdfwAKeCAO1OgvomNPSrkOd4DyVcUDQEmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVQj+Y24L5UkRIXKdd2vCZJHPSWEmiubsmtcOqLFMcLI79PBhHpjJaZwK4Vrhal6T
	 u3NxlIWRRERjuNgiav3ZyC+xpXefSbQJNgWbiFHIsyBzuqVkdvClHwmLBVZQeXV5o9
	 u890Fid594NoS4AtXuhom4pY7rlra9zTF/P6uFLT6UGCJCgIyHOlFZrvthbHQoGfEQ
	 TeiQCEli8RMwefZcrQu5OgSgxSYUV7TggBRUSAgFIHtUZ37ONhBocyKDuVvRyqFEZ9
	 ZIEIoIaXeU4eGlfd+E6mg7uxMmnB3YfSMdGMaBxF28eShZQTtpo6ZhrOTO0GeyYelS
	 F7XQr66T+I8rQ==
Date: Fri, 5 Jun 2026 01:47:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Margherita Milani <margherita.milani@amarulasolutions.com>, Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH] i2c: busses: make K1 driver default for SpacemiT
 platforms
Message-ID: <aiIOgFTEIcOf89hd@zenone.zhora.eu>
References: <20260526-orangepi-sd-card-i2c-v1-1-b92268bfd467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-orangepi-sd-card-i2c-v1-1-b92268bfd467@gmail.com>

Hi Iker,

On Tue, May 26, 2026 at 04:36:57PM +0200, Iker Pedrosa wrote:
> Enable I2C_K1 by default when ARCH_SPACEMIT is configured to ensure SD
> card functionality works out-of-the-box.
> 
> SpacemiT K1 boards use I2C-controlled PMICs (like the P1 chip) to
> provide SD card power supplies. Without the I2C_K1 driver enabled,
> regulators cannot be controlled and SD card detection/operation fails.
> 
> Suggested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
> Suggested-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

merged to i2c/i2c-host.

Thanks,
Andi
