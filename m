Received: from send288.i.mail.ru (send288.i.mail.ru [95.163.59.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966C334C3D;
	Sun,  4 Oct 2026 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128920; cv=none; b=ocye/KcvrhO1NRsMnq0moxspcZ0eE/yKjNGQ2szecqR/1BuRTJ6klKYz8sIxf+NgmNHycjcvsDODI4sA2g/S56PGndCLZ2cBs8o1NEmwb3UaiaJTG64JIM/91ewDGv9u5wA2WxpW0m0c0cBR78D722EHLMLDOT4JYbf+sTZW9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128920; c=relaxed/simple;
	bh=Q98Ob/et0Ad5ThdzlalK0d5SbwqbtC0m1flyFqDf3tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glCGHMRHLzkGQl3uMZKCzSn3KKNhyNpMZM8eb6oqAcof12Y1OSUsz0lPRKZFAOVygIX/faYiEWnGSDhNGw3pDLbxhYcYGn0gwdPQwUlv1C8FRM3PeMSYGZ2lVigJwlddJ9N+I7xCeU04asTYYxl9X7UlyIQzdVbfcSPTbujAmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=npeLtRjx; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=vJo9pSpO; arc=none smtp.client-ip=95.163.59.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="npeLtRjx";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="vJo9pSpO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=mB90G5H+eGeqxMX1ZBd2kKxnWNEIT8sYLRoBasATiMw=; t=1791128916; x=1791218916; 
	b=npeLtRjxF9o3miyD5tvH4hitQHTtCh+0GmECmbChm53jqSalEaHYPq6mxsi3buf7Gj4c5nZjq47
	RGl6sf52UM0mRyZvNYyWVU2o50TJqodiGo6j/sGkJzMEG/KLgzPNNzmePxqa+EwANQ5UJfbSKvQN5
	4sQ7hBDttuQmHBCuVVvIHpiRwREEfBy/FMGUu1URVPwYlqoGEUJe85benACTHMKBCC7LDOFhcOM+s
	XQHeG5OICIpf3cBG5tpCevCWtEbO1CK8ny3OkR8RtD9sXy2ykpc94Ol2dWIzRQZ5tYgiAKXF0oP2b
	Gz2R12/1Eyd+tfr+j0YXJi1KQzh6DLsogmHw==;
Received: from [10.113.70.127] (port=34956 helo=send243.i.mail.ru)
	by exim-fallback-canary-30-5f5f5797b7-sjhwp with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDODK-00000000EbX-3zUr; Sun, 04 Oct 2026 18:33:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=mB90G5H+eGeqxMX1ZBd2kKxnWNEIT8sYLRoBasATiMw=; t=1791128002; x=1791218002; 
	b=vJo9pSpOnY2m/vYu3Q6ZyBuyb9KvLtJ1Q7HWnRivbqYeQCA52uITKFFhpNm01i+8Y2LbsBubWLR
	7j2W4j9D1Q47X3lFyEWRhuaQEHmU7b4TnaNqy0AbupmdMdTIX81erNRUneWxUHkO+9TNNYMLg+66I
	SZRbWxhSy7qKWNpzAtFQfjtNoeJvG/hf6Zu97+ehiv1BbsGE1/QrPCoTfw2BcNeloPQz+c4UFgSa8
	yTTXIlZhCINR+NO2V/u6HiQECgWO+GriSf0YbHEta6SnVxtx9jnwfpc3RUOW8vMu+AZZHXgvIlm9b
	zSBvmTxyY8MWLiXEydlTLXyy4x5GGu4N8o7Q==;
Received: by exim-smtp-canary-30-7bd8444d88-2gbk7 with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDOD9-00000000PBz-0Xh1; Sun, 04 Oct 2026 18:33:11 +0300
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
Subject: [PATCH 0/2] i2c: rtl9300: remove IO_MODE configuration
Date: Sun,  4 Oct 2026 22:32:33 +0700
Message-ID: <cover.1791127538.git.misha.zavertkin@mail.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD916CE66F793C04802C937705057FAC64C8D095010D03BA95E00894C459B0CD1B9E75B5B493919319E06104296DCCA83D203A58B56A10BFA1FC28C821639F114AEF82D89A8CF7DB8F5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789805A6418246A1AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669FBB6EE09702D42792CFA01CAF86D7B1085DA90028991B7B932B26F09BF67B538EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E9D5E8D9A59859A8B699DB8DEEBFCC4B66CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C06526C9B1F5BC626BCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6104AF9A031C589D7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5EFE4809F597D63A15002B1117B3ED6968851931A9796B66DF09842853758E9E5823CB91A9FED034534781492E4B8EEAD619183A7BD6BC6F1F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D54AF47762AB4810619
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659243F0C7AC694BC8FCD8B58DAF003AF8FA4B141E193EA3E3F8E0F9DDF096DE02937192837DAA70EBEB8341EE9D5BE9A0AC71548C1A69F2F49442C5154916628D7998682C8811A4AFF52EE4E5D9E54FDA427302E973F6434AB8511FE41C8941D68F571C199C4BE91E79E69A34BD5DD98C9F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwPBU2Rt8bj1Q=
X-Mailru-Sender: FD65D7C492470CAEE010D97EE9FDA1EF30A43CBF52B51200D77739F4E260083E5A2229DB1BE3CD3932A72BBB8BE3169CF767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B400464DA02507E70B0546FCE11372492E55863E2B7114EDB0049FFFDB7839CE9E920F40F1183B47102B473EABEA2527F4EEFED01033B76AC4039D4C6DD5D7D878D020F7FCB975CFC3
X-7FA49CB5: 0D63561A33F958A50F1B27CD8912D05D5002B1117B3ED69608B10F07AB9A4E21F4374DBC560C873002ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a/xwH01AMJkn9snoPBmFZWo=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

i2c driver for RTL9607C used to configure IO_MODE register. The register
is global and responsible for configuring SoC pins, therefore it should
belong to pinctrl driver.

SoC-specific pinctrl driver is WIP (waiting for these patches in OpenWRT),
but pinctrl-single could be used instead.

Remove scl configuration (used only to modify IO_MODE register) and
reflect these changes in Documentation.

Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
---
Michael Zavertkin (2):
  i2c: rtl9300: remove IO_MODE configuration
  dt-bindings: i2c: rtl9300: add pinctrl

 .../devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml |  7 ++++++-
 drivers/i2c/busses/i2c-rtl9300.c                     | 12 +++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.54.0

