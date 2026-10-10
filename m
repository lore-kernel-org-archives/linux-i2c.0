Received: from send147.i.mail.ru (send147.i.mail.ru [89.221.237.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F637E5E1;
	Sat, 10 Oct 2026 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613690; cv=none; b=Vnz9ZWGQQkCzMMqMfVjTj/stMcNzSnwBGWLUAVNblHGCxkwbM8Vt5lzd4eqgnsI05L4Uaj7ZeoTvn1Cs6Qpmt5sEEUXfjJAScV/sjcQMAy8K4qig1Seqw6U84ve3L+928aHtgaq1/A8drNt+D3t+V9+z7BxODyhL+5kazyskkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613690; c=relaxed/simple;
	bh=baPPqtpYIDmrzDvHdcyGSX6hcmsdWOrgaxEvIhel5cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppQUqeomaQWWMRVi2O5wJ4qSIZ2rX/WACFNCPJ6ofkQq0DtsQk/XhEOg+EFB22lvRpG9qY9poJLBABjqC4cmU7fybW6Jdk361rF7EsWlNbDX4FMZ6Fqto8WYDkx5zO/4UEG25Rliovj4k1TdCigq0YPwcDY5G06Oku+tbDdA6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=xcgdZ4lZ; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=gujqBo4I; arc=none smtp.client-ip=89.221.237.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="xcgdZ4lZ";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="gujqBo4I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=1ai1vpYmFjiePFX6ZH7+RbdUVG6h1zia02eA19AzDIg=; t=1791613687; x=1791703687; 
	b=xcgdZ4lZYGm/gDRG2GHovDlU60/3K1H8yBMaFjzD27l7wu1pHGLBEw0h6ghjubQkDiCd/sdOnew
	5FTXkbC9UXIdf9ksxozkmaDWtA9CKeDmn9F45tcnoIGUrb0a+kvMc1VLNA5+CQ34MtVlRnEpnJZCr
	SEMS/gR9gml+9z4MCNijqgvpOHp6PilICLGsJt0qQi/qfV4LxstJuMvpXgbbfqy2BK5doxe3UhRje
	35m4Z70oYxPHAJs4lUawmrhixRpk2gg/oQ+ViMtt2QLyItAgpIvydk08UorBlLL32rosPRhcpD62W
	9mL3oRUbl92mcnh2/GbcApGx05z8e2Ln4BpA==;
Received: from [10.113.137.228] (port=58038 helo=send149.i.mail.ru)
	by exim-fallback-544d9fbb4-7mfp5 with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1xFQKF-0000000051y-2iW8; Sat, 10 Oct 2026 09:12:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=1ai1vpYmFjiePFX6ZH7+RbdUVG6h1zia02eA19AzDIg=; t=1791612775; x=1791702775; 
	b=gujqBo4IUvpmFszeEf9PWhIuXqK/dNH0xbiYxa3N7K/jpo0VeKqHNcQg0S3PtnmxyIDXDDojsJ6
	BjVWPTxFVuqGjkbbAmZs2mEYMDgadgJUuym8wdacQaSPcWL2ToSbuYRJOvsgqVCZuS7sF1xXo7cRd
	N/e28xmiVv9WPUfQMGf5i2W9nOTgwO0TxNoWg6fE44Sm9GsJEYIMRMde9xP6hxwFQ0vecyjR27V14
	RnXcUuR2QY3a5klGctO5KIZThg223OrNY3uUhnpZLUuOflfumBaBUC4dvaniSSdoKIi4Zx/Z7gWxF
	Zq67e7+DERWQ+q55t9RDR90rA6ThD9K0NZEA==;
Received: by exim-smtp-84d6fb566c-25dnp with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xFQK5-00000000O2J-12bD; Sat, 10 Oct 2026 09:12:45 +0300
From: Michael Zavertkin <misha.zavertkin@mail.ru>
To: linux-i2c@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zavertkin <misha.zavertkin@mail.ru>
Subject: [PATCH v2 2/2] dt-bindings: i2c: rtl9300: add 'rtl9607c-i2c'
Date: Sat, 10 Oct 2026 13:12:10 +0700
Message-ID: <9a95cfb2f09ec69af02d51d6a71e4f1a7e42cc4e.1791611999.git.misha.zavertkin@mail.ru>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791611999.git.misha.zavertkin@mail.ru>
References: <cover.1791611999.git.misha.zavertkin@mail.ru>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9A0706A514393B94563A9958F92DA4B87945D44F36EE26CCF182A05F5380850404C228DA9ACA6FE27172A2F15078958A73DE06ABAFEAF670574005687BBC3F059135CE729D64840978221C18B3D1622A4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BC08626EA5717D14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BFD6B3F1638522B88638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2B006FC27486ACA0B2E070BE324C7D3C4F00347D09F270839BB0A4F435E46E6718B35066C979671628AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9D5E8D9A59859A8B6F7EC8CC465A83DA3CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C028765F5520A300B2B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BD198C2A7CB645D0575ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5D4CCFB6D5F88FD345002B1117B3ED696EFEAD335FFC1978C3E67C18142C611B73610D81D389A125CDE35189EBF2DEA281E618B5D5F965AFD68BB0711B762D62E6A186E92D2455F13F20B3497AE2BACCE227B31BD05E65941F1165EFABA1780A6C79554A2A7244132F0C003246764559E58C12E6D310A6D535613D04DEA810176A71A35648BE338CE9510FB958DCE06DB58C12E6D310A6D53A16EC4B4EECACEB3
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659F7F32B9686779F2257C4CA5D10708C1E54A0F262BA33CF1116B8E3C64E1AB659DBD6D31A32CDBFEDB8341EE9D5BE9A0A7A977AFC745A152A0042E7F08D7CC598D0E3CE3DC388A63C52EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWKDWV3nCAgVbm5/lFOSIJYM=
X-Mailru-Sender: FD65D7C492470CAE23E6ABD178607DBC638EAB5EFB9BC4DBB951B70A5BD4BD8EDDE1C7E4DE8D307C134B2017C7F24A7E4B2A3C715BC1DED96EFAE8183A2EAE0D96DD28E056F58A23E3C55DE776B662A1DD77B849F69637CB3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B45D890D6ED435465245273A4B0F9DCCB491371931A16F820E68F3CF0E9FE49B69EDC4A72BC36E27D4C31BB23B05CC72DA4607604D0A28AEDA08EA13DD9CFF2E155D86DD3A8CD90C69
X-7FA49CB5: 0D63561A33F958A5844ED49A4379E7ED5002B1117B3ED696ACE53EE2B4FEB42C801339A757AB1A5B02ED4CEA229C1FA827C277FBC8AE2E8B8B853497FB30D3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8ax2PRtUjIWmf3mBhiq91jww=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

Add realtek,rtl9607c-i2c compatible for RTL9607C SoC and mark
realtek,rtl9607-i2c as deprecated.

New compatible relies on pinctrl driver for correct pin assignment
instead of directly modifying IO_MODE register.

Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
---
 .../bindings/i2c/realtek,rtl9301-i2c.yaml     | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index 5873cfdc5b3e..7c00918f33c8 100644
--- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -36,7 +36,11 @@ properties:
       - enum:
           - realtek,rtl9301-i2c
           - realtek,rtl9310-i2c
-          - realtek,rtl9607-i2c
+          - realtek,rtl9607c-i2c
+      - const: realtek,rtl9607-i2c
+        deprecated: true
+        description: >
+          Use 'realtek,rtl9607c-i2c' instead
 
   reg:
     items:
@@ -57,6 +61,10 @@ properties:
   clocks:
     maxItems: 1
 
+  pinctrl-0: true
+
+  pinctrl-names: true
+
 patternProperties:
   '^i2c@[0-9ab]$':
     $ref: /schemas/i2c/i2c-controller.yaml
@@ -96,6 +104,16 @@ allOf:
       required:
         - realtek,scl
         - clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,rtl9607c-i2c
+    then:
+      required:
+        - clocks
+        - pinctrl-0
+        - pinctrl-names
 
 required:
   - compatible
-- 
2.54.0

