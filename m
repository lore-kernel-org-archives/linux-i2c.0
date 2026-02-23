Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D334E767
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837220; cv=none; b=RXplUFVDvGSWJOME8IYdAuEpaHUParxPAfT3rLFliQqtuGstlL7MbqTKY7HLexNGIj04fKnKKXIHmeq5v3sRCXDb3pib+3qoLwgc8RH6vFsiLK1bnRFpp3OW2U++21T5lL4+2dMD1bq5Xthnd0dE5FDsZbIZmhfyigov2P+WbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837220; c=relaxed/simple;
	bh=+nrztrv3eun2Q963Kt+vOIIxHNHM2moiogYKDHo0wls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBhOZlHqy6xAQVAmtegPPaS8Ulncnka0hQrHT5giCrRpWDixO/QrdUpjktQD02TevYeun5rnAVxR9jMgrwgnBsYFOMcFss5yyTeaRBDZqYBt293CsA0Ci1HdS1Efo5XBVtA+SBd8CVh2i6SlqaP0GadwB4JpUTwCrYKirKPEXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TT0IGx/P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JE7HaO/u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TT0IGx/P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JE7HaO/u"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMMtuK3234263
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r9uATJ82hYYI1P1Ta5M3mFlNuQ1YfP5cbyb+2iRgAqk=; b=TT0IGx/PYUI1U7Ol
	kdWhf4gjUtimZksuqySAj9PKyiTbtTW1gVg4VkaQbbvu9xGcv5SIHNqkRkMHepfV
	g7twqGAQFobRdgsd/cXNgsHNgJ/YA4LMf2SF37z32lOEexmghS6ezEygxKPmyKYE
	o1sTZMCkUOkGo5df+14DsjSRzobWFnYlsht+rmhLzKoq6i2wMQ15klzZYcVMrAwv
	p0PuF9056UXiFL0Rbj2/JtKRmJGxsc/VS6PNggCqAb00Xs1LizbuKFdja0LTtSl0
	adfUiqxpOgTLQbwuOEuohEAlh/zIbFumspXaXWFeqmMNO6tKwnqQDWHqZfj+9wNQ
	woHLVw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wk4078-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71655aa11so6373919285a.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837217; x=1772442017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9uATJ82hYYI1P1Ta5M3mFlNuQ1YfP5cbyb+2iRgAqk=;
        b=JE7HaO/uWbc4aZ454SpeXa/TpDnqQNujML9nJHkwZzI6rpLaFv+odqpB5KU06wcTOx
         ZSo8B6BSUdfr1q6qMGuiEgPZ2uwSObVkLmqCIpya3ppHqpp36b9044SnK5eN+sKYH45i
         eCtXQXOETEgKlG3uOnkw8y6+GFazElQ4LC8oUWTF17vDa2lim6ahwQMFUn/5WI72RhQd
         S+7Q4sJGST8u16T9VKSTqEBG0JEt46cB/iL/K6Jf+YUCKrRImOeJJTSLvtclFFCztNYb
         EEGp1SG5HWqAuEVl2BXrGwwnSghS7FJF8VS3eQFZGROVjh9zb2gd4iuKGpno6YEkim4d
         R5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837217; x=1772442017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r9uATJ82hYYI1P1Ta5M3mFlNuQ1YfP5cbyb+2iRgAqk=;
        b=e5lDQCx2gmQbz3uZW/CYz3VPMDDGnOoSAmPc+Ic4yRbGVgvOHv+R3KX5ieQJSsWERK
         zIznaBGCo/q2Vl0Q3tPWwzbPreByCAdeTdEjsdCkMYHXVKWC/5nR5fUCa4vxc8jiouKU
         zY/jD181q2Zl6kBfaWPYb9C8zsGuIPsvap8lqRvk3rNDs5FjAyFUYN8el9L6zOFDM97N
         2kFQhwQJH5SWBLafzGjhmDJyFIhhjkoB6kBHj8fOaIt+aw0dfLtqAR+U29DdRa6pn3O/
         X1vHwW58uVj3ijJ+A6BkuVMdqMxobt1WTrHaajtUScMIs/JkfUoI+THKTQpUEaUXUTTU
         Ip2A==
X-Gm-Message-State: AOJu0Yx8KZvZfmlhYqcsfi5Ie1GNBQRbjqTfAt3HNsUOKnRf30qW3lpQ
	Y+4zWl3bC9tafiSPczk4UveayehJQl9Qf+daJyYIumol0IGdIuntpZe0MNjhkyNN/DNyY1z89YX
	OjwNo7AXBafMwG3axCGHs/SPGHuEJGhS0/QPjgIFvu/y4tPSgJ9sNKSZJB1PT0a8=
X-Gm-Gg: AZuq6aL5JgTbxwxD2Cil1KEVsk/Sjf4p/TaB1QOsG0BC0UDH0M7PbEzp8n/e68Ivjk3
	EnzK0Ki/i9cUQDpPdwQvmcv2x3D7KL2w94UOe1EexCDf6/gt/1E42eSXLnrLpwF2EJLKVlohfx7
	rXFfLGLonRnD18Qnbkwefmn3bw+VMilq4dDxT9V5jE5aVKbi0Y0ya5CpJGS/V/Z5BimtfurHCGO
	TX/tRjxq/9yyITXOtMUobITEFdWCi6hclgegSn2RKz9t+QL+h7E/WD+IIFjNcXY3IFr9xQI6JkA
	kXIb0BdQWKspG7dwYRhvBm8WnrQAs40C+Sh3XBNjM/biTkOAuAnhJ0xcf9rQ86xwykDxW9Oofrt
	oPcToolkKOANN/bN1c/+ya/kn8oc2nsGnEjPG2RCrxJk/YkUTtFpR
X-Received: by 2002:a05:620a:29d1:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cb8ca6e5f5mr946106785a.38.1771837217171;
        Mon, 23 Feb 2026 01:00:17 -0800 (PST)
X-Received: by 2002:a05:620a:29d1:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cb8ca6e5f5mr946099485a.38.1771837216730;
        Mon, 23 Feb 2026 01:00:16 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:15 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:39 +0100
Subject: [PATCH v2 10/13] i2c: owl: use i2c_adapter-specific printk helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-10-13b2a97762af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+nrztrv3eun2Q963Kt+vOIIxHNHM2moiogYKDHo0wls=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcG0op/5Rmmcmy1LClzr9Cd5rvHSa2IOhyh+
 IHRW3jceAiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXBgAKCRAFnS7L/zaE
 w5oqEACL8mqyvJjis6Rfx0rOWs5khRMic3wAg6GrTXJNenvQou1AWcDbjBunSF26We1tgWQEmf7
 VRCVaQ/cWoy6LateYwLbZVzpk4XNFkbere/m43SlqDPwo5mWGAF7HmASiol/gc4AnJ6gGEic0Zk
 47TiKxSQ7+nj4p9k2Gjf1BALtw9qKgtTXgZIQkG2Mipxi1fV6I3KnMXvY9LLcSdSanBeW6wgYBF
 EN5KAfr8gi0sGkley7vLr0vlCaL9fJUw3wvnoxaGcjKZPIqbjPJAAbio28UP7cwtt1fv7nTw4qo
 MtkuZG76tz6CpvoLwK7i8qoNFOZMHmqKXVY5VwTVHUa6adviUk/UXcsECWHknfSL1o/F28QPipQ
 TOxHFbOj9KmIGFJ1/G6YiO54Z13GwZRCEBBXi+KYgh9e6Dg3XJ965Z589WrWaJO2Si1wCWxNTZK
 cBuTsMAuNvrbrkcZ8vFSM96OHqLs18szgWhcgb3nuLqXqd5YdBfpms2I6hsaz9DXxqnTGXoZSBM
 1vNqLs2epqXyzG6VlfibW6cEzyb+80lDvbacE7/aVxEjQjMS8k5LTMSKMIue8o/ZvU1Qs2Q0kmW
 eBqKRa5zfF7/AswvNJrigg31veDBrNwzhG/+0B6u8EH6op2DaYyv/l55F29zOnJkV5kC9vi8FKe
 EXKVEvxa6w8ktEQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=699c1722 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=td_-LIo_6SHiI0BopBAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX6bdaOIxwtx6A
 ZlZ0L2ZItlEa6g4CWGCgetQa0gGVGFzJzN2FwEAwzNh2b45iXdX1YoOvioNN5/nzEBT1ifCiZt4
 +TU7GUtGHMOQNvGs8qvBEUY5Ky5HKuf5a2u+vjVZH0s75Cp6JGhntSwEbab/CuaNwiCMQQQ6YQl
 HPOo3D3uiSATbkm6GlxENATW2s5EEUtJ8+nSUg+d0q16Fl4tg1OIdTKReYSuK324h6rU1Xngv+P
 utSMvQS2XsAEu9z12KOL2lLj/2TZskQ4Dn2QSHcAOlwZI8wCRtEEaCvo+bEyJK1pzMGc9PYOEGv
 5OLpGg0NPMGehRpJOGYUy/FV7TOujN5jjFGVFYNdvUzr3NclXrP1jmPjOo4Tuv53UK9zlwWVXEB
 TZ+2DElIganGXKCi6xHfz9F5zK2/VAO649TZtiehj5Z5I+DL+KVL8S/LzXXT/9pR8mEfYsy5XG6
 CiddYCTiq2ZcK8v8+SQ==
X-Proofpoint-ORIG-GUID: b_wRsSaDHwl8V8wXfRmpqEmvXUSyRYvJ
X-Proofpoint-GUID: b_wRsSaDHwl8V8wXfRmpqEmvXUSyRYvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-owl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 84a195e358866d693fb6d435a5beaaee640fd2e2..17718f15a0f1fd238bb4a6f23dbb4f9696969ed5 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -241,7 +241,7 @@ static int owl_i2c_check_bus_busy(struct i2c_adapter *adap)
 	timeout = jiffies + OWL_I2C_TIMEOUT;
 	while (readl(i2c_dev->base + OWL_I2C_REG_STAT) & OWL_I2C_STAT_BBB) {
 		if (time_after(jiffies, timeout)) {
-			dev_err(&adap->dev, "Bus busy timeout\n");
+			i2c_err(adap, "Bus busy timeout\n");
 			return -ETIMEDOUT;
 		}
 	}
@@ -383,7 +383,7 @@ static int owl_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	spin_lock_irqsave(&i2c_dev->lock, flags);
 
 	if (ret) {
-		dev_err(&adap->dev, "Transaction timed out\n");
+		i2c_err(adap, "Transaction timed out\n");
 		/* Send stop condition and release the bus */
 		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
 				   OWL_I2C_CTL_GBCC_STOP | OWL_I2C_CTL_RB,

-- 
2.47.3

