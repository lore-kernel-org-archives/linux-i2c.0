Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C13815D4;
	Thu,  9 Apr 2026 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721142; cv=none; b=M9BoAVRJmLvVoIVNAfe9vOinE0+o3SEKvOF11m+sGbhQULHr++pRulorjoLGkW3PwodEmBqoOU6uI2SSrD1hBnZT6foYVw0uxhNSb2Ht/+UvzvRSGmTg/L2pa1kKEWRJKWWjUGxRs7bBJGu85baa5kViaPMJIyuqj99V/uEZYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721142; c=relaxed/simple;
	bh=AEGSH7uqeU+Lwm35Z0c1HO6xd8EheEWUPP+QQbCRcUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWJKk+CTg5H2rY7gPdS4an8idB+J+B2ZwKbAoNQENdKxSCubhdyt9ru9J4MM8fPwFmK6+2HIrcs0yaYzl2ReBNv1RAf8MGqx2GqkW7z4FDB+psJOK7sbtfKl5vK6mLM83ti0bPNs4TN+yLxAoAWQ/0chNf5vdpkkNbmo2NaSqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNSxtkDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNSxtkDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1EC4CEF7;
	Thu,  9 Apr 2026 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775721141;
	bh=AEGSH7uqeU+Lwm35Z0c1HO6xd8EheEWUPP+QQbCRcUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNSxtkDEZffNw90cxRqD2s1VidL3ASfUTQgrFqnu3P+szt2RL4Gplpe6W+r+9wjIs
	 qAcZwgfwASIKH5zuK4H0MUqenzz/4LCnmDQ3j5NVM96352Lpe79+7W6c8x/s2TAFxw
	 EOREiAaU89KiRO8sltRl930RnbIuUM/UsNi5OdIXZDWUfwTk+uZaA4OYFRggpcoISc
	 7R/TEAlE46uzGfE4xIwC2+qZ85Us0brLPItQ/eWQnys9WffuKB51IO5oFe+5iiLZTW
	 ofPhi7ORDw79Z9TWgx0Cj2iFbiMxB9Vy5TUJCL7Y0ixbjopDOeBuTMl42n9rc/OjNI
	 0l2cjGqBSzXgA==
Date: Thu, 9 Apr 2026 09:52:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, andi.shyti@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com
Subject: Re: [PATCH v2] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT
 schema
Message-ID: <20260409-beneficial-macho-shrimp-4b3a8b@quoll>
References: <20260408083549.12815-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408083549.12815-1-i.shihao.999@gmail.com>

On Wed, Apr 08, 2026 at 02:05:49PM +0530, Shi Hao wrote:
> Convert the Conexant Digicolor I2C bindings to DT schema.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
> 

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state in the patch changelog
or cover letter why and what changed.
</form letter>

You missed Rob's tag.

Best regards,
Krzysztof

