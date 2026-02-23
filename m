Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F934EEF2
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837230; cv=none; b=Mpq4A58z36cZdbLr++TQUJATnLKRkrgWD5mnTqG7p1csN8cqyI2zMgXNCoGqne8amDTwOma33dQg4wt2DIlRIuchFSpA1YBMZhVbV5PspPfZVv7utXAjW9CU1MW4+aS2Fkff1i5ADhar0ok9QXsl1xPf3vnpej3o8tvwhOA/ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837230; c=relaxed/simple;
	bh=JDZZ/6aGOo6nTpfOU40qBlSpYdHiADcGwoYL6QYt5dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWgtlSkikwllVMWTgD2qhy1EcDn/U76EUZhBoGa/kQ52n82IrNtiBThZE2tP7XwdXcK3riOh/2mhn5xikakhBSY1Qbwzk/pa72AQQqVqdA02Y6I/olKs2qdhYwEQnkjNhCkS6mBAAvBR+QhT+8bKr8HXwRKR8KLEHDY511JtJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hvr7zPTz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMGN9gLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hvr7zPTz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMGN9gLA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNHgnF1778082
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ebs4592ZeGx4XEtowa9rtUzeO9XIr9Cws6MAkd96cvY=; b=Hvr7zPTzrCaCVx85
	+pWeuCaqk3ssZ3HpkZRf+BLU90H8Q9hwgIsSRvokmoMdvCIv/lykqwqQ1tVUhCyy
	0j9tZZE0BoxwcP+klWXT7MLXWAvCJQISCVuiO9J55chWHyHkCP/XhoZp/t4M4Y/k
	dFXBM4EPtwVa+4toWGGGGue3TaXQw1RivEQLz5Ypek8SioKEBaQVoDNT44NxHmEd
	Gu4ucWk0dWMeK/rCMfday9iyQ3Zup380LIaWK1kP0+m0RkY7MWFx4+0/Mn3+ysrk
	uiFCOmnQS7JElPU6r72eSg8NF6yTiIw10k+5nXvMMcpz7zsX5//azU1OEjB8BvoF
	pHcCbA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u9v2kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8966c2b187bso497583846d6.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837227; x=1772442027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebs4592ZeGx4XEtowa9rtUzeO9XIr9Cws6MAkd96cvY=;
        b=HMGN9gLA/cRhOD2i+cbLGK79jatxq8FZ5k7AvLKOmH7kIhPofW+8fT0md+F1oXKiLa
         qrJUiQxVBMWxckcYiWWmqK+sAtWz7aklVygahiVsDjpnwXUGNfWGVPF/ATZJiPLIFHn+
         fZqGe99HO0YhNSTtgFs+Idam9kxawlLTt3iJgEU0ej+Wn14FFB996MDDi/heHULYhv8R
         ul5Edj5u5HAU/B4CPMkbi25dhFpLrhVZgRvF4C4shxBP4IglKdajE3ed5L6WfdL8BonR
         NKxbrDSKTK674QBnJkiK+CpF0FHQGm8m0/aQ8snJ4B9mo1NfhpNkNvVFHc/1RtHRJqda
         8UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837227; x=1772442027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ebs4592ZeGx4XEtowa9rtUzeO9XIr9Cws6MAkd96cvY=;
        b=ocFsegt+7q6bkhoI/+o9wycQBUOBM6B28JSPminsS8L+U84wkKeIX0GRw29abp1jXZ
         lIlMqbTSQBJM8lm1SM7lZCzmUARktP12sWdXTOKFDDfRcAARwAac3FQFtnNg0D7Culg7
         5cU9dvhTaon5uBBj1dhxAC4G+GTzBG3h5qCC+hJW3EN0jjm9abrnVDoXSDXGLp4khEgD
         UXtrj9ZdlTV90IanIxpp9DQJHWtV0/1TmIxjdDZay3Yf3OgCIc3zIzU506zmlk4ta92y
         z3pK+yCR9HSBuOThHkyuvDBGaqElLTDn+ySBrFG0DI2HgBeM4nLcZOMzhp7MXP3tDwN5
         n75A==
X-Gm-Message-State: AOJu0Yy0PMxLwBbTvjleWqTTGEgl5oeugWLbUS1m7B8YCQ49jw50xvTP
	U6/UpljoP1d9K+iVKjtaCCRDS+NMVDKE3TQlaPZBYwih/u3xsWcJCliZr2SNJFBVAJRvorIbmol
	KA0d/EZI9eTYZ1Kr2UHsQXPW6hrm9H/aGq35vv8Ts6gIuJMvVE69RAERmmmEo1KM=
X-Gm-Gg: AZuq6aJssmdJWbxXm7d/2SDsnneNkJ54UR7rPnUqTkbJQJr3A5t4Ur0PdYr26xzEOEa
	kSQ0WZ1DcqRAYOkCbR/QmtvgaDM6TIOUkoSUY6lQqXTJK2b14fCgUDc4+IKl2K0ryYq3ZarV7aL
	fwmEKQ2tnF4h6TDn06jwCg70G2zhcDou/UoCyBJFcGUdGEp+dBe5SGA4E5Xpk2qzsGV6xNikXLq
	mUn9CNfGVY0IYDv2FSFVUsd6BbaiaHnbm/HiivVx6B9TK5AYTUavutmJzxzk3cZtZpjvfo/knoI
	TP/BIiYXXHN8UepYYbSPB/FUcyi21oGAgGeK0avfPnuQYmVC33/mOPrpSsTLQsk16ae2LYZhI8X
	SHoX15bGMJs4cdJ+qhoOhFsNjPN7gOGOFdd12KGRBbVsCObhVSqHA
X-Received: by 2002:a05:620a:318f:b0:8c6:b258:dff7 with SMTP id af79cd13be357-8cb8ca8962amr979347685a.72.1771837226492;
        Mon, 23 Feb 2026 01:00:26 -0800 (PST)
X-Received: by 2002:a05:620a:318f:b0:8c6:b258:dff7 with SMTP id af79cd13be357-8cb8ca8962amr979342585a.72.1771837225985;
        Mon, 23 Feb 2026 01:00:25 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:42 +0100
Subject: [PATCH v2 13/13] i2c: piix4: use i2c_adapter-specific printk
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-13-13b2a97762af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JDZZ/6aGOo6nTpfOU40qBlSpYdHiADcGwoYL6QYt5dk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcIdZYwirJnUNOGujgI7ogwb5RBbVsRgHzZt
 6K9WXX042OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXCAAKCRAFnS7L/zaE
 w/1fD/9C9lHh11MQDFHNS2CdDlMZobYyoli8+SLRr7N1NFuXSbJv/+h//P2hoBy0ke6yXqTJ4+L
 axzRX/jM2FO3L1ru6ZrxkjvExiROejYsY2HigPuosAHZEcMJHX50dppFDbhFtilqHuGGRbQ91rb
 UdnyjHFtSkUZAtT/ahTl9re5M8Vighq8YxQKegyiyrIfT4o5mJMMyI5gs4cv9wWuhpByp+tchBj
 n+NVrFNe4cUBw0EgzHfbabeRPa75XEGBdgCLmD/0BOT4YBwTL4BmfBt/4kazL2DiuU1ogHEDSID
 3K7NJSMh+04p0We0l2P8ZxiEn6EMBMjvh0h8wQqUrPdCEzBCNe/1dVdSthVFXYEppwL4ofSvok6
 XG9a+P6zSiBBE+B1A2+hmabACNJNMQ0AvZY4GXpDWjhOiW7QVl1HIiQEiPCyiyi30W+rVH4lspI
 8JUhkGQuwW9zYF/NzbMusTvzOqoJ0XsNGI3vHJPv0CqVQLX4m1bPZnqaf9OW+ls0gPDcrrK+oeq
 r23BCzSbMK80frsQ8dtiZGTXaAxlemajkek9awA8vE6y3aFEynS4iquHJ2E8pWSbYo4ke7/5C0d
 GD8jLMRaKsY+SoT4O7JObjMnj/9nVkONjeXiLY+x3XdOiJsoVn+/Tx1OvpSG88jXqVllU0NwSqV
 ozIxTLR3zZ0NIZg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfXwXXjIdqG2Nkp
 +KBgZnUsGX/KE/A1SEtthFwta4x+OtT6SVrU38rSH0gFhgLp5tCzxE8Pp/TMljheVUkYKKZD07/
 vOBCwmdM7I0QzfqK/XOCGqYLk6496PUCgmx6e9tN/SaqxGuBjBF+gpsS9OLZPDh/GbQDIkonYUQ
 7kE4hm9HqvqGLDmiqxhLhYfhD4gUhgicZoj7YMszXpH7zADYW8FWK1u0a769G/t6su2i1fbekgC
 wfxTtTR4bjjMYi3srTWJ30t2CnnINkFGmQUXE0GrxExnwhB01APd7A5beQzEaAITtIkrgXbXCyR
 hj4fNWFv4eqT/6s7dRqvUzGoG5RDzviIgK3Kk25ZMVQ8DpvJco1bkrvp78TEVLLNm6D1AKnwdfy
 733posmAIfVDhhdgXYZYDIOLBNZCrBcM8xZ+ub/RenNBm1y1mMtyVYPopft6tEEbepjhM0vCC3m
 bgDRRztp4Xp6ztLRyjA==
X-Proofpoint-GUID: yWeEJZTIHIZX6PI6PF6E7lLzLdumyRuY
X-Proofpoint-ORIG-GUID: yWeEJZTIHIZX6PI6PF6E7lLzLdumyRuY
X-Authority-Analysis: v=2.4 cv=RpDI7SmK c=1 sm=1 tr=0 ts=699c172b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=dY4OjmsCUpDc7DjzIskA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1011
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-piix4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 7b6a4e201be4a211c3b84e57fb7d8e0adc9895b7..d7fa2fbace908d1c2de66aae152e848bd1678fb9 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -650,7 +650,7 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 		size = PIIX4_BLOCK_DATA;
 		break;
 	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		i2c_warn(adap, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
@@ -825,12 +825,12 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		ret = piix4_imc_sleep();
 		switch (ret) {
 		case -EBUSY:
-			dev_warn(&adap->dev,
+			i2c_warn(adap,
 				 "IMC base address index region 0x%x already in use.\n",
 				 KERNCZ_IMC_IDX);
 			break;
 		case -ETIMEDOUT:
-			dev_warn(&adap->dev,
+			i2c_warn(adap,
 				 "Failed to communicate with the IMC.\n");
 			break;
 		default:
@@ -839,7 +839,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 
 		/* If IMC communication fails do not retry */
 		if (ret) {
-			dev_warn(&adap->dev,
+			i2c_warn(adap,
 				 "Continuing without IMC notification.\n");
 			adapdata->notify_imc = false;
 		}

-- 
2.47.3

