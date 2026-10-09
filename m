Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3373B058F;
	Fri,  9 Oct 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530550; cv=none; b=eFjVRCgBMm5gFcGoabrlzXjONm/aWQaFPXnXtp5PSYSnTx8EHcJpnOxD8kLDTyDt63bJF1QuQEssyO0ruQSmMFh55DbRLi3hf+IughyICcJ4+mcMX95rqT+kk76ysGgAjORX/M5mpcdPIsyTAxZQo4eWQxKBGnMoc6zNmj/vhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530550; c=relaxed/simple;
	bh=8/8aLj3ULZYoz3mBo6D7qwpK/tGH7gvBced6ID8m3zQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ihB63EHUwURKVVo7HlBYdwMsRcMCXKofIkY5Lkcgj3aZAkMOqUuBgLcyvlsvD1MFLGvgS3LxXVeMm3JIHZG/ztC9TaojykKCV9Wf6JsHarp2zfAZx3sceo+93ocQuAam8+uhvVflq30MhUqf2S7HbgRfvKuQtr9y6Zll5aRWFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from luyulin$eswincomputing.com ( [10.12.96.77] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 9 Oct 2026 15:22:00 +0800 (GMT+08:00)
Date: Fri, 9 Oct 2026 15:22:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yulin Lu" <luyulin@eswincomputing.com>
To: "Samuel Holland" <samuel.holland@sifive.com>
Cc: "Pinkesh Vaghela" <pinkesh.vaghela@einfochips.com>,
	"Darshan Prajapati" <darshan.prajapati@einfochips.com>,
	"Pritesh Patel" <pritesh.patel@einfochips.com>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Paul Walmsley" <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>,
	"Albert Ou" <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>,
	"Andi Shyti" <andi.shyti@kernel.org>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	"Min Lin" <linmin@eswincomputing.com>
Subject: Re: Re: [PATCH v4 3/7] riscv: dts: eswin: eic7700: add pinctrl
 support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <b7428a65-b303-4ed4-bdc0-caf5a89b4712@sifive.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
 <20260814070007.1662455-4-pinkesh.vaghela@einfochips.com>
 <b7428a65-b303-4ed4-bdc0-caf5a89b4712@sifive.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2dd7292f.aba1.1a11f8a5115.Coremail.luyulin@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqEYlshqYu6FAA--.13830W
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/1tbiAgEPA2rHxigjHQAB
	sz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgU2FtdWVsLAoKLi4uCj4gCj4gPiArCWRlZmF1bHQtcGlucy1ncnAgewo+IAo+IE15IGFzc3Vt
cHRpb24gaXMgdGhhdCB0aGVyZSB3b3VsZCBiZSBvbmUgZ3JvdXAgcGVyIHBlcmlwaGVyYWwgKGUu
Zy4gU1BJIGJ1cywKPiBlTU1DLCBVQVJUKSB0aGF0IGdyb3VwcyBhbGwgb2YgdGhlIHBpbnMgdXNl
ZCBieSB0aGF0IHBlcmlwaGVyYWwsIHdpdGggbXVsdGlwbGUKPiAiLXBpbnMiIG5vZGVzIGluIHRo
ZSBjYXNlIHRoYXQgc3Vic2V0cyBvZiB0aG9zZSBwaW5zIG5lZWQgZGlmZmVyZW50IHBpbmNvbmYK
PiBzZXR0aW5ncy4KPiAKCkkgdGhpbmsgdXNlcnMgY2FuIGRlZmluZSBncm91cHMgYmFzZWQgb24g
dGhlaXIgdXNhZ2UgcmVxdWlyZW1lbnRzIChhIGdyb3VwIGNhbgpjb250YWluIGRlZmluaXRpb25z
IGZvciBncGlvLCB1YXJ0LCBpMmMsIGFuZCBvdGhlciBwaW5zKSwgYW5kIHJlZmVyZW5jaW5nIGEg
Z3JvdXAKd2lsbCBhcHBseSB0aGUgY29uZmlndXJhdGlvbiBmb3IgYWxsIHRoZSBwaW5zIGluIGl0
LiBBbHRlcm5hdGl2ZWx5LCB1c2VycyBjYW4KcmVmZXJlbmNlIGluZGl2aWR1YWwgcGlucyBkaXJl
Y3RseSB0byBjb25maWd1cmUganVzdCBvbmUgaXRlbS4gV2hpY2ggZGVzaWduIHRvCmNob29zZSBp
cyBkZXRlcm1pbmVkIGJ5IHRoZSB1c2VyJ3MgYWN0dWFsIHVzZSBjYXNlLCBzbyBJIGhhdmUgbGlz
dGVkIG91dCB0aGUKZGVmaW5pdGlvbnMgZm9yIGFsbCB0aGUgcGlucyBoZXJlLgoKLi4uCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAwLmR0c2kgYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL2Vzd2luL2VpYzc3MDAuZHRzaQo+ID4gaW5kZXggYjNhMjMwODcwMzE1
Li5iMTZlM2UyODYzMmMgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2Vzd2lu
L2VpYzc3MDAuZHRzaQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAw
LmR0c2kKPiA+IEBAIC0zNDksNiArMzQ5LDExIEBAIGdwaW9EOiBncGlvLXBvcnRAMyB7Cj4gPiAg
CQkJfTsKPiA+ICAJCX07Cj4gPiAgCj4gPiArCQlwaW5jdHJsOiBwaW5jdHJsQDUxNjAwMDgwIHsK
PiA+ICsJCQljb21wYXRpYmxlID0gImVzd2luLGVpYzc3MDAtcGluY3RybCI7Cj4gPiArCQkJcmVn
ID0gPDB4MCAweDUxNjAwMDgwIDB4MCAweDFmZmY4MD47Cj4gPiArCQl9Owo+ID4gKwo+ID4gIAkJ
Y2xrOiBjbG9jay1jb250cm9sbGVyQDUxODI4MDAwIHsKPiA+ICAJCQljb21wYXRpYmxlID0gImVz
d2luLGVpYzc3MDAtY2xvY2siOwo+ID4gIAkJCXJlZyA9IDwweDAgMHg1MTgyODAwMCAweDAgMHgz
MDA+OwoKV2Ugd2lsbCBjaGFuZ2UgdGhlIG90aGVyIGNvbW1lbnRzIGluIG5leHQgdmVyc2lvbi4K
ClJlZ2FyZHMsCll1bGluIEx1Cg==
