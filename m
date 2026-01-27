Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0758B274FE3;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547845; cv=none; b=M0nw+h//gqRoqFfGvmcLgMaWgdAc40LE2VYfQozZjxyY/BfRs3srkP+H67sW5R78GGPxbKpczNukP1ZZA7/EP+5VwmiXZtqZroTftyybtaYv5Fv28SD5MvqTf4CQjfFzpg5Lxqhs4ceW/TQNb3IOZ+/odJmOOx5TOUqo5dcK0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547845; c=relaxed/simple;
	bh=2f258ZKMGjMDX6rVeyYTKnl8hXsCenCR77UWDe3H8b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rsnl/pkZaqysy6GSR2tEjt5+9y/EqKpNxsGCOzP9sg95Kh81qd6iwvLuAfOMGWc+VE2x4M0LT+jK/KgH3eScVxtIWip3Mk9819sX/zox4iKbbHd5CIosuUpkSQn95c3bGO4UGZHBbLOG3Le8EoINaGYmS/nIAfSJqMFmc8wlB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+N9NKKW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+N9NKKW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A026EC2BC87;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547844;
	bh=2f258ZKMGjMDX6rVeyYTKnl8hXsCenCR77UWDe3H8b8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p+N9NKKWL+cxS6luMRys+V2zGZago5/o/xnC2XxtwYcTUUaL2LN30OxxK8aaaqgeg
	 AQT2n+47rGDlz3ZhvFceYlL5hf6c0/82Uf8WIWT281kKlV2smdizdE31K8tJajSqy2
	 PrMR56heVIzOYbUMmJOdtCXjTAK6/DzTAqTm/ntl34jl4cIMzB3vHMJocKaFdObVKc
	 rQhpCh+bnpAEjdNNyLs8a5xIxLUS5H691LE+myMrLfVU9BiqzeR3snbZ+1dX1x1bNQ
	 wMExWqoI+BceO+D6OgWnJASUjvYKTeHw9VX+lLK3/3A6njhvbHbKMsJUq7howS9KGe
	 qrOtG4ja4FH5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919AFD2FED9;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Tue, 27 Jan 2026 21:03:55 +0000
Subject: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
In-Reply-To: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769547843; l=759;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=Jp8L32rGkddXyWP1kCRtOWV6Txgpa0+B9TbjL9V4o78=;
 b=u1JsuQG6Ngsrd05YJZA+2pdIjEIfAGdmj2WXnu48Z6ITIo+Hh2iL+m05kDLxkG7cwOBA1vGBk
 I6GaIzZE4xDDKR18UK7oEOuDBzvE3o8QBxTX0ojRs1UnNdigFm7Llq4
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The xiic driver is designed to operate without explicit clock configuration
when clocks are not specified in the firmware.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
index 658ae92fa86d..cc500130f41f 100644
--- a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
@@ -43,7 +43,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
 
 unevaluatedProperties: false
 

-- 
2.52.0


