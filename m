Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F73FAE19;
	Tue, 14 Jul 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021134; cv=none; b=VhyLarx7QibiAs+YyqVDSVVg94+XlLSZAcu/fCkx831QbM1Uw64wqFgl7+YBDvwITAZexn5ozA66QZ3TSdajbuhc14t/pE1LHEjKCMRq1Vmynww4hQzzzcsXdxMc+YgkcY3PZFsWID8k/lS+o3n25TqpfUrGpujYaaP8MHRtPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021134; c=relaxed/simple;
	bh=ZzlR4NdqZCujCnqCeNCDE8iklttiPWSXXrJ1IJc5/Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyB/kjUuq5YzXQcsWZHs3moaI2l1yPRLQGsmmCXpo4ICuYK4eRiuZP6p6g8uCZYA7NbYv2ry3U5c5gPlHQMfMKXS4AZwt/Sugx9TlvFcrgGZHOHIv+G7S2ARhC6uobajzi2U0w+vi7uF+p+RnOmTD02kkzuUK9Yn+dQ6H2syUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=bSKsZB0V; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="bSKsZB0V"
X-UUID: f32393d27f6511f181a149c3f3c08161-20260714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=nGZQxZq3i0r44o9Cr4AQDN11wNrR4bWIQ4+TvnUUBpg=;
	b=bSKsZB0Vt20rQaOSDlvrJIalmpqXR2lyWDGrBLy19Gtcl/zr5+9UObT7om6qdpztwSD6QoiQ6arwshD9nHjN9dIbOh7tDB7lE6sqAE/adPA8rZO1CI5uTSpLBA/MG85+Z6AQFNNrTo1f9IqznuqZ94EYLAmrPZmfUkgyVbJPRVU=;
X-UUID: f32393d27f6511f181a149c3f3c08161-20260714
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1107628219; Tue, 14 Jul 2026 17:25:27 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 4214E1A1E1C;
	Tue, 14 Jul 2026 17:25:27 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id BE200C600CC; Tue, 14 Jul 2026 17:25:25 +0800 (CST)
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
Subject: [PATCH v2 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC I2C controller driver
Date: Tue, 14 Jul 2026 17:25:25 +0800
Message-Id: <20260714092525.82613-1-Nina_Kuo@novatek.com.tw>
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
	boundary="__=_Part_Boundary_003_985712725.1147062870"

--__=_Part_Boundary_003_985712725.1147062870
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

--__=_Part_Boundary_003_985712725.1147062870
Content-Type: 
Content-Transfer-Encoding: base64

RnJvbTogQmVuIEh1YW5nIDxCZW5fSHVhbmdAbm92YXRlay5jb20udHc+DQoNCkFkZCBlbnRyeSBm
b3IgbWFpbnRlbmFuY2Ugb2YgTm92YXRlayBOVDcyNnh4IFNvQyBJMkMgY29udHJvbGxlciBkcml2
ZXIuDQoNClNpZ25lZC1vZmYtYnk6IEJlbiBIdWFuZyA8QmVuX0h1YW5nQG5vdmF0ZWsuY29tLnR3
Pg0KU2lnbmVkLW9mZi1ieTogTmluYSBLdW8gPE5pbmFfS3VvQG5vdmF0ZWsuY29tLnR3Pg0KLS0t
DQogTUFJTlRBSU5FUlMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQppbmRleCA2YjQ1
NjA2ODFiNTEuLmU0ZThlYjAxYWQ3YSAxMDA2NDQNCi0tLSBhL01BSU5UQUlORVJTDQorKysgYi9N
QUlOVEFJTkVSUw0KQEAgLTE5MjA4LDYgKzE5MjA4LDEzIEBAIFQ6CWdpdCBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbm9saWJjL2xpbnV4LW5vbGliYy5naXQN
CiBGOgl0b29scy9pbmNsdWRlL25vbGliYy8NCiBGOgl0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9u
b2xpYmMvDQogDQorTk9WQVRFSyBOVDcyNlhYIEkyQyBDT05UUk9MTEVSIERSSVZFUg0KK006CUJl
biBIdWFuZyA8YmVuX2h1YW5nQG5vdmF0ZWsuY29tLnR3Pg0KK0w6CWxpbnV4LWkyY0B2Z2VyLmtl
cm5lbC5vcmcNCitTOglNYWludGFpbmVkDQorRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2kyYy9ub3ZhdGVrLG50NzI2eHgtaTJjLnlhbWwNCitGOglkcml2ZXJzL2kyYy9idXNz
ZXMvaTJjLW50NzI2eHguYw0KKw0KIE5PVkFURUsgTlZULVRTIEkyQyBUT1VDSFNDUkVFTiBEUklW
RVINCiBNOglIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3JnPg0KIEw6CWxpbnV4LWlucHV0
QHZnZXIua2VybmVsLm9yZw0KLS0gDQoyLjQwLjENCg==

--__=_Part_Boundary_003_985712725.1147062870--

