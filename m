Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE82D0C64;
	Thu, 18 Jun 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797711; cv=none; b=XUJD27DpXNdOQXb9slLl9JQpXnmOmb6u30pk6RkDr1S3XSqavd3NdCsFquj5LKnoMtjTQeJRi1RUPs97mJcaGkptCWEWnyAFjagB25bjFDMFbtPAF8dAPkGsLbVM1QCSv72d6h56aLe17oNFQK9SfMPnIdexGpRZppVr2ePic0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797711; c=relaxed/simple;
	bh=uCXl/Add3HoeRazrrsXKsLsrykUvT+dNm/0BV4NN7J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bk5hqzG/REdHC2WIid/kc6f0KAzZvRA6n7TeMLHUWHhIAjtm1+rgeJMCr60pKdNhHubMsUZFmJgLiKOYWUh7H9eKWAg03PPQEFafj6Jf8lKwAqB9TEoQ7pGHSH0QtaEWtnNMqmr99kAgzwaGxAkVrbhLzzpsS32k13SX33Oc8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LeIOAAQZ; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=e4d54Xda; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LeIOAAQZ";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="e4d54Xda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1781797703; bh=uCXl/Add3HoeRazrrsXKsLsrykUvT+dNm/0BV4NN7J8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LeIOAAQZ2RTPfJfCi0KozwbvUtwUseqO/tHTGc77J6MXxbSpfXfmGl5VlHSWuXtFs
	 ofxoC3SL2lvma2+j7TkAfVXMq0Mwc5rCQEqkVNCPHewvR//G3BXbfYuHHeYgBEL4Iy
	 HJ74opzvLwCqGaRL4grddWfe6baPIdPBnZZtFu9mmOgKP6UWsyNkvtA4ITUCxS5l5s
	 Rw1EEah5jV7aEcuZ2PALqcw4TddgdY+VB91BWE/Meyy/A8eC0qyW9gC/YbU013ORoM
	 0IiCGWZJ96/D15Wdjq6v0xVzGiW9ifs4KH+4WJaey+QwtGRyIqPWS1Fc/x3Tc2k4zV
	 yQM4EnUzSYmXg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 111D13911ED;
	Thu, 18 Jun 2026 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1781797702; bh=uCXl/Add3HoeRazrrsXKsLsrykUvT+dNm/0BV4NN7J8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4d54Xda3CMi8yGO935DopAK67wBsPfS6ltay/OPeAUjV1QpAl5Rp1l0uFxvx0tPY
	 ZnsSKHRTiJwdFcWC8kTKpNp5+1l6eRD1XyNGPk++R8YvdTjs+PP5qdBsC2tpM5eo5W
	 9ZF+p+PdwoDLihKyossohSx84kQbHOMIVm2G80Qz511hqmJfSbkUMkHx8jIYVvEaXz
	 5vqNBOjkAdB4ip7mJlVhQMy42Gi3dUzX+1zm0hEesRcLArbxZgMyXNPIhXxzi0sls+
	 95jetLPKEoOquev/FTIcxW3ZaS+KDKvjm5jy2mxeixkPnjtvGti3qMqXo1It66Q76E
	 8wzg8a9uXKnjQ==
Message-ID: <5a84caeb-59fb-42bb-b717-578fcfaf8a8f@mleia.com>
Date: Thu, 18 Jun 2026 18:48:16 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] i2c: pnx: Use generic definitions for bus
 frequencies
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Andi Shyti <andi.shyti@kernel.org>
References: <20260618130948.3199768-1-andriy.shevchenko@linux.intel.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260618130948.3199768-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260618_154823_094444_D6336B07 
X-CRM114-Status: UNSURE (   3.47  )
X-CRM114-Notice: Please train this message. 

On 6/18/26 16:09, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir
