Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34738FF0F;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054014; cv=none; b=SjfKkkNuMvsYTZ+K/lZh2L4nOOPvguGmEFrualQOM01ysiLtcN/jZbPhl47kYaDkSAHtCe6EU9OtlHPe8ruHMJwtlKQFLvjaBjwSTbc8cERyu9UvYgors1ESv7sQLcN0vFgzl/7LVhNOurmMK6Oj6r3hjyL77UC8uMaREz1geI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054014; c=relaxed/simple;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyGw/WyNDfqRZNdEvT592KqBkPE4ipYox+H3mQbRjKy8nYuuNLez30Fnelte8UU/BuZhnMz5gGgSIB8GbkhtOJSjjbRjrgXFWA0f7CQ35iT6MurOhWanFi4jo6kQB74ZGrglvfI5jI0zUpnw6ut7nFSDzKIh8uY8kovnkLeFMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpGMLl4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpGMLl4m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7DC6C19423;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054013;
	bh=YUyTnratnqlECwzSAzk6FREP35eA7ZpjXULZWweNn00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bpGMLl4mIFgV61A9Q2THHlMjzlDs6K7ieCZNsfNdZb9KBAcRDsE5RtPxlTjmPy5vc
	 mtalZMlIjwXm5BLp7UP4Dq33+WbtXb5D2vT1Soi5Em2dLowP5DtXaaEdOYISTdoxFb
	 ns0VocjMMpRNQh9K8QhanaaJLqF4r8HjsEeb279G/wO7xbHFInZQs7DT9jueejEsAn
	 r9msHCLe+/4Vl1B+AzSBUapG7r9wUjk15sVOTQpjOZSGj9zWkYevssBIzjeYBa7pu+
	 p3ZnyYqzGQCXulSKmxhP/KEaWNYiY8cj8nvDhzb3gNOPwChrJz18DfE/FMIY6fJdec
	 pR+svBXIhDvVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC92D625E9;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Thu, 22 Jan 2026 11:53:21 +0800
Subject: [PATCH v2 4/4] riscv: dts: andes: qilai: add I2C controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-atciic100-v2-4-7559136d07cf@andestech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769054012; l=723;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=lHt2jE6+LDmM/nXD6n9TCCx5A6rJ3cqG+Q1RYfyMh24=;
 b=iQnJZd47qVd7XoSMvzcJ5R5zVO+zQfuzU0q0WaUJznzsDZ59v88OiVEbBZPkzjzFOhclrG4vg
 k/KD4r89D2YAmX40WHr5xetJkK4m8lyEL3ckbopFs6NGdMUp6uLwRzV
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


