Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1E37473D
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994221; cv=none; b=ZoRl7d9irVQ0khpvr/lEAoHCuQOEKdFAjfGozgGyWueziwAlA0PF366quAgXsFklydDtNTMfCs3S33SdRZV9YAylmoQ2MOymEwhuWEo3oqm3v2bG5ZfSgMCvv6Ui/XHThq7uAGmszKvs/MyDa7qgAO4EofCrOmwiQCK+6gUO8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994221; c=relaxed/simple;
	bh=OOBMl6N+6wWq4VI/kMem7gKFfbgc3xAME32xiW5QX+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdzbCextdzhdhy6D1e8xa1qLBVzRH0PUuCLePOj2PGmQhgNiexX+1BmKm+7NLNajs5BPOuIKoWU3MQWWOKzKKixQUOfG+jUgMb35VrRYSmrl5vFDMB7TYt7z90NPs2dFUnUgWp+D8mbiRQxLN7BT6pjq0fsRA6RIGc/NB3Z3GCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4fLtUZSh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4fLtUZSh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b93698bb57aso346240066b.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773994218; x=1774599018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xz0m8rU9A280bToU8IuILL5Mw5gJnGqIrAD0/ydeaXM=;
        b=4fLtUZShdAuIn9+mW2e/IYierHJgZA97eTd/3tmFFEmhLgZSfTYDHArmzx1JBZdzi9
         cKrXgmNwG/muGDMFYKeecZXsP9a9yjBvvLbIQOdv/sEqFpesqwcoGPDm7HwonxNF+bpg
         cLDZMR+tZ/bT2fdUQx1Jjiyk3nsl2pCT3YbAWVL9mKO7uFeokS3ShmA10TK0aGs2pskH
         e00BtKk74/gv6c+Z8p1xJj8x/oU80MhUH+anagd62XdHvodaDN8s/2NO26q8XOPy63BP
         zl2qdDzkSoBI+sKPzsKTX95dun5JZeXfDBiN+Sy6/5V42m8HjUoaFzJh4dKsX3gE+qJ9
         oZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994218; x=1774599018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xz0m8rU9A280bToU8IuILL5Mw5gJnGqIrAD0/ydeaXM=;
        b=OUGzX18QsZQmIlnqfQK54TXrzVni2+p7b6clB+x3R1YIsVz3SexiY9AhjZCSfHMOHv
         6Bur4fCbBLVBZgA0jnP5d9zGZG5LcicB2peggMLgbwXVKytQ93o5CpG0t0uCjPcN3LgU
         Jm4+BuOXOR+WLH70BmIpHGjKVD3a4Za1lg+TJWI6ciMsYSWvKwAy/ouJH45Bb8d1APjF
         vgpVcu9Jfg8oQpSqM+ml1K7eH+nQDOIqC8neXrDlNbGIU14uxsGI0rNITSg4MxqYgvnK
         ek0+MDQm7zaGmw35OXUOnEKTpdgZmfL2+MwnHCdrcVEe/zzftufa7TkJGqF8g4ZHalxg
         +UQw==
X-Forwarded-Encrypted: i=1; AJvYcCXy9M4Aq8xQBjFLZrBIzPBnUooeliczENgCU3tgmpeZjKD+Dn/SDAcZfzvBM9fwvjG41Y47pEikToo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhASaB4T/GaciBcakiuazYE7/nKHNN2fDcK3jh9SjT0cVsOgBj
	moJdCg6N4lvP+KT3sRwsnNNHFadrL4Mq/1H1LX0MFowSa0raAUmQN9wMvu6ck/e6Wis=
X-Gm-Gg: ATEYQzxXhjhjxyb2u3UCzF1gPTV+KlZ1iXEa2WngHgqguRbVHCGaFUqAk7VZwShGWrM
	1+8sXAAwl9mEPobXgPA8YLvhSju9HmOM7ftnIKhQhBsKlDlRQaDKB/5PJWtX8ldEZuzmp32Csv6
	FwaE4HIMU3MIQPpbhT1P5rGuLoiaq1DfjGhRu+/D+TmgeLigMe41UHifBwJY1Bx2bGw1e9S5wKX
	frYJarZNB2MAchTKfYhohtjvGsqF604yIRnNEyw05T1+aK6Zi71kcUXib2B9dRSn+ydVrlj8iQT
	MchW6m2tSDqhiTYpwJTUqQrKQSPvhLZs9tczkxsdQcoZ5O17u76gAK9X+ebzV5Wkwyx2A/hs3V9
	3Hcicc7fHWcwyI7efH0JCWT75Ow+Ug5DvY6a8k6oQu1H1Hgta0D+73mjQFPiCa4oG+lNW8HTNp1
	RzBxalIGs4kltDOxWnY1ypRIFZ4w80Ae+pdNbWPSQTXgNsgeLyf4rwLSLMVJWy28hrRM+Dj1uCB
	yZ5rw==
X-Received: by 2002:a17:906:37cb:b0:b97:f2cc:8c3e with SMTP id a640c23a62f3a-b982f39b197mr103173666b.10.1773994218017;
        Fri, 20 Mar 2026 01:10:18 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43b5csm121016466b.1.2026.03.20.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 01:10:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Mar 2026 09:09:51 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add camera
 EEPROMs on CCI busses
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-milos-cci-v2-3-1947fc83f756@fairphone.com>
References: <20260320-milos-cci-v2-0-1947fc83f756@fairphone.com>
In-Reply-To: <20260320-milos-cci-v2-0-1947fc83f756@fairphone.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773994215; l=1724;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=OOBMl6N+6wWq4VI/kMem7gKFfbgc3xAME32xiW5QX+Q=;
 b=PtK07MSBbaUBbhPt07Jp3YhUm43bkaj9J/cjajCZxkqEJDLGAMbgkavtMBPQ1xvpFsBgidmXv
 HN6LoKa4+BNDhiBU8v5dt3YQbHIyzADJhP4OPy9KuTy9VDJdlU4XbqT
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Enable the CCI I2C busses and add nodes for the EEPROMs found on the
camera that are connected there.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index bba327cc7a38..3e65f5deb5a6 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -541,6 +541,56 @@ vreg_l11f: ldo11 {
 	};
 };
 
+&cci0 {
+	status = "okay";
+};
+
+&cci0_i2c0 {
+	/* Main cam: Sony IMX896 @ 0x1a */
+
+	eeprom@50 {
+		compatible = "puya,p24c128f", "atmel,24c128";
+		reg = <0x50>;
+		vcc-supply = <&vreg_l6p>;
+		read-only;
+	};
+
+	/* Dongwoon DW9784 VCM/OIS @ 0x72 */
+};
+
+
+&cci0_i2c1 {
+	/* Awinic AW86017 VCM @ 0x0c */
+	/* UW cam: OmniVision OV13B10 @ 0x36 */
+
+	eeprom@52 {
+		compatible = "puya,p24c128f", "atmel,24c128";
+		reg = <0x52>;
+		vcc-supply = <&vreg_l6p>;
+		read-only;
+	};
+};
+
+&cci1 {
+	/* cci1_i2c0 is not used for CCI */
+	pinctrl-0 = <&cci1_1_default>;
+	pinctrl-1 = <&cci1_1_sleep>;
+
+	status = "okay";
+};
+
+&cci1_i2c1 {
+	/* Awinic AW86016 VCM @ 0x0c */
+	/* Front cam: Samsung S5KKD1 @ 0x3d */
+
+	eeprom@51 {
+		compatible = "puya,p24c128f", "atmel,24c128";
+		reg = <0x51>;
+		vcc-supply = <&vreg_l6p>;
+		read-only;
+	};
+};
+
 &gcc {
 	protected-clocks = <GCC_PCIE_1_AUX_CLK>, <GCC_PCIE_1_AUX_CLK_SRC>,
 			   <GCC_PCIE_1_CFG_AHB_CLK>, <GCC_PCIE_1_MSTR_AXI_CLK>,

-- 
2.53.0

