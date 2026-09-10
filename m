Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429E390987;
	Thu, 10 Sep 2026 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073505; cv=none; b=O9siz4FO5NvpZOLp9IqkV+3N7UVfxfCh7AcykQaJxUGbJDotBB19gpeu/4iKnsord2E4bWFXEJXID/QL91ww0uK6VChvYUsVqhB0zq+x4vjz1hZjXxiiIrkj8mz9o5Ezq6bGzd13T9zoD+COZQNOtJTgjlGm93DjTMkQtnUDnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073505; c=relaxed/simple;
	bh=I6NrJ4Rg6XZaG8bouHqPiwvG+RdRE1E1Noyx3g97kck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUDAsEEx5W3zOmJHL+v2j88xUYWOnYI2/VWjyawx9lcrlr0rxBKdz4jsBPbAd0PpWrOkwJmZnAktBRuNAp3LA9vfuoBBNHcoTaDX9rDSOnLKRQaVmnYemVM6Plw14eVEUuS27IIGHHp+l7hfTe0ppIJ3pyZLcj2jH1fvOFnXE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4OCok0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4OCok0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1456E1F000FF;
	Thu, 10 Sep 2026 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073503;
	bh=mN82z+mpSzvnJYZfh0TAn1/Wv9mtu3lW8f+BTD/77v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R4OCok0mgCuyOT3ZFy8pZSH8FNo3vBa9XVIQp1nQwQiaJK3JDV978dOlAahrO78p0
	 VOMrqul1jLjRJnr4hLtMBL+/atEOCoBI6HT1eAc84AfPgV0N+Sxojk3PCzc/vZ9N0t
	 3WpmnzoZSZvu5LXpQxILp2t9LAIh18rzqd82dEAIcv8388QKBO/6zYdguIB2Ubug6m
	 pFqRctWkt7IoAmcTSL5N6ihV3AxZkx9RNWBn+FT4EKL5/lNKtTex1tsSA8V6BYXAnv
	 2QkWWVy4TL859kzs2oDQmKLfio/LigUXIrh5vJLkziId49eYTlFDq5Jx8Tjd9xVrp4
	 qMsy8cIGbHUgg==
Date: Thu, 10 Sep 2026 22:51:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viken.dadhaniya@oss.qualcomm.com
Subject: Re: [PATCH] i2c: qcom-geni: Simplify PM resume error handling
Message-ID: <aqMYSAJD0HPHkoG-@zenone.zhora.eu>
References: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>

Hi Mukesh,

On Wed, Aug 05, 2026 at 12:30:13PM +0530, Mukesh Kumar Savaliya wrote:
> The driver currently logs pm_runtime_resume_and_get() failures with
> dev_err() and returns the error code separately.
> 
> Replace this with dev_err_probe(), which combines the dev_err() log
> message and the return value propagation into a single call, consistent
> with how all other error paths in this driver already report failures.
> 
> No functional change intended.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

merged to i2c/i2c.

Thanks,
Andi
