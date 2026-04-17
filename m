Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9E023ABBF;
	Fri, 17 Apr 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435756; cv=none; b=dlag9DCeoM8cj9TBCNNXacsJCOCoJetGHt1ZRyVHSavzAs39/rDHE1ySgdlXHE4n/0eMwsiAqx/jB8LzuGx6DXiFj8Jkz//qUUJvHqyzLWHOyixcooga7njv7frqOwfiJpJ9Rhl3LLtV9ljDILGUOVpd6+1vnW7Gfq0WPDh36So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435756; c=relaxed/simple;
	bh=T5p4o7NokXE655+xC9IM65bFKl/Ph7JMzow26nNmOYw=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=rdttdlCYLtsEoV6P+rfK/CYCSLniCqbXHd0zPJpJU1sx2S4uJe7EdnYAGAWnYk//UUwGeP6Bhauy9paX0eV+aPAucZXswgMBvDaG8BqwHADIuT3KnO5ia+RkHfnZDOJMHkTo0Y0FN4grREkhCOT9IdbDOP6+ot4qQfRuztAOrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=s65BUDbe reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="s65BUDbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=laMi9VWVfjUFij0Fy3F5i9dkS+GBxwvmJUfrr9GHoXg=; b=s65BUDbeKut2R
	erPj67gTmsIdUcC4bQ7Gjs7bYed2zQl0AoIgNtUTjIajA6T5EfH2A4g81jTU/Yw+
	l/FPf6ISF4Uo9ApAp+lMzfrOt9G4ZiwUFVYG5nViYNPSZEX2ZaU08ReZ/5gYJhNX
	GXTGmDAolB5xcBl6C1q8tLYjcyXHQo=
Received: from 23009200614$stu.xidian.edu.cn ( [113.200.174.18] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Fri, 17 Apr 2026
 22:22:25 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 22:22:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
To: linux-i2c@vger.kernel.org
Cc: wolfram@kernel.org, andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [BUG] I2C: i801: possible deadlock / hung task in i2c_smbus_xfer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <67fa1b6e.44c7.19d9bd25323.Coremail.23009200614@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkC2XbkiQuJpMNSdAQ--.40188W
X-CM-SenderInfo: qstqimqsqqliuu6v33wo0lvxldqovvfxof0/1tbiAgUGCGng-OO4-
	AAAsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBNYWludGFpbmVycywKCldlIG9ic2VydmVkIGEgcG90ZW50aWFsIGlzc3VlIGluIHRoZSBp
MmMtaTgwMSBkcml2ZXIgd2hpbGUgZnV6emluZyB0aGUgbGF0ZXN0IHVwc3RyZWFtIExpbnV4IGtl
cm5lbCB1c2luZyBhIGN1c3RvbWl6ZWQgc3l6a2FsbGVyLgoKRW52aXJvbm1lbnQ6CkhFQUQgY29t
bWl0OiA3ZDBhNjZlNGJiOTA4MWQ3NWM4MmVjNDk1N2M1MDAzNGNiMGVhNDQ5CmdpdCB0cmVlOiB1
cHN0cmVhbQoKTG9nczoKT3V0cHV0OiBodHRwczovL2dpdGh1Yi5jb20vbWFudWFsMC9jcmFzaC9i
bG9iL21haW4vMTNkNjliODRjYTY1ZGMxYzFjZTc2YWNmN2RhNGMyMzBkNzRjMGJiOS9yZXBvcnQw
Cktlcm5lbCBjb25maWc6IGh0dHBzOi8vZ2l0aHViLmNvbS9tYW51YWwwL2NyYXNoL2Jsb2IvbWFp
bi82LjE4LXN5emJvdC5jb25maWcKClByb2JsZW06ClVuZGVyIGZ1enppbmcsIG11bHRpcGxlIHRh
c2tzIGFyZSByZXBvcnRlZCBhcyBodW5nICg+MTQwcykgaW4gdW5pbnRlcnJ1cHRpYmxlIHNsZWVw
IChEIHN0YXRlKS4gVGhlIGlzc3VlIGlzIG5vdCByZWxpYWJseSByZXByb2R1Y2libGUgd2l0aCBh
IHNpbmdsZSByZXByb2R1Y2VyLCBidXQgb2NjdXJzIGNvbnNpc3RlbnRseSB1bmRlciBzdHJlc3Mu
CgpPYnNlcnZlZCBibG9ja2luZyBwYXR0ZXJuczoKVGFzayBzdHVjayBpbiBTTUJ1cyB0cmFuc2Fj
dGlvbjoKaTgwMV9ibG9ja190cmFuc2FjdGlvbl9ieXRlX2J5X2J5dGUKLT4gd2FpdF9mb3JfY29t
cGxldGlvbl90aW1lb3V0Ci0+IHNjaGVkdWxlX3RpbWVvdXQKCkNhbGwgdHJhY2U6Cmk4MDFfYmxv
Y2tfdHJhbnNhY3Rpb25fYnl0ZV9ieV9ieXRlCmk4MDFfYWNjZXNzCl9faTJjX3NtYnVzX3hmZXIK
aTJjX3NtYnVzX3hmZXIKaTJjZGV2X2lvY3RsX3NtYnVzCmkyY2Rldl9pb2N0bApfX3g2NF9zeXNf
aW9jdGwKVGhlIHRhc2sgd2FpdHMgZm9yIGEgY29tcGxldGlvbiB0aGF0IG5ldmVyIGFycml2ZXMu
Ck90aGVyIHRhc2tzIGJsb2NrZWQgb24gSTJDIGJ1cyBsb2NrOgpydF9tdXRleF9zbG93bG9jawot
PiBpMmNfbG9ja19idXMKLT4gaTJjX3NtYnVzX3hmZXIKVGhpcyBzdWdnZXN0cyB0aGUgYnVzIGxv
Y2sgaXMgaGVsZCBpbmRlZmluaXRlbHkgYnkgdGhlIHN0dWNrIHRyYW5zYWN0aW9uLgpJbnRlcnJ1
cHRzIHN0aWxsIG9jY3VyOgppODAxX2lzcgotPiBwY2lfcmVhZF9jb25maWdfd29yZApIb3dldmVy
LCB0aGUgaW50ZXJydXB0IGhhbmRsZXIgZG9lcyBub3QgYXBwZWFyIHRvIGNvbXBsZXRlIG9yIHdh
a2UgdGhlIHBlbmRpbmcgdHJhbnNhY3Rpb24uCgpJbXBhY3Q6CkEgc2luZ2xlIHN0dWNrIFNNQnVz
IHRyYW5zYWN0aW9uIGNhbiBob2xkIHRoZSBJMkMgYnVzIGxvY2sgYW5kIGJsb2NrIGFsbCBzdWJz
ZXF1ZW50IG9wZXJhdGlvbnMsIGxlYWRpbmcgdG8gc3lzdGVtLXdpZGUgc3RhbGxzIGluIHRoZSBJ
MkMgc3Vic3lzdGVtLgoKUG9zc2libGUgY2F1c2VzIChiYXNlZCBvbiBvYnNlcnZhdGlvbik6CjEu
IE1pc3Npbmcgb3IgaW5lZmZlY3RpdmUgdGltZW91dC9yZWNvdmVyeSBpbiBpODAxX2Jsb2NrX3Ry
YW5zYWN0aW9uX2J5dGVfYnlfYnl0ZQoyLiBUcmFuc2FjdGlvbiBub3QgYWJvcnRlZCB3aGVuIGNv
bXBsZXRpb24gaXMgbm90IHNpZ25hbGVkCjMuIEludmFsaWQgU01CdXMgcGFyYW1ldGVycyBmcm9t
IHVzZXJzcGFjZSBsZWFkaW5nIHRvIGluY29uc2lzdGVudCBoYXJkd2FyZSBzdGF0ZQo0LiBJbnRl
cnJ1cHQgaGFuZGxlciBmYWlsaW5nIHRvIHNpZ25hbCBjb21wbGV0aW9uIGluIGNlcnRhaW4gY2Fz
ZXMKCk11bHRpcGxlIGNvbmN1cnJlbnQgZnV6emluZyBwcm9jZXNzZXMgaW5jcmVhc2UgbGlrZWxp
aG9vZApObyByZWxpYWJsZSByZXByb2R1Y2VyIHlldC4KSWYgdGhpcyBpcyBmaXhlZCwgcGxlYXNl
IGNvbnNpZGVyIGFkZGluZzoKUmVwb3J0ZWQtYnk6IFpoaSBXYW5nIHdhbmd6aGlAc3R1LnhpZGlh
bi5lZHUuY24KClRoYW5rcywKWmhpIFdhbmcKCg==
