Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111721;
	b=SDe10g68L7Z8UiB313i6d8Zca1gDVmt3/ho26Ni2E/PpVI9yBcERvVA7vOQwTFCH8V5r
	 WlcmoKMH7XVurbpnJLkjV0/k6kzzK+rRf85bU8ke6bksQNfqN040b9v/3m6MJlfHz1T/+
	 bziHg2P0lM0m8l6zla+hVx+XSLfASV99MFsNpTKpEKunfaNpsymIJctRttjQKiVXgn9A2
	 4lmbZw1WjuR0Jx7Uqn3bOOan7WoHEDh6Cf6Zqp7NFr0UAgXg7TVPAxQMOBjwZGz+EnM0p
	 6F9MqaIjF1ltHbFYX3tMYXQVPiIGq1le5Nmz5QveZD2x/Rcx/79L3MBzFCnVH1T205Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111721;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=Q/JtrdSYqaoMZ5K50zjIe2pHdtAbZc6SNut/NqhXrVI=;
	b=PrSkB8jqOhN+c5siATLsihKEBYA53WdfdVyjfIZNqMRmdA0QQ7ZM1FedyoRGcdMwc1E5
	 Yf6RPzboe5Ddrix7kYKX6XhavCcAlMU+KLcAdK84DLywytQu2+njpnc4U8mpvNU4QgjpN
	 s5E/bQg7jvsvv5Xd9QnNgsW0U8WQffiHDzT3dhwIgr6HwJLEIQMg1Xja7MQzndGwyozD9
	 X3mNsFHNgYu6kQlqNoDQxUF/EGX1p/kRkWqdSw903tlEI6L45ohyho4qyZPeAh0aNazPR
	 71GLg9YGnUUcTeIhLesmfOSaBMLU0A0QZjLAWQuv8AkVFqQf0PKajCJYW4G7I8X2ZoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=howett.net;
	spf=pass smtp.mailfrom=howett.net;
	dkim=pass header.d=howett.net header.i=@howett.net header.a=rsa-sha256 header.s=fm2 header.b=aAGkOodr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Qs7usP+m;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BC606A31A
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howett.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=howett.net header.i=@howett.net header.a=rsa-sha256 header.s=fm2 header.b=aAGkOodr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Qs7usP+m
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13FF6140004E
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 10:35:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 10:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=howett.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1793111720; x=1793198120; bh=Q/
	JtrdSYqaoMZ5K50zjIe2pHdtAbZc6SNut/NqhXrVI=; b=aAGkOodrm9GJSNDFnm
	bwuSwi3Gs1GC4H6vg/Am/RahdumD8xkzGNxD0KEA2qOEtsEBE3MiUmOeh2qiq2XY
	z+SJmQXIobQPNrDNlqT92jBTL2f523uHtKWk38lr08N/7Zg9JOxGasBXQ762wTQS
	6+qfy3c0UhSgLiDZoATHg4+8N3hAzc8cSufHaOuuxL90M0Nzw+GVdu7MSoKJrGN0
	4gHGEJF2BR9448G3cRkiEgXoORbKtqIviCaJw9ROAKKLUKwF4Pjda7QLglBCIg3h
	4/BhzRfsznzHG1WWOa2ltwxtgLCvei+H3X/GCET4BE43fuOU9rsRx4ZYdMBCdJfP
	fGrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793111720; x=1793198120; bh=Q/JtrdSYqaoMZ5K50zjIe2pHdtAb
	Zc6SNut/NqhXrVI=; b=Qs7usP+m0ZhxSsgWlLv+ETSx+HPn72pGgoDm4e8HXHke
	PgDH/0OqXOPhbuO6u/C8HxyYpctaj08fNnQ+KFpRBciQ0bmc8P3f0HQu4QmbHPS6
	jEAWtZmo/Dhwqhmo6A2uanuCULZmF15V+al+FGCIo2IhFJ7bkMxFHTc7SmXXA3GC
	ItB/+CzVU9Fd4nrSO43vxwJmrTYEHarNCvRyDeFbsG3re+MJoGp1HMHwhYUXqcyT
	3y8Uvib0CO8KvUKEG3XNLEbJrgzaK3NIpYIY+3oZDOYA/IgR5mKN4uJE+S7LwnVi
	HTbTgWpjN0bXGDOeqGVOdk4kxQ2Xz7HxdDwSPIogCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=howett.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793111720; d=howett.net;
	mf=PGR1c3RpbkBob3dldHQubmV0Pg==;
	rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PDqmasvDR5g7ziM5QZuiefsRSCc8Npkw8cr6z40JRa/buGy
	2HwSc3JPqimTUy6YKAhAINtiPL4L2mvOnGA/SgqTN6mY45kB21djTeit6nLDih+J
	+cPxZX27UDEwz0k0FAiPNZBK9EmAD0yLyam4IEHuYSwSjJi7USRgR71m6PLSDwcV
	466B+K+YmVttSP8JhfPxLHlrIwNmK98Xz8l8TzRHDxc4oH0t2v152hyPd+bDiR1H
	vmO7XdQwbB+jCYg/ycTeeKpDdWa2Bc1ZDAtSMQuwMzBuNyGbnIF6VZsNL9Pb0Gn4
	2w39Wy9DVNd5NxOro8hZBMIKK6ornfaofnuqEuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:7MAftU3YGbzG9HxFexOx+ZJ+tmgk6HO3PnmxawkX5MA=:b7leeV9rfUv+9vbvtzbdB4Q/59mZHGYHICDYPmQ+tXA=;
X-ME-Sender: <xms:p7bgar1KuJh1A8xSgJOq5WoB66K1tVhPsvuuKf7R5P3-eR45wkFIsA>
    <xme:p7bgajYQx0nepxI_6gQHsx7w3DoWN9KwgzS_m1lzYz-z8ABgZ089xpPlVKVXDBWx9
    ICpwLwNVI7IxrthelDXld_Y7azGp8cNAZ5X1-sKdoUeEbSVH5onRoyM>
X-ME-Received: <xmr:p7bgajI6kG4WzDPhmvI7II3W7XR5GbbIyXAzQKZYWuiemJ8AeoyjgtlWFoKEEUxrr-YFLA8HRhmEnb9pn7vl7HpkNBG1xAhJAhmESv7lRn6nZPYMNqo>
X-ME-Proxy-Cause: dmFkZTFQce6hq3A/PH9aM+qNxdORuWXaq7+Yjm+OUnPHnfDVZyqx1Ex6cpmILMwBRVk+m0
    0lnTD5NfIWg41bWHXe3c+sfWEDYvTGq6jjyNiDCkygIxn5gXbgfIeaYtd+/3M9jGm5d8+n
    NtPUaskUoMJUvCGbcPWp7DvSgyxuzkKxsYslsNJMTq/8RhLcwq/Nnk7BIFtdgc3mwgIa/C
    07lkcJz2X86CSD5VwjX083wkVDSaku1iF4aFiIHaFEH7kxy9Nlp5QsRI1MW/LCy4rYfJB7
    DB+qShCEiIMk07knNWIebV9+5LcW9jnA39KgYkfXfboTl/0i5HAUWnHYU6JKKiy2HZYaOF
    ljSUgYcX7xvt1XP6RU4O12FQ3fewokslBVlz9xgVdjro4YhVTYGDBLsGIDWY4qyrzBkD6n
    mT5dCLg+PNbSTRczyVU0l5NOwRWLi+uS9J9U3jFZlnMJofxxoWjDmBwtgX0qkE/ydqg2vM
    VSnxMKJab6VSiPpMNfQyHBa20PTFJjP23butcaCbpT/Vyxxtc/sWoyqbX2XtIvjL/Gs3bC
    90o96BbXS52c0yQJvZ5WlZINsX/UXM3LObxPdrMKXAMU5bFAU3dMqcJrmdJczEr/NZgx95
    X8HCIxWLj9SaVXmlWxF2OCNx96YShP8nR2gk+eSyzY4KVQEg9WDKQBn6rhLw
X-ME-Proxy: <xmx:p7bgaiHS-Tg4mgb9Zy-3RNoZsceBbswfzqYteQ_VMCKkkjWMcR5XAw>
    <xmx:p7bgaquUnBfXnHVG-csukZn4i6Ch-6R95S6x3D28CRhLXwJUftaW2Q>
    <xmx:p7bgahvzrhGZEkf674JNOv8wr8g9yK_OjLYL0EP3dE0-Ex7kU_DT-A>
    <xmx:p7bgaoCgDyiz3gVo_ucz7uPBk0KKmLMyeb6AQuqVUSS9yI-Y564Qow>
    <xmx:qLbgakuM4kV2XIz03-g0TOFXZVNmqo-cTpZO_31q7FU_84JDbA1K7bLR>
Feedback-ID: i32264b73:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:35:19 -0400 (EDT)
From: "Dustin L. Howett" <dustin@howett.net>
Date: Tue, 27 Oct 2026 09:35:18 -0500
Subject: [PATCH v2] i2c-tiny-usb: add support for the Oops Electronics SFP
 Media Buddy
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-i2c-oops-electronics-v2-1-0601f2ebf579@howett.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7Rhaw58r72FYQDvIGNOSTkUN4
 e4WPIDLl3zvewsIBSaBc7ZAoJmFvUugDxmYsXM3QraJQee6VLmqkLVB7ydBepCJwTs2goW1p7J
 oqlrbDpI6BRr4vd9e2x/Ls78nYfvaFiNL9OGzd2e17f4kZoUKDTVlPtSD6qvuMvoXxXh0FKFd1
 /UL7wDVZssAAAA=
X-Change-ID: 20261017-i2c-oops-electronics-5dd3659782da
To: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Whinis <whinis@whinis.com>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Dustin L. Howett" <dustin@howett.net>
X-Mailer: b4 0.16.0

The Oops Electronics "SFP Media Buddy" is an open-source USB device that
provides i2c access, among other things, to a SFP+ network module.

It exposes a vendor protocol which is compatible with the i2c-tiny-usb
kernel module. Due to a bug in prior firmware versions, that protocol
can only be used with devices reporting bcdDevice >= 0x0101[^2].

[^1]: https://oopselectronics.com/product/SFPB and
      https://gitlab.whinis.com/oops-electronics/sfp-media-buddy

[^2]: Devices without the fix will crash and drop off the bus when this
      module is loaded, which prevents them from being updated.

Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
Changes in v2:
- Matching on interface class as well (thank you Andi)
- Link to v1: https://patch.msgid.link/20261017-i2c-oops-electronics-v1-1-ce960f8f1b7a@howett.net

I think I've seen the under-the-cut behavior with adding Trailers with
b4 in the past, and was unsure how to fix it. Thank you! It should be
better now.
---
 drivers/i2c/busses/i2c-tiny-usb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 73355a56aabf..07cfa6598a44 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -162,6 +162,17 @@ static const struct i2c_algorithm usb_algorithm = {
 static const struct usb_device_id i2c_tiny_usb_table[] = {
 	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
 	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	{
+		/* OopsElectronics SFP Media Buddy v1.01+ */
+		.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+			USB_DEVICE_ID_MATCH_PRODUCT | USB_DEVICE_ID_MATCH_DEV_LO |
+			USB_DEVICE_ID_MATCH_INT_CLASS,
+		.idVendor = 0xc2f9,
+		.idProduct = 0x0004,
+		.bcdDevice_lo = 0x0101,
+		.bInterfaceClass = USB_CLASS_VENDOR_SPEC
+	},
+
 	{ }                               /* Terminating entry */
 };
 

---
base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
change-id: 20261017-i2c-oops-electronics-5dd3659782da

Best regards,
--  
Dustin L. Howett <dustin@howett.net>

