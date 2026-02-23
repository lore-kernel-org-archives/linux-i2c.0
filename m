Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B834EF12
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837588; cv=none; b=B6VwjLn/h5YklSdCYkDcpKQWHwo49a6ixpJvi2ApeSM3Ky0aZEdqxhmkxuNUN6J03xIo52FHg0WYYWKYS6cA7qpzizd/Jq7hng2WrNv/6G0sGIn+HCaO/iWjLpvyibfq3P9Y/NGttbkUoi5Cib+g7CUa4+8ytXWHo+R1yDCrtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837588; c=relaxed/simple;
	bh=deCpsbgsyzGz52UYVrUFu+GK4rDUeaxHx5qfsuJiwbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1S+S4p3M5yBcrASWQDu9ha+OdMrRgusWm3FlzacsMhqZHd5vCpoUTJ0elnluUwLO/X5Ab/375pKlnTkLkfoO6o5f7TOVJBhaoaNUgNWTWQLRLoZmIOHZU4747s7LgaK5JNxnhuNOgwG1g3Ct7G7D89CZEcTM+xLhN080P4b+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lCyqVScc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D/8lBfrM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lCyqVScc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/8lBfrM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMvjq52496428
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4IEVe23JvosF/ljVHhtNPHgumeDGeBSyPmBAPyvh5HY=; b=lCyqVSccFm2MNmzq
	d/VWC0//Ou8hzdNf1sUs01NwCFgGtI6gp+comyP9bcJ9wz6wYtMv5SRADSyOfPbu
	cLPxr969xyh0DoSsTvzjlM3bEa0UhRAkhzvogOqv36RscKZxZ/8i+qLP2OioAIlf
	9oK5GMyIKP9vbCVc3H7Jttk/nm9/yn4S+uZ5pVDmSgDrzjOrPNYulSAC1RYUf2D+
	ga8pXgO3vsN2sNLe/0Ec1jRr95T2Hg/59NsYfamSMPQcqYe9X2uOMFmykvZ9NXbG
	vTgNjDnB1ZLS8Y5T/zI0+EFroavgpPfxpJlzPwJdJumiaTnCdGTyI0HqILFH6FGN
	1pAGSQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyv2mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4e37a796so3431640585a.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837584; x=1772442384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IEVe23JvosF/ljVHhtNPHgumeDGeBSyPmBAPyvh5HY=;
        b=D/8lBfrMi61WjmRqueRxhSDhXeFXytFgAR2s97PescPe1Q89AkQr4coWMNiWud1yeA
         r1apKFWv/r8zUvtE+X3XYQ1UTDIbqOdzw6IfasqyLTKBU8c3winEc/zd53e7UxCl3jha
         7G9WVdrGa5ineJP0iCI6eKDg0g+eiIQy/XNhWp+X82fel6Fs0C79VZ5/tfEq96NTjja8
         qhroSSPg/CnATRi21QG1Zq7HocjHnCon4aoHQLHO+pd1sdF+oYZ7GtWd7ZfzTwBYzGi9
         lJ3DPRpZYI4dyCcXhJQTQ5CAqIW10x79OAuRRjFswLN3UrlaMAJ3lnOu86hO3l4aDio1
         rO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837584; x=1772442384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IEVe23JvosF/ljVHhtNPHgumeDGeBSyPmBAPyvh5HY=;
        b=DmHJL00bi5HdwydKeneIFmrubSTjzChwGQ64GONLDOQdtYCmJQI2CLV6Id5ROA1WPF
         cyO3duz+vrRcjP8TiOkSFekEBpByQFcA/6IvUEwK5Rawlzwbzpvy6oV26g0T2HcFyLhr
         izqhpVBuoaM+ttZ/MEcNmQ0YdJG8vTdllfkEUZrs+RNsDcfP/TN8/ZluzaKD5G2KhQxx
         qDPeQiFJ/Rz7wxMTCk3dVQ2819h9nYkiHn+wcXAfarEehpTxxyuLOe9LcIGzQHUdC1nQ
         bMW8hiZhVoMIcm54pbmwfCjYiltbtQd/GYjRwHOPRzln0dAUFdgRgQbJ6dViqMGgcHdL
         5a1g==
X-Forwarded-Encrypted: i=1; AJvYcCUhPhzjcJsN8Xha3Qj486IEXx3MmZMWZGS4VxouFrzNfqrN9gjF22/ZaeNyKGyPWC79gLeD5za+oCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtLJzu+dzo8Y/X6f0o6wTNZ7NucYlE6PmoYArqkLwcG71n22o
	HiMKqH8ONrk/ahalOWKodm7HXpOduZuvXYFfSPUbYNIE926CRZNFf0Uz/mrNYhfAiBLMwyrozZE
	SC0AcMgdeHX4IhDLYqeB1jcqep7+TpdzzynVQQIh3jozWBvTfIG8qA7ej3Xaw70g=
X-Gm-Gg: AZuq6aIMtQbUPipLQuvSnHqRRBMz8VQvyhnpDdnjAIfPMssiNomFjJ+P+krjYf7JFxy
	VdUtKBnd77vds/Af0Q24bSg1c+hvTOEzW/u/4E9RGFkuJKn3yB/7BL/PTYyPBzqSOHFgNVcVwGS
	3Ejxy42PWojjBpuDVRJwDffg6S5rcp5MItBi5tIId9AMdGCvnhTTreK1NXit5Oj5sZSqAIMwRYo
	gfyY8CCQQYINr77Sv2OQvjKGjA2nFWQt5+3e1ttwJ7VoO8W82xWq1f7Y8zHVEgjWY0VjBdJn01/
	Fv0y3V8jUA2NAPPcwcOaAXhWONZqGxp5WfFTdETNm3czZXZraiCAlPfX1Y7TmwRsXou5iLDEjjj
	OEiglV6t3RvU7/LBPJS/nXorqLZtNjRtbN+cgdAA5Lpf1v2GWTemV
X-Received: by 2002:a05:620a:1904:b0:8c7:10dc:9055 with SMTP id af79cd13be357-8cb8ca0b5e4mr941450285a.23.1771837583973;
        Mon, 23 Feb 2026 01:06:23 -0800 (PST)
X-Received: by 2002:a05:620a:1904:b0:8c7:10dc:9055 with SMTP id af79cd13be357-8cb8ca0b5e4mr941446385a.23.1771837583455;
        Mon, 23 Feb 2026 01:06:23 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:22 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:52 +0100
Subject: [PATCH v2 06/12] i2c: rcar: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-6-d78db0a6fcf7@oss.qualcomm.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=deCpsbgsyzGz52UYVrUFu+GK4rDUeaxHx5qfsuJiwbw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh2nfK3wWYF2E/xl2FdbyYiySDaGr7DmWU7Y
 gVOwe1z2tCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYdgAKCRAFnS7L/zaE
 wx/KEACU1EBIcNW47+QMfddH+tXvVKOd2tvwk6pL6qS63YjG7EoaUpXM31XW4EJi7MqCRLRCDlg
 gC81tNRb+Zid1pqEiPYtS/Kqvfp1ycij7mS5/LnnC17ugukqtbneKVtXQRVg9nny9MfzCxP5UUl
 xgHzIFWCwq98ELAqzaSg4rrdG8ofefA0PJEcuq5f2fPmsQyAHcF62k6bfZWOV1+vcJkgyU9GZxR
 NOjBebuqmXgJP5NisCzQ6Nu80KBwZT53MEQ0heWoc/EiSuxxgogMYrBCBsL/WFj49zhR4+4/EJV
 adnwNMA9579jlTWF3Szxb+vG5W/MKZTyeqxSA9BZ2NhPsBlNReYLHjJ429tUvSg2rnt6q+qFftT
 Xlmh42TrNDLpPpdXFvJ9KRX0enYLbt9JXs9AkIGQKiLYrAAwZrwodaptbHtC+XYX4uPiKwbKd+0
 2bIJgfeim7TcZL+Ruh1mfmXHgPwUG3AWFArAHg1sBe047KuWqd6PbBFFkQlH+K56BRq0lU8Ch2y
 7sJawmyu6+SbRyP8DE7EpDWu5EYph29HOzk9f/NoQSC3ARHNUayWALyELpMufM2EORXiNq5M3YL
 S6yzQDKetgiK3wkpUAxzJKwZBzmE7clZ7sXnbfXLcJXmNjOQlikQbZ0dWNcmnuq9OvqeVNqfqPQ
 boJzOV2Zd4srHmA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfXxrkO2n7nF5ke
 1uAp6C+awtdRgLwyTKsvlS+RytK32Wj8/zG5L41D8D24xFkjwjfyua4hBM8xqdi7OL8WcBwt4f9
 GCY43WY0SIXUo2nqAJ8RD6mMBqhtjwQVl+gYjne/qM5G5TrUpkP6mDU72lneNtnfXeiureCEcN8
 9CsN/lWDnBiN54vHW+lHSfPhqlYGM0sbxNHbSHR81S0rbmblv2LZhThFrF4THn98RLpfOU4y3RU
 m0QtjK0GsYnpMhlUmHM3c2x+ZpuLNutdnD+M+hdFY8OH+En2s++EjC2+D7UmAdZ98s6wJCKK2qU
 BZZIo7gkTiOKsaZ7hEDgVMi5H+prSQcU8uqLE93SPYRNKhbnMq1Y1dgC1vJVD9aFi/XvkLUcfp5
 uSw8ohgBWvBBwLdnbpiYHYEtyHMQH/uLO3IIwwGhTq49h/gp8LGx3AVCeE1OTbrstNbkXfq/X1I
 koWEBMlYwujiouYAZRQ==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c1890 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Cv5rWQh4W07jABGdPz4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: EU8sXm8BW4obIl8Iv3EuhqcNAqFfjHLp
X-Proofpoint-ORIG-GUID: EU8sXm8BW4obIl8Iv3EuhqcNAqFfjHLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 5ce8f8e4856fb2bb21c9cd731ddbbd8f3622ca26..af96892718fe04c5c428c82d3a47ad23aa08ee9c 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -171,7 +171,7 @@ struct rcar_i2c_priv {
 	u8 slave_flags;
 };
 
-#define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
+#define rcar_i2c_priv_to_dev(p)		((p)->adap.parent)
 #define rcar_i2c_is_recv(p)		((p)->msg->flags & I2C_M_RD)
 
 static void rcar_i2c_write(struct rcar_i2c_priv *priv, int reg, u32 val)
@@ -1149,8 +1149,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	adap->algo = &rcar_i2c_algo;
 	adap->class = I2C_CLASS_DEPRECATED;
 	adap->retries = 3;
-	adap->dev.parent = dev;
-	adap->dev.of_node = dev->of_node;
+	adap->parent = dev;
+	adap->of_node = dev->of_node;
 	adap->bus_recovery_info = &rcar_i2c_bri;
 	adap->quirks = &rcar_i2c_quirks;
 	i2c_set_adapdata(adap, priv);

-- 
2.47.3

