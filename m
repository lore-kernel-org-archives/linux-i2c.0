Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C303BCD17;
	Tue,  6 Oct 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295141; cv=none; b=BiwhbcOTtCcffgVSNePRYjJGTYSizmGWbqY0linsTE1KLW+yjdrp+OhRkhAmAKB0j57PbzNDyEsPL+lCODGqHvRS0yg6xEd/XkEai8w0Ze0vAvFZs1UN+hQovvsquBDjVirdYANE2CXU/Ze4bdDoT7Z09WQO6CDqaL0F9l4neHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295141; c=relaxed/simple;
	bh=Jvx+pFq7EB6HueHN1Ejnv0ZYM5Nq/i2+w5/6j/bq9Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rolao72fZl+soS07jx3ZIbT5M8bz/p+O/V7mlYQGrhTuj66x1DLoXYPIf/vcclp/YaC9hN4K7HG2s0ypCWFRLM9YCyZltbH6fSKBJUUmaaJHqMWNG4wNRCxYDXvTqeq0RwClCBFCiYl1CAMM94kWhQUAJr380zNzd54kbzxFJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9ynM+A4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9ynM+A4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5521F000FF;
	Tue,  6 Oct 2026 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791295140;
	bh=TpUKaXYbNuvpTeX9DhfA6G8N4LFCqpraZn36XFeqND0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9ynM+A4p8Z/xhl1KMLQeDpqbN0GFxn6f9ysyMcnDu3UFavAmdZgoCC7L+6vy67cL
	 GKWhyMm4NtWKQzWx+NuRV++Cl7hNdmZGWpYCilAOfvb75n7tRbmPJMmfBGchhTQzEu
	 K2iXAAzsiMRUM9puptZI0oT4gI+qRMB67bUGQIzEVUpU6sTb0KXHf5iQr6RQSzW98D
	 sLCfK6OKFrxmImBQiJPGDylZEUX8eoIjQkAawzrxVpSr9dlIxSbqMpBwCaskvsGfXR
	 X1K0WNa3qMSe55DG6wg/e9+ghvfNBQCfnHJZEq7d8vhaZTrYFuCcXC2oh0zHAMT89A
	 lERIm25RFcNoA==
Date: Tue, 6 Oct 2026 15:58:57 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hitesh Patel <hitesh@ebytelogic.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, ravi@ebytelogic.com
Subject: Re: [PATCH v2] i2c: qcom-cci: always enable SCL clock stretching
Message-ID: <asT-VRVASrO1FB9M@zenone.zhora.eu>
References: <20260914132328.976902-1-hitesh@ebytelogic.com>
 <20260921131954.1690578-1-hitesh@ebytelogic.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921131954.1690578-1-hitesh@ebytelogic.com>

Hi Hitesh,

>  drivers/i2c/busses/i2c-qcom-cci.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

I'm trying to apply your patch but it has some conflicts, do you
mind sending a v3 rebased on top of -next or i2c/i2c-next?

Thanks,
Andi
