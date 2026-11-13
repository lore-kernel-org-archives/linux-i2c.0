Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575962;
	b=2yb1CyTWsYWBiZuOuZzfp1GX65xUk63be4LCgj8OaUwCI9adXg7em07VhfQ99PpE55jy
	 rv5pNHi4aRBOcMp2eJ9xIX9JcrnyI4bcun796Kow6UGfINSNwG5ELiFlDp0gK8MmdKnbB
	 rlK75OfsJQRJf1Hun90RYV/8B9bzY5/sjfFMncO9xnY3pyOYGT6zZr9zRAAb8LY0vHrg5
	 H71jY39c2/x/N6PBp3ozjUuk2nUJ7fXPdVyBOKteBiuSKMRVDLW63iKJgs4GJlIsaekLj
	 CKrchVoa3vn+ch0NFwtGsDplJG6iSXvgMGQUz1MZYJ9qD+eWkXPl8znfeKom70egeFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575962;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=p9+kvjIHXZ14mZtQUS7aUqmnr3L7WL4yh3D1cUye5yA=;
	b=lys8fr6UXXAI1x5CMxYusSsSzqO+/fibX6gW7QBTbvtab+vOggkfDTJzPdIRV+y1sfQ1
	 +7cWHV+s6I4icZBds2RRv7/NS7BG1vwpwCScEKVpMD4YJEOOSU0fDelW9nn7s6Lm95raA
	 i/7T4BDC8YvAktOR7aJDJ8TpGKwnU5UmhhmJxoQDMJYmGFqb7bMtmN90gzEzBrawIR5Tm
	 X3DL+4RsLOpbuSf/QgsqMMH1etXeqfzUmIiYIrX5iZpYzFd3hRmSgmLtgm1614tCk3IqY
	 mmPFYQxvdngtQsmGxoswWuJtxW1odq1Y75Siq4OlVLBn36dELmL7DIkzuPRJ2CmTL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fkiSGV9o;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="eoWtndR/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96041606B54E
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 13:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96041606B54E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fkiSGV9o;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eoWtndR/
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJTt22796671
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 13:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p9+kvjIHXZ14mZtQUS7aUqmnr3L7WL4yh3D1cUye5yA=; b=fkiSGV9oMEBen73e
	3z3PXFbDHhaz+jN4Juhm/OAHGyzWR5THMgLV6/ep/4YcHrW3wBHscpFlSK5Fhdxh
	nIFazJ31SoXEVTJMorHr2ErEP+s8LrOPOUQYvsD4c5miz/yPNVQYx47NsvQycS9B
	VEnRCv8R39sk3fGti9QdSBV1F9E6KdVnhmmceFE7icoCcsEGGqS6UGp6WnyUXwLS
	FOKRYXbZavF1jbKoO8ENEoTAIkwsdxTG2V35l71vpgfXVg1z2H142jJGEr7UjzEZ
	0MyMmMCRHWAz/qDuUYaMXveDgAx8EzsNeSbnxbZ8ooSgnT6PPk8PHbonx2IRjXTp
	EEy5Ug==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6sffq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 13:19:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-537548d4bc0so27222911cf.2
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794575960; x=1795180760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9+kvjIHXZ14mZtQUS7aUqmnr3L7WL4yh3D1cUye5yA=;
        b=eoWtndR/pXHgQ1aFoYbhBcQbb8HdXDBaOcfLERgPDIHEL3i30UFrfDnkZ5aiP52R/k
         Hev0E2E78bM5OEyeAB8Q4uQ6P/H43tjB9/wFrzoH0ukMhQJ2hm+PnqufIw1Ud210b6bd
         xkJQNf/fhiiwBa7daeAGdvhLdSVi/1WHkUfZjIyQVk7a8NkPdntus7V0Y4PTsJB5BuMl
         qdl0tJrZ3sDhUYoxX7rVGXwVv2zV/Fe1w+e+kKSpW0KNL+Ac7/MBsjSBiXgvhST2Jh3R
         4EVHujsxjHn9kGZD2KekSIXnSdhJblc9kJBjhC3tXDbCfrKiqfdCnNiqcOxpSlbs5OQx
         Vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575960; x=1795180760;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9+kvjIHXZ14mZtQUS7aUqmnr3L7WL4yh3D1cUye5yA=;
        b=jEowBgx+zU1hXIJXVi1aNDd+WsXApMo2mjbpPIxgcjEAmoxBB4HNnQ0/Jfd6KLQUUH
         c/TM4a0AAfzy9B/BGf9ceo5h978kWHZYSlkUMSEz38D3U/V/u43R0h6k/ak6l+yHMrjg
         Eb7E45URDPzTh1ItXvnxnyBNKql39tfipgU2qwj4l1trow2TMxScq08RBZLTRd9UARYo
         3eWDm44ghTYhmOVEkQ1n5HiDBmNyjkGB3JCesK9jG434Jlxdj6dYnrKl1gVg30WHCPll
         iOD1IVADEi6xRcb/KvlqyRtJ/gFsVg4LR2RWxCtsr7lFBVsGSy22daXjY1UHpbU+tQh4
         NLkw==
X-Forwarded-Encrypted: i=1; AL+hErGsS/ZIe4/2ofUAzW+T2PATlkIRUQXufPx5q/M7gzeB/a6p+bQ5mRq0MsJjt/+P9tZfqkzauIxkcoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ILxj/iirD7UduP1eNLqai11fC3PTOAGIdAu5yirR6EK4/kxk7
	lyEP3SynZkQoe5op7iuR8NOkJkwH5HUhqkcbVnGmCG9+WBJXnBAa3wQt4C4FKT4Cislb4I3lXYb
	GADzizvICTnHCPDGUSzMCKGp7joULL2ZlHeOvZ4RcIBiRTeFyflfbJfhWwDDhX9A=
X-Gm-Gg: AYBFou1qrVHtNy989HoBzzvatmOswYUyeuRtTUhSZPZxoJjd6FTJONM6XOzspNa+/St
	TVoMh++0shvUniy1VcFQ4NxOWncPljDP7nUss1uywar0gBfcaX7UJT4RE72lLFDFr92eWWfsO2R
	cvNXiVxSwZ4Fora6oaLVdJBOisptCCApyIXINRVgMxeGQPjt50VOmV0gjY904sShsVhe1KhRVH7
	Z4vIuk0/44K2QH/uUDLUTkZ3dVjgQWQ7mrQu6hF8h2dKrP7tzNfP2T0U/ATAONZj3KA63865x7+
	W/npw+uonL/pp8r5syz0LIkxJXn3UEc7vuUipQM7F21YYwPVUIZrP0SC4NiwHK+SJaVI1T9geGe
	9DIJAjcWMp+zvRrxg4ZUZUzgKIO/sAXuseOixpv10iRSCmdW6OjbzXVJ2uGdIChqdjBSNfwsiOf
	9R5pxa
X-Received: by 2002:a05:622a:991:b0:542:d089:2060 with SMTP id d75a77b69052e-55ac8d8b5c1mr34890121cf.37.1794575959809;
        Fri, 13 Nov 2026 05:19:19 -0800 (PST)
X-Received: by 2002:a05:622a:991:b0:542:d089:2060 with SMTP id d75a77b69052e-55ac8d8b5c1mr34889651cf.37.1794575959180;
        Fri, 13 Nov 2026 05:19:19 -0800 (PST)
Received: from [10.218.9.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1b11d9csm18250821cf.28.2026.11.13.05.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 05:19:18 -0800 (PST)
Message-ID: <146d6fcc-e977-41f6-b34d-f7a9a4283ee8@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:49:13 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Prefer asynchronous probing
To: Wenwen Fu <wenwfu@qti.qualcomm.com>, andi.shyti@kernel.org
Cc: viken.dadhaniya@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261111090955.3378623-1-wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261111090955.3378623-1-wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX38gXt0QaQZDG
 h+ADlzdvYgzjL2j1wHaZZFJ1xDJkJd4dhvq/nArDJDtHKIqL5/+THiEeuZia3DE+W6OCI7lGRMZ
 7pVFfVIuTpXGNjABnANCi+Y+BOzlUCG4D/scXxBMm71D6BuFqVPrGhtKFIGJVHZl3UnQyVDkCBU
 HA7VJjx42pbQ574qUw3uBQwYRklGU//1W/Gjtqrk9KtX7ZucOOBK4gfSzLNNMdo3/KBzJHzq8VY
 MHdEFDj2rxnwiEhNSVXZvK34Q3dsUUiNn/JvJm24u3IOUJ1L9r9QwXlFxSlovSCoGZ/NrM9EVyB
 iEXQbfff+Ei20gDU5v0xsTrdjHG3UmjLnm6j/ldVIoP6og9Xsw82Fc9/BqQGkdBxyLrJmPHYvmU
 m4HKfSlVeHZR/3MxmNGZmDpuTOJrerDz3T+eqga3KqLNxk2NNrISASg3xYdwxjeuVVF/pi5clqN
 HJmwMUybMEt8xFLxgRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfXy6HpTiIUHVro
 C+DgXfCpP8bcy7jrmaUxWguM/RMi7mBaetz0SmteBzRDlW71azKjP8VfOX3NP+VRTv5Peb5MD53
 q2GdGHIKyETBveKBSxqWxaVIIpGMQRE=
X-Proofpoint-GUID: xzn5LpbPCPK6D8i9CT3N2WeTRJPw39pV
X-Proofpoint-ORIG-GUID: xzn5LpbPCPK6D8i9CT3N2WeTRJPw39pV
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af70e58 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=BP9H1aEygeDGrBmwyXcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130052



On 11/11/2026 2:39 PM, Wenwen Fu wrote:
> When built in, GENI I2C can request serial-engine firmware during
> probe. If initramfs unpacking is still in progress, request_firmware()
> waits for it to complete, blocking subsequent driver initialization.
> 
> Prefer asynchronous probing so that other drivers can initialize in
> parallel while the firmware request waits for initramfs unpacking.
> 
> Assisted-by: Codex:GPT-6
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
