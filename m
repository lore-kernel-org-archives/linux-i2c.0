Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1C1DE4F1;
	Wed, 17 Jun 2026 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739509; cv=none; b=BhGrezMcgn5UWQBUKZbhhF1uilu2RexCoIgZ/VscuwTGCMEtagzALHGFsxtXDKM9zcbm8DH6ARW49pMsy5/JeeX1KzdnV2S5jhpc56d58ysCBVhiuFFz40Qr9d6TTvKm5ahwbR6cB4k22R2JPnc658xrcP4zeh5MMhYViRZvqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739509; c=relaxed/simple;
	bh=GDGCLkIeRmnqVhtJAZLTfSu4zBJAd4FkwPx1iN36FhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGt7mdOFKsT3elbr6ohWTUrNfSzUOoykLDVPLjQx9iuYTumg2IOASENXt/ImMWoH3weOayz6UpaqtRT80U6CBj9p30n5ToUGNvqnKTyQR90glruIC1RZ91hh+OuMk7pNOEaubAOqJ4AEWMxnMa5VBLw6loC6X9eBWMXcTwnIO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3iWkcgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3iWkcgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947281F000E9;
	Wed, 17 Jun 2026 23:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781739508;
	bh=wixw0026hj5PxnquB9p21grb3sypIWcI2jV3PxVVnkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M3iWkcgj9v7NAZ1As1RVp5E0VZ2egyZbGGe0bsoX+cspoQIXBe0UR6ruXaxtI2hAs
	 K/pJmO30beTIroy6UIyOPIPLDXqyZWdq8ZhrlPfsWatytzWX/8HFZslXIDaVG60fa1
	 HfD+WqvSv4z9nHCKEUahjuz/jezchA0yLfecM5dAsN3mErc814IiILEJKQ4r2h7W80
	 ZTy3MpwYu480vzjxY0ItyxMdODVQuGR0RbstBrjG0CwMGCZPF+dfAfDe+xpqIPGWMx
	 ke7kUedfEh+2c4gVDcxFM1JhpnZ1Qq48JtMyrIlwEaKXHSab5sObNIWI4G1o8zraTU
	 4zgnAz7Y5fyLg==
Date: Thu, 18 Jun 2026 01:38:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: shyam-sundar.s-k@amd.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Subject: Re: [PATCH] i2c: amd-asf: Validate firmware-reported length
Message-ID: <ajMv2evldPGr59gT@zenone.zhora.eu>
References: <20260612093502.3805287-1-paritosh.potukuchi@amd.com>
 <20260612101815.4124804-1-paritosh.potukuchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612101815.4124804-1-paritosh.potukuchi@amd.com>

Hi Paritosh,

On Fri, Jun 12, 2026 at 10:18:15AM +0000, Paritosh Potukuchi wrote:
> The firmware may sometimes return a length greater than the
> allocated buffer size, which can lead to out-of-bounds access
> and a kernel panic.
> 
> Currently, the driver does not validate the length read from
> firmware.
> 
> Add a check to ensure the firmware-reported length stays within
> the bounds of the data buffer.
> 
> Fix indentation issues reported by checkpatch.
> 
> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>

merged to i2c/i2c-for-7.2

Thanks,
Andi
