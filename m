Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8842C4FA;
	Tue, 13 Oct 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889715; cv=none; b=IteQ387f0udmzreVYKQjgNV0KoqwgQ3OKqDuILvBC8nsVrMYZ3vteCTy+XjsnBlmx5VOB/o7ICmJFGUJ8gBtBOq3j7W8zf2NYidKZUo4hphjluJfGS5RP0T7jaRmqM2mxiQWh6iHkDgFS/z1+ctlY/ySSSjzkIqi9xnnGXwMQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889715; c=relaxed/simple;
	bh=JBVl+sw5wq1yVAdsNtfi6uVwGL/iySOG/Z9H5DSxPhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj7OrCV821oaUl0VternWmWOJlI2/ijhTanIXL/Yht9F6teeYVQff/MBCpZGJb2QpBRH+kLSuTQRjFlRdwym3ejEYvEFpW50t09KTonQNM9qGFzjIg0+f5M75Fiw8cBVRGmDJIz0V72fI8/eb1dYwCR0FxSZBSCtqM7RaDngL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlpbEupd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlpbEupd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3B51F00893;
	Tue, 13 Oct 2026 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889713;
	bh=hIx5Kf7j+Kmv05f7U5CV8sq+dl/uq/YHCGp8BskyOG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jlpbEupd2YRJPFhfGRv63Ew/E/vAKRlW3H9QvIzc38RbLAoWMhXWyoBZPTOa3dkWT
	 9pohirq/X6nvavN8WrREnkxmg5x00FgGGk9LZlPFTM+BYJ63kcwVNXpQs7/w2l+7Io
	 QuvRXoHcSYUIDcLJjtCnt2L7JnDvMk442hz7Q7qZ20GW7ODlpGXkXleFDuo4ydfnyq
	 sNmpKAzMQj/2cNiyg+rXKexpfYR/9j2QLYqexPuBqmMrMyr3wf5UG7PKXueIAsv6fN
	 rLNB4Gj8TPN0+mz4GTwybjH9lCQfPI1Upkh95bJDQiopB3YABaD2iGN1mCJ0zItn7R
	 owO2Qnq5lQksg==
Date: Tue, 13 Oct 2026 13:08:30 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Wolfram Sang <wsa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Todor Tomov <todor.too@gmail.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-cci: Fix HALT_ACK reset request being dropped
Message-ID: <as4RHTi0OppNhpOO@zenone.zhora.eu>
References: <20261012-cci-fixes-v1-1-8cd4eb1fc5f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-cci-fixes-v1-1-8cd4eb1fc5f9@oss.qualcomm.com>

Hi Loic,

On Mon, Oct 12, 2026 at 02:54:56PM +0200, Loic Poulain wrote:
> A HALT_ACK interrupt indicates that the corresponding I2C master has
> entered the halted state and must be reset before further operation.
> 
> The M0 and M1 HALT_ACK status bits may be asserted simultaneously in a
> single interrupt. However, the interrupt handler currently overwrites
> the reset mask when processing each HALT_ACK condition, causing the
> first reset request to be lost if both events are reported together.
> 
> Accumulate reset requests instead of overwriting them so that both
> masters are properly reset when M0 and M1 HALT_ACK events occur in the
> same interrupt.
> 
> Fixes: e517526195de4 ("i2c: Add Qualcomm CCI I2C driver")
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

pushed to i2c/i2c-fixes.

Thanks,
Andi
