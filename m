Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093944E64B;
	Tue,  4 Aug 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840286; cv=none; b=YIoaG+UrpoAhylW6y4UU5VslYKmUKwMjMpLBD/SyyE05t74T7qbu/OolPZoG44VUXAl8ssGC+ACkvgIut7FOl590IKYACrfPy383YhJjt7V3gcazNNrjNGWxVfn8ijwmXAu0oCC5KA9DxWEpfuBVQlascw3RTyvLEoiWPVT04TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840286; c=relaxed/simple;
	bh=zhMkW4peb4ffgzKBsDrgfAIZ4eDoQR3OisNYIwJRv90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsJMb7eb8IWG6WbZOVwL3iL8aPRzdfg9Isq32xs4lFspCEBfpfBj/V0UdZNVHGJxaN21fh5kCYtJn4TY4VlSVJnxdGJXvkWaKwmujtAYiVZCQ/QfquHLVK/Vb6LL1zNrEMfz1Xp6GQyU7OPVxCayztpSDGoaQ6FlZJkbDAEk9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=KtInZFKK; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="KtInZFKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1013; q=dns/txt;
  s=NAESA-Selector1; t=1785840284; x=1817376284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFCB65wa4dZGmLVFZqs+LWJsSkVireZtnJei79QMCq4=;
  b=KtInZFKKFZo1WOuzyn7si/DOXyxuHhvWdwI1ibTCnJxuaHubFTSV8uuH
   HC2CEy1z+I5uJlv9171eGvOUis7WC7Zam7StiiHKGkDY+G0Hj2Y1ZKsQv
   KMVu3PuRdZXofWkK3dMZsyDMDwaQ8D2O61n0vVkQzAqJRxyI8ZbLQWmy6
   DWa3ZK+lkOYMuIxoc8UwpXTBFU7+cHr1OHR9KVVVMOkCSFHK0ijh1G9Nr
   /OvImWV9Q8s5pUCkyLID1reP6pHciHmLEbfn0DWu8Lqj+pU9IQCgSlPTg
   S4a+jV8NXt3nx1FkT753HDfphwW8/r9YiZDG0PACiyo6sC/K9MVL78kd6
   A==;
X-CSE-ConnectionGUID: hJTU34xeRMOIuzZLZDfWWw==
X-CSE-MsgGUID: 4PFe7mSEQhKnRL01aFEQsw==
X-IronPort-AV: E=Sophos;i="6.25,204,1779170400"; 
   d="scan'208";a="59629011"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 04 Aug 2026 04:44:43 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Tue, 4 Aug 2026 16:14:31 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>
Cc: Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: [PATCH v3 6/8] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
Date: Tue,  4 Aug 2026 16:14:29 +0530
Message-Id: <20260804104431.1391839-7-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260804104431.1391839-1-pinkesh.vaghela@einfochips.com>
References: <20260804104431.1391839-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Aug 2026 10:44:31.0806 (UTC) FILETIME=[3B828DE0:01DD23FE]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add compatible string for the DesignWare-based I2C controllers present
in ESWIN EIC7700 SoC.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..ea3d4d4c299f 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -40,6 +40,7 @@ properties:
           - const: snps,designware-i2c
       - items:
           - enum:
+              - eswin,eic7700-i2c
               - mobileye,eyeq6lplus-i2c
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
-- 
2.34.1

