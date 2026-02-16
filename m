Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AD27A92D
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232312; cv=none; b=oNpF4DplPUZdCasTqYs3TY4CIkhotP/B8ebVZM8l1Hak/m8JoAPYN8XYR8+VbOyaphPyjZieYn/aj7jKv9fOk0s4eU/Thw1jIP5g+KTkR0zBdbrXRB198HirTfofyZJecSrZOKuB1/OIr1mQTIdMCGeRSR1/eQkvJwWp0Y9yWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232312; c=relaxed/simple;
	bh=SpvqgitAm5DBJSVPgUSEucLUHNRZc2U0J5AJUKtXN0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMtjOH5cdLvvU/O/EuiPEFSqVnqrjliFir2cwthUmhGmbheCEv0KNKeal15jr+tPBJ7nvRxbcjVCsjIbB5MybdweU2m0DXxysJ3o1MVaDCltuUinVH4fc+RfTuP5wNj2YeNPu3QG3uBLmDhYg3Z6uX+PClk5e9Q3EitJvupYvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pI0PCEaq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heVEx9rK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pI0PCEaq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heVEx9rK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G8dA4v2271398
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 08:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9mdP1sEEv3DicMUKY7bSjSANFfPYJzLjnK0
	jreJ9ZYc=; b=pI0PCEaq6yuacdESyQI3Xxu5yUgIKlr1pbhByXdK2cpGfdymriL
	1upMcvYNJS8w/ZU/kA0Sz3oQHDbeIjMiv8hfpmVH8ETEhzjR9wxqaFQDGsSR8HyQ
	Y1jvlPveJNCi7oxAqLaHgPad1jtQOf1gfImtjH0jWjwtpzEYbDfTny4UgvexHfS+
	BJ3IEwr3kSI/Mw9czgw9ErBy8WEyFaB9ZY7tsb67991r/y/9O+SUBIeFvgZfaOhe
	HWyvtXdNq2GPHLoiHsbP0joOIjYwFWTahPoMazEu6GAr8IWYA4YpqqxVHV7sKPTc
	53MeTb8NImYTGI5oF/w53QdnGGZvTZZqfZg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cah4sm08t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 08:58:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb37db8b79so3265957785a.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771232310; x=1771837110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mdP1sEEv3DicMUKY7bSjSANFfPYJzLjnK0jreJ9ZYc=;
        b=heVEx9rK9Hozqa2QaDbWY6UxIQYG0/SV/teBsNf8DYn1bt70y98aUP0xV+P5Mrtv+B
         ZnrBMuOAA1pPWr4NI3Z7eNPi3gJLurVEciyfr3WmadfBMjXpvTV269YTR48Ew8qdGwSx
         Lr37PWFI0WfYL3ifzHSgD868uz78OnQhaCqHO7OsUm/JmyVidk+iYNxeo6LesMZTAkvb
         i6liTgw7BB8xqHL70AKJsNoiFvAX7EpfigL3QnVxlriYp4814wWhSiF3zf1Ni1s+k3mT
         3QOjDgDtJSjVAn9JycKDZnTpo0Ep02/AxQCOw/kAXdPHVuxdfUAQqqlEyF1fUN+/rT0p
         dJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771232310; x=1771837110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mdP1sEEv3DicMUKY7bSjSANFfPYJzLjnK0jreJ9ZYc=;
        b=P8eZPx2vQ6Sfm/7vDxNSe5eb0Xp/YH0aEM8VLgpdaett+mLL2g/nSt9X/Bt3JnRPgr
         NOs95QWORCR+OushtiJlxxe75HyPyxVk3lQFCbzI6gQdPg1/oaKlmnGDYfxZubNe8vwK
         2Kzc0Z5HjJCq0xXCN5V4TXomk3pCWUG91jR3PF+EDCRZ0JCekp+vpiqbd+euo6BKOu0A
         QPdqD4k4iUrPIaE25q5WkrgPgvcgMfnhGt6vA6Vrwh+74kODLLqM0E8rpgTU2ANoqtjS
         wfg72UFsoARfo4GEFgedspFbdNRVO3lXhr5P7k0ZmXFFtkdRYqY0wmGOP4dbHHO1F8P7
         Fpjg==
X-Forwarded-Encrypted: i=1; AJvYcCW6LRlV4zFNALjayVFfv/LGGIB4bv3gJWMa7AGNFcTTDYvDDyqyKIY5p6r++isLAoX6qmZgBP5hLB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPqBY3tyS+vruNDfFvQbQT5Zh1Xu9WnY0bUBUaOImO/A80RoX
	RipJHdamDDz+Pd4m2Mko+lUJhp8QBQ250BZ2yB/Ib5pefGcomay22ZqDlw6YAnXhEtsxKBguf9U
	/GvWSLyxQK76adVQ3kDUZ9m3JVJJZBflHAXwtLb4dCwADXnMQrK6n94ieUblWjxc=
X-Gm-Gg: AZuq6aIPUkXI2tjCAoJ12UWxcDDOWIry+a3pURuNFJc0Etf1pUGyCdlKOrz6+xEWzuf
	KrDB7HKkBEEzAEiG47x5OjK5yDLm5hgXIpvKAWZ6f39z4O0MXWqP+otO6t0w4VN0HdoTCBeVGRe
	ZaMOsVoUFxIS3aGahYE3LRww5VO+v27CynrBK7t/jeYrDLg8k0s+r6jrkMwGsKhmXQ+0X7IyAXL
	BDlCRWq6pjGB//DS+eaYA/M2ja9VQ8a8XGuwHLPb8SrQLV4p41RJxSauECU23HiuaYjHk2IlwD1
	sqPVRQn375go/YHAaf9DOhai/971j60ylXh3g8Hp/5rGJEzfDmftiMYORhrUhm12asX2l3O0hCf
	vLVEB27vxHAWgdLFl6ed/RHpsAn/bminqW0sD1g==
X-Received: by 2002:a05:620a:4487:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8cb4bff2bd4mr845018785a.49.1771232310053;
        Mon, 16 Feb 2026 00:58:30 -0800 (PST)
X-Received: by 2002:a05:620a:4487:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8cb4bff2bd4mr845017585a.49.1771232309653;
        Mon, 16 Feb 2026 00:58:29 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm644400165e9.9.2026.02.16.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:58:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Andi Shyti <andi.shyti@kernel.org>, openbmc@lists.ozlabs.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] i2c: npcm7xx: Use NULL instead of 0 for pointer
Date: Mon, 16 Feb 2026 09:58:26 +0100
Message-ID: <20260216085825.70568-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=SpvqgitAm5DBJSVPgUSEucLUHNRZc2U0J5AJUKtXN0Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpktwxbeX3OO3EWdHHHK0tcuimC80VWGXUHBWb/
 TcNUsr+0x2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZLcMQAKCRDBN2bmhouD
 10wDD/9aOai/6YTX7krBZ4deU7lzy8oIaMnkFJiPfNFcD74mDJvAb0xMBxiT2xykteztHQHyhlJ
 7QBZsq/F9vhzh+jHHsqi+NNRxY7BRukmUW+Yy865W9sNxQEusH8cY71MR9xm79eMjX31apL4tUT
 k9bYQkU3DFOhiAmdh4VnH8qtecqeD/DKXVNPOlzTTs+CmPuRJA3tzpezwJw8W/HVavRfJ0+o7sa
 OqSiNS1oj8KCAzsyxEyPJ1ld+cwXTrBsyWvcqj9EpTpQJRrd0H232k4MxOC1kUFZ0R3PgM3NfMO
 m2i1nPEDdMA+Z6De7noJ1wg+GpjWHnefY7T2rfXNAqXqEGxk4VpEUZD3GfFiaynXOeYqAJq/YDl
 Iu89ub+d1xndMbS/oZSZ3YR/DdETPeZEC7lU7bsD/D5ZMyGesyP/Gda1gqai9ibOfPtzgRliYzK
 zzGc+OmBiXyZS5FEGCjMDuRarDrwYVfBOPo4PW6AVVCyPJtctGYWeKmjzDO6KX1QsEaTLrmWRq0
 i6tWHraMtGcSKqQWMAMvnEQUaQaQAkTrbZrF5MzNdwpbqbMmrUBwtG/DMRgn7wdHKHYoFgaVs2z
 0ILT24WuIHzzqc2Q9Asq3Gv86Nb250UKTWZmyDbNs2kUJzAPnMsDJd3VI4yYpw7xLc0bnMVblhi s8cR3vbkqSfmVaA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3NCBTYWx0ZWRfX57lIceHGJnu3
 0CfGrrKUWLtZWxJr6/etoGp2yXp93z5OxVhZeURAB4lFo4pCVhysUgwizqQCyguw+yTxQd+EB4p
 +u1V+O6jADIGx55K3zlfvtQtg/yjBTUkLD+AzzVmvovQjpg5H6vy13/U0I/P7hnmkZdBvpluE2S
 J9u/5ndzygiStB/AuwGiuuRkiEy8zlFAE2eLIxSq9m51A1+YUdSVZfJY5geq6HnVt7PNEdueGQP
 wJaA/eoU6wZy1TeqY1kNRwSBxvRv6CHvy3pOO9WIGiUxbYFIGsWWr7gAi9RtibTFKqiKLHQ6E5B
 M7Gxf0P7cKKbYY4nozPS8f/FUXIaPaieOT5h1Am/Qbl5HMjGc1rg2gU2DAKxbaZhgBKmObVUJq7
 dnqYQ8/KZOoF0l6gpK8Kja13lTBfnqdIX+didRmW2IkgTRAO3QTHBa0VXXw/s4IjrjeR5We1KFa
 Dp/e/bMAIU+kv33TJ/g==
X-Proofpoint-GUID: heABZe9SGftyu8O91YtWi7R99Y9PWgtS
X-Proofpoint-ORIG-GUID: heABZe9SGftyu8O91YtWi7R99Y9PWgtS
X-Authority-Analysis: v=2.4 cv=EbXFgfmC c=1 sm=1 tr=0 ts=6992dc36 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=pz2CoIr9GbPYS4DEQB0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160074

Pointers should use NULL instead of explicit '0', as pointed out by
sparse:

  i2c-npcm7xx.c:1387:61: warning: Using plain integer as NULL pointer

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 8b7e15240fb0..f667a873b81e 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -1384,7 +1384,7 @@ static irqreturn_t npcm_i2c_int_slave_handler(struct npcm_i2c *bus)
 		 */
 		bus->operation = I2C_NO_OPER;
 		bus->own_slave_addr = 0xFF;
-		i2c_slave_event(bus->slave, I2C_SLAVE_STOP, 0);
+		i2c_slave_event(bus->slave, I2C_SLAVE_STOP, NULL);
 		iowrite8(NPCM_I2CST_SLVSTP, bus->reg + NPCM_I2CST);
 		if (bus->fifo_use) {
 			npcm_i2c_clear_fifo_int(bus);
-- 
2.51.0

