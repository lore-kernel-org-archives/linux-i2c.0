Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D421257A;
	Tue, 20 Jan 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915161; cv=none; b=JdVyE+dYAcOiqrg7zNrDmw9E8ao5aFCsuk/BK+LgEzZWo54tI2cowVB8bpmT5UHBRj0C/iUUeGaz+G0XTApgzLuJnGfs8oC9hJ0iUxU2L6d+fPV+oN9K1xOuZ7FeBo5lGja3EvNYduG4yh9X/rXRlJGcK4hAONYUjmPLRCw/c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915161; c=relaxed/simple;
	bh=Ax1SsHcB3OywrieOtzxauXma1i5NjGs2ZsEwk+RuvPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC7AlJ5Ng6kDYZKBF/i2v8EoiFLBvvQZyuCSGNILb4bokrRDtmJcCKjOY0v/6YEN+bRJA846haz8pDhOa3eK8RksJk2b4ArbOAcrDKLckngdPXsrR7Pqkkd1eijNcyjGZKgCo8kiBWKznoBbP4KoXA54iFOLq31QqFkaAQTWI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCIUGTv4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCIUGTv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2F3C16AAE;
	Tue, 20 Jan 2026 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768915160;
	bh=Ax1SsHcB3OywrieOtzxauXma1i5NjGs2ZsEwk+RuvPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCIUGTv4SVmKc4zBKbCo2BH8QwQespzV5QljlLEHSupWVvHVQ/L7PxadNJ1zOsKKI
	 GPsPN6sf5vgh3egDhC+CaiOWhpXVk409ijvqR1wdLrASeJMvThkOQ31E2sk7i5ai8S
	 LUUf0NNm7mZ3EIGN/LMRrxQ35yTsgMNxXmbMm2nKRXkSlplaXUOt5FRpBNn7yXeqdf
	 Bb8OZZd7ZPefZn5XWcgL+W4pnEYlLj3mrGDqdAlJZfRCKmgvCr/4cHO9cgiapKZ8Q9
	 O9OikBLsuuPtVnBtV2nW9hWSzgXs+i17sioeDRhBkeSxxCLtwUZ7g0PUHwOV8eeGoC
	 ysKVbqb4x7Euw==
Date: Tue, 20 Jan 2026 14:19:17 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 20/44] drivers/i2c/busses: use min() instead of min_t()
Message-ID: <aW9_U2g0VmtdFtaE@zenone.zhora.eu>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-21-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-21-david.laight.linux@gmail.com>

Hi David,

On Wed, Nov 19, 2025 at 10:41:16PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(u8, a, b) casts both its arguments to u8 potentially discarding
> signifinact bits.
> Use min(a, b) instead as it cannot discard significant bits.
> 
> Detected by an extra check added to min_t().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

merged to i2c/i2c-host.

Thanks,
Andi
