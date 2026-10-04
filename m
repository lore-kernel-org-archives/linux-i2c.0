Received: from send288.i.mail.ru (send288.i.mail.ru [95.163.59.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB2359A90;
	Sun,  4 Oct 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128030; cv=none; b=n/VOICDMe7Yzm6CK/6SYyVna6ETtKGP8rzjtU1fImA/snjrlmu4RZ+iFo/p/F+1hJ8wajTcLdcisg1f0xJS1MHaelxikk+NKbNlJ9OgiKFvcTEx432b4Qt3+SQr3+dF14Yt3fwulhOYVEjc2xsuia/Xvq/mqUFK9JOwnrbYb/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128030; c=relaxed/simple;
	bh=1+Dg/pOJxmvxiZ3oanwyQsd1dS7R9tnvuCPy/GkF4GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFmbhtvHo3h5ZtL6ZfQe3R0goZ3AEOG/Eb/ghlav1UGdwbDyIqf1CQ7O3u3oACft8guxvBjaPw7B4AZCqazM5hO1T3eyz2iWZ9g7O7BoEWjrfpF+EZVcDpdPlxIwIQ5GlT4qEX2e3x5prIycACM7P+XuhkvV++MTAmGyIkD4UaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=k3QiXpBd; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=h19betpm; arc=none smtp.client-ip=95.163.59.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="k3QiXpBd";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="h19betpm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Kj2Q+sFXAaAnYe0up0vGPZ6BVxDgFo6inMTsXEk6pLY=; t=1791128025; x=1791218025; 
	b=k3QiXpBdL9L4T7giWNivuiSiPzw/zyvacPTWsu3HaL9dVCdGNrFS/P/T3cO6DEYqRT1aaoHF4M5
	fGSxTfy90h7kWKAhnZ26iF5AdKHpNsAC6vJSd57gzo3Bb/Oef7sHWz/c1w3BJS98PUGs30jsLA8cD
	bC4StDzyEfK8cvFYRYhKGdfYDJ1JdK12MEMvNLmvIB1S+tmO7jHaLHWWMlyjiVab9yVDRDfPc65zi
	RoSlIf3EPI0ALLGecabX0Bjipm5ERT0SD0aASOi/+N5I3vnCp/Cw4SQLQgGroIgOtqw2GRl3B6zo4
	4UErSvNiTDZ6Ker6F9cqjZTP6tIHzbtWHO0Q==;
Received: from [10.113.139.187] (port=38388 helo=send81.i.mail.ru)
	by exim-fallback-6df9d4c65f-6lgvw with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDODc-000000005OZ-2CPy; Sun, 04 Oct 2026 18:33:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Kj2Q+sFXAaAnYe0up0vGPZ6BVxDgFo6inMTsXEk6pLY=; t=1791128020; x=1791218020; 
	b=h19betpm4FySVfAgtQaag6Fl29pR9a2DmMJnwcOsAjygs4i33Hi5QpTI72kYnrg37Y36K5YPNFU
	20uAJbVfAZoZUQQyHNKWzjdT8hgBXL7SbLcnJ8OFzBC98AVPvRKc1uw3/rhaAIny1BEmB7+ANpfLE
	a6l9/R9ZM7/jdi9/ERO4pmpqv1u2N0yyGACXch2hpb4hlMWLBV+Q7i0LewTr10tvrJVcAhVmqRsVx
	JAzznsYx7+9NGD5wpyvqwDtmbhBW8Lfsd7kx8Of0igMtIhpmvCwZXTAl98EhbL7YcyVkdJFyqdHoW
	zNdDkA+E+qCGV2bSzAymRYYaoIR61gTojsEw==;
Received: by exim-smtp-5bd9c49696-bmqdg with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDODQ-00000000X5s-28yx; Sun, 04 Oct 2026 18:33:29 +0300
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
Subject: [PATCH 2/2] dt-bindings: i2c: rtl9300: add pinctrl
Date: Sun,  4 Oct 2026 22:32:35 +0700
Message-ID: <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791127538.git.misha.zavertkin@mail.ru>
References: <cover.1791127538.git.misha.zavertkin@mail.ru>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD916CE66F793C04802C937705057FAC64C8D095010D03BA95E00894C459B0CD1B9C0D2B691D61249AE7A388D641E84891FCA857CEC9940C89A61BFB344AEEE8BF308E1323863CD3BC3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72E4E5201E1C2E308EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DEEC83A7CF8598608638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B27935B1CABBCDF5BF2E070BE324C7D3C45D781E9EED398090BB0A4F435E46E6718B35066C979671628AA50765F7900637F924B32C592EA89F389733CBF5DBD5E9D5E8D9A59859A8B6FF43116A1C2F940DCC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C0BF77E1FFDBD4BA85CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6753C3A5E0A5AB5B7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A51DE1FD318F50973D5002B1117B3ED696E3327B04C8B0B4144A0A47EBA01A636A823CB91A9FED034534781492E4B8EEAD5DF1C2DF01CE7211C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659B7AA2CAD798B2477ECB3F903222E30FB5BDF483BC98E9433FE868A726225468710DEAFCD2EC19842B8341EE9D5BE9A0AD5A82FB10B0727CEC11916FD745A984D644A146FDC5ACD1052EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWGLFSMbYFIZdOphDQ8QPJMA=
X-Mailru-Sender: FD65D7C492470CAEE010D97EE9FDA1EF30A43CBF52B51200A4C2FF93DD6D44FAFBEE072C978D3699665B2B62676F92C7F767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B400464DA02507E70B0546FCE11372492E55863E2B7114EDB0049FFFDB7839CE9E920F40F1183B4710B205C9BACD9E5B032D5B7D26EB7E2AAEB7F9DE3B8DE5A35DB2C51EA428EF7ABA
X-7FA49CB5: 0D63561A33F958A5BD9631BF0D162C665002B1117B3ED69693F36BA8B8AB64158E3074072ED0045E02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a/xwH01AMJknzm8p7tOIojE=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

For RTL9607C driver used to configure IO_MODE register. This register is
global and is a scope of pinctrl driver (either pinctrl-single or WIP
driver for SoC).

Drop realtek,scl requirement for that SoC and require pinctrl instead.

Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
---
 .../devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index 5873cfdc5b3e..ad143509aa42 100644
--- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -57,6 +57,10 @@ properties:
   clocks:
     maxItems: 1
 
+  pinctrl-0: true
+
+  pinctrl-names: true
+
 patternProperties:
   '^i2c@[0-9ab]$':
     $ref: /schemas/i2c/i2c-controller.yaml
@@ -94,8 +98,9 @@ allOf:
             const: realtek,rtl9607-i2c
     then:
       required:
-        - realtek,scl
         - clocks
+        - pinctrl-0
+        - pinctrl-names
 
 required:
   - compatible
-- 
2.54.0

