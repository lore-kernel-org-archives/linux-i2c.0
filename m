Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2A3BBA07;
	Wed, 25 Mar 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435375; cv=none; b=L/mcA4ejakah6LupjkP88ghEiOSMpZinM2w73y8HIIB6xQvBblVmXOKWPXHYewkYx2koZyd8Yx/7i3CwORfE4FQ5vzKZXZH9wAx6Kx32JS8xaTJTyLN3/6I0ISLddqLQHcOGcuJywcqMKNKHZhqSWVjD/jwKJcb9CkFkpmzPAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435375; c=relaxed/simple;
	bh=Xd3v/lgQPClZhhprKyX8eszD/JDLsPJt3Q2OWgG7cpA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ed1Lo77w+gTzIek2nO+uqDjs+mgZa8UQPbGInOpfBnogHotP+sstFFQDw5u3M7bqPMR5uw+XFFFniaFxM/tMwVba/iXnTi6QawuoSaBfEKgNUk3NGeLMDNnThCA48LoC+7WwpKUGBZD6J6EGWORi1Myct/qr+8bj1MmAzdSmkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=tWIvrTi9; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="tWIvrTi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774435365;
	bh=arsbVOQqNrFGFD4zXyvy20fOvHwbaNRzAN3h/Bf6owg=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=tWIvrTi9L4vL/dw0LAImXTWNlwXB1dZxS9DheN3alf4xoKcydjy9Sgxs4DUoorjA1
	 y/MOHHwpLygobut/sdIrspzJ3F5CChHNO40PQ+mPDYlqews09/QrG3rYXowvZd2qHb
	 fKW9zttAqn4ekrpwnVpXgXGohbah4Wkc0xuszCXw=
X-QQ-mid: esmtpgz15t1774435360t08c25bdb
X-QQ-Originating-IP: 7OPY19mGtSlo4kPWwupOktdlSC4sswfnQ7F5LXLlhdE=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Mar 2026 18:42:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7138833924869601224
EX-QQ-RecipientCnt: 15
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 18:42:38 +0800
Message-Id: <DHBSU6889P61.4IKB55N20GPQ@linux.spacemit.com>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
In-Reply-To: <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NlUc2cqXmL74TKJKu5byzUENTnLS3Dfj1FqhBpm5R4s1CdLKXqBWIXcn
	z+f5WuxC1g04rlcwXNpskDISEWT7vyUaYikL88cCg+PTIqCdSxvThx2qfmUfEr5qvJQ7MEL
	8m45F3b5s1CeD2H6pS5VTGgCes664S+VFdNMLVX4uE+8wWyE57k9h6d4uNclzoB2ECPE/ci
	055EjRgNYXTEFJywBXcFOhL8THFQHsOsDEVEHas6TaFory7xAXhFsqsN8kO6bcLhth2gBEv
	8ncV8f9VbOzlkB9qw5R3JwbHsNyYqWi5++NvdmV6X7jKD1v04wpelhUj7/rW4uG1UgIVkXF
	LILCdAcJ77MisOHh8QvJV1vbkNpwxJfc75K2KbyF90OkomBX1ZcoB8HSuhoegEDk+yED54N
	VfCk3BH2PTyNHt+XKxNPKorzV9g66MlGLGZDNtH5raJYbsGZ6gPfnGfDow6jM7aRBnIMubh
	WuxTnX29oSpJeVnuBjUcYd69WAhXEfTgjvyydCioLgfS2dlzHBEUQB5KYVLL/WRSI7NEeiX
	pGi90qBggoUZW+0RynAMhKgHKohQjRKR6neW3D864u6loSE0S2T3o1yrQbro4B+xoZkOPOw
	owXKBF3KYT9eULVaw1J2WRvlQlV97Fm1Aoo0F0w09MWmH/PnsEKvjgBYVrdDrLcs8RhaiQj
	fsfq9HEUnaqFESQ2H0K4A7R0uRuD+RLU+tqSn7W+0UNJQjNVltvkynwUIOHT8qX8pLFUowo
	t9utEXQRac8+Nf4cQvFNWatlSPruz+9ozlk8JtkwKS4MWOiRG9LMf2S8WE+O97x2iph9XBa
	ptDVTqhss3L8y2NIqHchYuUGYv0hSw7JV4cv9O49TeHUnpVwG2RuAFCA7IZwkIymassLfyx
	8vGZgnK4HAiJsk+UlgWKmAEYbxDs9WKRZ+jDcfNLNMHEEQc5XDeUXvk8hztK0aQxK1dtTvh
	nSQ5XoB5X1aIG8NzUmGB9mZCxFXuZ7G/aWHMIvu5HCe5k5KxDEeXqZAjB9WfBkzOyc5HTdF
	UEFmU0o+jraHG+HuPO7FBGnSX6NxgimC806U0RdJan1Lce0qOvvfcsMR8TgjU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Wed Mar 25, 2026 at 5:49 PM CST, Yixun Lan wrote:
> Add a compatible string for the I2C controller found in SpacemiT K3 SoC
> which use same I2C IP as K1, so make it fallback to K1 compatible.
>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml b=
/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> index 5896fb120501..8c04c675b25e 100644
> --- a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> @@ -14,7 +14,11 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: spacemit,k1-i2c
> +    oneOf:
> +      - items:
> +          - const: spacemit,k3-i2c
> +          - const: spacemit,k1-i2c
> +      - const: spacemit,k1-i2c
> =20
>    reg:
>      maxItems: 1
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

