Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A83B6352;
	Mon,  6 Jul 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325478; cv=none; b=JiZc73/+y0yPUaq4+N3l3WT45nv++rBZkCy1duhac/5A/VQ/B3Z95HkryyBv/riGiieU3xlyYyYHvdLn+iM4CChT5IIJCUTnP3h/dQzYOaMpb47ZrSNznzNyxQlhuydp++EN8Q0b45bnXQPX1XZnJhed++rABE87y7hn9CemUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325478; c=relaxed/simple;
	bh=Q/Hj33DLpcs2zdqCW9ns4EkeTsFZhzDVp5AhWDnfxc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWJ0n7uIXDmfZqEF9TAYwsCNyWJw6NsziB+bgwYWSmse1BIEV+SjErfgoB8yvUJ2Jn8VFdlgwdcsgCv0ugDmxwMhKoFDlOJ850nsnVVxU2L1Q9i6cVIRmGqvxnzXpmDdEOLEcj2WryD5Jh9uf+1N9TVDm7a/Ocn9bRhS1Pfpfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=LU4zTF+x; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="LU4zTF+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1026; q=dns/txt;
  s=NAESA-Selector1; t=1783325471; x=1814861471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZrSLv+fD0qvW7IF5sK5E0CXoCtasghvxf6Evd3A7pI=;
  b=LU4zTF+xLCLut2oVaXgdHq+1+Rh1FCb/Dugp2En30RECvWnPIhAatAoS
   i4r82ekLGKBgM72I+30MZC91OHRdgmbZl4RIljMuzvY3Pc/GJJAK3V3Qa
   5oMDNsm/3MB8HmWnddCJVHEbfFz5q4LvzA+WYNZBW2SdZTjaCnnwAOHLN
   JAvvYuy4RhKkFB6GnmGPjWCE08FVuEFPxwMd4H3kaaWI+2+nJZVBFJfkR
   bXGQMb1CEo5lr7f2rm4YFWsT00+s6VzgxQkc8acM1CzXygjEgEphIrvJX
   1YIg6DtVgotLWxamvpzUoTmOOKW11D+yg4gD1NRrftLr3xg6OgWq56f5P
   w==;
X-CSE-ConnectionGUID: hQNeb98iT9Ow9lHck/Wu+g==
X-CSE-MsgGUID: YacXAAWLSRusUi5KvcmDvg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779170400"; 
   d="scan'208";a="57540305"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 06 Jul 2026 02:11:04 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Mon, 6 Jul 2026 13:40:56 +0530
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
Subject: [PATCH v2 4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700 compatible
Date: Mon,  6 Jul 2026 13:40:51 +0530
Message-Id: <20260706081055.1126275-5-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Jul 2026 08:10:56.0050 (UTC) FILETIME=[F8830920:01DD0D1E]

Document ESWIN EIC7700 SoC compatible for syscon registers.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index e22867088063..7d3365601249 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -62,6 +62,7 @@ select:
           - cirrus,ep7209-syscon3
           - cnxt,cx92755-uc
           - econet,en751221-chip-scu
+          - eswin,eic7700-syscfg
           - freecom,fsg-cs2-system-controller
           - fsl,imx93-aonmix-ns-syscfg
           - fsl,imx93-wakeupmix-syscfg
@@ -175,6 +176,7 @@ properties:
               - cirrus,ep7209-syscon3
               - cnxt,cx92755-uc
               - econet,en751221-chip-scu
+              - eswin,eic7700-syscfg
               - freecom,fsg-cs2-system-controller
               - fsl,imx93-aonmix-ns-syscfg
               - fsl,imx93-wakeupmix-syscfg
-- 
2.34.1

