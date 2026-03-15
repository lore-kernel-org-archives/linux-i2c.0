Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624137C0ED
	for <linux-i2c@vger.kernel.org>; Sun, 15 Mar 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773610566; cv=none; b=X5QxJTgCAo4cU/V3TWUsBC4P9t4LfOCn3NyufRZB16ntq6RjgtWlV5CwXlt+AHRqcAjB3nA0hLs/QeIrKZfvUgPx/A6AIZwzEUHC9WSR6dT9PKxFKM3jxMeuXe9FdZnyUQ1guOs4MQREUh/ZNqpHnG08k0Af34JusOC6LTwRax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773610566; c=relaxed/simple;
	bh=o7trqVei18a8K6anFaToDsX9xeFct+Q/hQ1+Rwxz73g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rzz/lwGg+Ut0vhFapcCCFeluZ1IhQOvpWLtVJ0o1SMhUf/4ryeE9KKJGDZq7Hmm1QW1esnZk371Qp///baQmQWf3pi5mDyw46WJB7GArXcKP36UpYCa/IuGE4ZvHA6lYHhvEp+mj9Gmj54R5lzAzgikfxo42wAMg/09z6b5fgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=OT49QBAv; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="OT49QBAv"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3596C2C05BD;
	Mon, 16 Mar 2026 10:26:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1773610016;
	bh=o7trqVei18a8K6anFaToDsX9xeFct+Q/hQ1+Rwxz73g=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=OT49QBAvXXjt09I0W+PvCui2J59tJyBMJRiWmgTXH6hJmnJvGqdnpAY9TnkjNfW2v
	 kZOuSfTHOgWr9qr14A4SHQYMh+1awT3ntFltVU8NNmwYkaydS+2/jZukZOz0mQ4sO9
	 uYsHdBtSSG9ThWhPVua20HF8w/BOTAQHwwpQSwml9I4+15VQXzsOvClqhUDjNwoka7
	 Q8DjD/7ru1FY/cCt6iunFnvMHiwkmyjezicynwfHx0qBHwsF1qJUiTIAo5bxzlxrh0
	 qIIHt+AZ8D5FLBzKganvgDb/deZ3o+49Hk35uf+vocsHzR5pN2o9BqV2+AOmO/JtBo
	 LgCLvNUAEQcJw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69b724200001>; Mon, 16 Mar 2026 10:26:56 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 16 Mar 2026 10:26:55 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 16 Mar 2026 10:26:55 +1300
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
Thread-Index: AQHcs4xrIL0qfGb1U0GyvvEnqztOg7WvQ9oA
Date: Sun, 15 Mar 2026 21:26:55 +0000
Message-ID: <6b283fb8-5d80-4ffb-b21c-8d8d8fd025be@alliedtelesis.co.nz>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-5-adilov@disroot.org>
In-Reply-To: <20260314082628.25206-5-adilov@disroot.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D73ECDB14ABAFD49A9AE4F4EA92402E7@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=EcprQ+mC c=1 sm=1 tr=0 ts=69b72420 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=LpNgXrTXAAAA:8 a=fjHevkijCDgla4ZAOPQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=LqOpv0_-CX5VL_7kjZO3:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNC8wMy8yMDI2IDIxOjI2LCBSdXN0YW0gQWRpbG92IHdyb3RlOg0KPiBJbiBSVEw5NjA3
QyBpMmMgY29udHJvbGxlciwgaW4gb3JkZXIgdG8gaW5kaWNhdGUgdGhhdCB0aGUgd2lkdGggb2YN
Cj4gbWVtb3J5IGFkZHJlc3MgaXMgOCBiaXRzLCAwIGlzIHdyaXR0ZW4gdG8gTUVNX0FERFJfV0lE
VEggZmllbGQgYXMNCj4gb3Bwb3NlZCB0byAxIGZvciBSVEw5MzAwIGFuZCBSVEw5MzEwLg0KPg0K
PiBJbnRyb2R1Y2UgYSBuZXcgcHJvcGVydHkgdG8gYSBkcml2ZXIgZGF0YSB0byBpbmRpY2F0ZSB3
aGF0IHZhbHVlDQo+IG5lZWQgdG8gd3JpdHRlbiB0byBNRU1fQUREUl9XSURUSCBmaWVsZCBmb3Ig
dGhpcyBjYXNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSdXN0YW0gQWRpbG92IDxhZGlsb3ZAZGlz
cm9vdC5vcmc+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5jIHwg
OCArKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5j
IGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1ydGw5MzAwLmMNCj4gaW5kZXggMjUyNWI1N2E5ZDAz
Li44NmE4MmYyYzNjZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRs
OTMwMC5jDQo+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcnRsOTMwMC5jDQo+IEBAIC02
MCw2ICs2MCw3IEBAIHN0cnVjdCBydGw5MzAwX2kyY19kcnZfZGF0YSB7DQo+ICAgCXUzMiB3ZF9y
ZWc7DQo+ICAgCXU4IG1heF9uY2hhbjsNCj4gICAJdTggbWF4X2RhdGFfbGVuOw0KPiArCXU4IHJl
Z19hZGRyXzhiaXRfbGVuOw0KPiAgIH07DQo+ICAgDQo+ICAgI2RlZmluZSBSVEw5MzAwX0kyQ19N
VVhfTkNIQU4JOA0KPiBAQCAtMTA1LDYgKzEwNiw3IEBAIHN0cnVjdCBydGw5MzAwX2kyY194ZmVy
IHsNCj4gICAjZGVmaW5lIFJUTDkzMDBfSTJDX01TVF9EQVRBX1dPUkQyCQkJMHgxMA0KPiAgICNk
ZWZpbmUgUlRMOTMwMF9JMkNfTVNUX0RBVEFfV09SRDMJCQkweDE0DQo+ICAgI2RlZmluZSBSVEw5
MzAwX0kyQ19NU1RfR0xCX0NUUkwJCQkweDM4NA0KPiArI2RlZmluZSBSVEw5MzAwX1JFR19BRERS
XzhCSVRfTEVOCQkJMQ0KPiAgIA0KPiAgICNkZWZpbmUgUlRMOTMxMF9JMkNfTVNUX0lGX0NUUkwJ
CQkJMHgxMDA0DQo+ICAgI2RlZmluZSBSVEw5MzEwX0kyQ19NU1RfSUZfU0VMCQkJCTB4MTAwOA0K
PiBAQCAtMjk5LDYgKzMwMSw3IEBAIHN0YXRpYyBpbnQgcnRsOTMwMF9pMmNfc21idXNfeGZlcihz
dHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHUxNiBhZGRyLCB1bnNpZ25lZCBzDQo+ICAgCQkJCSAg
dW5pb24gaTJjX3NtYnVzX2RhdGEgKmRhdGEpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgcnRsOTMwMF9p
MmNfY2hhbiAqY2hhbiA9IGkyY19nZXRfYWRhcGRhdGEoYWRhcCk7DQo+ICsJY29uc3Qgc3RydWN0
IHJ0bDkzMDBfaTJjX2Rydl9kYXRhICpkcnZfZGF0YTsNCj4gICAJc3RydWN0IHJ0bDkzMDBfaTJj
ICppMmMgPSBjaGFuLT5pMmM7DQo+ICAgCXN0cnVjdCBydGw5MzAwX2kyY194ZmVyIHhmZXIgPSB7
MH07DQo+ICAgCWludCByZXQ7DQo+IEBAIC0zMDgsNiArMzExLDcgQEAgc3RhdGljIGludCBydGw5
MzAwX2kyY19zbWJ1c194ZmVyKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCwgdTE2IGFkZHIsIHVu
c2lnbmVkIHMNCj4gICANCj4gICAJZ3VhcmQocnRsOTMwMF9pMmMpKGkyYyk7DQo+ICAgDQo+ICsJ
ZHJ2X2RhdGEgPSBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoaTJjLT5kZXYpOw0KPiAgIAlyZXQgPSBy
dGw5MzAwX2kyY19jb25maWdfY2hhbihpMmMsIGNoYW4pOw0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJ
cmV0dXJuIHJldDsNCj4gQEAgLTMxNSw3ICszMTksNyBAQCBzdGF0aWMgaW50IHJ0bDkzMDBfaTJj
X3NtYnVzX3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICphZGFwLCB1MTYgYWRkciwgdW5zaWduZWQg
cw0KPiAgIAl4ZmVyLmRldl9hZGRyID0gYWRkciAmIDB4N2Y7DQo+ICAgCXhmZXIud3JpdGUgPSAo
cmVhZF93cml0ZSA9PSBJMkNfU01CVVNfV1JJVEUpOw0KPiAgIAl4ZmVyLnJlZ19hZGRyID0gY29t
bWFuZDsNCj4gLQl4ZmVyLnJlZ19hZGRyX2xlbiA9IDE7DQo+ICsJeGZlci5yZWdfYWRkcl9sZW4g
PSBkcnZfZGF0YS0+cmVnX2FkZHJfOGJpdF9sZW47DQo+ICAgDQo+ICAgCXN3aXRjaCAoc2l6ZSkg
ew0KPiAgIAljYXNlIEkyQ19TTUJVU19CWVRFOg0KPiBAQCAtNTAxLDYgKzUwNSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcnRsOTMwMF9pMmNfZHJ2X2RhdGEgcnRsOTMwMF9pMmNfZHJ2X2RhdGEg
PSB7DQo+ICAgCS53ZF9yZWcgPSBSVEw5MzAwX0kyQ19NU1RfREFUQV9XT1JEMCwNCj4gICAJLm1h
eF9uY2hhbiA9IFJUTDkzMDBfSTJDX01VWF9OQ0hBTiwNCj4gICAJLm1heF9kYXRhX2xlbiA9IFJU
TDkzMDBfSTJDX01BWF9EQVRBX0xFTiwNCj4gKwkucmVnX2FkZHJfOGJpdF9sZW4gPSBSVEw5MzAw
X1JFR19BRERSXzhCSVRfTEVOLA0KPiAgIH07DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVj
dCBydGw5MzAwX2kyY19kcnZfZGF0YSBydGw5MzEwX2kyY19kcnZfZGF0YSA9IHsNCj4gQEAgLTUy
NCw2ICs1MjksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0bDkzMDBfaTJjX2Rydl9kYXRhIHJ0
bDkzMTBfaTJjX2Rydl9kYXRhID0gew0KPiAgIAkud2RfcmVnID0gUlRMOTMxMF9JMkNfTVNUX0RB
VEFfQ1RSTCwNCj4gICAJLm1heF9uY2hhbiA9IFJUTDkzMTBfSTJDX01VWF9OQ0hBTiwNCj4gICAJ
Lm1heF9kYXRhX2xlbiA9IFJUTDkzMDBfSTJDX01BWF9EQVRBX0xFTiwNCj4gKwkucmVnX2FkZHJf
OGJpdF9sZW4gPSBSVEw5MzAwX1JFR19BRERSXzhCSVRfTEVOLA0KPiAgIH07DQo+ICAgDQo+ICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaTJjX3J0bDkzMDBfZHRfaWRzW10gPSB7
