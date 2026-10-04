Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A33230264;
	Sun,  4 Oct 2026 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122816; cv=none; b=StuaQ3eVUz62AdC5sJ4F9aNFtNZCm2uwOwCpVT76+eMtMNfrAHyg+63udzjhMb7lbdrmJlrB9OiLLUd0dyFNyQmXFmkto8rA5KOP+AmKG38sZFbD6KSS5fqkbC9zcsOONwDCEfDk4NngjTUUjpAtBXHfrK4cXO6nZR+s0xQ9BWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122816; c=relaxed/simple;
	bh=t39C9F9CdnRszpZ0BPl4M1EDNRhMCRwIKGe8HBLYKg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy617ex/zugCb+EDHtWC7p1Sro6lnKWH1oAnSk86sWKXe9JokLLSrQq9BuwP+eGewVtiiaBXim0xwBQy0rdnjX6q9pJe01CDzE4tAJBQUFr42vapuJF2U68Mif2t62nVBbNJdFYCfrSQuW8hMz8O6wTOu6FjmeT+TT3Fpe3uCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYiUZ0GG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYiUZ0GG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E747F1F00899;
	Sun,  4 Oct 2026 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122814;
	bh=tZ7UqKpfVOtfTHG6pq4Va8qwE8lp5gASuNdUcPEZFWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RYiUZ0GGCwz+qxZicIGp432cxU8FuNxHAbDStRhKnlXyKxn4h0PTjDQPo6jRCDUD1
	 tTOaPqztVZvZt4pii6dUEWSEGe/vCWMcOwEZNDcXL+ACAtkRNTgrVnxqKCcIADHWPv
	 CPo96Y+EAIIyfvnM46O5oZOdzYNzJW+hUx/bYGCO65f8sQXqsHi5u9I/IxK4B8spri
	 lZPxU3DSrMrHKl0qEu5euLP3v6Ivm0sh30eRiWz0thk1Jou7ErMyBmFg8aDBj4JsYg
	 XreRbyIkagZC8py7fM/PpQgeb1ihsCakxcuURNxMhHcRe3/Qm4YbGgVjbGZvkf5vMM
	 6CJseKkaVKjYw==
Date: Sun, 4 Oct 2026 16:06:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rahul Pon <theflyingrahul@gmail.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: release runtime PM reference when
 set_rate fails
Message-ID: <asJdH-axJc5vLTvV@zenone.zhora.eu>
References: <20260930111641.1134-1-theflyingrahul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930111641.1134-1-theflyingrahul@gmail.com>

Hi Rahul,

On Wed, Sep 30, 2026 at 04:46:41PM +0530, Rahul Pon wrote:
> geni_i2c_xfer() takes a runtime-PM reference with pm_runtime_get_sync()
> and then returns directly if the set_rate() callback fails, leaking the
> reference and keeping the controller resumed for good. Route that error
> through the existing cleanup path, which drops the reference and resets
> the transfer state.
> 
> Found by code review; compile-tested with arm64 defconfig plus ACPI and
> W=1.
> 
> Fixes: 10e74f4c5046 ("i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms")
> Assisted-by: LLM
> Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>

pushed to i2c/i2c-fixes-2.

Thanks,
Andi
