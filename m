Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE2480970;
	Thu, 22 Jan 2026 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069323; cv=none; b=EDOn+cwCVi5tOdyArXYLQtxaXshvMYJvUlsnw3cYV1OjoCuencVXYJcQlIQ2yHI5zVGCv0rLFukzv9HEBKXIqgooQzTjKyRgzVSWN8u3nSq5z99YJMpvMts/MvJkgW6N4p+AwgK0okrGT6WhY/inzIL0Qzr5pkPDdgfC5eDdyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069323; c=relaxed/simple;
	bh=QdnzH/k/Cpxt+cbGkFJe3060i3uFURJ3AiMAUgzjrW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIA4HVdHteiqiPsyEmcFpr2yS5L4QEwMbrxxTwaWWxd0Pj0kOIQJAD7wWuW2Jbgj7IY2jEWvxA/2bUsRcFyt+z9dMxqxT56kvpluc1Dcm2/KZUt++3tgDuVTATyJNp+4TAv4eZ4XI6qcisb8AOVoheQKA7bBltgSHaCKRZPybnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bagLUWiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bagLUWiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE38C16AAE;
	Thu, 22 Jan 2026 08:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769069323;
	bh=QdnzH/k/Cpxt+cbGkFJe3060i3uFURJ3AiMAUgzjrW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bagLUWivqopIxhtDMa4hRZVJlzZb1kOZZsiVJnxhmZ7KLjsN6zgCRuoAMeWeiKT0i
	 o5XfefkojyxAH+mcKs5mdF+lMOnuo0UyRh2dY0QzIf1CjL3Q4CapMm7uRBbDVUI9EA
	 zXwzAvjbxhHSyFIE5UO8QV7c8bqDBXuM86amczFv7LQg/jcyNQu1XyIxE6PVHMGafq
	 GPhJ5VVM+EESTXOyPb5bECIGqYtWvl3640i5zTALnrwGhMuEky6JZy1M6m+h3E+D9I
	 72jCj78NUmFwr72E1RR5qO3AZFraIVU6S66ImRnev+NXK55Q7BFha/7EQqn2epNilq
	 Pg32b92y/9i1A==
Date: Thu, 22 Jan 2026 09:08:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: i2c: add support for AE350 I2C
 controller
Message-ID: <20260122-almond-pug-of-management-33d438@quoll>
References: <20260122-atciic100-v2-0-7559136d07cf@andestech.com>
 <20260122-atciic100-v2-1-7559136d07cf@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122-atciic100-v2-1-7559136d07cf@andestech.com>

On Thu, Jan 22, 2026 at 11:53:18AM +0800, Ben Zong-You Xie wrote:
> Document device tree bindings for the I2C controller on Andes AE350
> platform.
> 
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  .../bindings/i2c/andestech,ae350-i2c.yaml          | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml b/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
> new file mode 100644
> index 000000000000..59a521fb249b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/andestech,ae350-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes I2C controller on AE350 platform
> +
> +maintainers:
> +  - Ben Zong-You Xie <ben717@andestech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - andestech,qilai-i2c
> +          - const: andestech,ae350-i2c
> +      - const: andestech,ae350-i2c

Same question as before. Nothing in commit msg explains me above and you
STILL DID NOT send your soc upstream which would help me to understand
the relation between SoCs.

Considering you did not even build check previous version, I do not give
you any benefits of the doubt that this is correct code.

Respond to previous review.

That is a NAK and I am dropping it from the patchwork.

Best regards,
Krzysztof

