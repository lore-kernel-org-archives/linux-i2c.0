Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492343FD11;
	Tue, 14 Jul 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022113; cv=none; b=GIlryM5ZP+Z7Y46VauTBVcxDyCjJvyc7/0ExABjf8c4zw3nA7kVi87xoXh4Zm89FuZKeWg3AYubSYWsoKsA48U+n5AumR3ZkNKZHjz0JK5NiLyOAamjXD/vhwGzAEyHOpTXPe8fUqRTftEnHbuAIguYrpTBV551ZRhzvEaQwiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022113; c=relaxed/simple;
	bh=lKr2kzuSeiAjC16p+wndtFIdffFzMSq8xCj4zQAyyyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuOG/b29VKeDK55EWdfBdrLfaNFch0KH9+qX2lcIfXUVjvg2MJJaE69owTr/PAMsafdKBTQTLhvoorW7iUBPyaiN+j5MuSgQpOAorrjbTMeqeG65dSz3QYPNdtel2cOiHZ8ateptsG1DpLYOEB6TA+sV0tfNm2ytf4Nyq7SJDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=YDK+dE81; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="YDK+dE81"
X-UUID: 3bc0d8e67f6811f181a149c3f3c08161-20260714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=psN0kqo8uQkSysWusSvrifCMa9oTwBGcSyqXdNVrwLs=;
	b=YDK+dE811h30HRDMsfWwU4oGBjQHlLeuCx9F6t1nbSMWisuIB0yfJqVIeXLNFoBn77hwzY5CX5MjV2mRTgIdda+P6IL/s9XmuUnRhbvfgGgWoTE7t+hsjkv1gYjPxWAZY6Op3GLZpUCvQkdvz3O3n6PwS7bqn7PVINRwP/dJD/4=;
X-UUID: 3bc0d8e67f6811f181a149c3f3c08161-20260714
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 707847343; Tue, 14 Jul 2026 17:41:48 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 1EF1B1A1E1C;
	Tue, 14 Jul 2026 17:41:48 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 883BDC600CC; Tue, 14 Jul 2026 17:41:45 +0800 (CST)
From: Nina_Kuo@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v2 0/3] i2c: Add Novatek NT726xx SoC I2C controller
Date: Tue, 14 Jul 2026 17:41:45 +0800
Message-Id: <20260714094145.84387-1-Nina_Kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260714092504.82538-1-Nina_Kuo@novatek.com.tw>
References: <20260714092504.82538-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="__=_Part_Boundary_001_1727655448.1529552306"

--__=_Part_Boundary_001_1727655448.1529552306
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PCEtLXR5cGU6aHRtbC0tPjwhLS17LS0+PHNwYW4gbGFuZz1FTi1VUw0Kc3R5bGU9J2ZvbnQtc2l6
ZToxMC4wcHQ7Zm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWYnPkNPTkZJREVOVElBTElU
WSBOT1RJQ0U6IFRoaXMgbWVzc2FnZSwgaW5jbHVkaW5nIGF0dGFjaG1lbnRzLCBjb250YWlucyBp
bmZvcm1hdGlvbiB3aGljaCBtYXkgYmUgY29uZmlkZW50aWFsIGFuZCBwcml2aWxlZ2VkLCBhbmQg
aXMgaW50ZW5kZWQgb25seSBmb3IgdXNlIGJ5IHRoZSBhZGRyZXNzZWVzIGRlc2lnbmF0ZWQgYWJv
dmUuIFVubGVzcyB5b3UgYXJlIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGFueSB1c2UsIGNvcHlp
bmcsIGRpc2Nsb3N1cmUsIG9yIGRpc3RyaWJ1dGlvbiBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCB0aGUgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIGltbWVkaWF0ZWx5IGRlbGV0
ZSB0aGUgbWVzc2FnZSBhbmQgZGVzdHJveSBhbGwgY29waWVzIHRoZXJlb2YgYW5kIG5vdGlmeSB0
aGUgc2VuZGVyIGJ5IHJlcGx5IGVtYWlsLjwvc3Bhbj48c3Bhbg0KbGFuZz1FTi1VUyBzdHlsZT0n
Zm9udC1zaXplOjEwLjBwdCc+IDwvc3Bhbj48c3BhbiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdCc+
JiMyNjQxMjsmIzM3MTA5OyYjMjAyMTQ7JiMyMTQ1MDsmIzIwMjE5OyYjMjAzMDk7PHNwYW4NCmNs
YXNzPUdyYW1FPiYjMzg0Njg7JiMyMDIxNDsmIzIyMzQzOyYjMjM2NjA7JiMyNzIzMTsmIzIzNDk0
Ozwvc3Bhbj4mIzY1MjkyOyYjMjA2Nzc7JiMyMDM3OTsmIzIwODU0OyYjMTk5Nzg7JiMyNTM1MTsm
IzIzNDUwOyYjMjIzMjA7JiMyMjMzNjsmIzIwMDQzOyYjMjU5MTA7JiMyMDIxNDsmIzIwMTU0OyYj
MjAzNTE7JiMyOTk5MjsmIzEyMjkwOyYjMzg1MDA7JiMzODc1MDsmIzI0NzQ0OyYjMjYxNTk7JiMy
NTM1MTsmIzIzNDUwOyYjMjAwNDM7JiMyNTkxMDsmIzIwMjE0OyYjMjAxNTQ7JiM2NTI5MjsmIzIx
NTQyOyYjMjEwNjM7JiMzNTUzMTsmIzIxMjQ3OyYjMjAzNTE7JiMyOTk5MjsmIzEyMjg5OyYjMzUw
Nzk7JiMzNTA2OTsmIzEyMjg5OyYjMjU1ODE7JiMzODcwNjsmIzI1MTEwOzxzcGFuDQpjbGFzcz1H
cmFtRT4mIzI1OTU1OyYjMjQwNjc7JiMyNjQxMjsmIzM3MTA5OyYjMjAyMTQ7PC9zcGFuPiYjMjAw
NDM7JiMyMDIxOTsmIzIwMzA5OyYjMzcwOTY7JiMyMDIyMTsmIzEyMjkwOyYjMzM1MDk7JiMyNDc0
NDsmIzM3Njc5OyYjMzU0OTI7JiMyMjMyMDsmIzI1OTEwOyYjMjEwNDA7JiMyNzQ5MjsmIzM3MTA5
OyYjMjAyMTQ7JiM2NTI5MjsmIzM1NTMxOyYjMzE0MzU7JiMyMTM2MzsmIzIyMjM4OyYjMzUyMDY7
JiMzODY1MTsmIzIzMzc2OyYjMzcxMDk7JiMyMDIxNDsmIzM2ODkwOyYjMzA2OTM7JiMyMzQ5Mjsm
IzIwMjE0OyYjMjAxNTQ7JiM2NTI5MjsmIzIwMDA2OyYjMzU1MzE7JiMyMzQzNjsmIzIwODQwOyYj
MjEwMzQ7JiMzODUwMDsmIzE5OTg4OyYjMzc1NTk7JiMyNzU4NDsmIzI2NDEyOyYjMzcxMDk7JiMy
MDIxNDsmIzIxNDUwOyYjMjA4NTQ7JiMzNTA3OTsmIzI2NDEyOyYjMTIyOTA7PHNwYW4NCmxhbmc9
RU4tVVM+PG86cD48L286cD48L3NwYW4+PC9zcGFuPg0KPCEtLX0tLT4=

--__=_Part_Boundary_001_1727655448.1529552306
Content-Type: 
Content-Transfer-Encoding: base64

RnJvbTogQmVuIEh1YW5nIDxCZW5fSHVhbmdAbm92YXRlay5jb20udHc+DQoNClNvcnJ5IGFib3V0
IHNob3dpbmcgdGhlIGNvbmZpZGVudGlhbCBtZXNzYWdlcy4NCkkgc3RpbGwgZmluZCBpbnRlcm5h
bCBzdXBwb3J0IHRvIHJlbW92ZSB0aGVzZSBtZXNzYWdlcy4NCg0KU2luY2VyZWx5LA0KQmVuIEh1
YW5n

--__=_Part_Boundary_001_1727655448.1529552306--

