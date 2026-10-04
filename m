Received: from send78.i.mail.ru (send78.i.mail.ru [89.221.237.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2F370D7C;
	Sun,  4 Oct 2026 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128937; cv=none; b=rdoG9VmoeCU3ENv4sCWyzJB1Rr1W7ko5ckaL3ttKaj6CHTdxxMsTIK+5NiRU0MlQU/CY/haEyCV9Qw3Aw+T/Rkxxap0nUJTa0iplnD+Jb8grt02YMrvsSc+UJlYTJTzc5JJNI1LJ6NUGIppFKwInA+1UgjBXqWZvRBnPXjVMwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128937; c=relaxed/simple;
	bh=HtPj4v8vpBxFgFJufxwc4+glAkb0g0ppGp3VEwVoCYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgO3VRFW30QVfEoUYZA8nOsP9G1sYwkhelPPQfKgHoZioC0+nixUvyLZRJNfOUAAOddLE3leFHguFLXr6w23XFpd+M2aHX3QhzcHCnMcV90slQRLC5MC2tHzQopomQhbuJc3eWTfYKiLN1mNFhLReTwnMD6TylhpqtgpqALQPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=kf0VJuql; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=IM3c2xhY; arc=none smtp.client-ip=89.221.237.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="kf0VJuql";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="IM3c2xhY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=AoqdPOP+Cjce4dSgxWZppBWDxwYNlD9LQgjeP3c5zxg=; t=1791128930; x=1791218930; 
	b=kf0VJuqlLszWtCqh/143mcMtP0bzpWvuttBiAGTCkkIEitZTXuLkW6IYHrNHHnb2KvjYcDwLHcl
	kZiyZdx0S8UL8RKi25Wv8WhTYgAbsI1Zj2nKSpqf0TGzV1M6jISuMafIp0fhwwOI7lTaSScPBaVZb
	VYAWJPRGFG8WtaY0e/1HcXEjfR7RnroYmZ3br/zltiI3lnNwxbBg9J284oUH41C9Dqq3OzcB7gvul
	ASrYZacv3YmS/OMpmgVd5HMBsI6R/58K+WVIQnOOtpqcNY2a/ooeOJVpjh38Wn1GOU/hfY5pL0wiF
	lowkQX5CSY14GorVjIxMe3yK5ymP/hqwgJJg==;
Received: from [10.113.104.231] (port=58018 helo=send217.i.mail.ru)
	by exim-fallback-canary-10-5f5f5797b7-zrprb with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDODX-0000000099x-1f3C; Sun, 04 Oct 2026 18:33:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=AoqdPOP+Cjce4dSgxWZppBWDxwYNlD9LQgjeP3c5zxg=; t=1791128015; x=1791218015; 
	b=IM3c2xhYBP2kBIiYT6eE/Lu5CqsF1naF7bfW+O75CR/wJSC9rh0XgFWkRDX8BbaPmfGecHdFlty
	+t1swhawmZODSW+1mpLZ/GzDgXvkx/jqTQu6GjjLQ0XuAwUoq0K/wesVAAZE7wV7HC16BoveATm0F
	u+7YPpdHoHNOKnaKl/JLCFWHMOr/dImlYTr+wfwUvtPhthPeFgDxHH6SK4J3IBFcxgihzHFEu8lRN
	PZjHy0wU9+e6GvTMZYXqBf9hYnXT4g6LAO+3M2rJsvszfJVk+m4OvWRtLrJVfFWUUJXLBKkcMXlOo
	iLEzegdw3CJ+kzQojzNCp5Aum6ksy6J0QmHQ==;
Received: by exim-smtp-canary-10-7bd8444d88-pl44g with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDODN-00000000GTm-3GwH; Sun, 04 Oct 2026 18:33:26 +0300
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
Subject: [PATCH 1/2] i2c: rtl9300: remove IO_MODE configuration
Date: Sun,  4 Oct 2026 22:32:34 +0700
Message-ID: <6f0c33689ebda2ff828a0b830bb78b1168b199b3.1791127538.git.misha.zavertkin@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD9BB9BFA8D9985286B4F78699DE9EED6EA473D818687BD1C4A182A05F5380850404C228DA9ACA6FE279C61FDE9CE37E1BE3DE06ABAFEAF6705D8DA8371B8ABA3A286CEB8CC6E9E542E012184F85FB44711
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AD2F2D6F6013FF7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2B7D0B5183840C9FF9EF6160EB656399EF45B3919D0767016C7968AC6EA8EA59EF0C819B32DFABC24A725E5C173C3A84C31E02C13459908652117882F44604297287769387670735204B6963042765DA4BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D98AA50765F7900637C58260CBB077EDD1D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FBFBFE0634520CEB9156CCFE7AF13BCA4B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5ABE912BF0A094BF35002B1117B3ED6961DFAB8D082378937C638DF663A625AFA3610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB394A2C4B6BA9DFC510F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659F026A0FD0F68FC9665F699225282CFD70E900F82C31408C1C7D0DEEF1BED95A747426E8E4290DFBEB8341EE9D5BE9A0A775A37602C485E74B812BCDD4C60D96665FED16896228FC952EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWGLFSMbYFIZdl/VZul3y37o=
X-Mailru-Sender: FD65D7C492470CAEE010D97EE9FDA1EF30A43CBF52B51200965EDF11CFD47EC72093B1EE85BB7EC84626B9F2B7165D05F767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B400464DA02507E70B0546FCE11372492EA203111655A248E6049FFFDB7839CE9E920F40F1183B4710DB691C1CA50798F9400DE8D5D10784F5028FFF5AE1A43F2F357E5DA21CF0CBBE
X-7FA49CB5: 0D63561A33F958A5A1644732401DA7925002B1117B3ED6963C4C5414080E67A63C54B0D56BCD470902ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a/xwH01AMJkn79cp17RWWLI=
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

