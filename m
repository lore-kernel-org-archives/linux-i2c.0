Received: from send243.i.mail.ru (send243.i.mail.ru [95.163.59.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C137E5C9;
	Sat, 10 Oct 2026 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612760; cv=none; b=asb4KM2vbDlYh9DVpPs0qpvMkLCcWvubFJ0xw3wjCCDOurerjzrlZuhQesWsnd+sg36Jj8qaYHjLEPO1LWlXfAqnwBGIfV8sbaFhVSzyu5/WQ92poH3CdDOZzaC2hmhPmqcCLQZf29WMFGJu5NkdAfgLtXqee20MECUahA4SwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612760; c=relaxed/simple;
	bh=VQ03bKt1Lc9xSCPUDMHYST6N7vO5NoSZVaTHwV2YQ5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGNk45d6WwCbceaCvoeNXxOVpC61/Bal+ZNfF9WOwcgHG1ksTgQHkD1TcgUAyHBHZFYhq9r41zOX/8ScncTI8eRwN7Pjo1ywdlOBduLg7/7Kylgqv4zW+Y8Y5/CX/tZs5QYZedelm8FvQuNHeKE6fC2x8/DopIQgENRw/42ygKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=Sv+992xj; arc=none smtp.client-ip=95.163.59.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="Sv+992xj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=xKKldkkdmRrlH3+XC2HtxbhefRTI2jE/Cn2PPdVNjdc=; t=1791612756; x=1791702756; 
	b=Sv+992xjT4XTv/pFJcS0Zwew6OZNoJWEv4hQK47Sw7hledqNx/JJ1o7rgMlHaAt6nTC5Hf7uF2k
	udzRmDKOGGC5ls2UoQaFdbGOeGTwfPralGZGATLlNRRzUsa94n45tCd3aRvbNZMvbljHqOtRUvkJC
	8KaabE1a60dZtnLuBePLuvdfVqEIePLbNMQqJ5SJgrdyRa89GHvd6KR2gpxbaywEeM0L4VQF9PtBZ
	LuqBXeMHmSan0Sj+1e9Zu7UWrRqiJW0I+s9DulNqjMzQuBdq+3VYRGad7vTijEDMR3HXPe5Bb9FJJ
	NJw8FnGMbq3R/PBqKRz1NlBgnHljBIq82lPA==;
Received: by exim-smtp-84d6fb566c-gbdpj with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xFQJn-00000000RHY-1S3i; Sat, 10 Oct 2026 09:12:27 +0300
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
Subject: [PATCH v2 0/2] i2c: rtl9300: remove IO_MODE configuration
Date: Sat, 10 Oct 2026 13:12:08 +0700
Message-ID: <cover.1791611999.git.misha.zavertkin@mail.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-84d6fb566c-gbdpj; auth=pass smtp.auth=misha.zavertkin@mail.ru smtp.mailfrom=misha.zavertkin@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD968B159B7CE59A0BE79D87027893E9730068DA622128DD5D4182A05F538085040C6AC82DBD7B562893DE06ABAFEAF67055E4E41E3A81E8A69135CE729D6484097B7464F346B62472A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756616B1AC507046C935DF4C00BBFB3C043D74995A4EFBB3D3B79C6F6C88131200F68EEF46B7454FC60B9742502CCDD46D0D062BEEFFB5F8EA3EF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0AF05157F0BAFB9978941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B6AC143D7F65F00CAD76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C52A781257067E9B843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5C250198685926CE45002B1117B3ED696AC3A97D61D6A891FB2920F75BA9A967F823CB91A9FED034534781492E4B8EEADEEA082C9A12FE455C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659F9064DE9A493218A0CC515E6CFA3C3580CE6D8858CC135DAA1C9F1EC53928A313F7E3A5EA15F1C19B8341EE9D5BE9A0A2C4CD57F0B7B53D7E1A3658CE16BAF6E0BCF0E9579C30B3052EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwQqAS+6VDYZ8=
X-Mailru-Sender: FD65D7C492470CAE23E6ABD178607DBC318B7C7AFC912EADB951B70A5BD4BD8E6184A1D3A18F35E9140FE51BDE05C0F74B2A3C715BC1DED96EFAE8183A2EAE0D96DD28E056F58A23E3C55DE776B662A1DD77B849F69637CB3DDE9B364B0DF289AE208404248635DF
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
2.54.0

