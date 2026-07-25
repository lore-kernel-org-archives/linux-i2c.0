Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945882BEC23;
	Sat, 25 Jul 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784968616; cv=none; b=X51Zi15wr9PVhkITONgbxmctMcg+wSATHbKWAfukVg2ujJdgPCdVfjWS/fsRgXPgq31o/x8GYc0vtZuC9n7/41iT54pwXDLLwNflmn2V9pOHiZ0q8wzOxLnd264LpgJm7vwTnfj8UUayQHAsER6LzcZsQ1+4B9/QofcWjGevQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784968616; c=relaxed/simple;
	bh=HtPj4v8vpBxFgFJufxwc4+glAkb0g0ppGp3VEwVoCYE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jj9klUMUVLNDkevnAtdEIqbR/ZjB1ImtP9xp5+7vRkv3HXJfwHUkcWnkkl4knfesWplipneD5wwxnzWpsu7oS4+U351bZSGrw5wqA8sutcC9cd9fRMSRMevpKbl1Cm8onUO2KUQ2kX+DQZkt9bqytIXrm0ZCaNvaeAVTpTWiGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=1PAz3OI3; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=TXdnF0x0; arc=none smtp.client-ip=95.163.59.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="1PAz3OI3";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="TXdnF0x0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=AoqdPOP+Cjce4dSgxWZppBWDxwYNlD9LQgjeP3c5zxg=; t=1784968612; x=1785058612; 
	b=1PAz3OI3RUQ0s6vGsgpr4NsYe5uNdFzprG/jGgIOeanEBM7P491MiPAi0LX7USMSE4Angnciwlk
	XFhH+Dp0KxHZMwPoWIhZkLQDLt1XRp8J3R41ZgygoFKqAP2XbhDzuMC60CrxpSiiMjbCOqCl+BCeb
	MzrbI3fk05LoIpEFKiDyiBrj3LOT/ugWacLhqtnU3YB9P/Ay8js1hiw1aGgY4yYMLITCgbT5Yw8Er
	Hy8Ug4Nzun23V/PIYoody1i+VFrq19CP5o0otcTpn9LvjrmMEB1qBA0rltluyP0IumXCjKH5xlhVd
	VW4C+jbCM4PggObQzof+GuI+b5jTAvvSqzRA==;
Received: from [10.113.175.152] (port=55822 helo=send57.i.mail.ru)
	by exim-fallback-5cf4fc9bf6-jwlq4 with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1wnXdc-000000008ir-1yGE; Sat, 25 Jul 2026 11:21:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:
	Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids:
	Disposition-Notification-To; bh=AoqdPOP+Cjce4dSgxWZppBWDxwYNlD9LQgjeP3c5zxg=;
	t=1784967700; x=1785057700; b=TXdnF0x00MbgmOwxfmwUZzogOJOE/H4WgolzHOevWxMCqBa
	5L/cP8yZSiWAUt7zewYIKBTTopP1AKhzW99KjytYHPPpc6dlOZKb1p+GDxuj7sCTh9qZl5dZWqJBv
	yiXn0wMG90mvBVybzaeZSiSNQcIk9u328GOPH+AXiPDczmRkJYLLs9bCfgh7yFSw0wPinPmsHcvIO
	HxTqfUO1Bt81ZWO3msexT9nfkLIyAPFQ0/o+KnsmJCKf80KuEWUIgIVPNkTu9GRrKWn43B/EVUkEg
	8tJChu4gJ60cb6QLEjzuqRxmBJPfr8S4ebwS2cOiHQb9AAlK1HqsgOTT5NUp8bjQ==;
Received: by exim-smtp-6c76488b9f-qk49n with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1wnXdQ-00000000Pn7-3vgs; Sat, 25 Jul 2026 11:21:29 +0300
Date: Sat, 25 Jul 2026 15:21:25 +0700
From: Michael Zavertkin <misha.zavertkin@mail.ru>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: rtl9300: remove IO_MODE configuration
Message-ID: <amRyBYZrBKY6uxd0@gamepc>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD93ED3C6BF6FFA701F7F2B1828239C9590C9D8BEA4C3C4F923182A05F538085040D6208A19C77FAD343DE06ABAFEAF6705DD7DDC178215A90D62CF7C0EBA458B79B3FF27712106A5C5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FEAC828D2BF6EC3CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566DDF253B6BCADDB79FA3648AA6143FE822F9EBEE08F86FF741BA314D1DBA2F63C8EEF46B7454FC60B9742502CCDD46D0DB861051D4BA689FCF6B57BC7E64490618DEB871D839B73339E8FC8737B5C22498CE9D8A6861299E6CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C05C65A4548AF84F858941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C005273F62ACDB011A7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F0AC5B80A05675ACD9100238FE36DC7A2B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B82259E19AF10636475ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5B7BB4774EF7F39495002B1117B3ED696C99380C2C03D812CB91D2EB2DEE3878C823CB91A9FED034534781492E4B8EEADABF80F987DAEDACBC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6592B45ABA1E61951DFEF349DC79C3D0031A794755BCF66709B8D4D3ABEC52295C8701835C76EF1EE5CB8341EE9D5BE9A0A14B5652DF9957438D331799F98ACD315960C91F9F1BD8A1CC7CEAA0681F5848F4C41F94D744909CE2D653CA06E969CEAC4926F5095E487D6D64CFEF34022E96A964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVWmxowtcrDwUEBC5ffO7B1c=
X-Mailru-Sender: FD65D7C492470CAECC472F0E02B2254CBC80376FA681C37DB951B70A5BD4BD8E470F8DC6C6D1872651675C988997E3A04B2A3C715BC1DED96EFAE8183A2EAE0D96DD28E056F58A23E3C55DE776B662A1DD77B849F69637CB3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B486472E5A48B460E48232B7BA1535077B82EC484ED754B209049FFFDB7839CE9E426FEB9BE75545304F636D1A863734543FD39D8513B859F159469674F9E0BD2A354B5F5FEB893B66
X-7FA49CB5: 0D63561A33F958A5AFFC05610165F3805002B1117B3ED696942C0AB6A7DB06F68DB33178460FA33B02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZsUNbXfcb/nvKnL01ZIRaTg==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

IO_MODE is used to route peripheral controller to SoC pins. This is a
job for pinctrl driver.

Since select_scl now have nothing to do, remove it.

Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
---
 drivers/i2c/busses/i2c-rtl9300.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 3a8225b0666c..c36c29e1833e 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -130,7 +130,6 @@ struct rtl9300_i2c_xfer {
 #define RTL9310_I2C_MST_DATA_CTRL			0x8
 
 #define RTL9607_I2C_CONFIG				0x22f50
-#define RTL9607_IO_MODE_EN				0x23014
 #define RTL9607_I2C_IND_WD				0x0
 #define RTL9607_I2C_IND_ADR				0x8
 #define RTL9607_I2C_IND_CMD				0x10
@@ -190,7 +189,6 @@ static int rtl9300_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
 
 static int rtl9607_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_chan *chan)
 {
-	const struct rtl9300_i2c_drv_data *drv_data;
 	int ret;
 
 	if (i2c->sda_num == chan->sda_num)
@@ -200,11 +198,6 @@ static int rtl9607_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
 	if (ret)
 		return ret;
 
-	drv_data = device_get_match_data(i2c->dev);
-	ret = drv_data->select_scl(i2c, i2c->scl_num);
-	if (ret)
-		return ret;
-
 	i2c->sda_num = chan->sda_num;
 	return 0;
 }
@@ -619,7 +612,6 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 
 static const struct rtl9300_i2c_drv_data rtl9607_i2c_drv_data = {
 	.field_desc = {
-		[F_SCL_SEL]		= GLB_REG_FIELD(RTL9607_IO_MODE_EN, 13, 14),
 		[F_EXT_SCK_5MS]		= MST_REG_FIELD(RTL9607_I2C_CONFIG, 26, 26),
 		[F_DEV_ADDR]		= MST_REG_FIELD(RTL9607_I2C_CONFIG, 14, 20),
 		[F_MEM_ADDR_WIDTH]	= MST_REG_FIELD(RTL9607_I2C_CONFIG, 12, 13),
@@ -631,7 +623,9 @@ static const struct rtl9300_i2c_drv_data rtl9607_i2c_drv_data = {
 		[F_I2C_TRIG]		= MST_REG_FIELD(RTL9607_I2C_IND_CMD, 0, 0),
 		[F_MEM_ADDR]		= MST_REG_FIELD(RTL9607_I2C_IND_ADR, 0, 31),
 	},
-	.select_scl = rtl9310_i2c_select_scl,
+	/*
+	 * No select_scl - single channel available
+	 */
 	.config_chan = rtl9607_i2c_config_chan,
 	.config_clock = rtl9607_i2c_config_clock,
 	.misc_init = rtl9607_i2c_init,
-- 
2.54.0

