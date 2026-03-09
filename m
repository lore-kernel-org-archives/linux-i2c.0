Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB82D3ED1
	for <linux-i2c@vger.kernel.org>; Mon,  9 Mar 2026 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057839; cv=none; b=BZS48J9859SCHVa9q3UNZvCXes4SU8UtLrvqDR7dJ5e2UjEb4wtvBH5YTs5ghPnohNXyN0eDSGpoTEuPLVpaHn5fjjpGxSY3+CtTge3NO/VTtGr1vAbT11TQ8bZVcf54FM6flG0QBjRdey9Ldjr0w+FkJ/lD5FzrYH02hPirZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057839; c=relaxed/simple;
	bh=+TAmd42UIaglHGE/3bX49QcRlO9QTc2VdzRDQrqceZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLAC35VF6qthY/0N2e5jqCkcvqpCU1EPY3Qn7VM2k9AQBIjulLrq65fPSsMEHnJ4HQJ5n19oTGqVqRvODdcYkX7NCl+52iA5TDmZvmFiAq9n7gdVtTv8gC0ERm3zU5Mbj8xOUEU0vkQa8mzvJmd5YWenEtp2HRPJz/206SQcYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mADDQ0jO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mADDQ0jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5Hiy
	aThHq3+rh7mDIEUL8bioSnbtaPFQO4u2XnbzF2w=; b=mADDQ0jOZPZQC9iVXtKp
	pFkqMFjzhNDMkygEPX+MtPBbb0vcBB82wBcK7A5uIIpNGqw8f3LArdbH2tLafiAU
	K61eKhYIuvduFmQWA9tKq96t60NOo6D71MjkqqTVaqmmYENGqgL4HTMMRN2T33yk
	oM8i/sEnxCY9T4iL4XU6w2/ZGYUSN0Erj3+h4LXM1D7Daqa4MRRHngSrRcygDC9z
	J4m8tjUfXMsdK8R6jC0IooOcTqxCqyDZpcVNkzOk4L9cdJkWY2trzFKTg2XF9b+C
	1qg8vXmlduVlCrrrjB/GUjt9kg3GSsye2D2xvxNkJ3ahbRba4g/AKyrgL4qEQc1u
	lg==
Received: (qmail 2766109 invoked from network); 9 Mar 2026 13:03:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Mar 2026 13:03:55 +0100
X-UD-Smtp-Session: l3s3148p1@R11pMpZM3tkgAwDPXzF+ANZpdrMKUeLI
Date: Mon, 9 Mar 2026 13:03:54 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: dw: Update maintainer
Message-ID: <aa63KjktVReu2QZT@shikoro>
References: <20260225125109.3794977-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225125109.3794977-1-mika.westerberg@linux.intel.com>

On Wed, Feb 25, 2026 at 01:51:09PM +0100, Mika Westerberg wrote:
> Jarkko does now work for Intel anymore and since I'm currently
> maintaining this driver, update my contact information here to make sure
> patches get Cc'd to me as well.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-current, thanks!

