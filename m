Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73745A297;
	Sun, 20 Sep 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928673; cv=none; b=IAVWpX1FCc7Hpg1lcX3izssLcfaUqRNGHlvSU1QyamU1aFgj2B972ZxXrH+DjvGrW6C6H595Q82AVclvrynj1HRVHD10phnlyaejxd2f27yp37m1dgSlx8uqZuJ8HaXvIpKJVkGwHncr2qf/IpiyBaKVsrul9E64B/ZRggNjzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928673; c=relaxed/simple;
	bh=wetqL7yeDkif7OVG4S+1UbSEbh/sk/5MkK6vpSkgdJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y23kcBq+6b3jW+W0v5Pa3NiSFil4PgYVo/crLg/P8T9LMSuwH46ZDHov8YY7RmbFPn6tH5bVrn/686vtknHYqUPr+04nHI0yQ3fsZBHGs6eMVSWEEvbJRnzdkAOsbuYEbsEpY1YulX8jdiQ4JCi9sRHFg5miawiMh7js623n3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtDF3E2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtDF3E2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB62F1F000FF;
	Sun, 20 Sep 2026 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789928671;
	bh=wetqL7yeDkif7OVG4S+1UbSEbh/sk/5MkK6vpSkgdJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GtDF3E2gwyvrCvXG36PVngtCs7TL5bxZDpf98vz3A8xd9q2OMx//ZhXg9GQqfXiHy
	 wJmIJ2T3dVaZ3HTELiG/dqNml0hT3Wz6T5GTAbkFLedri8oR752au4PNNlNtlW7NbR
	 r0f4y5tD6WlJrg/JTxuo097Qo4mxbAtXGQBEZbD0G3Oq2VNZw26jYZOooYzI8hY9Rc
	 csk6TtkQ80c9fdpgBWNygLUTMNXlBY6h8QFjDRtBNcmdUkOfq5Dmn2ULZ63IHpoy/8
	 y4i2s1DUDCWXnP+LY12Y6FPhufUpjpZfhPcipbuPXX8enSKjbEPorYe0yg30TJdw9X
	 MBZvGJ7yNuyvw==
Date: Sun, 20 Sep 2026 20:24:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>, 
	Bin Du <bin.du@amd.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vigneshr@ti.com, nm@ti.com, u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com, 
	Ritwick.Sharma@arm.com
Subject: Re: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
Message-ID: <20260920-warm-lurking-poodle-dd73ee@quoll>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>

On Sat, Sep 19, 2026 at 02:36:06PM +0530, Aniket Limaye wrote:
> Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
> referred as DWC_i2c. Compared to the existing "snps,designware-i2c"

dwc is designware, so snps,dwc-i2c = snps,designware-i2c

I think this is *the* argument why generic compatibles are wrong.

Best regards,
Krzysztof

