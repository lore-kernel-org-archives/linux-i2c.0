Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1343F4DA;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239190; cv=none; b=fxve6Fil0ZGyudRPosHLAHdxypQyNnP0AgiYdYqwECghJq+f7zX9F6VxdZeaxizVdwmf5UGuw9dPwJBXyvy6M2iHZSFMClfs8iPJBKiUVL9OmRnS9YNu5mikt6P/XpMSSp3IcuA4w4scwep4kjODXP6bZkXJNPqxK6syRSbtpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239190; c=relaxed/simple;
	bh=06FZnhXGZuZR4CkcXGwW8TQfbRJRFXYynt8Gr0hO7Y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rf+IZmyfQYLBZctaoLkV2uOdmpFTf1DVSA6LUY9KIBfMjNRJf75ow02bw/8uc8WFISUerEt8LXBIC8rX47giEjHp6icJd06yDauTNfDnwO+g0WlSPdMk8FeS4X2Ub1ZIZzWCYVVJgmpcIVQrkVY1btCmmCuEzMQ9ZuCDDKXg4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8cGWr30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8cGWr30"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F9D6C2BCFB;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790239190;
	bh=06FZnhXGZuZR4CkcXGwW8TQfbRJRFXYynt8Gr0hO7Y0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f8cGWr30DSG9SZtNzvp667ycxEY409ApragHa6j+pzrt0j64NNkDX2bFYijltU7hc
	 qdRB9vjJn/IKF2YxnlzOYsDJTMC9fZsoh8fBmoEuB+yxRxoE1UfQQQ2FaGskjP8yz2
	 lOPmTfWoLgU6hvpqp/mE5ziJCKRNoEVokbEJSH6Sn7PMc0hzmVh3GPZW+cHsatYFR5
	 3IPViR/vU8AQzG56Uo6orucSG8fXYgCP/dGD2O1Crz/qJ7KZ6QD44Vs+Qs0cqbvUZo
	 SAscG+d3RP33cLL6BfjQ0UgJ+Y9Div8ktbeX/Hiav6gk5AsVWEmI3muSVLQ9/7q/74
	 kRnw0i1Cx0Juw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E75C98319;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 24 Sep 2026 08:39:36 +0000
Subject: [PATCH 3/3] MAINTAINERS: Add an entry for Amlogic I2C driver
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-a9-i2c-v1-3-b8ad9b46f4a8@amlogic.com>
References: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
In-Reply-To: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239188; l=829;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=aYonPJ+1tSzZLPuDMhjuR3pNtXh8ncO4wuKdJvLpiZk=;
 b=W2fhuoKGAkSXG5MS0wF+fkCwKpIiTkXKALi46UKdci9Vw0mrWEaJm3i8Nc6u20K6rY8qICF9M
 ViMHi39DZ58AbpKcjkXoLGboKoo37YOI8rXrOi0ve2ziIU9SDiCzP0G
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic I2C controller entry to MAINTAINERS to clarify
the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6215fcb07770..33c39ecf535f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1371,6 +1371,14 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
+AMLOGIC I2C DRIVER
+M:	Junyi Zhao <junyi.zhao@amlogic.com>
+L:	linux-i2c@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
+F:	drivers/i2c/busses/i2c-amlogic-a9.c
+
 AMLOGIC ISP DRIVER
 M:	Keke Li <keke.li@amlogic.com>
 L:	linux-media@vger.kernel.org

-- 
2.52.0


