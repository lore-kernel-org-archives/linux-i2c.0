Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730172;
	b=5kYG2aNmLNa+dcajsDOl9uM+fO9beFE6ByBzH2lml/ld9wUX57tOJ319ZpWq5WJDblap
	 pyn+SoEsRntPdPoYkLS9aodieH/yLcOHIyR44xxVur4rvvWFzjHcYYtw12DFJb09op0XO
	 bnHJJ7gAy/GRf1Dkf8CAs8CxobfURCyT8tNh/P/tA82MoBekuMTaDhifbxCTtrtFoM3YP
	 phM7GOUr49UCEKjZ0vvTd+dgmKGkekjbRU5hYq6EuAhb9rVcQE8Vt2/ypMmzxzyyfEGJ+
	 HtJ6SsS7o849oyFmdnVDb3OowRbfW+1q2IP/zWWALAv5anPN2dqyLwXb37nljY8pV3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730172;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-C1DE0DAB:X-C8649E89:X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=4DMNu+zZJu014dWJwS8ga7RyCPClm5EMOFsEhE6v4e0=;
	b=Zv2XN9r6KOKD1mdVUYD90oq1HNEDpVadnKs81O31/5AXpnwIHOcdsysr4ZqEavwGH3fR
	 ALi2u7IlM2CXXXlQA9sNa/7JXXn2ANdyM5VCCcwbshZ4co9NUg4hY1WV3zK4+DV5ODIH1
	 e0mG7vyv6RPWkFTCgXT5vv5bi91JNp1k7/YgI4597ET3TPrZ8TO6f3YJjAnGF7kO/C+ZE
	 s16gVcxzSd4wlyWDrFkgak3ZF931PAy4ygIWuwn1XKXziiJCua9niPPtHYqdz0IknvnAV
	 j01p2vZUYGk9GiSOZOkRrTvluUhEN01QjiBUChZwXsn9tH1FL8Pfzgw+wYlgtC5C1bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=T+M+6rzd;
	arc=none smtp.remote-ip=89.221.237.154
Received: from send59.i.mail.ru (send59.i.mail.ru [89.221.237.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA49606A329;
	Sun, 15 Nov 2026 08:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA49606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=T+M+6rzd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=4DMNu+zZJu014dWJwS8ga7RyCPClm5EMOFsEhE6v4e0=; t=1794730171; x=1794820171; 
	b=T+M+6rzdbf6Syh3xMxa/Rwu/KFfO2iXbwYguEvDhVFihCBUBGyQGpI78sjKZS7PiRuIllCQYcSD
	+e0ncmxI2NbhwcU6rKTTe9kTM2M/Jmx6WH/vBXjxcVbHe29fEPaSCJUc4IMhEWzyI0dSLn1RrhWNE
	wM+8BWDU/32aQqcwOV37nz1Sd5yrKaY9JPBxBwh2ejbm6MWY1GSlbs6Ev7OKHndBCkYV/seQ1QTMW
	Ss0b9WHOhTq2DqNkNzC6X3Ny/TC+mvz6K8Lf8ADjpkox4vTLQfLVBBSldZmReX4d4tJUabTnGhiZh
	z4d8sQTvFXXOK+o+ME8t/51IaAS0yrJIx+Wg==;
Received: by exim-smtp-canary-10-844c8fc8c7-wvbxd with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xSVIh-00000000Nd7-1uGp; Sun, 15 Nov 2026 11:09:23 +0300
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
Subject: [PATCH v3 1/2] i2c: rtl9300: add realtek,rtl9607c-i2c compatible
Date: Sun, 15 Nov 2026 15:08:54 +0700
Message-ID: <3012533a43fd32d1c526e5a90385457f8b46f111.1794728344.git.misha.zavertkin@mail.ru>
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
Authentication-Results: exim-smtp-canary-10-844c8fc8c7-wvbxd; auth=pass smtp.auth=misha.zavertkin@mail.ru smtp.mailfrom=misha.zavertkin@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD93F98A09C3FD4AFA267E9C197542936F1D72816242C8E930F182A05F538085040486696E6EA9CE6A83DE06ABAFEAF6705871AC31A245F945F2D3D455C7CCA3DF1B939BEC6D9612482
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AED985C8E545F588EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F28F4AF03526AA8F8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2032D0CEA763FFAD32E070BE324C7D3C4E6AD3CB6CAE017FBBB0A4F435E46E6718B35066C979671628AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9D5E8D9A59859A8B62B7ABF3321926E07CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C0CCA08DC4F53F8CD1CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B67899CB738160EFA0089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A56C826C03668A64535002B1117B3ED6968795445F64BC9AC98D59E407A97E9958823CB91A9FED034534781492E4B8EEADEEA082C9A12FE455C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659E86BFE6EF337F57692B4AE3FA24244259438892C293E82947809D27D96408ECE4F4AAB18A5DC1D6DB8341EE9D5BE9A0AC8EF0EF4D127450221A060B3207E88920085755F7A009B4E52EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWJlWF3x/5SjG3KofJT2Itw4=
X-Mailru-Sender: FD65D7C492470CAE44AF3B5ACDA31542B549799C38C167E8E693A2F4CD4B1000B0BACEB96EA8D8D8100CBC36EE59ED45F767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok

RTL9607C was already supported by realtek,rtl9607-i2c, which is
confusing, because there are another SoCs such as RTL9607F, RTL9607
(without letter) and a few more. So more correct compatible was added.

New compatible doesn't use IO_MODE_EN register, leaving it to pinctrl
driver. Old one left for backward compatibility.

Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
---
 drivers/i2c/busses/i2c-rtl9300.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index a9dd85a286d4..ae20fbdc307a 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -200,10 +200,12 @@ static int rtl9607_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
 	if (ret)
 		return ret;
 
-	drv_data = device_get_match_data(i2c->dev);
-	ret = drv_data->select_scl(i2c, i2c->scl_num);
-	if (ret)
-		return ret;
+	if (device_is_compatible(i2c->dev, "realtek,rtl9607-i2c")) {
+		drv_data = device_get_match_data(i2c->dev);
+		ret = drv_data->select_scl(i2c, i2c->scl_num);
+		if (ret)
+			return ret;
+	}
 
 	i2c->sda_num = chan->sda_num;
 	return 0;
@@ -494,6 +496,10 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
 		scl_num = 0;
 	i2c->scl_num = (u8)scl_num;
 
+	if (device_is_compatible(i2c->dev, "realtek,rtl9607-i2c"))
+		dev_warn(dev, "Compatible 'realtek,rtl9607-i2c' is deprecated. "
+			      "Use 'realtek,rtl9607c-i2c' instead\n");
+
 	platform_set_drvdata(pdev, i2c);
 
 	drv_data = device_get_match_data(i2c->dev);
@@ -652,6 +658,7 @@ static const struct of_device_id i2c_rtl9300_dt_ids[] = {
 	{ .compatible = "realtek,rtl9312-i2c", .data = (void *) &rtl9310_i2c_drv_data },
 	{ .compatible = "realtek,rtl9313-i2c", .data = (void *) &rtl9310_i2c_drv_data },
 	{ .compatible = "realtek,rtl9607-i2c", .data = (void *) &rtl9607_i2c_drv_data },
+	{ .compatible = "realtek,rtl9607c-i2c", .data = (void *) &rtl9607_i2c_drv_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, i2c_rtl9300_dt_ids);
-- 
2.55.0

