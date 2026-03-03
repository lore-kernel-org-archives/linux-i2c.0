Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADD37B3F3;
	Tue,  3 Mar 2026 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555702; cv=none; b=jj/s7cYgT/NpVpbKrPgFGBc1hS+Lk2RbndpFheLxA5EkIFporzef9Jrni2g1JCcFSrERl+rmWTgarSGuZuHuC50t/O54zYvn4MFnR+CYQXqzUu8Y2uE85UmLzO/D57s+1qh3ZYN9gJUTOP+cLAWmwJ9Vw5Mt0scJFJPe6jVzhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555702; c=relaxed/simple;
	bh=HyqZMtRcUrfGU9UNlm5NhcKJckrPgBuMi0FqgbdPt2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxWJs5t1eySG/4VqNtXsduo/P5T80oGxNLM5wT82mjhBbyTSHIYwQy3KYbb06Rafd+V3FgXJ8xeIZcQcggLoJCWc1ILVLaIkbZsC5iy2BZqWOI/dWXVvYZzjtC+McdA9I7ZUKzLHhdKL/K+2hv2mrCzYdc2jhm8loNIJlYLQtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msenSNMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msenSNMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA98C116C6;
	Tue,  3 Mar 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555702;
	bh=HyqZMtRcUrfGU9UNlm5NhcKJckrPgBuMi0FqgbdPt2Q=;
	h=From:To:Cc:Subject:Date:From;
	b=msenSNMh8KjFxvpvnerBh4NvvxBkgSl7OONTO6jmpZG9mczAJrRC82tqX8/oLylTo
	 fxjMk+QDEEZp+/oCZu0d+PgxSALZN10mMQHvsa7SlzX5sO9D0k7tF7pB9Ti3U2AUmC
	 o5q11S8Aw/Yj4v6Pge0xGaIeF/geRlk2NcE7bGI9R9r6bMIljIIYy4NyGwNscyfOxP
	 FKXTnAuzWwT2nCzqg7ZTzwmj/uywWGvxgOgNk6zQaJsfyykV+21SLHWRPEnRURO6tn
	 PVqbSyIOxrEpN/emw+GchloKjZUuvBaRjFSQxv2LzFO9uazAck7a7eXA7TbVOH8N32
	 NeF22Ku8klBcg==
From: Conor Dooley <conor@kernel.org>
To: linux-i2c@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: i2c: microchip,corei2c: permit resets
Date: Tue,  3 Mar 2026 16:34:54 +0000
Message-ID: <20260303-clang-earthling-8a4904cb8a7b@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=23oSag2Y7V+S+9pFwJOyhqecZQK8YjdMRoaWJl4XUFs=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnLedepBlzn9LzYnMMuunH2Z8n2+qupActWST0qC54gX n9M4TtTRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZivYyR4e7FB8reL5rj1nG0 ZhX+M7p4bFKx0gqTvyEdj6rMp1d+esDwT+vsHYa6ffGVNSdc1QqdMo9cefM9fhH7HIaoWZ7Z3tr 63AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Both CoreI2C and the hardened versions of it on mpfs and pic64gx have a
reset pin. For the former, usually this is wired to a common fabric
reset not managed by software and for the latter two the platform
firmware takes them out of reset on first-party boards (or those using
modified versions of the vendor firmware), but not all boards may take
this approach. Permit providing a reset in devicetree for Linux, or
other devicetree-consuming software, to use.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Andi Shyti <andi.shyti@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-i2c@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml b/Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml
index 6ff58b64d4962..bd63c70aac6bc 100644
--- a/Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml
@@ -37,6 +37,9 @@ properties:
       modes are supported, possible values are 100000 and 400000.
     enum: [100000, 400000]
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.51.0

