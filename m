Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884C37CD25
	for <linux-i2c@vger.kernel.org>; Sun, 15 Mar 2026 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611105; cv=none; b=BzTSt9YqLavK19Xpqh5aBwq+DF5c4Wi0tj4Hqo4kIb2z6cJTOFfCD8cw1jdi+/G9KTd1iNUSz2FRtvdlba+AG4NnGZ1BiIa6frjsZe0gomIuaq3QWk0cN6tDN0X0EXeRc7vrP2FCauBH5hYTStmhY2LeW4RHMrE0W3fcSxvet80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611105; c=relaxed/simple;
	bh=9pyVlvPC76KcMClHfgwkfU8R1Q34ey2Pp/yM0eEZswM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFLPXRPgn4MSGbpHOYOVuDQ9jhSaEeUmLprN4prP3iEA3AQd2zrp616tuGD+CRuTXettweOT0H8kwyetfwac51KSxdyESEkpvZamclxKaLTb4OMetBWP9fUbkkSOAznEQEwCmIvH0NM0G4Z/uK3yQ5Z68GSMatitZCTnhyX3g70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DqRYR57v; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DqRYR57v"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D40432C05BD;
	Mon, 16 Mar 2026 10:45:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1773611100;
	bh=9pyVlvPC76KcMClHfgwkfU8R1Q34ey2Pp/yM0eEZswM=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=DqRYR57vnH3rqySK1vjPaRZnuPyY2QQIkySMLNBy8Z/gueMPCcG8IFjxbjhnmpDem
	 lG8VQaOocfQLXhZmw2AUdk83hBdVP+xNThqVrXYOrA4zGyjoLbFdjLwYfg2QSOiMsy
	 daPIC5gpkhy6ywP+q1ioR7cCGNHdTHasxQgxDGzrhIgmVTLCcFIB1MOkOg7a8/99Im
	 q8dKBKa3xlNIVYg0C5hT8wh2c88vZNk+S7i28SCHqBxUoP0Sr1mo6pW+iss6D6tjAv
	 xZnKnhOqPr+YlOwUtClNo31EkxRSlWh/OH8tC91NBHNQaZ+XWuWEeh3Ey42kRe9N0e
	 yxv+g9NPFj2fw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69b7285c000a>; Mon, 16 Mar 2026 10:45:00 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 16 Mar 2026 10:45:00 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 16 Mar 2026 10:45:00 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Rustam Adilov <adilov@disroot.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Thread-Topic: [PATCH 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Thread-Index: AQHcs4xiMjFOEDKSO06/HZHP90Z4vrWvSOeA
Date: Sun, 15 Mar 2026 21:45:00 +0000
Message-ID: <3fb8f700-a77c-4713-b3e2-7abd84d4a659@alliedtelesis.co.nz>
References: <20260314082628.25206-1-adilov@disroot.org>
In-Reply-To: <20260314082628.25206-1-adilov@disroot.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <504EC4280CA57D478CB8C679DBD96281@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=EcprQ+mC c=1 sm=1 tr=0 ts=69b7285c a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=WczAkwAvwwI12XJ2doMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgUnVzdGFtLA0KDQpPbiAxNC8wMy8yMDI2IDIxOjI2LCBSdXN0YW0gQWRpbG92IHdyb3RlOg0K
PiBUaGlzIHBhdGNoIHNlcmllcyBmb3IgdGhlIFJUTDkzMDAgSTJDIGRyaXZlciBhZGRzIGkyYyBz
dXBwb3J0IGZvcg0KPiBSVEw5NjA3QyBTb0MuIFRoZXkgYXJlIHNvbWV3aGF0IGRpZmZlcmVudCB0
byB0aGUgUlRMOTMwMCBhbmQNCj4gUlRMOTMxMCBidXQgbm90IGVub3VnaCB0byB3YXJyYW50IGEg
bmV3IHdob2xlIGRyaXZlci4NCj4NCj4gVGhlIHBhdGNoIHNlcmllcyB3YXMgc3BsaXQgaW50byBw
YXRjaGVzIHRoYXQgYWRkL2NoYW5nZSBzb21ldGhpbmcgaW4gdGhlDQo+IGRyaXZlciB0byBzbW9v
dGggb3V0IHRoZSBSVEw5NjA3QyBzdXBwb3J0IGFkZGl0aW9uIGluIHRoZSBlbmQgYW5kIGZvcg0K
PiBlYXNlIG9mIHJldmlldy4gQmVjYXVzZSBvZiB0aGF0LCB0aGUgcGF0Y2ggOCBkZXBlbmRzIG9u
IGFsbCB0aGUgcHJpb3INCj4gcGF0Y2hlcyBiZWZvcmUgaXQuDQo+DQo+IFJUTDk2MDdDIHByaW1h
cmx5IHVzZXMgdGhlIGkyYyBjb250cm9sbGVyIGZvciBjb21tdW5pY2F0aW9uIHdpdGggbGFzZXIN
Cj4gZHJpdmVyIG92ZXIgb24gaTJjIGludGVyZmFjZSAxIG9yIDIuDQo+DQo+IEkgaGF2ZSBzdWNj
ZXNzZnVsbHkgdGVzdGVkIHRoZSBieXRlIHJlYWQgb3BlcmF0aW9ucyBvbiBteSBSVEw5NjA3QyBi
b2FyZA0KPiB3aGljaCBoYXMgR04yNUw5NSBsYXNlciBkcml2ZXIgaW4gT3BlbldydC4NCj4NCj4g
UnVzdGFtIEFkaWxvdiAoOCk6DQo+ICAgIGkyYzogcnRsOTMwMDogc3BsaXQgZGF0YV9yZWcgaW50
byByZWFkIGFuZCB3cml0ZSByZWcNCj4gICAgaTJjOiBydGw5MzAwOiBpbnRyb2R1Y2UgbWF4IGxl
bmd0aCBwcm9wZXJ0eSB0byBkcml2ZXIgZGF0YQ0KPiAgICBpMmM6IHJ0bDkzMDA6IGludHJvZHVj
ZSBGX0JVU1kgdG8gdGhlIHJlZ19maWVsZHMgc3RydWN0DQo+ICAgIGkyYzogcnRsOTMwMDogaW50
cm9kdWNlIGEgcHJvcGVydHkgZm9yIDggYml0IHdpZHRoIHJlZyBhZGRyZXNzDQo+ICAgIGkyYzog
cnRsOTMwMDogaW50cm9kdWNlIGNsayBzdHJ1Y3QgZm9yIHVwY29taW5nIHJ0bDk2MDcgc3VwcG9y
dA0KPiAgICBpMmM6IHJ0bDkzMDA6IGludG9kdWNlIG5ldyBmdW5jdGlvbiBwcm9wZXJ0aWVzIHRv
IGRyaXZlciBkYXRhDQo+ICAgIGR0LWJpbmRpbmdzOiBpMmM6IHJlYWx0ZWsscnRsOTMwMS1pMmM6
IGV4dGVuZCBmb3IgUlRMOTYwN0Mgc3VwcG9ydA0KPiAgICBpMmM6IHJ0bDkzMDA6IGFkZCBSVEw5
NjA3QyBpMmMgY29udHJvbGxlciBzdXBwb3J0DQoNClBhdGNoZXMgMS01LCA4DQoNClJldmlld2Vk
LWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQoN
ClRoZXJlIGlzIGEgYml0IG9mIGEgY29uZmxpY3Qgd2l0aCBhbm90aGVyIHRvcGljIHRoYXQgaXMg
ZWl0aGVyIGluLWZsaWdodCANCm9yIGxvc3QgZm9yIHBhdGNoIDYgKEkgcmVwbGllZCB0byB0aGF0
IG9uZSBzcGVjaWZpY2FsbHkpIGFuZCBJIHNlZSB5b3UgDQphbmQgS3J6eXp0b2YgYXJlIHN0aWxs
IGRpc2N1c3Npb24gdGhlIGR0LWJpbmRpbmdzIGNoYW5nZXMuDQoNCj4NCj4gICAuLi4vYmluZGlu
Z3MvaTJjL3JlYWx0ZWsscnRsOTMwMS1pMmMueWFtbCAgICAgfCAgMTUgKysNCj4gICBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLXJ0bDkzMDAuYyAgICAgICAgICAgICAgfCAxNzkgKysrKysrKysrKysr
KysrLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNjUgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRp
b25zKC0pDQo+
