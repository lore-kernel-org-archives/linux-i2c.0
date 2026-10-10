Received: from send262.i.mail.ru (send262.i.mail.ru [95.163.59.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4E14A60F;
	Sat, 10 Oct 2026 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613680; cv=none; b=VFqAyCOawWm9cxkuoaQfMZM5S5zvKyv4ZtpijIzo2xYGZfZ/sBjnqtSOpT1XEM4EN0sOabr+D32L33tF82Kq6CS93Yp0WnXpco+JlUJ3EZgsCc1GkXWrzq3vrGap5bJYy4MHKI6Pa05VvL3eFGqUPwoYcyZSq7h7wpqf/CuwHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613680; c=relaxed/simple;
	bh=DJFWa2xLbHCnhJQKmoISVvct/sXJnm45rEFXzhtrSSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDwVNnuum1niaUpNC6T88NYquKYfPgwnFN8EjMUDZq4sA8Uk2u85l5HbWaptYLM6jQ3ydLfrHZ9uqgZLS8EZ4sodtraAAMKC1rwFNdiJNJEW3Hn1HTxZqO0V76inIhS9Z/PdAFhldf5id5IH5pe6B7z4vz+I/6+UUTWF6kRA1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=vNgH8CEq; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=oBj3VdRZ; arc=none smtp.client-ip=95.163.59.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="vNgH8CEq";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="oBj3VdRZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=vikzqNTMvp60HYZg4LXDHHYJAfDcqZ+BIwx2GDqOw1E=; t=1791613677; x=1791703677; 
	b=vNgH8CEqyoZh+tE+4cSvog6ZE0bSu08UT+/NPosRApJ/duAfi+hysiJtHZBdUOglgyxPvtNTUEg
	P2NUCum7gK3ehRcPVNvuwB4EH6RzmANI0AFVf17LPc0WwGzJn9VbRaSUXby45SEPvZZN+ZR/6SR//
	dsO2hASekkJfFVbJE2wPOqlBwzN6aQJNlwQf2UYcLKUMUnM9HWp4yeN9fcPoj+akr5ksrMWerZCtd
	RxYbCvnhL4srD3oOpbdAaBhEQRoEsKw1tNm8ZbYlpMjB2fJ5J69+GrjS1d/XjafhCfZIDc/0NtMvN
	Ir6/FXvhdJOXSQ00pluqS8L0sKXCsrGcZF4g==;
Received: from [10.113.230.49] (port=45690 helo=send278.i.mail.ru)
	by exim-fallback-544d9fbb4-wpp9d with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1xFQK5-00000000BYI-39IE; Sat, 10 Oct 2026 09:12:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=vikzqNTMvp60HYZg4LXDHHYJAfDcqZ+BIwx2GDqOw1E=; t=1791612765; x=1791702765; 
	b=oBj3VdRZn+AngLeaKbiSmXuI4e27cTOh/8xnlCxJYR4zWKo8LPujE0WJ5D11CudSPGr8bybp2wJ
	ZwZoRuRNzGiPk6+GMgF+PizPJcmh0leaHQP7DCF7xg8gRELwVLhObe6MXVZzGpUpPmABjI8/GIwMq
	A961r+iDYg6sDqMdHq8+xAib/lEQxjk67k2B6PKKw3cJtzEJwml9U3umY2go43zd0Ts5cWuxygJOX
	4CqERWwvdZqZeiHMvwhOX1t2EfViuss+EAXsTLe6uwTCKJRiZ8uLOcy1F/eVyXqRPmtetX51sjChB
	P0L8nl45Cv6esqg3P/AVbHlX1EWLuV7qDVYQ==;
Received: by exim-smtp-84d6fb566c-g6vwg with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xFQJv-00000000QI8-0qsb; Sat, 10 Oct 2026 09:12:35 +0300
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
Subject: [PATCH v2 1/2] i2c: rtl9300: add realtek,rtl9607c-i2c compatible
Date: Sat, 10 Oct 2026 13:12:09 +0700
Message-ID: <e7186b18caf58f2fefa61093921805d5dc045e07.1791611999.git.misha.zavertkin@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD968B159B7CE59A0BE99D5F922DE1F30F91D2ABBA517F25BE1182A05F5380850401C91B48FC7D1BDBD3DE06ABAFEAF67058FE6B9431FBF0F69135CE729D648409797FFBCB1194FBF86
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77E216A0E97507353EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637ECAF4C2CEE0D0B2F8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2C790573B727A14A82E070BE324C7D3C46AF66719B6D68F91BB0A4F435E46E6718B35066C979671628AA50765F7900637BA939FD1B3BAB99B389733CBF5DBD5E9D5E8D9A59859A8B631C0090ACECF247DCC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C0E45489B29CB19804B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B29DCAEE16903B69E75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5DCE185BD4DF83AC35002B1117B3ED6962113ED899F05EB96361FAC1196A180DE823CB91A9FED034534781492E4B8EEAD3CCD70CEBBF18A22C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65938DB9D76F5D560E10ED2081391057E0358AF17487AC96324158EF8F11652BC9EF41183B5E7F571FEB8341EE9D5BE9A0AA60314B835B1EC4F105042052E88BCFB5C066A707D2F90E052EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWKuWPAQkIR1ym5/lFOSIJYM=
X-Mailru-Sender: FD65D7C492470CAE23E6ABD178607DBCA456EA84EF7D1ADFB951B70A5BD4BD8E56FC6370C135ABD87DB34D8E89655EEB4B2A3C715BC1DED96EFAE8183A2EAE0D96DD28E056F58A23E3C55DE776B662A1DD77B849F69637CB3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B45D890D6ED43546529BF35145A2DB086E7D61F9AA269937FD68F3CF0E9FE49B69EDC4A72BC36E27D4D776607EF3C56C79DDC51F0E98FA897C5F62C6B133D4B0A3C4C2948F175DF179
X-7FA49CB5: 0D63561A33F958A5D4CCFB6D5F88FD345002B1117B3ED69634850311FEA7A1968DB33178460FA33B02ED4CEA229C1FA827C277FBC8AE2E8B23E969EC8BBB9161
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8ax2PRtUjIWmfeTOpfURtIUM=
X-Mailru-MI: 20000000020000000000000800
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
index 3a8225b0666c..22aa3b38458c 100644
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
2.54.0

