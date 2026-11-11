Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418081;
	b=WHN1yZCdqjWG8tmn4SdvtCp38E0ZshaHP2amYAPDWnQV3PzbFfqPoPmUfOiSjffUtWdv
	 RWRfgMJ3uQH7jm89QIh/6Bawe+f+aJ62mEWCrHKM4hO5l71213325FlQb6OM5Qn7wfrWz
	 GJfdyI2ohSMBVaDDOf66wYs3XhNixx6FPZfnEykl+ls4ihbdsbJVp4hKi+9+0z4wMLWbG
	 kbRXNvfT2B86RvzeYZ2UFiyBl3UV4me9LAMR+A+Usq8UxL+gahg4qXTJ93XDGbCAzqixl
	 BN3Y++r/txIkcKnXJOINWAfp7ZCmNa+uJ9spskMZxfDMXC0fF+lsryJOZQgvrrhjELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418081;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=57R6AFZNjX3IvkWqFL/eA5eFodZe26hJrX2j6VH/P2I=;
	b=LntbQujlpS5WsjkWLbLrjoGi3M6tF229/+ajt05ayTvbo2N7rkWvChjGocbD7zt1rHjA
	 tnje+EzIvt7UOaGvfaTLa0BVDqBTctI7QY2BUtAdb9fGuQwynHFcKd3yDjZCJ/0/0r8op
	 UT5GBTmLqhrZ1kv/S+djTNPSPn4y+Rzv1zgxkZqMz12KSqZBp9QECNvkp66NVijXZcs4A
	 3XRMUgX5JK8pYqec4MNWow3AMAxhrVCbiKOgjo8x3DGrLYhtV6c8t9hz5MeCMEryO8qof
	 fCj0AsXiJmzheNZctzBGJxgMi+TP9Pi0EUFWk0GNeFOctjCjgJ7rQ7Ru369hrFdkd1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/yvgPWr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51696606A8AC;
	Wed, 11 Nov 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/yvgPWr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93F21F00A06;
	Wed, 11 Nov 2026 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418081;
	bh=57R6AFZNjX3IvkWqFL/eA5eFodZe26hJrX2j6VH/P2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j/yvgPWrbwE0QZSqkKi6PQOZnzLCWCFLZZojRWPSDLZdX7ipzVj9jUlLsyJjhO9QG
	 10J81aP+p0nwG/1IjCGKn4KYhAtxoowQsmtBFcgDr+YKJ6fRhfDUXVhCYIoA6Q/NNB
	 8g6LpMZJJvQdxFJYlp2uxkfOqGZzxEhbtyqiIGgXEuqLOIWGQhHedR+UJZiOyM7/9m
	 D+2lKu++l1YtgVEOmMNeJvpIgRrD+Xqv1CaOq1tl5PMX9Cm9A6a9ozTZS89xvR56MR
	 iKxZRjweZauAm4ZXdkc8PSYIm3EfzbSfpkCbnP1XztxwYy+S/j3ar7mujy2TwTm3vw
	 HdlAkAIui6Bvg==
Date: Wed, 11 Nov 2026 11:27:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update I2C Designware driver maintainer
Message-ID: <179441807837.73144.5244188045735801589.robh@kernel.org>
References: <20261111122808.1302491-1-mika.westerberg@linux.intel.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111122808.1302491-1-mika.westerberg@linux.intel.com>


On Wed, 11 Nov 2026 13:28:08 +0100, Mika Westerberg wrote:
> My @linux.intel.com address will be going away soon and I won't have
> access to the Synopsys datasheets anymore. Heikki kindly agreed to take
> over this driver.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 +-
>  MAINTAINERS                                                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

