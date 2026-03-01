Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C4302753
	for <linux-i2c@vger.kernel.org>; Sun,  1 Mar 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393373; cv=none; b=P61BVgQnwpNXP6KFGKUnoPFqFdOQX6EqFSVOUoZTJF6YiARjrOoYAglbiJ+PYXCv8ypcc3hzYWi3hFJjHSiWx763snk6dxurvfFqkenNtycXTGMWxh9TI41Ddut8//O/7TXU0dAde6HkhXv+9Nbeddw5zFeIC7HT0WJ/kLwlTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393373; c=relaxed/simple;
	bh=2NqTcIliIP77dCY1wsxxiykKVs/kDKw87cIQmtO8uXA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6GqP7c+VmPikFYDWlpZpXi72eyQZMFzOPnnXvxSnZY+3rMNWaVnzMajHz9rHrojvmygOjYyyBJR54CyKSSKLsqD3ISvQ6HJRxXZgwuy2pzFpil06J1RiqTHmU+jrytrThgqSc7LUGDaE1td39YnzeKDCVDQZkg6aZr4ViYFdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=XPQKmITe; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="XPQKmITe"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 361D12C083A
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 08:19:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1772392778;
	bh=2NqTcIliIP77dCY1wsxxiykKVs/kDKw87cIQmtO8uXA=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=XPQKmITeAAIMCJGLZuCOQQiLSghHxz8h1CU/sRuLmPFHUOkbgqT6AO+mHJjP6FjV6
	 MYBYJRw7LH23VqpSzddCsvtIkW9uuNhlCZjz4UAv9AASvPAbYdKlnQfAGw/pHzZ9aQ
	 fHnRijwwv1PEzl5W4ZKZyQqPcxEDloa0CrtunFa40lxNfCHieBaoURFxkBvLpLCqi2
	 QpqVU01UPN9loaLBPlWOsfoWqb3b43j7zbwK0E8s3RR2MP+ZMTmpanoBNRbMpGxpqj
	 8y5jfLHPB1ZwXSnFlXbU0DJclC68lqb8r2ikerwFnm4rTKL3ewODGezWmipjX9KL5e
	 cSntZFYO9vE4g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69a4914a0001>; Mon, 02 Mar 2026 08:19:38 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 2 Mar 2026 08:19:37 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 2 Mar 2026 08:19:37 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Jan Kantert <jan-kernel@kantert.net>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus
 speeds
Thread-Topic: [PATCH] i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus
 speeds
Thread-Index: AQHcp9nlfaiyPOZwFkOkq2cdAuASo7WZNw6A
Date: Sun, 1 Mar 2026 19:19:37 +0000
Message-ID: <4be6f824-fa05-490b-8414-e08e654523ff@alliedtelesis.co.nz>
References: <20260227111134.2163701-1-jan-kernel@kantert.net>
In-Reply-To: <20260227111134.2163701-1-jan-kernel@kantert.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <505EBE91AC551C449B7CCCA8D0AF953F@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a4914a a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=yYSUFh-PAAAA:8 a=DGfo-y3Mp4DUiHDfqWQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=CgABnY4_5IjXit5a9HeR:22
X-SEG-SpamProfiler-Score: 0

SGkgSmFuLA0KDQpPbiAyOC8wMi8yMDI2IDAwOjExLCBKYW4gS2FudGVydCB3cm90ZToNCj4gU29t
ZSBTRlAgbW9kdWxlcyBvbiBjZXJ0YWluIHN3aXRjaGVzIChmb3IgZXhhbXBsZSB0aGUgT05UaSBP
TlQtUzUwOENMLThTIGFuZA0KPiBYaWtlU3RvciBTS1M4MzAwLThYKSBleGhpYml0IHVucmVsaWFi
bGUgSTJDIGNvbW11bmljYXRpb24gYXQgdGhlIGN1cnJlbnRseQ0KPiBzdXBwb3J0ZWQgc3BlZWRz
LiBBZGQgc3VwcG9ydCBmb3IgNTAga0h6IGFuZCAyLjUgTUh6IEkyQyBidXMgbW9kZXMgb24gdGhl
DQo+IFJUTDkzMDAgdG8gaW1wcm92ZSBjb21wYXRpYmlsaXR5IHdpdGggdGhlc2UgZGV2aWNlcy4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogSmFuIEthbnRlcnQgPGphbi1rZXJuZWxAa2FudGVydC5uZXQ+
DQoNClJldmlld2VkLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVz
aXMuY28ubno+DQoNClRoYW5rcywNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2kyYy9idXNzZXMvaTJj
LXJ0bDkzMDAuYyB8IDE2ICsrKysrKysrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1ydGw5MzAw
LmMNCj4gaW5kZXggNjcyY2I5NzgwNjZkLi42N2E1YzQyMjhmYzkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5jDQo+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtcnRsOTMwMC5jDQo+IEBAIC0xMSwxMCArMTEsMTYgQEANCj4gICAjaW5jbHVkZSA8bGlu
dXgvdW5hbGlnbmVkLmg+DQo+ICAgDQo+ICAgZW51bSBydGw5MzAwX2J1c19mcmVxIHsNCj4gLQlS
VEw5MzAwX0kyQ19TVERfRlJFUSwNCj4gLQlSVEw5MzAwX0kyQ19GQVNUX0ZSRVEsDQo+ICsJUlRM
OTMwMF9JMkNfU1REX0ZSRVEsCQkJLy8gMTAwa0h6DQo+ICsJUlRMOTMwMF9JMkNfRkFTVF9GUkVR
LAkJCS8vIDQwMGtIeg0KPiArCVJUTDkzMDBfSTJDX1NVUEVSX0ZBU1RfRlJFUSwJCS8vIDIuNU1I
eg0KPiArCVJUTDkzMDBfSTJDX1NMT1dfRlJFUSwJCQkvLyA1MGtIeg0KPiAgIH07DQo+ICAgDQo+
ICsjZGVmaW5lIFJUTDkzMDBfSTJDX01BWF9TVVBFUl9GQVNUX0ZSRVEJCTI1MDAwMDANCj4gKyNk
ZWZpbmUgUlRMOTMwMF9JMkNfTUFYX1NMT1dfRlJFUQkJNTAwMDANCj4gKw0KPiArDQo+ICAgc3Ry
dWN0IHJ0bDkzMDBfaTJjOw0KPiAgIA0KPiAgIHN0cnVjdCBydGw5MzAwX2kyY19jaGFuIHsNCj4g
QEAgLTQzMyw2ICs0MzksMTIgQEAgc3RhdGljIGludCBydGw5MzAwX2kyY19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJY2FzZSBJMkNfTUFYX0ZBU1RfTU9ERV9GUkVR
Og0KPiAgIAkJCWNoYW4tPmJ1c19mcmVxID0gUlRMOTMwMF9JMkNfRkFTVF9GUkVROw0KPiAgIAkJ
CWJyZWFrOw0KPiArCQljYXNlIFJUTDkzMDBfSTJDX01BWF9TVVBFUl9GQVNUX0ZSRVE6DQo+ICsJ
CQljaGFuLT5idXNfZnJlcSA9IFJUTDkzMDBfSTJDX1NVUEVSX0ZBU1RfRlJFUTsNCj4gKwkJCWJy
ZWFrOw0KPiArCQljYXNlIFJUTDkzMDBfSTJDX01BWF9TTE9XX0ZSRVE6DQo+ICsJCQljaGFuLT5i
dXNfZnJlcSA9IFJUTDkzMDBfSTJDX1NMT1dfRlJFUTsNCj4gKwkJCWJyZWFrOw0KPiAgIAkJZGVm
YXVsdDoNCj4gICAJCQlkZXZfd2FybihpMmMtPmRldiwgIlNEQSVkIGNsb2NrLWZyZXF1ZW5jeSAl
ZCBub3Qgc3VwcG9ydGVkIHVzaW5nIGRlZmF1bHRcbiIsDQo+ICAgCQkJCSBzZGFfbnVtLCBjbG9j
a19mcmVxKTs=
