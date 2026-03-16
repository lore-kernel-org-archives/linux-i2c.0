Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892F3EE1E1
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692674; cv=none; b=S5bjfrxuNL4qxAUdCSWZRz5qsqGuZ+nlvHzAaLtiHlqkjTHGOhethCrGmAW0k74AAFtxA29QqH91L8yrYfInFj31HpOmXS/82SBArjgAzinATFfuOpMOVNJGtdmc9GsDlilrmKy2oFAalEXltOoQejXDWF7nf1g0Ur7hccrhpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692674; c=relaxed/simple;
	bh=rTLaEIhnTxxY0mZimuYVhC+XuPvdPac1m0noGuVsluo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qi3r+gnovY4xBKjJeu7olhuw7uUfikA0SfVEviu2sfUANK5trFlsAqCe3YVpY3WjoApY9nyxXlRWvts6J+JyvpADp1HM+wSzBCHz4v5gGdyqfVgHWNDZZJ56Rp8icfm6UsdsdN6xv2Vs/FrYnrNhlcQnlllJeA8aLfLQLnOw0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ntysSkQz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ntysSkQz"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A3DF82C0488;
	Tue, 17 Mar 2026 09:24:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1773692668;
	bh=rTLaEIhnTxxY0mZimuYVhC+XuPvdPac1m0noGuVsluo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ntysSkQzzeWKyYgPm7eeNZGlFMgwgcGb1THF6SKDASuPlW3cKQq7nZm3ZaFsyvcPA
	 uE5+UfH3WQp5Lhi6XnU42wJnm/sa1cJD9CKmRWuhWWTh0boK1poyjM2TaMWvCSaHNu
	 RQ/LIumSXNKvfukp/qAC8AL3lzzYQkLsg0phvHTGRN0dQHIcucfae/6RoSksuXrmz2
	 hUhVCnsf9qzbZ24SwBo4EezXCFRzowbObeRSvtcAEwmMJ8on0JDERLvs18YucMBKw2
	 Q2krI8BZYg/fCBHIJbRkzP3yDbbxhTLJhkBc+WlqwL7FgUBrq/6YhvUj2xBdB+Wgvh
	 jhKaqcVsOrcgQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69b866fc0001>; Tue, 17 Mar 2026 09:24:28 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 17 Mar 2026 09:24:28 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Tue, 17 Mar 2026 09:24:28 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Rustam Adilov <adilov@disroot.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] i2c: rtl9300: introduce a property for 8 bit width
 reg address
Thread-Topic: [PATCH 4/8] i2c: rtl9300: introduce a property for 8 bit width
 reg address
Thread-Index: AQHcs4xrIL0qfGb1U0GyvvEnqztOg7WvRUGAgAE9qwCAAEHSgA==
Date: Mon, 16 Mar 2026 20:24:28 +0000
Message-ID: <e689bc8e-63bf-41bf-94f5-30305b9b94d6@alliedtelesis.co.nz>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-5-adilov@disroot.org>
 <d91f5897-c565-4574-81e4-5b0624da2766@alliedtelesis.co.nz>
 <c03ba2a5b0fa3ee0714d9e6cf475a1c6@disroot.org>
In-Reply-To: <c03ba2a5b0fa3ee0714d9e6cf475a1c6@disroot.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1308D56DDF48A94F85C42665F4428598@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=EcprQ+mC c=1 sm=1 tr=0 ts=69b866fc a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=LpNgXrTXAAAA:8 a=whH2sxI45A99ThKM1eUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=LqOpv0_-CX5VL_7kjZO3:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNy8wMy8yMDI2IDA1OjI4LCBSdXN0YW0gQWRpbG92IHdyb3RlOg0KPiBIZWxsbywNCj4g
T24gMjAyNi0wMy0xNSAyMTozMSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEhpIFJ1c3RhbSwN
Cj4+DQo+PiAoc29ycnkgSSBtaWdodCBoYXZlIHByZW1hdHVyZWx5IGhpdCBzZW5kIG9uIGFuIGVh
cmxpZXIgcmVwbHkpDQo+Pg0KPj4gT24gMTQvMDMvMjAyNiAyMToyNiwgUnVzdGFtIEFkaWxvdiB3
cm90ZToNCj4+PiBJbiBSVEw5NjA3QyBpMmMgY29udHJvbGxlciwgaW4gb3JkZXIgdG8gaW5kaWNh
dGUgdGhhdCB0aGUgd2lkdGggb2YNCj4+PiBtZW1vcnkgYWRkcmVzcyBpcyA4IGJpdHMsIDAgaXMg
d3JpdHRlbiB0byBNRU1fQUREUl9XSURUSCBmaWVsZCBhcw0KPj4+IG9wcG9zZWQgdG8gMSBmb3Ig
UlRMOTMwMCBhbmQgUlRMOTMxMC4NCj4+Pg0KPj4+IEludHJvZHVjZSBhIG5ldyBwcm9wZXJ0eSB0
byBhIGRyaXZlciBkYXRhIHRvIGluZGljYXRlIHdoYXQgdmFsdWUNCj4+PiBuZWVkIHRvIHdyaXR0
ZW4gdG8gTUVNX0FERFJfV0lEVEggZmllbGQgZm9yIHRoaXMgY2FzZS4NCj4+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFJ1c3RhbSBBZGlsb3YgPGFkaWxvdkBkaXNyb290Lm9yZz4NCj4+PiAtLS0NCj4+
PiAgICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXJ0bDkzMDAuYyB8IDggKysrKysrKy0NCj4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1ydGw5MzAwLmMgYi9kcml2ZXJz
L2kyYy9idXNzZXMvaTJjLXJ0bDkzMDAuYw0KPj4+IGluZGV4IDI1MjViNTdhOWQwMy4uODZhODJm
MmMzY2UwIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5j
DQo+Pj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1ydGw5MzAwLmMNCj4+PiBAQCAtNjAs
NiArNjAsNyBAQCBzdHJ1Y3QgcnRsOTMwMF9pMmNfZHJ2X2RhdGEgew0KPj4+ICAgIAl1MzIgd2Rf
cmVnOw0KPj4+ICAgIAl1OCBtYXhfbmNoYW47DQo+Pj4gICAgCXU4IG1heF9kYXRhX2xlbjsNCj4+
PiArCXU4IHJlZ19hZGRyXzhiaXRfbGVuOw0KPj4+ICAgIH07DQo+Pj4gICAgDQo+Pj4gICAgI2Rl
ZmluZSBSVEw5MzAwX0kyQ19NVVhfTkNIQU4JOA0KPj4+IEBAIC0xMDUsNiArMTA2LDcgQEAgc3Ry
dWN0IHJ0bDkzMDBfaTJjX3hmZXIgew0KPj4+ICAgICNkZWZpbmUgUlRMOTMwMF9JMkNfTVNUX0RB
VEFfV09SRDIJCQkweDEwDQo+Pj4gICAgI2RlZmluZSBSVEw5MzAwX0kyQ19NU1RfREFUQV9XT1JE
MwkJCTB4MTQNCj4+PiAgICAjZGVmaW5lIFJUTDkzMDBfSTJDX01TVF9HTEJfQ1RSTAkJCTB4Mzg0
DQo+Pj4gKyNkZWZpbmUgUlRMOTMwMF9SRUdfQUREUl84QklUX0xFTgkJCTENCj4+PiAgICANCj4+
PiAgICAjZGVmaW5lIFJUTDkzMTBfSTJDX01TVF9JRl9DVFJMCQkJCTB4MTAwNA0KPj4+ICAgICNk
ZWZpbmUgUlRMOTMxMF9JMkNfTVNUX0lGX1NFTAkJCQkweDEwMDgNCj4+PiBAQCAtMjk5LDYgKzMw
MSw3IEBAIHN0YXRpYyBpbnQgcnRsOTMwMF9pMmNfc21idXNfeGZlcihzdHJ1Y3QgaTJjX2FkYXB0
ZXIgKmFkYXAsIHUxNiBhZGRyLCB1bnNpZ25lZCBzDQo+Pj4gICAgCQkJCSAgdW5pb24gaTJjX3Nt
YnVzX2RhdGEgKmRhdGEpDQo+Pj4gICAgew0KPj4+ICAgIAlzdHJ1Y3QgcnRsOTMwMF9pMmNfY2hh
biAqY2hhbiA9IGkyY19nZXRfYWRhcGRhdGEoYWRhcCk7DQo+Pj4gKwljb25zdCBzdHJ1Y3QgcnRs
OTMwMF9pMmNfZHJ2X2RhdGEgKmRydl9kYXRhOw0KPj4+ICAgIAlzdHJ1Y3QgcnRsOTMwMF9pMmMg
KmkyYyA9IGNoYW4tPmkyYzsNCj4+PiAgICAJc3RydWN0IHJ0bDkzMDBfaTJjX3hmZXIgeGZlciA9
IHswfTsNCj4+PiAgICAJaW50IHJldDsNCj4+PiBAQCAtMzA4LDYgKzMxMSw3IEBAIHN0YXRpYyBp
bnQgcnRsOTMwMF9pMmNfc21idXNfeGZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHUxNiBh
ZGRyLCB1bnNpZ25lZCBzDQo+Pj4gICAgDQo+Pj4gICAgCWd1YXJkKHJ0bDkzMDBfaTJjKShpMmMp
Ow0KPj4+ICAgIA0KPj4+ICsJZHJ2X2RhdGEgPSBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoaTJjLT5k
ZXYpOw0KPj4+ICAgIAlyZXQgPSBydGw5MzAwX2kyY19jb25maWdfY2hhbihpMmMsIGNoYW4pOw0K
Pj4+ICAgIAlpZiAocmV0KQ0KPj4+ICAgIAkJcmV0dXJuIHJldDsNCj4+PiBAQCAtMzE1LDcgKzMx
OSw3IEBAIHN0YXRpYyBpbnQgcnRsOTMwMF9pMmNfc21idXNfeGZlcihzdHJ1Y3QgaTJjX2FkYXB0
ZXIgKmFkYXAsIHUxNiBhZGRyLCB1bnNpZ25lZCBzDQo+Pj4gICAgCXhmZXIuZGV2X2FkZHIgPSBh
ZGRyICYgMHg3ZjsNCj4+PiAgICAJeGZlci53cml0ZSA9IChyZWFkX3dyaXRlID09IEkyQ19TTUJV
U19XUklURSk7DQo+Pj4gICAgCXhmZXIucmVnX2FkZHIgPSBjb21tYW5kOw0KPj4+IC0JeGZlci5y
ZWdfYWRkcl9sZW4gPSAxOw0KPj4+ICsJeGZlci5yZWdfYWRkcl9sZW4gPSBkcnZfZGF0YS0+cmVn
X2FkZHJfOGJpdF9sZW47DQo+PiBGb3IgdGhpcyBvbmUgSSB3b25kZXIgaWYgd2UgY291bGQgY29t
ZSB1cCB3aXRoIHNvbWV0aGluZyB0aGF0IGludm9sdmVzIGENCj4+IHN1YnRyYWN0aW9uIGZvciB0
aGUgcnRsOTYwNz8gbGVuID0gMSBqdXN0IG1ha2VzIHNlbnNlIHRvIG1lIHNvIG1heWJlDQo+PiBS
VExfOTMwMF9BRERSX0xFTigxKSB3aGljaCBleHBhbmRzIHRvIDEgLSAwIG9uIHRoZSBydGw5MzAw
IGFuZCAxIC0gMSBvbg0KPj4gdGhlIHJ0bDk2MDcgd291bGQgYmUgZWFzaWVyIHRvIGZvbGxvdy4N
Cj4gSSBhbSBub3QgZW50aXJlbHkgc3VyZSBpIHVuZGVyc3RhbmQgdGhpcyBhcHByb2FjaC4gSXMg
UlRMXzkzMDBfQUREUl9MRU4oMSkNCj4gZ29ubmEgYmUgYSAiI2RlZmluZSI/IFdvdWxkIGxpa2Ug
dG8ga25vdyBiZWZvcmUgaSBwcm9jZWVkIHdpdGggcG9zc2libGUNCj4gY2hhbmdlcyBmb3IgdjIu
DQoNCkkgd2FzIHRoaW5raW5nDQoNCiNkZWZpbmUgUlRMXzkzMDBfQUREUl9MRU4obinCoCDCoCAo
KG4pIC0gZHJ2X2RhdGEtPnN1YnRyYWN0X2xlbikNCg0KT3Igc29tZXRoaW5nIGxpa2UgdGhhdCAo
SSBjb3VsZG4ndCB0aGluayBvZiBhIGJldHRlciBtYWNybyBuYW1lKS4NCg0KPiBBbmQgd291bGRu
J3Qgc29tZXRoaW5nIGxpa2UgdGhpcyB3b3JrIGp1c3QgYXMgd2VsbDoNCj4NCj4geGZlci5yZWdf
YWRkcl9sZW4gPSAxIC0gZHJ2X2RhdGEtPnN1YnRyYWN0X2xlbjsNCj4NCj4gQnV0IHRoZW4sIGkg
aG9uZXN0bHkgdGhpbmsgImRydl9kYXRhLT5yZWdfYWRkcl84Yml0X2xlbiIgd291bGQgYmUgYSBi
aXQgbGVzcw0KPiBjbHV0dGVyeT8NClByb2JhYmx5IGEgcXVlc3Rpb24gb2YgdGFzdGUuIEknbSBm
aW5lIHdpdGgga2VlcGluZyB5b3VyIG9yaWdpbmFsIA0KcmVnX2FkZHJfOGJpdF9sZW4gaXQgd2Fz
IG1vcmUgYSBjYXNlIG9mIG1lIHRoaW5raW5nICJob3cgaXMgdGhlIGxlbmd0aCANCm9mIGFuIDgt
Yml0IGNvbW1hbmQgYW55dGhpbmcgb3RoZXIgdGhhbiAxIiBidXQgSSBrbm93IHRoZSBhbnN3ZXIg
aXMgDQoiYmVjYXVzZSByZWFsdGVrIi4NCj4+IE5vdCBhIGRlYWwgYnJlYWtlciBqdXN0IHRob3Vn
aHQgSSdkIG1lbnRpb24gaXQuDQo+Pg0KPj4+ICAgIA0KPj4+ICAgIAlzd2l0Y2ggKHNpemUpIHsN
Cj4+PiAgICAJY2FzZSBJMkNfU01CVVNfQllURToNCj4+PiBAQCAtNTAxLDYgKzUwNSw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcnRsOTMwMF9pMmNfZHJ2X2RhdGEgcnRsOTMwMF9pMmNfZHJ2X2Rh
dGEgPSB7DQo+Pj4gICAgCS53ZF9yZWcgPSBSVEw5MzAwX0kyQ19NU1RfREFUQV9XT1JEMCwNCj4+
PiAgICAJLm1heF9uY2hhbiA9IFJUTDkzMDBfSTJDX01VWF9OQ0hBTiwNCj4+PiAgICAJLm1heF9k
YXRhX2xlbiA9IFJUTDkzMDBfSTJDX01BWF9EQVRBX0xFTiwNCj4+PiArCS5yZWdfYWRkcl84Yml0
X2xlbiA9IFJUTDkzMDBfUkVHX0FERFJfOEJJVF9MRU4sDQo+Pj4gICAgfTsNCj4+PiAgICANCj4+
PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0bDkzMDBfaTJjX2Rydl9kYXRhIHJ0bDkzMTBfaTJj
X2Rydl9kYXRhID0gew0KPj4+IEBAIC01MjQsNiArNTI5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBydGw5MzAwX2kyY19kcnZfZGF0YSBydGw5MzEwX2kyY19kcnZfZGF0YSA9IHsNCj4+PiAgICAJ
LndkX3JlZyA9IFJUTDkzMTBfSTJDX01TVF9EQVRBX0NUUkwsDQo+Pj4gICAgCS5tYXhfbmNoYW4g
PSBSVEw5MzEwX0kyQ19NVVhfTkNIQU4sDQo+Pj4gICAgCS5tYXhfZGF0YV9sZW4gPSBSVEw5MzAw
X0kyQ19NQVhfREFUQV9MRU4sDQo+Pj4gKwkucmVnX2FkZHJfOGJpdF9sZW4gPSBSVEw5MzAwX1JF
R19BRERSXzhCSVRfTEVOLA0KPj4+ICAgIH07DQo+Pj4gICAgDQo+Pj4gICAgc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgaTJjX3J0bDkzMDBfZHRfaWRzW10gPSB7
