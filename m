Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993992ECEB9;
	Fri,  5 Jun 2026 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623410; cv=none; b=FvFrK2M4dK+dCNs65eBgz6EH3wJTIXEhqnxYT0xrwal0v9BpoQYmArR5ufyel+3HJmhx1/OpmvTJ4cLtp0yX1Efxgi9JyV3Tns+Yce6C5fSIxzxBfnQN0A6gImigiQlC0eMgHX8B5247kD7JEKpAKfIgV0Zsh0knyusMbzNO5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623410; c=relaxed/simple;
	bh=S0pF9XhMWVKgCicZM4AD9AjB0EywAaMY+nWWgyRp3Nk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ctSvNSHu8TIfiZAj8MF0QFXasD9cC5MP28dwmo3ArmJ4y3acbGtWqPDciRy5ZBfTFdffBwoa6Od96gtDyoYpJWo5xRbLZ5GOxjV8/qMNt48T8UQARFF2cFwXvIq5FksF7bvEavxTnJ5jCM0h95BdWm9qNP1i78NYZEJdfJ0QTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=TOCaJ2m6; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="TOCaJ2m6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1780623346;
	bh=JwsWwOBz5GX7EzuT7eXhUYnjRfE7WBBa6+EMLcf4a0g=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=TOCaJ2m6fTONOq09UHKVR+0nA6cQGX1i5VrSt0QRjocNV2VmMLug+QR7G6joVwSHO
	 o9Nn4bMwU/g5K46iUSh3Xwq5c9KXB5EZRy4AI2djamlRKIjNQq553Zk0KoMV+quXOO
	 Q5NpUSLA4y2QsRrJVpGb3+wdbLljk04MMNAhunBw=
X-QQ-mid: zesmtpsz3t1780623340t7e85ead3
X-QQ-Originating-IP: DsHQgpFhyT1HZD0HvIBfYZf7PkhmVnDeGfAxFHW0bsY=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 09:35:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14962368755913038228
EX-QQ-RecipientCnt: 8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 09:35:37 +0800
Message-Id: <DJ0QAKGJE2SQ.DKPXWGPGC161@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Alex Elder" <elder@riscstar.com>, "Yixun Lan"
 <dlan@kernel.org>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
Subject: Re: [PATCH v7 0/2] i2c: spacemit: improve clock handling and
 cleanups
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>
In-Reply-To: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MjlOSqg8Riw0iDiF0Lg7G/6fjjsjtd7u5QcEiwikrdlsPAZrQyC9QAcg
	P4BsgAnI/sm+zUvOPg24z0PYSr7HOI2410Ng9PTzA81ajDBnZnCI+tDEcr9eOu6JFZLVFx1
	WpY8hgYidqyxJ3YiTK5+Oak5YbbyjxNN/2pzrZlfDSw86jxsw3EZRLGKDPXFCOvgDJA4QuM
	eTfZEQThx0SMDEWlpmSTy2vv/Mh73F+mWLEQmMZtxfo6WosUbRBW7DAmWKE1FYPvZvl2SNy
	ZOKtWLGDm/EBEn2HAT/UOKtI0ygP7whxdYRaQgZpW3c05n7dSPGl8k4tuzyzGefO2d9WTWH
	Ph4Gcp7FT7ynu5IAY6HUez2ncOhRbYxEZYqqNulTEt67j88af+gjvOvp9NyBqX6Zs/TL1G4
	42zF+l0kF/EF/55vNt/micZV5ulPBkgBlrc4Ka0Bg0HSz3WsIz7R44L9lf2MUX7dmmOWfAg
	ENiiRVwB0fyGdnpa1n1audffvCrwvor85ytonG8AE8rStSNNEjZA371pYC8SsIa26caTMJB
	a7JPCuqMrdrBpNPhBrxw3kvaKVZVQW3TbnS7Sz5/sFqzqjRWYqK+TSscTkLC3z6cfB02eHL
	F41vq4H9Wvd6/9V2Pxhd2G7q7UKU4wKsTMKLmKhJM1Q0a6q4fWUrfHuPyeg95kVUx5wlZZK
	PVVoYIOP85AipcufscpGlLlGE+dJ/691TP4vIrv1M90iK/44J5rS260tvEIpvh3ylBCcyEP
	f3DvQBXMqxBXXQXI5SXveCP8/X9YKuFKgjzeyozhLYzbKZ3PDrmG4yJADMLZrBSkMC72H7l
	S4rgq/wjxu/m70OpY4v0MbSla9Qm6IwSMeokWydREL4Q8JaWiCdRaoU+Esp3YEMGRv77lXn
	bj5ZRBHJdCVkaJnzWbM+cGN1uy4C/2FITbqEsQ7//vobl9ak0bj5y3NFu6y0HcZZrwovtgO
	sPocqLFzXXtTFV4fDKRwgPzl5YL5M13NikO6HNlXPMwyrr7LSK5xnRbktTsPKDUJdUU6HCM
	6Lm+ODN/c2sIOwBimjUyysEWKhueQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Fri May 8, 2026 at 3:25 PM CST, Troy Mitchell wrote:
> This patch series contains a set of small improvements and cleanups for
> the SpacemiT I2C controller driver.
>
> The main change in this series is to improve SCL frequency accuracy by
> configuring the ILCR register based on the requested clock rate, rather
> than relying on the hardware reset defaults.
>
> The ILCR is exposed as a managed clock via the Common Clock Framework,
> allowing the driver to program appropriate divider values for standard
> and fast modes.
>
> In addition, the series removes a spurious warning when the optional
> clock-frequency DT property is absent.
>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Just a gentle ping on this series.=20

Please let me know if anyone has any feedback or if there is anything=20
I should update.

                                  - Troy
