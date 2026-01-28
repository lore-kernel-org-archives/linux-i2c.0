Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB43451CE;
	Wed, 28 Jan 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603148; cv=none; b=Q0+kirhCfQ/g//BD6Ah6EpqDpGMH6f01X53wQNWiPN1iEBh7C0raw2EkkTbeBhvaas4qy2BI1ALVfoffQkn6Ea6rd5Ri9k8BBsRVolm9ZYT1JXCYUzstDD80BHuq/FlC1tS7w0lcDvkCm3ZHBC1DMmAKSVOsRtju5K/g3UGFI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603148; c=relaxed/simple;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhh5/zgy61b2/N37w9BE4a5XbYRwVlzqgNXc8hrglfHl236ZBZwhSEJoEA/NyL/IHK5nUyBcezNUW7E7+FDce16bwuuvWFgrLCoI3hWB066XtsnFIAgTQFj7I6npssd2AxFRukxelZEi6dLyePmn82nU0nMMHAQB4gbmgNIMEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjoBPkpp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjoBPkpp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0221C2BC9E;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603147;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UjoBPkppqn8rtO4vKy06deYyu4nEch30VOjE3bjy/VoXTBZk4h65wHGWcKMZCODQz
	 UA8DLH8KxZsWyKahslFBiWxkb9ANq3GL5jp9rE+ifRxmYQoWFkCPNnYtABy2JzHlPj
	 crqzUpII1nVBf3KC53dJjJ+60PxmRMrvy1h7mNYZNq+RCU4PHQTP8lbpV1n4k0Mc8L
	 uZgEm2+C5vqQdRxR+NsE2/agxnnl/qxx5+iUM1+UQNMW3gXw/v1lTpC42xxSs1m4OE
	 ox32ny50ToD3DLc4h8ss7AaxO+KZgUWtCzOwPHxOF0Z4xYC1izFWTM86KLOzBOtqxs
	 hLWAAimfbKnfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED3D25B4F;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 28 Jan 2026 20:25:47 +0800
Subject: [PATCH v3 4/4] riscv: dts: andes: qilai: add I2C controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-atciic100-v3-4-8c002fcc2bb4@andestech.com>
References: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
In-Reply-To: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769603146; l=723;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=lHt2jE6+LDmM/nXD6n9TCCx5A6rJ3cqG+Q1RYfyMh24=;
 b=ccLAKZkoxh+ypDT9aqYIJZXyBbiUKMWGPeojaXOGtFgKOjUzLSWq5zobh6hYafCbsxBnvUDRo
 YnPdTctjgjNDRCgcm6B9SaJGo82neYFZHQZ+8isvziAopFYQ/XzYb5B
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


