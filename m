Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFE1F192E;
	Fri,  5 Jun 2026 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780637141; cv=none; b=CGVRQwMneihtozpSWvGD1Qmk4cYfUWSmV4oo4b4ezKIPfaK6XFH/Gb+En8mhiS8Pxlxk3msSFQo8CiYI59V8dTUp4CLgsiy6pyLHRsK0FzIqIxbZqV3OfEtmijzu/839Nv6wXvSGhcEG3A3LYNj909ecqm5YBosln4iTawuLr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780637141; c=relaxed/simple;
	bh=tjnwlyM9ZA0VXvCHB3G/PZDqW/tb+I3zIT8YJMgqI2o=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=H0G0eaC79SYAJLD8kNem/pUr/Ke+NHlYx1m6ughbMrNGsMzyeuU9g1ydVy6OOT6I3+U9gPVb0x7YsU9nnWMeVstk76qncwAKc5vovtADyAdVlGCEIvH1zXR8gVHso3Fwp84DDdgz5A8KZklYWlklwoPJ3BAjqd503Cyj6A3sH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLz5rOwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLz5rOwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCE81F00893;
	Fri,  5 Jun 2026 05:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780637140;
	bh=VPkcWDCZPepeMSEYEjxFVH75DJ9Y6blVRIbuxL72pgg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=LLz5rOwe9JE0EqxVXhFc51KxeRjTuMFDFsTtnwUoN0KArKAjGiY7wY8UE4F7i35ye
	 lhOJ78e00fbvAxSjaIe6gMEzzMIICeQ0GnzZylCyoD/ziDTAFbrHIQgYJnFTbD0YSm
	 +oULJ04xxr1hXl+WLHGgZ/MkOOtqT3GpdAKJ50Gt57+XuWDFoD+/L7ayzqhQG6CHA7
	 kEyOsqqbAgOuX1s7zB+PlZOhNVNh4m5agBoB+g3uWMEFt+tCSGdZvkQe9qlJmdKgJ0
	 Xb3UxSw+/PAdJSfOZFVB7wuX2bswYOSOrbCEZ2375ay1RIYAlE+WtVWOV3KQflraHG
	 kkzqj4TC8sd5g==
Date: Fri, 05 Jun 2026 00:25:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: shihpei_hsu@novatek.com.tw, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, toby_chui@novatek.com.tw, andi.shyti@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, ben_huang@novatek.com.tw, 
 linux-i2c@vger.kernel.org
To: SP_ISW1_AT@novatek.com.tw
In-Reply-To: <20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw>
References: <20260605035558.383330-1-SP_ISW1_AT@novatek.com.tw>
 <20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw>
Message-Id: <178063713915.2151967.2717517603807521677.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: i2c: add Novatek NT726xx SoC i2c
 controller


On Fri, 05 Jun 2026 11:56:14 +0800, SP_ISW1_AT@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add device tree documentation for Novatek NT726xx SoC i2c controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Novatek i2c <SP_ISW1_AT@novatek.com.tw>
> ---
> v2:
> - Add Novatek i2c to Signed-off-by email list.
> - Remove confidential related statements and HTML messages.
> - Fix the potential issues in the device tree document and
>   i2c driver source codes.
> - Fix typos.
> 
> v1:
> https://lore.kernel.org/lkml/20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw/T/#t
> ---
>  .../bindings/i2c/novatek,nt726xx-i2c.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml: properties:novatek,stbc: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

