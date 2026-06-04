Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49186421A0A;
	Thu,  4 Jun 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583868; cv=none; b=gZgboCh9PnklSj2XccEMHsyyKw8aolxNGwVjPUEOyohObW16o1k3sx0XyzVr8MP6uIzQtUl5Gh/hNvdnBhYPBgBBPUV67pdbWtAxRkyMHKf3KOHz9CrtKwNX1kTODSluPD0mIGTZnGBngf/t81BM4cMsJmr6UTUSItqk1oEvILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583868; c=relaxed/simple;
	bh=6rpNKwEWirGe4zw+hchD5zm3isud23TmbdZq31HbjmM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cniRYFZu77/4H9JoXa6bKKeYnpEZdvRNHy9QW/OhGvdVJ33fv85GO9ZGVToceQX7TyvmDZe860+sNMXh4qwIcq+GBn3dSCaphbSmnzBQcePT24/9u7CKf0Pm33Oq7eHZR+2t6mGEwvTq/te/o7oZhgDcg4HNhXlOeUqm1kBvdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIDJZA7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIDJZA7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025C71F00893;
	Thu,  4 Jun 2026 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583867;
	bh=mal6PLuH3+nCvKz9UQzGUlPZGIlcU127254AslQXThs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=EIDJZA7lhILwNwkAQHRsNjfTAyGJnS8RFeIloHAhu9e9nLvQFQg6/XYzwesm69vmp
	 dNxxSSERpa4pBzk0Zps2J8GPPXezylj4oAJ0Qxrit8HDwjMcxZ8WGzmPDfiJZ/Kqtb
	 r3ncursllB8gI5iEporMtawRMTt7bXySi2PxzQJdnCwWLI88QuyqHzfryHr/q0ReTC
	 tQSemYO1l+26xYQAFhuEgB1H9S905su9ravfK9TF7G0kdh0G7KVUKiJBUSiZ6UL731
	 0LXBg1Z2UHW3gXvafyq7byeOcIwxgP7mK+ajztbzFVf26hdlPsm4lFcNR7+z29DWip
	 PV0bobrlR6fjg==
Date: Thu, 04 Jun 2026 09:37:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, shihpei_hsu@novatek.com.tw, conor+dt@kernel.org, 
 toby_chui@novatek.com.tw, devicetree@vger.kernel.org, 
 ben_huang@novatek.com.tw, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andi.shyti@kernel.org
To: SP_ISW1_AT@novatek.com.tw
In-Reply-To: <20260604060430.355733-1-SP_ISW1_AT@novatek.com.tw>
References: <20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw>
 <20260604060430.355733-1-SP_ISW1_AT@novatek.com.tw>
Message-Id: <178058386530.470828.9428918291987591263.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: i2c: add Novatek NT726xx SoC i2c
 controller


On Thu, 04 Jun 2026 14:04:30 +0800, SP_ISW1_AT@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add device tree documentation for Novatek NT726xx SoC i2c controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> ---
>  .../bindings/i2c/novatek,nt726xx-i2c.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml: nvt,hwmods: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml: bus-enable: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml: properties:clock-frequency: 'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260604060430.355733-1-SP_ISW1_AT@novatek.com.tw

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

