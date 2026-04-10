Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624B33D4FB;
	Fri, 10 Apr 2026 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854899; cv=none; b=VijaP3VetlmUVLbJSgQCZx/G8yCTz3zR+HUGQoREVXPVNd6pfUrKITEWC8jYnAjnDgU9UizIJaTVZi9H2mtE2O7oiHNaiGfhMoBQEIXmrlyM9gXrC9QHY7HgpSIj1e7B0s/G5/jI3PqnGIxkIy5Ww8k10AZNtx0G60HOocS0hM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854899; c=relaxed/simple;
	bh=8k+cK41OdLbgiT4F2k1zDjLX7TALCLcSSuKKXuBD5b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK+POXM0zkPgZYBJbIiJJOrjJe6vjbwLHRXgmuVrTZ/DGPCIryaCC+GN0pwhKeO6xRMZZz35wWXulsZ0tzx1qJiG5Bv9YhLEu5f9hCamkGeFCLWJ+wP+I1t3rYXzbsZxjKzd8I16iz/TlFz5weVoSmU3aEk8/eUOM8utgMzEmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXTTppZX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXTTppZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C6BC19424;
	Fri, 10 Apr 2026 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854898;
	bh=8k+cK41OdLbgiT4F2k1zDjLX7TALCLcSSuKKXuBD5b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXTTppZXN+vGmdnk2DXTuCGh1voIkYp9YeyZ5p3j2xv7T9htCXGGteKGaDSydEDRt
	 eSJweeepxWIhcwsawv2pX61JdAPCdNZW4Sk/Z+fL1frDE92WQkAZL4n3XQ91I//bIe
	 c4nNwR+Ta2Prra1N8RHrMtMixyGTe1fbG9qvaFHDQCZqr+tOebuJcnAyoG5Yh//g1m
	 5U/VMXemnaVONazS2wcmdGOnOBR7XH73+PsznIuBo9PUNgPhv83ucaM3PR8ad582vj
	 Hnm5tlIE/eq5+zWthQuCd3yk+B3T4o8Kwc9c7cqQDtnrbc50plLiIOgudNrv7OtJQJ
	 C5p9QDil4hnJw==
Date: Fri, 10 Apr 2026 23:01:34 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	naresh.maramaina@oss.qualcomm.com
Subject: Re: [PATCH V4] i2c: qcom-geni: Avoid extra TX DMA TRE for single
 read message in GPI mode
Message-ID: <adlkwQZ_9iR6WkA0@zenone.zhora.eu>
References: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>

Hi Aniket,

On Fri, Apr 10, 2026 at 03:49:49PM +0530, Aniket Randive wrote:
> In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
> descriptor (TRE) on the TX channel when handling a single read message.
> This results in an unintended write phase being issued on the I2C bus,
> even though a read transaction does not require any TX data.
> 
> For a single-byte read, the correct hardware sequence consists of the
> CONFIG and GO commands followed by a single RX DMA TRE. Programming an
> additional TX DMA TRE is redundant, causes unnecessary DMA buffer
> mapping on the TX channel, and may lead to incorrect bus behavior.
> 
> Update the transfer logic to avoid programming a TX DMA TRE for single
> read messages in GPI mode.
> 
> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

merged to i2c/i2c-host.

Thank you and thanks Mukesh for the review.

Andi
