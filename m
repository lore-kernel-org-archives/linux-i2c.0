Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA13D9DC9;
	Tue,  6 Oct 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279292; cv=none; b=trH/whjWQRrVlIthyJ1lHXJpluL26j+72qBwWYn2dUfSCTa6joWZOwAqUtaLNAgDedPelHhW47SIpAbgRrOnyOwi2YIgivYGThO+379saqEbvDkORujifSjbLhZf99OEqgNN/Qy2BI+QfWFFJnlYvBSwxoV+Q2ZXrAMFJrnXM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279292; c=relaxed/simple;
	bh=QcMm21XZyTDjC5onR0ZC/Mk5AFMbO9TuS1iDa3AD3c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVWkB2Rh6O3Tq8edqedQMWq/lNtN0VvahLpdUiZI17Qu7wfLjmIW61Kn22fr63hPmiX5XmKltmt+UuXuOcVxOuqh/7FDLd4Vci6+CNqCk+PQBKtiusehiWaVay7UXqsmQv6h2bfdZGp6shOyWSpUqaAW6IJ5TP2epBlbqbQKCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6Ps3Om5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6Ps3Om5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86E51F000FF;
	Tue,  6 Oct 2026 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791279280;
	bh=QcMm21XZyTDjC5onR0ZC/Mk5AFMbO9TuS1iDa3AD3c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6Ps3Om5x2CrooaQB40xdb9urU2P9CP7k5CQFv5m2qFa00EZKVsJYQXjTqbIZJR6j
	 82pAinKvrPwr8ClmHzb5UudzcrsdeXVD+wDETbSZTSR0iulsQZWZphaPV+HAKHTNqr
	 qFQeST4u7hzgaztnSqkPuGYusGb0vKaCIlc9Lalv9O4KV/qpzGEDZI+s6ceL+KHt7R
	 OAh3uuqtg34iGb3hUVkMxYAhqT9Nn47X2w8FXvbeS2GuJnJgmFs8W+CxYH5JyzAxxA
	 /w/VJLg2XdsbTl+UdDf8buuubwgxnjgOqZ1dybi4uqgmLD+3EkUiuLgYxv6ZyzDg4s
	 xCKxh0dWSRsLg==
Date: Tue, 6 Oct 2026 11:34:37 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] i2c: qcom-cci: Detect capabilities from
 CCI_HW_VERSION at runtime
Message-ID: <asS_Z1RWYiwXnXop@zenone.zhora.eu>
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
 <20261004-cci-imp-v1-3-227d12cb4829@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-cci-imp-v1-3-227d12cb4829@oss.qualcomm.com>

Hi Loic,

On Sun, Oct 04, 2026 at 09:09:49PM +0200, Loic Poulain wrote:
> In theory, every SoC integrating a CCI revision that differs from
> an existing one should introduce a dedicated compatible string.
> In practice, most CCI instances still fall back to the msm8996
> compat (v1.4.0), one of the oldest supported versions. In order
> to take advantage of capabilities introduced in later versions,
> such as larger queues (v1.6.0) or threshold IRQ support (v1.7.0),
> we need to properly dinstinquish the different variants.

distinquish/distinguish (no need to resend for this).

I didn't see anything wrong in the rest of the patch.

Thanks,
Andi
