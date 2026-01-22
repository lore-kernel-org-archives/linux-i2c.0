Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3D285068;
	Thu, 22 Jan 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087188; cv=none; b=pVqK5ZtDpkcDphsZwYSUnbcOV0s8ATHr2Ei+E2//B+JtIk4d565B1XxT6NSzcD23iMrskvz0MI188nz9nYLCeCY7EjucDuICd8qTLV0Xnk5//VZAj6e1BoLU0xgLLHxqnAcWCMZoUD8k7tlpjXKa+wVsxBCBfO+L7jJuxlHBwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087188; c=relaxed/simple;
	bh=gCxiwAEkAW1/kJHAFTDw0bNVSClmk0Y0pxeqMlpD8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aete0D8Oyz/gKoDKV+WMRf65OV/8rVfSY4ZThIJMufmiqqVceeQGjcOwzQM/LU4BsKDkP/be3nuwPb3vqS9jLNemj6mHz8NH/W5wug3SmaB7gBvQjDeM8GuK4LRQFCDF+nKcSDjFhcfpDHhOTS8DMmVClw6tb87vgB6ihF+h4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmbiaW43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmbiaW43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C931AC116C6;
	Thu, 22 Jan 2026 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769087188;
	bh=gCxiwAEkAW1/kJHAFTDw0bNVSClmk0Y0pxeqMlpD8Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmbiaW43matw3oDkMMwT52mk2XrU4qkoJUwxT+LvFTd5zSVe7MUM9r1eTV8qk11Y7
	 KK7H5vDwgJxjnkdOalPNTTIyktcntGaUh9x7I7s1rZ9nVsgYiEye1EX+ZxAn9TZPSk
	 9pjEE/XX1boOCNtLpA85qjIrUWEDE2OP7FL8a+f3kvTnUFw/q2ekEtpJctiWrjwGKh
	 Rvvlt4KVUduOl0fd36KCl1ivRWu2150ex2uEcavY6Np/7+Pc3Xg0pppwkfI7puIBLG
	 rDhDftFpUeTFGywy3Sc119azATIFAGQ44FbOMovbDFxfiZC+2ey8m6FH35TKmrKfTk
	 AC8gMicfneSGg==
Date: Thu, 22 Jan 2026 14:06:25 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, vz@mleia.com, pandy.gao@nxp.com, 
	B38611@freescale.com, wsa@kernel.org, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [Patch V3] i2c: imx-lpi2c: fix SMBus block read NACK after byte
 count
Message-ID: <aXIf4RfhZ2nI2Uks@zenone.zhora.eu>
References: <20260121094837.2651035-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121094837.2651035-1-carlos.song@nxp.com>

Hi Carlos,

>  drivers/i2c/busses/i2c-imx-lpi2c.c | 106 ++++++++++++++++++++++-------
>  1 file changed, 82 insertions(+), 24 deletions(-)

thanks for resending this patch, may I ask you to please rebase
it on top of i2c/i2c-host-fixes[*], please?

Thanks,
Andi

[*] https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git/log/?h=i2c/i2c-host-fixes
