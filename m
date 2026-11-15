Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730175;
	b=rNh14gKUxqk16FOpTpg2NQlhr0LTJHAMa976ptxIfuCzDFynUeYpAQVjovxgHogK0oDQ
	 n2d9xgMc9k9PxKDFWMtN9swCUYZLoCVu1LA4TWXMKcFAiSnnF1aSPUQDq97tKdlJNGyMR
	 gbn3bK2SGPQ0zgWt9tb8pWDd0QuMkPsegJkKoYhTHsIDMz8YBWEKBQhUbpyNDgxo6cTiL
	 3uuyquf7TymqUqSNTef6U3XPdtCc2dV7cOq4NiMM76o/jtoGofmU9UQLb8GkijACRqqhr
	 VFhaPTfhMef/+VLi5PcouLVrgqCLz1mONqhPFmPzM8XNCfj5nBaylwPp9jetUSQ1IkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730175;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-C1DE0DAB:X-C8649E89:X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=1Ge42m7xaVdNI0a6WHjvJypQfj93PjLMWOeIsusYNAs=;
	b=KriQj2txlXfpZM1+aP5A6sFv3wz/XYy+x4uLbzo+Ms+XUi5rWC4wMEraNJPJ5OJZLAEX
	 SAcE4Rry/fctayKo8SMYE63Y5Mrc89j/5+79cDwQ1tiJHucjy6Cu+NcaEci6of/J3XA30
	 9T5JssI3yln4FZrWRN1AEueevrzAuGmBxnvKozSt30m2TJgK7J9qxP3X8vyHsfM0FUmcK
	 yDPKmrmAlIQGo5rkPHDv1m0WB+h4Qv/s7EsnKovERumiZK0Mt1bQkFop2vBathsj/poDU
	 Q1Dy6APErv+aN0Z2j61czGd5yXZAJEaO8CJlhTIjRSMyg4hO0g4OyC7t6u8Lnt+ayVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b="ax/oS44w";
	arc=none smtp.remote-ip=89.221.237.175
Received: from send80.i.mail.ru (send80.i.mail.ru [89.221.237.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9839606A331;
	Sun, 15 Nov 2026 08:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9839606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=ax/oS44w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=1Ge42m7xaVdNI0a6WHjvJypQfj93PjLMWOeIsusYNAs=; t=1794730174; x=1794820174; 
	b=ax/oS44wbtmc4DGeMmkYV5GyxmnPAk6lBZKsqZUcrVhP8NoRw/jX/nVxqGVak55p9Bp6Y8eXe5V
	JdMypshEkWpbTx+hQza3RNlYwDRFe/JGD+HR+dCrBt2AcVwcGHli1cmKkAYxGbGnE1ssulGMctUB5
	0g4MBWi6Ew7DU++4lZG7jVPvQ0yh0F9Vf3NZzeuo38L8Oo6Rnk+DsBlQ8oO7CTIgnj+BXcOPZFSf3
	ofXVEn0JDIWh8/3XARc/oIMh2xwGtMAeikOQcwgiWmsvkLF87KW5YX6i+d7I+GjJx9Ejxtkd/JxC6
	NPMKwV5LsOvRto5j1Ji20PyLVEqDTgJ7vAFA==;
Received: by exim-smtp-f7c4f5855-pvjld with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xSVIk-000000007DM-24tF; Sun, 15 Nov 2026 11:09:26 +0300
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
	Michael Zavertkin <misha.zavertkin@mail.ru>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] dt-bindings: i2c: rtl9300: add 'rtl9607c-i2c'
Date: Sun, 15 Nov 2026 15:08:55 +0700
Message-ID: <c7b57529342608c59468aef247250aa8f017d5cf.1794728344.git.misha.zavertkin@mail.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794728344.git.misha.zavertkin@mail.ru>
References: <cover.1794728344.git.misha.zavertkin@mail.ru>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-f7c4f5855-pvjld; auth=pass smtp.auth=misha.zavertkin@mail.ru smtp.mailfrom=misha.zavertkin@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD93F98A09C3FD4AFA267E9C197542936F1D72816242C8E930F182A05F5380850406C9BB4FF38D8A5ED3DE06ABAFEAF6705D0458B6C56C4E67F2D3D455C7CCA3DF1F0D203FE66146AB1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FEAC828D2BF6EC3CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FF37B1FF54E2C7C48638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B23024475F5497F9E52E070BE324C7D3C458D56F9695DC95C8BB0A4F435E46E6718B35066C979671628AA50765F7900637F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C01A0BB1A02D89336B8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B67343888678D28C1476E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C0B02670E5FEECA50C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A55873B81980DA6B465002B1117B3ED696061D3E89353758DCED71F038FC046993823CB91A9FED034534781492E4B8EEAD9DB614F8F96CFA30C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6596A442881947969C200A4598BA8A02400574A1ECFFF198C21A6A0F1F029C9854CE350E27DCFB720D9B8341EE9D5BE9A0AC286D446ACDC1FDDB13C3BE5A31CE7B6C02557439C218EBD52EE4E5D9E54FDA4A7285BF96B6084FC8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWJlWF3x/5SjGl/VZul3y37o=
X-Mailru-Sender: FD65D7C492470CAE44AF3B5ACDA31542B549799C38C167E8CC811723C208B417509812F0892FF2D35EA261D0D613CA7FF767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok

Add realtek,rtl9607c-i2c compatible for RTL9607C SoC and mark
realtek,rtl9607-i2c as deprecated.

New compatible relies on pinctrl driver for correct pin assignment
instead of directly modifying IO_MODE register.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.55.0

