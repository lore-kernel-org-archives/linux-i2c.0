Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942E3DA7D0;
	Tue, 28 Jul 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228484; cv=none; b=OicECUUiojW12UlnjdQyml0+KEwGKlZpAUgRDAjduXlDLvwX+RjkPNvGJ2wmkTcWFrt5tIjJOlzdmKscjy2qf45WfX7kDsimlGz0GM8yeczZgE1e02G1Fxy2fNuIborhaLRNY9xFaENz/AsU48E+housnIBiAqcLgcUI9TNspSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228484; c=relaxed/simple;
	bh=3SFQMMZ4Sqee/3tiL2U7/s7G4R8uK8ZAHXtuel4CWc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSA/OHcSOZiMpO3FGScUy5mWOzYB9M/uKbbto9I3B+OBoedMKRx+Q5r5zWFORlQbH2AVPVjQYKZxxj92geIN/IXp6Gnnk6xIw5rTLkhu0/P9lI7/6UN6MxpJ1rWwZhQYInBZw7n/u1iLh52HtucY0YR2A3omO84KYctkxfqmQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6KFjZYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6KFjZYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFD71F000E9;
	Tue, 28 Jul 2026 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785228483;
	bh=zjxYoxPJm2y9I1tZrtcuT5McS8yD8t8fy/r1wYWueD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L6KFjZYK2r6XGUzIkg+Nxf1Kb/O+Zp33uJGE/Ky1DVV73FtN1BDK9EqhOB5U+ZcB5
	 9GJgsolfOnKvIj1OcPgWGsYuqe86LnnjUIjP2kCK2NaVJaHObjEtgUK25agga9ZVyq
	 /NFeUKFtSjl/HMUbiG/NcbF8xvT5m4zMmOK3kE6wNlS/G23KfJ3JgtTQdn5T1d0jhJ
	 pTqljLcpnzJCkANImhuFBqW5Y3ePkgLshr8aA2SGUDJcjt0TLR4fV8mFmblASThvSh
	 ZrN4baFXHTSs5Rh/aruWFWaOuu0QiUhFZOnfb/h2/063JGsppX1pxyYhP52zbs1/qo
	 BuyyKQH7G5X9Q==
Date: Tue, 28 Jul 2026 10:47:59 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: qcom-geni: Use devm_pm_runtime_enable() for PM
 management
Message-ID: <amhsr3heA6hZy9v2@zenone.zhora.eu>
References: <20260714051512.3732551-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714051512.3732551-1-mukesh.savaliya@oss.qualcomm.com>

Hi Mukesh,

On Tue, Jul 14, 2026 at 10:45:12AM +0530, Mukesh Kumar Savaliya wrote:
> The current implementation manually calls pm_runtime_enable() in probe()
> and pm_runtime_disable() in remove() and error paths. This pattern is
> error-prone and requires careful cleanup in all failure paths. Using the
> devres-managed variant eliminates this complexity.
> 
> Migrate from manual pm_runtime_enable()/pm_runtime_disable() calls to
> the devres-managed devm_pm_runtime_enable() API. This simplifies the
> driver by automatically handling runtime PM cleanup when the device is
> removed or probe fails. This helps  with Simplified error handling and
> Automatic cleanup.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

merged to i2c/i2c.

Thanks,
Andi
