Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745531F9BD;
	Thu,  4 Jun 2026 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553101; cv=none; b=Dy7LtV44vQ/vwf95TrzJbgvkvE07HvqIxGbMCi39UUNGClFDKoF/L7+ojYTY3rvZNFyJABc/NehRVKEXLJFamZeVbaNqKTYkL3SxaVmseMzn5F2RQs4LXsW3CVILyf81FANOGVVJetaAFSaxD5XNtEEnvdXoRf+82jfdYZLuccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553101; c=relaxed/simple;
	bh=v6868ycCn/yidRR0dRG3qmqGg2jAXpuJIh2VaUnQDk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbKWdE/BT2fD9hHnxSoKEOv2v0TEH8fVHbMHB5IuonaxX5Fk1spT2OsS8LzZPAyFcQCivRaNN2gjeWI7YbfD/3Eoe/ge+IEPp67VllEfNzNETRIBcEf078ll3Zy2j9lxcAAm4q+klSYcHN5gtPIDs1KLf19manCov5wxr/uCGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=Iky6JfDG; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="Iky6JfDG"
X-UUID: 40af6cb65fdb11f1ae774f059c8739df-20260604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=aRt305Bvj1tODwrQnSNjQ4fhnxXXhcpvaUofFEoxQFE=;
	b=Iky6JfDGtAQlnogNluKYMhZKPzoq49CCtE+ZTZ1N5fZA2qDLUp3uIDfpW89K+UhTSYeQ6/Nxi3JFWWtgrycKSGJ3h2DBTxKvN8a1ShBySBE6gPJH3Bo2tKFVaMNt/uYuD5xIzGySupQ27UfoU8u4e/Uu4WZjTmm76hpuXfVRyNQ=;
X-Spam-Fingerprint: 0
X-GW-Reason: 11101
X-Policy-Incident: 576k57WE5L+h566x5a+E6YCB6Z2e5a6i5oi26IiH5L6b5oeJ5ZWG6YO15Lu255m95ZCN5Zau
X-Content-Feature: 
	ica/max.line-size 140
	xyz/abc 14
	audit/email.address 3
	dict/job 2
	dict/prolog 2
	meta/cnt.alert 1
X-UUID: 40af6cb65fdb11f1ae774f059c8739df-20260604
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1743302658; Thu, 04 Jun 2026 14:04:31 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 3BC2E1B315E;
	Thu,  4 Jun 2026 14:04:31 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id A3940C60082; Thu,  4 Jun 2026 14:04:30 +0800 (CST)
From: SP_ISW1_AT@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: SP_ISW1_AT@novatek.com.tw,
	ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: [PATCH 2/3] dt-bindings: i2c: add Novatek NT726xx SoC i2c controller
Date: Thu,  4 Jun 2026 14:04:30 +0800
Message-Id: <20260604060430.355733-1-SP_ISW1_AT@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw>
References: <20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="__=_Part_Boundary_002_1601237780.428716608"

--__=_Part_Boundary_002_1601237780.428716608
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PCEtLXR5cGU6aHRtbC0tPjwhLS17LS0+PHNwYW4gbGFuZz1FTi1VUw0Kc3R5bGU9J2ZvbnQtc2l6
ZToxMC4wcHQ7Zm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWYnPkNPTkZJREVOVElBTElU
WQ0KIE5PVElDRTogVGhpcyBtZXNzYWdlLCBpbmNsdWRpbmcgYXR0YWNobWVudHMsIGNvbnRhaW5z
IGluZm9ybWF0aW9uIHdoaWNoIG1heQ0KIGJlIGNvbmZpZGVudGlhbCBhbmQgcHJpdmlsZWdlZCwg
YW5kIGlzIGludGVuZGVkIG9ubHkgZm9yIHVzZSBieSB0aGUNCiBhZGRyZXNzZWVzIGRlc2lnbmF0
ZWQgYWJvdmUuIFVubGVzcyB5b3UgYXJlIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGFueQ0KIHVz
ZSwgY29weWluZywgZGlzY2xvc3VyZSwgb3IgZGlzdHJpYnV0aW9uIGlzIHByb2hpYml0ZWQuIElm
IHlvdSBoYXZlDQogcmVjZWl2ZWQgdGhlIG1lc3NhZ2UgaW4gZXJyb3IsIHBsZWFzZSBpbW1lZGlh
dGVseSBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kDQogZGVzdHJveSBhbGwgY29waWVzIHRoZXJlb2Yg
YW5kIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5DQogZW1haWwuPC9zcGFuPjxzcGFuDQpsYW5n
PUVOLVVTIHN0eWxlPSdmb250LXNpemU6MTAuMHB0Jz4gPC9zcGFuPjxzcGFuDQogc3R5bGU9J2Zv
bnQtc2l6ZToxMC4wcHQnPiYjMjY0MTI7JiMzNzEwOTsmIzIwMjE0OyYjMjE0NTA7JiMyMDIxOTsm
IzIwMzA5OzxzcGFuDQpjbGFzcz1HcmFtRT4mIzM4NDY4OyYjMjAyMTQ7JiMyMjM0MzsmIzIzNjYw
OyYjMjcyMzE7JiMyMzQ5NDs8L3NwYW4+JiM2NTI5MjsmIzIwNjc3OyYjMjAzNzk7JiMyMDg1NDsm
IzE5OTc4OyYjMjUzNTE7JiMyMzQ1MDsmIzIyMzIwOyYjMjIzMzY7JiMyMDA0MzsmIzI1OTEwOyYj
MjAyMTQ7JiMyMDE1NDsmIzIwMzUxOyYjMjk5OTI7JiMxMjI5MDsmIzM4NTAwOyYjMzg3NTA7JiMy
NDc0NDsmIzI2MTU5OyYjMjUzNTE7JiMyMzQ1MDsmIzIwMDQzOyYjMjU5MTA7JiMyMDIxNDsmIzIw
MTU0OyYjNjUyOTI7JiMyMTU0MjsmIzIxMDYzOyYjMzU1MzE7JiMyMTI0NzsmIzIwMzUxOyYjMjk5
OTI7JiMxMjI4OTsmIzM1MDc5OyYjMzUwNjk7JiMxMjI4OTsmIzI1NTgxOyYjMzg3MDY7JiMyNTEx
MDs8c3Bhbg0KY2xhc3M9R3JhbUU+JiMyNTk1NTsmIzI0MDY3OyYjMjY0MTI7JiMzNzEwOTsmIzIw
MjE0Ozwvc3Bhbj4mIzIwMDQzOyYjMjAyMTk7JiMyMDMwOTsmIzM3MDk2OyYjMjAyMjE7JiMxMjI5
MDsmIzMzNTA5OyYjMjQ3NDQ7JiMzNzY3OTsmIzM1NDkyOyYjMjIzMjA7JiMyNTkxMDsmIzIxMDQw
OyYjMjc0OTI7JiMzNzEwOTsmIzIwMjE0OyYjNjUyOTI7JiMzNTUzMTsmIzMxNDM1OyYjMjEzNjM7
JiMyMjIzODsmIzM1MjA2OyYjMzg2NTE7JiMyMzM3NjsmIzM3MTA5OyYjMjAyMTQ7JiMzNjg5MDsm
IzMwNjkzOyYjMjM0OTI7JiMyMDIxNDsmIzIwMTU0OyYjNjUyOTI7JiMyMDAwNjsmIzM1NTMxOyYj
MjM0MzY7JiMyMDg0MDsmIzIxMDM0OyYjMzg1MDA7JiMxOTk4ODsmIzM3NTU5OyYjMjc1ODQ7JiMy
NjQxMjsmIzM3MTA5OyYjMjAyMTQ7JiMyMTQ1MDsmIzIwODU0OyYjMzUwNzk7JiMyNjQxMjsmIzEy
MjkwOzxzcGFuDQpsYW5nPUVOLVVTPjxvOnA+PC9vOnA+PC9zcGFuPjwvc3Bhbj4NCjwhLS19LS0+

--__=_Part_Boundary_002_1601237780.428716608
Content-Type: 
Content-Transfer-Encoding: base64

RnJvbTogQmVuIEh1YW5nIDxCZW5fSHVhbmdAbm92YXRlay5jb20udHc+DQoNCkFkZCBkZXZpY2Ug
dHJlZSBkb2N1bWVudGF0aW9uIGZvciBOb3ZhdGVrIE5UNzI2eHggU29DIGkyYyBjb250cm9sbGVy
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCZW4gSHVhbmcgPEJlbl9IdWFuZ0Bub3ZhdGVrLmNvbS50dz4N
Ci0tLQ0KIC4uLi9iaW5kaW5ncy9pMmMvbm92YXRlayxudDcyNnh4LWkyYy55YW1sICAgICB8IDQ3
ICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJj
L25vdmF0ZWssbnQ3MjZ4eC1pMmMueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9ub3ZhdGVrLG50NzI2eHgtaTJjLnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL25vdmF0ZWssbnQ3MjZ4eC1pMmMueWFtbA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uMDgyNmVlOWVjODMxDQot
LS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJj
L25vdmF0ZWssbnQ3MjZ4eC1pMmMueWFtbA0KQEAgLTAsMCArMSw0NyBAQA0KKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEu
Mg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaTJjL25vdmF0ZWss
bnQ3MjZ4eC1pMmMueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMNCisNCittYWludGFpbmVyczoNCisgIC0gQmVuIEh1YW5nIDxiZW5f
aHVhbmdAbm92YXRlay5jb20udHc+DQorICAtIEphc29uIEpKIFd1IDxqYXNvbl9qal93dUBub3Zh
dGVrLmNvbS50dz4NCisNCit0aXRsZTogTm92YXRlayBOVDcyNnh4IFNvQyBJMkMgbWFzdGVyIGNv
bnRyb2xsZXINCisNCithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvaTJjL2kyYy1jb250cm9s
bGVyLnlhbWwjDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBu
b3ZhdGVrLG50NzI2eHhfaTJjDQorDQorICBudnQsaHdtb2RzOg0KKyAgICBkZXNjcmlwdGlvbjog
TmFtZSBvZiBlYWNoIGkyYyBwaW4sIG11c3QgYmUgbmFtZWQgd2l0aCAiaTJjWCIgKFggaXMNCisg
ICAgICAgICAgICAgICAgIGFuIGludGVnZXIgc3RhcnRpbmcgZnJvbSAwKQ0KKyAgICBtaW5JdGVt
czogMQ0KKw0KKyAgYnVzLWVuYWJsZToNCisgICAgZGVzY3JpcHRpb246IGVuYWJsZSB0aGlzIGky
YyBwaW4gZnVuY3Rpb24gb3Igbm90DQorICAgIG1heEl0ZW1zOiAxDQorDQorICByZWc6DQorICAg
IG1heEl0ZW1zOiA0DQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBtYXhJdGVtczogMw0KKw0KKyAg
Y2xvY2stZnJlcXVlbmN5Og0KKyAgICBkZXNjcmlwdGlvbjogT3BlcmF0aW9uIGNsb2NrIGZyZXF1
ZW5jeSBvZiBpMmMgaW4ga0h6LiBEZWZhdWx0IGlzIDEwMGtIei4NCisgICAgZGVmYXVsdDogMTAw
DQorICAgIG1heEl0ZW1zOiAxDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0g
YnVzLWVuYWJsZQ0KKyAgLSBudnQsaHdtb2RzDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQor
DQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KLS0gDQoyLjQwLjENCg==

--__=_Part_Boundary_002_1601237780.428716608--

