Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A93327C09;
	Sat, 18 Apr 2026 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776513795; cv=none; b=k7aNwxyRtlrjAwmekrNc2mSWy3wKEvP1qb0gQ/Xthso4KwOxhdOq4kjS81wVs/NcaOzGBRlQf67aP0q3MMu32qTieHTyi2B1otZ+hX3RodOe0OlaqDYPziJlMinnFMAodmGCE2CGM6tH4xB/jdfGGrO/4i3DDVhCa+VVfdQsdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776513795; c=relaxed/simple;
	bh=9+jKU+vNJVMZSKpqz13DadwpvDANayZHvY11qBQetUI=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=bIRPKyJeE7gRZW8kd0pLr5RU75LcPgNPnDAJ2EPR15oTUejQ2oSV4UIA3dW/UyHI7dXB+8wW2lrDkMvwhJJyWEVluQb86S56TfIOUWT7K8zWMV8TNpgX3jSvGzHlGFVi520wvl/E0tMkZ2dDWFexsMPH45hDoiZp19Wq6EXaPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=dCU1Dj4k reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="dCU1Dj4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=kwsKBjCSIKFAo9RV0tuqSQeXeZMU7rFTOCIXyjv8GIg=; b=dCU1Dj4kJZ0/T
	9JqSbidBoPgj0OM71df4xGRfPZuKCO3+ZxGVBhgTx4wUKFq1R2I0zQE8GHStBC/E
	st+bR0GxDk7XwaBSxOUqr0lK9puVwZZ6UPr1dXRc7AEGNQ9K1hNb+5/zzTNHJSNI
	9bi+tx6RmxHqQtdbxs6sVwontA7N24=
Received: from 23009200614$stu.xidian.edu.cn (
 [2408:8670:ae1:0:82f1:5fbb:efaf:86bb] ) by
 ajax-webmail-hzbj-edu-front-3.icoremail.net (Coremail) ; Sat, 18 Apr 2026
 20:02:58 +0800 (GMT+08:00)
Date: Sat, 18 Apr 2026 20:02:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wsa@kernel.org,
	andriy.shevchenko@linux.intel.com
Subject: [BUG] i2c: i801: crash with NX fault after invalid SMBus block read
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
Message-ID: <69db9f36.3ca7.19da07904dd.Coremail.23009200614@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BbQMCkCWvTfzcuNpzoShAQ--.34620W
X-CM-SenderInfo: qstqimqsqqliuu6v33wo0lvxldqovvfxof0/1tbiAQUHCGniTth6C
	wAAsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBNYWludGFpbmVycywKCldlIGVuY291bnRlcmVkIGEga2VybmVsIGNyYXNoIGluIHRoZSBp
MmMtaTgwMSBkcml2ZXIgd2hpbGUgZnV6emluZyB0aGUgdXBzdHJlYW0gTGludXgga2VybmVsIHVz
aW5nIGEgY3VzdG9taXplZCBzeXprYWxsZXIuCgpFbnZpcm9ubWVudDoKSEVBRCBjb21taXQ6IDdk
MGE2NmU0YmI5MDgxZDc1YzgyZWM0OTU3YzUwMDM0Y2IwZWE0NDkKZ2l0IHRyZWU6IHVwc3RyZWFt
CgpMb2dzOgpPdXRwdXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9tYW51YWwwL2NyYXNoL2Jsb2IvbWFp
bi8xMzExMTJjZDA4MzRlZjNiNGRiNWE4OWNjNWUzMTkwODU4ZWI0ODk4L3JlcG9ydDAKS2VybmVs
IGNvbmZpZzogaHR0cHM6Ly9naXRodWIuY29tL21hbnVhbDAvY3Jhc2gvYmxvYi9tYWluLzYuMTgt
c3l6Ym90LmNvbmZpZwoKUHJvYmxlbToKQSBtYWxmb3JtZWQgU01CdXMgcmVxdWVzdCB0cmlnZ2Vy
cyBhbiBpbnZhbGlkIGJsb2NrIHJlYWQgc2l6ZToKaTgwMV9zbWJ1czogSWxsZWdhbCBTTUJ1cyBi
bG9jayByZWFkIHNpemUgMApTaG9ydGx5IGFmdGVyLCB0aGUga2VybmVsIGNyYXNoZXMgd2l0aCBh
biBOWCBmYXVsdDoKQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgKGluc3RydWN0aW9u
IGZldGNoKQprZXJuZWwgdHJpZWQgdG8gZXhlY3V0ZSBOWC1wcm90ZWN0ZWQgcGFnZQoKRmF1bHQg
ZGV0YWlsczoKUklQOiBzZWNjbGFzc19tYXArMHgxNjViLzB4OGRjMApDUjI6IGZmZmZmZmZmODVm
Zjg1ZmIKZXJyb3JfY29kZTogMHgwMDExIChwZXJtaXNzaW9ucyB2aW9sYXRpb24pClRoZSBjcmFz
aCBvY2N1cnMgZHVyaW5nIHN5c2NhbGwgcmV0dXJuIHRvIHVzZXJzcGFjZToKZG9fc3lzY2FsbF82
NAplbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUKCkltcGFjdDoKTWFsZm9ybWVkIFNNQnVz
IGlucHV0IGZyb20gdXNlcnNwYWNlIGNhbiBsZWFkIHRvIGtlcm5lbCBjcmFzaCBkdWUgdG8gZXhl
Y3V0aW9uIG9mIGEgbm9uLWV4ZWN1dGFibGUgbWVtb3J5IHJlZ2lvbi4KR2l2ZW4gdGhhdCB0aGUg
ZmF1bHQgaXMgY2F1c2VkIGJ5IGFuIGluc3RydWN0aW9uIGZldGNoIGZyb20gYW4gaW52YWxpZCBh
ZGRyZXNzLCB0aGlzIG1heSBpbmRpY2F0ZSBhIGNvcnJ1cHRpb24gb2YgCmtlcm5lbCBjb250cm9s
IGZsb3cgYWZ0ZXIgaGFuZGxpbmcgdGhlIGludmFsaWQgU01CdXMgcmVxdWVzdC4KCk5vdGVzOgpX
ZSBoYXZlIG5vdCB5ZXQgb2J0YWluZWQgYSByZWxpYWJsZSByZXByb2R1Y2VyLCBidXQgdGhlIGlz
c3VlIGNhbiBiZSB0cmlnZ2VyZWQgdW5kZXIgZnV6emluZyB3b3JrbG9hZHMuCgpJZiB0aGlzIGlz
IGZpeGVkLCBwbGVhc2UgY29uc2lkZXIgYWRkaW5nOgpSZXBvcnRlZC1ieTogWmhpIFdhbmcgd2Fu
Z3poaUBzdHUueGlkaWFuLmVkdS5jbgoKVGhhbmtzLApaaGkgV2FuZwo=
