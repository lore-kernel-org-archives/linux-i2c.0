Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607E34E741
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837203; cv=none; b=Ug6lKudp/Z86U2pet2I+rud8Pb5ReGI6oIk9KKa/oVXGjpusi1+uUg4BLKIUidYfZxUKExYntlZz18ZG+cUTIi6ks0F6OxjLQ6k/OguW8wxpJ6GdazQW5RSBQKRTQydAs8kht8rvL6sml7b4B3NAryXwivh6vmuusxQ20/CFibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837203; c=relaxed/simple;
	bh=3ocHwW+sRAuHA65NGYfWiu2vYKpc/cBf3QlL1rRapRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJKzqiyXisBXU21m9STU9yf4ARu+EDoINRo73pc0akZ4y8GYMdXd3mg8FEVsiUe2v1yCBjHpnUI6NpKT1qhcw6bDw+zNFtXcxFZWF1Yp0syJbrpi1D+PlsbhDc3ob4/rJvDoR9hguMRvts0DrlhcCFwVADGlJLLjeHAdnYGrZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cws0ECAb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=egWETWmj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cws0ECAb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="egWETWmj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8WqGw366810
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFnYYnBwOxyLsl4gp3Gqs5QoCyJ7O2QmTAIBUb9SP2Q=; b=cws0ECAbBSCqE6iv
	a8QGmcMF0cnSH9ehxsknG6A2aDPtW9cHO2uem4vDvgFFF66/ZsfJ6uAfEyYz8gKJ
	QgUytz7Is8SH+AYe7IDBTZtKQUD0JgXcLmrmE/5dz2mpGDRr5VRvkRo/BTkDLKbB
	yNLoGtFhMEe8Pk1Se6WZRzgZzWmQGRltuRYozmE8npfyDtPHiJziFtQJIbrRKKoF
	ms+KDNJSiEhZxrZsBunwaUbxpI7XhCsOpb1uMaQWCtqZYLpVBeG3pmO5bko5wgvi
	zZI2B9N51LdwSt+hLE1+CBB1nq3YiKOgt/QyKM8c4VkbuzHoCMyf8gLqO/n7HiI6
	kHp35A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf603m2a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4d191ef1so590621185a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837200; x=1772442000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFnYYnBwOxyLsl4gp3Gqs5QoCyJ7O2QmTAIBUb9SP2Q=;
        b=egWETWmjR/0oh6IrrXaI55D5IMZ/gg48V56uoQGrEwXaVmHz1EZjf2w5wXqxKy3uwC
         YizAuhn+0gKIzyzUYHjF4KlKiYu47zDmPwC74KT52ft9XDmZZukV1P2QLXGhKxFy5r0v
         oXMfipIumq3+RfnUKVxyDa+l/o7kkXV6L/VGrVK0gYrOsbgmRkf7zniy1vDD926ctKSP
         pFhnR4l8LWyYFAyIL9ej6WmYYiPgKZVEBF56JgpqUbQ+lReX1j6zRjolYi6xu5dGEoOw
         p8C13hsSAzBqBnHW1kA81Ia+QhQdD5yFIRiw+/TU/PASxdlRhYOYeJHo6+015MjdgZdf
         8daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837200; x=1772442000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFnYYnBwOxyLsl4gp3Gqs5QoCyJ7O2QmTAIBUb9SP2Q=;
        b=WaXJlNCr9dlH2L8H/E6BwIFZGl2V7B8dTWc0bQF3lZ1tlIpQNDhBQ532Eks5dypfAD
         9H3CioL5BIXbM/pkqVVPkIeeTbazBFpNpRSbQ3UfDs1QlBCBVxUcqBHujNOdxGJrXoWG
         8fbRB9vljhyigAN3hjbWmgb1sG5Mx6DBD1yPGS1qQdrito8u7VfrNv6fiOkYcu+cIu3r
         QFqTt4IFyv1XRV8u3jPLebwlRc4YpiTeNvHLaHj9Cyu/8TDsYCvysnnOs88hB86kFkXL
         s8wTqvE17l0cy+sj6G4YgN2dELZ2qbj4bcPOOsSI6ai/ZXvQC/98xEzsvn9ZpFnEffdt
         ir8w==
X-Gm-Message-State: AOJu0YxQnPflFOEUAyOL88r4LDn9yPYF65udv1+jbJwiq6du5mO/iU/a
	SoIiitaHI0A1jtgFCEoglJGVvzHZFMuD8Y7AqMA+3srzbdhQ5YGnh9Fu6LtPI5IHc+3CEADxh0v
	gap5YDLkPpbAsORTYWyjGRVbbZ2u39b8wb9gXTlh3wjaJe56XzXXTYuHsn61Buok=
X-Gm-Gg: AZuq6aKzmF2NdKLAQsBKvqRrSvzid9Bq3PDuiZEwaBIUR5Gz4bzYuzrPgpYcpVroKt9
	a/QeYxVnVFcionOei6rhAMfOJM60bGS+IaXGP9HiURX5pCCF9rTIDEEVu1QSehy/bh2k1c7CzRB
	kWYKYAuBXnUPYxEfnTvOl7MTuyxbCJqCaZTYkjzw1R5Xw1Kqbfq3OTOctmh3Tk+fVNyuVJEP2hJ
	BUqvU2xdpjw7hFgdPtkmYKFPh02SjHsALO0VhKcE7VOf3i+NZQhhWJN1FM+ybNFwaYsv3X3iVz/
	Osncrtm1Cafzki7QYAsCmjhdDldUPaLQ4SSRg4A5qEMTh0BEnPP/agQ0KV7daazMZKoCfiPl8np
	0jpaWzP+4rvR5XebYJpcsJ5QK+0JPugT87Fe/Jgg0u9OyHKAEixsN
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr970849085a.52.1771837199589;
        Mon, 23 Feb 2026 00:59:59 -0800 (PST)
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr970846885a.52.1771837199129;
        Mon, 23 Feb 2026 00:59:59 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:59:58 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:31 +0100
Subject: [PATCH v2 02/13] i2c: add i2c_adapter-specific printk helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-2-13b2a97762af@oss.qualcomm.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Khalil Blaiech <kblaiech@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
        Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3ocHwW+sRAuHA65NGYfWiu2vYKpc/cBf3QlL1rRapRc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBb9jzjFTJdq3M6FO7EYY2QiwT8GVE9qmSWuz
 3ohkzvQSVmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwW/QAKCRAFnS7L/zaE
 w8BmEACrMBvc0WtZJaG8d5jaaStBPDhB6rA1XzsrpvPKTzprO3pfbK0+LDvt2i6hcSz6G/sATKM
 4wmqFf/XEdRLWL54Vwi3cecAtJ8tkTh2p8nA6YHe87diSRhjKjFAv216+yDh0QLuwHOYhUjqM08
 f5kZhLL3dJ4hDRd49MZkT6LGkkFA56GIxx/wOQhMg9FsMGQSnm5tJW4wBUy2F4ldoKdRK3r4eF6
 STm5Z0uulFjPHiAlQ7n/ZGdGSFI/mKQe26GVRiSUTzgHepT6OoK69CwEU6WRm6JdvHpE804SJhS
 6ps8EJHVXUT89mV3+Gbyzz7UtIrFymORTZoy4pq0S5Ari/vp1uOMfyqvRJ0n5OO2oDbe0DiofMd
 L8e6e0NWZ1LU0AHDQ5EFb2rh0u5gom9/cz0WAQ9mGcMdru5aLcsCPFXKFd2aVeRHRskvjca97bk
 pCQ22fRInNk9I9PZzhCx2dLcEUE6ogUyuzOB6bVMFnmtHa6dx99uirWBGGqvzgyIbSqsNGwnXic
 GLik9Q5xUP0W1vpKN6XCwLXHgHleEtmYCyp1FnncRrxB6TxXUTsMd2PluQIrapHsp9Ty4zItN9D
 /wRIDRb0bAFp0WUToMEZ5+f+zdAf3iI9Nl8IyXV7G01Gf2FT7qaKyY93dG3gdHrAKTMSNLB400a
 XLWKVbwUcAwCgXg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=XbWEDY55 c=1 sm=1 tr=0 ts=699c1710 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3PEwmxbnAXTcU586h74A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX3W9BHDBG1j1y
 t8vdO/a8RSQJRb60xtrDKco8FOXdEWTVC9F43ZNaCVzVmuX+Vb4uZNUD0yj7jtGS7Z/w74HR54V
 ceD7yxYh6rNkS3EJtZc+lLAuR730+BCXxJjf8pS3FdSaK9fryVFXjoYqoULjDUuGXiMLd1Y22Aa
 ev//lJD0UCwJWWUphVqS8H5GMEzHmxTNWt2SrcqTzWR2CfcDNgylXvu6+c1PD7kGERHKWRrR7bP
 gs8SkIfWvb2lxsiG0t39NTOnDMtb3ZQomhj3RGhdK51Uzyia93WFZfOyB6TixkX9DlI4yJ0z5Fc
 CqBB35Ugzx21omUwFrtTjlSAxTANXqAE4/qGEiAWnRRH5aDFzlfWEHryDfUSgTA1ilJ0n4QAnIx
 CM4qeCojxpG0umrV9xwGcVc5r6RZ0rAFBL7EAHqvbLsYDok2Pt3WvlspwKbXG9F24AjoGS83DSB
 PNsXepZV52macYW6OBg==
X-Proofpoint-ORIG-GUID: nSiCpDGFBPNU59U_xofWxEuPIM3heWac
X-Proofpoint-GUID: nSiCpDGFBPNU59U_xofWxEuPIM3heWac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230080

Add a set of i2c-specific printk helpers that wrap their device-level
counterparts and hide the dereferencing of struct device embedded in
struct i2c_adapter. This is done in order to allow moving this struct
device out of struct i2c_adapter into memory managed by i2c core.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/i2c.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..2225696c859f617479be4d5c9d304bb32cbf5e9d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -768,6 +768,12 @@ struct i2c_adapter {
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
+#define i2c_err(adap, fmt, ...) dev_err(&(adap)->dev, fmt, ##__VA_ARGS__)
+#define i2c_warn(adap, fmt, ...) dev_warn(&(adap)->dev, fmt, ##__VA_ARGS__)
+#define i2c_notice(adap, fmt, ...) dev_notice(&(adap)->dev, fmt, ##__VA_ARGS__)
+#define i2c_info(adap, fmt, ...) dev_info(&(adap)->dev, fmt, ##__VA_ARGS__)
+#define i2c_dbg(adap, fmt, ...) dev_dbg(&(adap)->dev, fmt, ##__VA_ARGS__)
+
 static inline void *i2c_get_adapdata(const struct i2c_adapter *adap)
 {
 	return dev_get_drvdata(&adap->dev);

-- 
2.47.3

