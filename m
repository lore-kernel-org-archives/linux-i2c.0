Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04643F39CB;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429790; cv=none; b=guqiI9XHIBG5jJHxxunSf9Wy3p8zOmGMQhR0j+MzJ/acqQ7WIQ3rDVp1oLVMkzRIeskkxU9eh2kxxnVn7yUcDCJhWFNqGbm6Wyk3mkU8CvTo7FceLoKBqMFrsQUa+YeS9M09HVWrBa6+kpvDEWcbHCABJKONmkwCn21VAR5DV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429790; c=relaxed/simple;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlSoD/gyBaNoTADJtqBeAJCn05Ug4xrqboF/ZnO5lcYkfzsPSYQ7trWF4R0Oj4/7nycAA5fkmcyCRK2ScdUk1AHbYIKGhLnSK0kr6rEXhWDBjNeWua/hFvbsS8J852UeUqYgyYWgREdLbbqttNyNz+bqJ7BFreInrnSdDBrjBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qegK+1IY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qegK+1IY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 636CDC2BCFD;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786429790;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qegK+1IYLJRmJs1FNoA0zUkyYS/g7nJ+HWHBOgrj8pVKZKrZ4GTxftJaLXznYjTqF
	 Ehth2vgSYI6jge/7n0WF/4oi1zdA3jtaFVgjPLYsVKTjZsunQbYpOifzsoTZ60kB2g
	 FPylP6RNMnFv67CGWtysULNjSuZgDLwOpTE2Cwooqaj9MfNhoaxdsANqO4pcyJ5qPK
	 m/054y+unWcCI7VV6sw8opxsx7K0QveXKpsWGJAhSvt6Ou7r3q/JPEYGDEYIAFfl8C
	 DKGxpde7ijMp3NylUDKpfzKH0LsCoQdI7DO1amnpJ5uQUq/WMvo+akrrP25S/ZBM2t
	 E64p67DWSAb9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492E4C5B573;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Tue, 11 Aug 2026 14:29:51 +0800
Subject: [PATCH v5 4/4] riscv: dts: andes: qilai: add I2C controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-atciic100-v5-4-1d306c21dba3@andestech.com>
References: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
In-Reply-To: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-09770
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786429789; l=723;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=lHt2jE6+LDmM/nXD6n9TCCx5A6rJ3cqG+Q1RYfyMh24=;
 b=7qBBUukN4Q697T7Q52OnZqnGftXQt9gJBiL/RXCNLMZnybjenZ/TxkgbyDH8lSLYgHYtZQqlc
 MAGN2U/1Z84ClDt+A1AmpCbVus6K5zL+IfG5Zf1F3Oiy2C4kRgQxsIZ
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

Add the I2C node to QiLai DTS.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 arch/riscv/boot/dts/andes/qilai.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
index de3de32f8c39..8b40f4d7f8d5 100644
--- a/arch/riscv/boot/dts/andes/qilai.dtsi
+++ b/arch/riscv/boot/dts/andes/qilai.dtsi
@@ -182,5 +182,12 @@ uart0: serial@30300000 {
 			reg-io-width = <4>;
 			no-loopback-test;
 		};
+
+		i2c: i2c@30800000 {
+			compatible = "andestech,qilai-i2c",
+				     "andestech,ae350-i2c";
+			reg = <0x0 0x30800000 0x0 0x100000>;
+			interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };

-- 
2.34.1


