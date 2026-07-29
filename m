Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9A357D10;
	Wed, 29 Jul 2026 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351736; cv=none; b=e+Sed3Q9bBJqSZa5GmhuWYrOmuFEB/wVKsx16Zpf3tm5g6RG8X2AqtUnUlU/vzeYQbZFb/So/aW5tlTfN/Wvvz9J9ytbf69g8/r4BGvah6++UUhc7RrpKhZj7b/+7svdYbKUFPkwdiYq1zC/tNTZbWWIOYZ2sQKr9z7hXlvmgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351736; c=relaxed/simple;
	bh=NQXOcYNt7yVND4tW/ibBYZE3Zps4c1aYgByHotY3aKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc1dNVM7axbWnrnyypOZTpGB1Im7KlLmQD8eDxrTsB9vH/++kLpNvyutmfcq76QOWZGU6Ny/FwJ0ut+33uWJAL+LF3GkhORqbE0DK0uUdtyF5FKUFPex4TZEKzbXx7AI9nZ5grb/TWcsbve+dqKstSSrgSTU9IWotPNtlvASBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8fK1BV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8fK1BV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F281E1F000E9;
	Wed, 29 Jul 2026 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785351734;
	bh=Jrg4lsQgPwnm6hGcmdrk6V4zwZ6IS6QKsonqcnKOTM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k8fK1BV2juOQwN2EurviOrF1IfYpIadUSONbMhza6WaNEdkXg3rF+zTEoiIOZwydy
	 PYiIesU3idAh1Sk745h8F07xy1+BnWq9PKzgKoDIdMb1wgC25cnR3oKy+cjPT6B4Gh
	 +0sx9kHZ17iXJ62sJ6vgNZZAoriV+/4ZFgiGvMArFy5aOuCY8W3NWG+8ukRrWXhNMv
	 ekFx69KTzPRX8bfnBwIt1m/CNISYek4w9ZGXef5Z15qI6I6ElzUDgXtnW13W34L6US
	 6e5AoN9tQO4EXHqGomUJtPMM9VLWH/sMyc8NUd2LNjinMv22B5TstC3P54hEbL15uJ
	 32Jt/XoA+Gr2Q==
Date: Wed, 29 Jul 2026 21:02:11 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: wsa+renesas@sang-engineering.com, linusw@kernel.org, brgl@kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] i2c: i2c-gpio: Enhance driver for buses with
 shared SCL
Message-ID: <ampOBh-6yDGjJBNx@zenone.zhora.eu>
References: <20260714162915.3018703-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714162915.3018703-1-markus.stockhausen@gmx.de>

Hi Markus,

> Markus Stockhausen (2):
>   i2c: algo: bit: Allow to skip bit test
>   i2c: i2c-gpio: Enhance driver for buses with shared SCL

merged to i2c/i2c.

Thanks and thanks to all reviewers and testers!

Andi
