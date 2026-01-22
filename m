Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930238FF04;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054014; cv=none; b=GeOL6yYUNeSNEYoyOEnQKuyfbkrwnjR6k6NtzbLvHbP5TA4rtMFB01afBMzHzDhN+xhSJcjHhDWgsruz0Zhj8/OFcwdZypuUkDFdrczC3BI8TKBJCviTsxzTIMve96EMZrtMKy/UzT/Hz5yaYoXA79Asn2uxu6nKRvq/1NPSA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054014; c=relaxed/simple;
	bh=orgXr9zmHCBms+ytEAP7IDI/EZXaKPysvA5ieVEr3Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbaXXCnApr6UtSjTA+B+3BX6oqf2awgnVZ44UujeoultyrF9uE1PY8ez+vAOzmvTAC0fRE0Xu5gdyd+scYdFQSBJcMqaSUQ1czb85Qt9waBzLow4ifwVxT+nTs//2lN5+P318BkVaJ0sTqJUKsNcd0E+/Dodb+NnBjQE8RmKMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhREJzOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhREJzOH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4BB9C2BC87;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054013;
	bh=orgXr9zmHCBms+ytEAP7IDI/EZXaKPysvA5ieVEr3Ew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fhREJzOHffx6T8npPEpP/KlJePfThT4OZaG8GQxNvQswFdFjj5h7Fgz0J/i57S7TI
	 uShHYTWrbpvXrqA7s35ZN31FB2xJqbHoEmPKOFQb+eWEzgdxe6PcGPRrSuNVtkCLb4
	 ojcg0iITC6G9CofAl+bODRv0xvWchpmcO64BDxNZkjjma4zEKWLY33F8oFBJBLeW+/
	 OuUx1Sx1d5VpkW7mS3drXO5LlTs9wC25eDgRRWLFgRX06w/YrEoTBFPKzAWZ6xs3Pu
	 PPjjNLskge9jZmTfBN+lh3+R8CJ6UrR2bn1JkiHSckD8YV30XSPY1HJ/AbWR5Qx7vo
	 tI9BxPVfDSJ/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94FC44536;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Thu, 22 Jan 2026 11:53:20 +0800
Subject: [PATCH v2 3/4] MAINTAINERS: add an entry for Andes I2C driver
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260122-atciic100-v2-3-7559136d07cf@andestech.com>
References: <20260122-atciic100-v2-0-7559136d07cf@andestech.com>
In-Reply-To: <20260122-atciic100-v2-0-7559136d07cf@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769054012; l=725;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=3+hkSp62Y0BxAKsBp1ZxlSLfzIge4HcMfARxzT3H5hA=;
 b=e7/vVAFZV27UkQ/Y8zBjVN4l0NYgFJh+kCZNDbRFv2AD8POEZ9jRu368iAIFWqvLny0r0aGH6
 D4kYM/XQK4BBUW8e/e525q+toe9lHBit4IS/Bt6rRUDZ+ZxTm2MT61R
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

Add an entry for the Andes I2C driver to the MAINTAINERS file.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc731d37c8fe..c1145ee1038e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,6 +1817,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES I2C DRIVER
+M:	Ben Zong-You Xie <ben717@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
+F:	drivers/i2c/busses/i2c-andes.c
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>

-- 
2.34.1


