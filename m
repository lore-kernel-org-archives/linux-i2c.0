Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DCE3822A1;
	Sat,  9 May 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351983; cv=none; b=GMDDRtYZ5SYJT76wANypNpcviq7Zxw0mY6EHpH8oZZDsehcscwPAv0OidTaaugiV67pOLeUy2KfVhwEl5L2mvuM/xQgSNKRV4B/vg0KCrQWkZgIqsbtGcC2czU8t0FLXlkt7zTn+BClVAE2ioqJmnJiFmK/I7nYWRM3UNEzNPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351983; c=relaxed/simple;
	bh=YP1lLAj1kOaU0PEW+5u7X/h7202xHILAFb7iQtOepGI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NFTsPoVqcS06JZAfFG0ysqhaD93VkDZHRAXlAGqhSgT7rAaQU2Netqv82mjbJsEs8ab/UPpOgYcT1S1IbrmllHCVemEGC7PxiC16/hoPsCxZJboNmCY0biYkWrLuuFNRgDLcYpzDZYxGIWUwKr345XMG2UJDvJ4cKbk34ACg7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZsJmc8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZsJmc8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C2C2BCB2;
	Sat,  9 May 2026 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778351982;
	bh=YP1lLAj1kOaU0PEW+5u7X/h7202xHILAFb7iQtOepGI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hZsJmc8XtzqpW59SHZXhoVlUEg08IR/SyRenrdpJYjm7M9JP0DLp2jPdToLN5Qb7q
	 SZlKpn/VHRhOM1L50DMY6yytNF9n+bn85Jqmc6H8UVOkvGQO6itj30tC2SNyYtovPf
	 qO65iOz5uvnmRnvNZTGFvUQR23IezWGeNo7IpIlZPlyN1S6iqAZqXydPYhnbJQoxNQ
	 pyAjf1ePwLxnFG26NQxe9EY018h0ZdDcsUHE0PmhO/KKUSMiQ+t9lmqQ6e4IF+X2IW
	 sQLdihrAja0dlvMKLdM3Ml2UIJtF1HPV2lIPaqMszO4dSjSUkkkhuBgBGI/hBCVZXL
	 fsLNUMBN5Xwgw==
Date: Sat, 09 May 2026 13:39:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 Peter Rosin <peda@axentia.se>, Andi Shyti <andi.shyti@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
In-Reply-To: <20260509171354.12263-2-wsa+renesas@sang-engineering.com>
References: <20260509171354.12263-2-wsa+renesas@sang-engineering.com>
Message-Id: <177835197844.785566.9553774802925952117.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: mux-gpio: remove Wolfram Sang as
 maintainer


On Sat, 09 May 2026 19:13:55 +0200, Wolfram Sang wrote:
> The YAML conversion added me as maintainer but I can't recall being
> asked nor do I want to maintain it now. Remove the entry.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260509171354.12263-2-wsa+renesas@sang-engineering.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

