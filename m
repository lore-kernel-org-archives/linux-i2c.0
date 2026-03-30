Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09139E182;
	Mon, 30 Mar 2026 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855836; cv=none; b=F/AHIvfuKYSpS7TM1sj+Kpm6EwGeCaXctJOlJUXWDDfNPPGPgC7cT3pXKliMSlQVdIf22Rnb9vqeVxjQoXsqRKgP3fxaRw87MyUU4DYVuOU9BEUCYkWp48DrRbsdc9BnamfKC7aKOqre8Qv7leUWtrK4oLp96LSijfFERzYz50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855836; c=relaxed/simple;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y80K54hR3W+I9ZaZziIvDsDXKUp05fakXR/LsEV9BOTOFuJAjeVhv2pfdxATmeCwBwjU4ufUDluHqJwsjtMvQ6X8w+FtbYKZf85Ody8BaoybD5rmKePI21z5xLo44Hd1kqixuUAmez9ayh58NqRG+5CuAbh3PKCwBazBjiNXvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoKQsrAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoKQsrAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F40DC2BCB6;
	Mon, 30 Mar 2026 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774855836;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZoKQsrAJbzb3TJu/oO7LXEcHIOYjAh59baGNRqqnUvRoWSmjUT8NieQ+cwTfavFY7
	 YCd+y5PHt3xivi4czI8PVcKrSWFk9Pcpb5nN+vWF7VEjrN90giWPG9ZaK0zD+vIRbX
	 IU6Bl+DyxCsxndSED1DZiH6N+DxIjJqCUJEujnyGHFbUAgzQhWhKyHYD6g9Sk4sRsY
	 bw97S4Bq3J/6cLUimHJNwoYxO5fz33n4gIfRsfnrFPVot7i1TTY7pJx2NfMeSU+5lZ
	 mAR6R8z/ElAf6NruZrHV6qL83N3dmoIVbVq6SWs25KNSQwToz08cHzsOdoEWMMOil8
	 N8CzQp75De6QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004DFFF492F;
	Mon, 30 Mar 2026 07:30:36 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Mon, 30 Mar 2026 15:30:34 +0800
Subject: [PATCH v4 4/4] riscv: dts: andes: qilai: add I2C controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-atciic100-v4-4-d40822f63e4e@andestech.com>
References: <20260330-atciic100-v4-0-d40822f63e4e@andestech.com>
In-Reply-To: <20260330-atciic100-v4-0-d40822f63e4e@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774855834; l=723;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=lHt2jE6+LDmM/nXD6n9TCCx5A6rJ3cqG+Q1RYfyMh24=;
 b=3JQUmdg7CTpz4PVd+oiNv5GYe8NiGErraflMYoIzTBmXF+bglT80SfCOh3YAhrvP/Cnx4m9cA
 wEiDld68pirA8uiNBghFZrqCIMp+oS996n6BNjbin/JG3S8S2dqDTd0
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


