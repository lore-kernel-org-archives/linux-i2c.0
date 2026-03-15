Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BB264A65
	for <linux-i2c@vger.kernel.org>; Sun, 15 Mar 2026 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773610319; cv=none; b=An6CuBTlO4JXKYmoNfXs0q1mibBdUf5Hpl6bu5ymwAithhBnEawpddVrfXg2fNG6catdMOkZDh09KJRTPGNitdrFEjyZCHxk/ZEuFfrslXAK8YuELPvWpG3JSOm7YXf79e0sTzFEh2ac4yVDEx0nOvsUDcCYVfEsNrLkoA/RQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773610319; c=relaxed/simple;
	bh=K37l3s5Z93wysvYK4XZYnHruSwkE2n+yB5V1WZsaWIo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVNXIG0KqtlbqpD1GXZ52ptflVNBkc/6fnlhTJ7EVi9uMjgEZSV5KigMD48M7YNsyZefNDcLGcpgZmSkFdiFWgAcdF6QW7BmlbwdyWMYVKN110y6bwto5Qq3wIQ6AOHisx8QY3p9a9oxINJqo38t93K9BICc+D9YLGjqp9/lTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=wqf7o3Ux; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wqf7o3Ux"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 384712C0614;
	Mon, 16 Mar 2026 10:31:54 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1773610314;
	bh=K37l3s5Z93wysvYK4XZYnHruSwkE2n+yB5V1WZsaWIo=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=wqf7o3UxbQm3kOL8FCCeQP648ddBXSZyfDsvewIPv24ZCcIsX+DIWwS6Zq2Sj7Vzm
	 Nn/fM8ze8gIV+LSjEW0fXCZaRCKqO/IVz4ROMCNl0YZJ2Mnuc1yEWDprotdZAWxwS1
	 oWDk7hbcDejrDTsFhNm3pIM884nOYrsTd6tdbQJkzBtS86oOWaAS5iXBL7dLUKLFy0
	 NSoa30rWqcX3DwxPv/GUfdNU3pSTYkM1STj35il44a8X0VYphO9jBKG3rxXOGwpAXf
	 u35Pgzz7Uekfj4o1I/n350hSN1wnwPww59M9z7Qk3vcq9zn3dGXyhzQ9Ud/Fk41qGR
	 CkTK4USYIHJ4Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69b7254a0001>; Mon, 16 Mar 2026 10:31:54 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 16 Mar 2026 10:31:53 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 16 Mar 2026 10:31:53 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Rustam Adilov <adilov@disroot.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] i2c: rtl9300: introduce a property for 8 bit width
 reg address
Thread-Topic: [PATCH 4/8] i2c: rtl9300: introduce a property for 8 bit width
 reg address
Thread-Index: AQHcs4xrIL0qfGb1U0GyvvEnqztOg7WvRUGA
Date: Sun, 15 Mar 2026 21:31:53 +0000
Message-ID: <d91f5897-c565-4574-81e4-5b0624da2766@alliedtelesis.co.nz>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-5-adilov@disroot.org>
In-Reply-To: <20260314082628.25206-5-adilov@disroot.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F527538515C3F408AF5F82997EFC954@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=EcprQ+mC c=1 sm=1 tr=0 ts=69b7254a a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=LpNgXrTXAAAA:8 a=XCsCthptSie9v-chF9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=LqOpv0_-CX5VL_7kjZO3:22
X-SEG-SpamProfiler-Score: 0

SGkgUnVzdGFtLA0KDQooc29ycnkgSSBtaWdodCBoYXZlIHByZW1hdHVyZWx5IGhpdCBzZW5kIG9u
IGFuIGVhcmxpZXIgcmVwbHkpDQoNCk9uIDE0LzAzLzIwMjYgMjE6MjYsIFJ1c3RhbSBBZGlsb3Yg
d3JvdGU6DQo+IEluIFJUTDk2MDdDIGkyYyBjb250cm9sbGVyLCBpbiBvcmRlciB0byBpbmRpY2F0
ZSB0aGF0IHRoZSB3aWR0aCBvZg0KPiBtZW1vcnkgYWRkcmVzcyBpcyA4IGJpdHMsIDAgaXMgd3Jp
dHRlbiB0byBNRU1fQUREUl9XSURUSCBmaWVsZCBhcw0KPiBvcHBvc2VkIHRvIDEgZm9yIFJUTDkz
MDAgYW5kIFJUTDkzMTAuDQo+DQo+IEludHJvZHVjZSBhIG5ldyBwcm9wZXJ0eSB0byBhIGRyaXZl
ciBkYXRhIHRvIGluZGljYXRlIHdoYXQgdmFsdWUNCj4gbmVlZCB0byB3cml0dGVuIHRvIE1FTV9B
RERSX1dJRFRIIGZpZWxkIGZvciB0aGlzIGNhc2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFJ1c3Rh
bSBBZGlsb3YgPGFkaWxvdkBkaXNyb290Lm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1ydGw5MzAwLmMgfCA4ICsrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1ydGw5MzAwLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXJ0bDkzMDAuYw0K
PiBpbmRleCAyNTI1YjU3YTlkMDMuLjg2YTgyZjJjM2NlMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1ydGw5MzAwLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1ydGw5MzAwLmMNCj4gQEAgLTYwLDYgKzYwLDcgQEAgc3RydWN0IHJ0bDkzMDBfaTJjX2Rydl9k
YXRhIHsNCj4gICAJdTMyIHdkX3JlZzsNCj4gICAJdTggbWF4X25jaGFuOw0KPiAgIAl1OCBtYXhf
ZGF0YV9sZW47DQo+ICsJdTggcmVnX2FkZHJfOGJpdF9sZW47DQo+ICAgfTsNCj4gICANCj4gICAj
ZGVmaW5lIFJUTDkzMDBfSTJDX01VWF9OQ0hBTgk4DQo+IEBAIC0xMDUsNiArMTA2LDcgQEAgc3Ry
dWN0IHJ0bDkzMDBfaTJjX3hmZXIgew0KPiAgICNkZWZpbmUgUlRMOTMwMF9JMkNfTVNUX0RBVEFf
V09SRDIJCQkweDEwDQo+ICAgI2RlZmluZSBSVEw5MzAwX0kyQ19NU1RfREFUQV9XT1JEMwkJCTB4
MTQNCj4gICAjZGVmaW5lIFJUTDkzMDBfSTJDX01TVF9HTEJfQ1RSTAkJCTB4Mzg0DQo+ICsjZGVm
aW5lIFJUTDkzMDBfUkVHX0FERFJfOEJJVF9MRU4JCQkxDQo+ICAgDQo+ICAgI2RlZmluZSBSVEw5
MzEwX0kyQ19NU1RfSUZfQ1RSTAkJCQkweDEwMDQNCj4gICAjZGVmaW5lIFJUTDkzMTBfSTJDX01T
VF9JRl9TRUwJCQkJMHgxMDA4DQo+IEBAIC0yOTksNiArMzAxLDcgQEAgc3RhdGljIGludCBydGw5
MzAwX2kyY19zbWJ1c194ZmVyKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCwgdTE2IGFkZHIsIHVu
c2lnbmVkIHMNCj4gICAJCQkJICB1bmlvbiBpMmNfc21idXNfZGF0YSAqZGF0YSkNCj4gICB7DQo+
ICAgCXN0cnVjdCBydGw5MzAwX2kyY19jaGFuICpjaGFuID0gaTJjX2dldF9hZGFwZGF0YShhZGFw
KTsNCj4gKwljb25zdCBzdHJ1Y3QgcnRsOTMwMF9pMmNfZHJ2X2RhdGEgKmRydl9kYXRhOw0KPiAg
IAlzdHJ1Y3QgcnRsOTMwMF9pMmMgKmkyYyA9IGNoYW4tPmkyYzsNCj4gICAJc3RydWN0IHJ0bDkz
MDBfaTJjX3hmZXIgeGZlciA9IHswfTsNCj4gICAJaW50IHJldDsNCj4gQEAgLTMwOCw2ICszMTEs
NyBAQCBzdGF0aWMgaW50IHJ0bDkzMDBfaTJjX3NtYnVzX3hmZXIoc3RydWN0IGkyY19hZGFwdGVy
ICphZGFwLCB1MTYgYWRkciwgdW5zaWduZWQgcw0KPiAgIA0KPiAgIAlndWFyZChydGw5MzAwX2ky
YykoaTJjKTsNCj4gICANCj4gKwlkcnZfZGF0YSA9IGRldmljZV9nZXRfbWF0Y2hfZGF0YShpMmMt
PmRldik7DQo+ICAgCXJldCA9IHJ0bDkzMDBfaTJjX2NvbmZpZ19jaGFuKGkyYywgY2hhbik7DQo+
ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiBAQCAtMzE1LDcgKzMxOSw3IEBAIHN0
YXRpYyBpbnQgcnRsOTMwMF9pMmNfc21idXNfeGZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAs
IHUxNiBhZGRyLCB1bnNpZ25lZCBzDQo+ICAgCXhmZXIuZGV2X2FkZHIgPSBhZGRyICYgMHg3ZjsN
Cj4gICAJeGZlci53cml0ZSA9IChyZWFkX3dyaXRlID09IEkyQ19TTUJVU19XUklURSk7DQo+ICAg
CXhmZXIucmVnX2FkZHIgPSBjb21tYW5kOw0KPiAtCXhmZXIucmVnX2FkZHJfbGVuID0gMTsNCj4g
Kwl4ZmVyLnJlZ19hZGRyX2xlbiA9IGRydl9kYXRhLT5yZWdfYWRkcl84Yml0X2xlbjsNCg0KRm9y
IHRoaXMgb25lIEkgd29uZGVyIGlmIHdlIGNvdWxkIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcgdGhh
dCBpbnZvbHZlcyBhIA0Kc3VidHJhY3Rpb24gZm9yIHRoZSBydGw5NjA3PyBsZW4gPSAxIGp1c3Qg
bWFrZXMgc2Vuc2UgdG8gbWUgc28gbWF5YmUgDQpSVExfOTMwMF9BRERSX0xFTigxKSB3aGljaCBl
eHBhbmRzIHRvIDEgLSAwIG9uIHRoZSBydGw5MzAwIGFuZCAxIC0gMSBvbiANCnRoZSBydGw5NjA3
IHdvdWxkIGJlIGVhc2llciB0byBmb2xsb3cuDQoNCk5vdCBhIGRlYWwgYnJlYWtlciBqdXN0IHRo
b3VnaHQgSSdkIG1lbnRpb24gaXQuDQoNCj4gICANCj4gICAJc3dpdGNoIChzaXplKSB7DQo+ICAg
CWNhc2UgSTJDX1NNQlVTX0JZVEU6DQo+IEBAIC01MDEsNiArNTA1LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBydGw5MzAwX2kyY19kcnZfZGF0YSBydGw5MzAwX2kyY19kcnZfZGF0YSA9IHsNCj4g
ICAJLndkX3JlZyA9IFJUTDkzMDBfSTJDX01TVF9EQVRBX1dPUkQwLA0KPiAgIAkubWF4X25jaGFu
ID0gUlRMOTMwMF9JMkNfTVVYX05DSEFOLA0KPiAgIAkubWF4X2RhdGFfbGVuID0gUlRMOTMwMF9J
MkNfTUFYX0RBVEFfTEVOLA0KPiArCS5yZWdfYWRkcl84Yml0X2xlbiA9IFJUTDkzMDBfUkVHX0FE
RFJfOEJJVF9MRU4sDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0bDkz
MDBfaTJjX2Rydl9kYXRhIHJ0bDkzMTBfaTJjX2Rydl9kYXRhID0gew0KPiBAQCAtNTI0LDYgKzUy
OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnRsOTMwMF9pMmNfZHJ2X2RhdGEgcnRsOTMxMF9p
MmNfZHJ2X2RhdGEgPSB7DQo+ICAgCS53ZF9yZWcgPSBSVEw5MzEwX0kyQ19NU1RfREFUQV9DVFJM
LA0KPiAgIAkubWF4X25jaGFuID0gUlRMOTMxMF9JMkNfTVVYX05DSEFOLA0KPiAgIAkubWF4X2Rh
dGFfbGVuID0gUlRMOTMwMF9JMkNfTUFYX0RBVEFfTEVOLA0KPiArCS5yZWdfYWRkcl84Yml0X2xl
biA9IFJUTDkzMDBfUkVHX0FERFJfOEJJVF9MRU4sDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpMmNfcnRsOTMwMF9kdF9pZHNbXSA9IHs=
