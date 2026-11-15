Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730168;
	b=sMntO31Zy8iP1lhTQi6FdWAJ3CEVFfasAW2b8D6Fda9D0/utdf2IVTQt+64JwqcKIpe6
	 eFgGnJG5H+/HP2Zk6VQZA01q/BX4gOSMk4zOYdVV7r7elIRWD/FdzS2vbD2uBqlpVwdAv
	 4NbGWTrnMVD0hNgpY+yt974fnv/ZoNH2X1E/P8MFOhnDBLRbXo+YM4G2ov+UTAcxwtfnZ
	 vtse99HcS3xfGgRRPztNqqglaBQeBUu+zThnKmPppbVlUGSRSoDarNSeGPCcAIxNqY46O
	 gYhFq2uaaSfCW/47kEVNT3o2XPYXa5w0ATPVWHZRR/jl8UwKPbYG341DJJwG36Mi8ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730168;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailru-Src:X-7564579A:X-77F55803:X-7FA49CB5:X-C1DE0DAB:X-C8649E89:
	 X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=bVTKd2uB1X07Sl8212JOgVG2WhKKXS5Zhpj8Uuhn9FI=;
	b=noH5DfvBpjnZ9pQjUpDQ4ENUzbxPcjtUO/WW45hCVwNUGQgMAbkcnqGQIHXiYB7BUCE8
	 qW52W0q0iwIp6vCHJzQL252//DVprgY7c6rVQe0a1o2m5sBvBFkjr4RPzK+Vp73GrFnqA
	 N1oInBix8BnzuFkXmf76XlmFjlfEAFrWfZFsRxBB/mhOznMNk4++WU3tkRQy/cXW/1VQw
	 KT5x7Fy2d2fUXrurnWlr5t9KVDw05EV05BRsXL78pzKlBGxBcpnHESzJ05ckLNsgJNUSl
	 HBDuwfIjlF3uXskzxYv3g0dNhOuumowI0WnfUQnHwfapQZLHrDLOCO5+5hKY+XZ93Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=XAIJO3W5;
	arc=none smtp.remote-ip=89.221.237.177
Received: from send82.i.mail.ru (send82.i.mail.ru [89.221.237.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D08606A31A;
	Sun, 15 Nov 2026 08:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=XAIJO3W5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=bVTKd2uB1X07Sl8212JOgVG2WhKKXS5Zhpj8Uuhn9FI=; t=1794730166; x=1794820166; 
	b=XAIJO3W5RzdDEuEAMySh2DkAPUcA1MV0ILVgxJxOkCcxGGzkyjR5GDKYt5kNnvcB9CDHJdBaVXW
	Tuz8l1wigLLJB4OdPRK06J+DmobabA1hovXyiV/UO4WeMNlHCxBJUAYi+44cRx/HHmdAQMEq8ED65
	z15BXpFPgsUwUeqHtZEwZSwEKIAUE7jUbJlC6yl/xhGWb2nGjBElzRlC/zhuA7mH62OY8Dvh0e/G0
	a1e1XFHT3hiX6O7Z2GIc+luSLpfiuQrY+U4xrPTwoOKlnqbve7kXvIVnduSKub2WB+y+kVSLQQ7br
	MntGk+a55OaTdD9jdkWxgfwccY38Z4jOHCcw==;
Received: by exim-smtp-canary-30-844c8fc8c7-6jd66 with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xSVIa-00000000I1j-42cY; Sun, 15 Nov 2026 11:09:17 +0300
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
Subject: [PATCH v3 0/2] i2c: rtl9300: remove IO_MODE configuration
Date: Sun, 15 Nov 2026 15:08:53 +0700
Message-ID: <cover.1794728344.git.misha.zavertkin@mail.ru>
X-Mailer: git-send-email 2.55.0
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
Authentication-Results: exim-smtp-canary-30-844c8fc8c7-6jd66; auth=pass smtp.auth=misha.zavertkin@mail.ru smtp.mailfrom=misha.zavertkin@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD93F98A09C3FD4AFA267E9C197542936F1D72816242C8E930F182A05F538085040788266B2FCE13DE73DE06ABAFEAF6705060D11EBF344DFE12D3D455C7CCA3DF1A5E3C45D6879BF4E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B264C8851FD8E810EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B247607D0661665F0F2E070BE324C7D3C4D500FB7FFEFF695EBB0A4F435E46E6718B35066C979671628AA50765F79006377C70927E34808485389733CBF5DBD5E9D5E8D9A59859A8B6F7EC8CC465A83DA3CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C088988B59C992DAD0CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6463FC9783E6330D7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A584D0F4314A0B54FB5002B1117B3ED696E36F58C52888A52ECCE9A60C8CB01D7C823CB91A9FED034534781492E4B8EEAD220496FFA5CD4785C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659BCC82A82B51B3530185D28D066416E2BB405E3C31290BA89390CCEC15992ECC870B6660B8847369DB8341EE9D5BE9A0AB8E1FF289D759174438C348CF61FFE7FA6D344E22782C04D52EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwrTSeL17PiTE=
X-Mailru-Sender: FD65D7C492470CAE44AF3B5ACDA31542B549799C38C167E887A35C9C7BBE74BEA0A89D6FBA911447E5E7D33C24B88A05F767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok

i2c driver for RTL9607C used to configure IO_MODE register. The register
is global and responsible for configuring SoC pins, therefore it should
belong to pinctrl driver.

SoC-specific pinctrl driver is WIP (waiting for these patches in OpenWRT),
but pinctrl-single could be used instead.

While added compatible realtek,rtl9607c-i2c relies on pinctrl driver,
old realtek,rtl9607-i2c left for backward compatibility.

Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
---
Changes in v3:
- Added Acked-by
- Link to v2: https://patch.msgid.link/cover.1791611999.git.misha.zavertkin@mail.ru
---
Changes in v2:
- Backward compatibility achieved by adding new compatible value. Old
  one is marked as deprecated
- Link to v1: https://patch.msgid.link/cover.1791127538.git.misha.zavertkin@mail.ru
---
Michael Zavertkin (2):
  i2c: rtl9300: add realtek,rtl9607c-i2c compatible
  dt-bindings: i2c: rtl9300: add 'rtl9607c-i2c'

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     | 20 ++++++++++++++++++-
 drivers/i2c/busses/i2c-rtl9300.c              | 15 ++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.55.0

