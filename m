Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048431A057
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413823; cv=none; b=VSYioY6/CwBf+aTOY8Y0V9i+urYKRfI5WPSbpXuFI9Ifd8nkmkyV3yYE0v3NO23Ib3IZ5WJn3PCYKyRa5MmfwtWyLwFOqNcjMHUtPxCFzuLm8ALaaWSHyzYQDmMuaJZM9K+b7hwS5dkVpo39vSO0folQmCOsUyBT9oaUdOZ8h1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413823; c=relaxed/simple;
	bh=ndLgSXx/mBdH+aIO/R/melqhTk5w4EmPGLL7fH8ffyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGQyiUc9+nx9rglIefg5mBm0uE0LQ2hdKzvE6jbm7fgcwFxx/aMHjN7mgXXwlJuGN/cwvUtrjQ1O7KB8eCIfDuqeZkGSybAGiy+Qea4J28YRSg06roTHtXgbSmFrefL4lVthn55b4fMt5ZpTr64/c2k9Ky1t8fR8zfIgugtTnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PeVDUUfK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E1cJ074x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PeVDUUfK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E1cJ074x"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678DsW73182768
	for <linux-i2c@vger.kernel.org>; Tue, 7 Jul 2026 08:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Tz2heZwqcXE9G3TtPQ+L0V6o
	PZSaui8/wbpBIExE0eU=; b=PeVDUUfKU8Or2HWA2zJvNNCXoookpr8OqY8Zp6XJ
	1N6t+58r2et2rMHd+fXDcBxXLeEn5HnRB1jAbiEd1ogKt8ou037Rxkt6jC7fNlni
	ndSQYKBqBBF1OmcmaNSDZVAmMmvpakKdefgc8+1xV6BB/GTd+IOpDAsMpsdOT7SI
	ebWrFjLh2tBIPqiMQDDZbT688VIsXzQY+gyiaJLrWTEao2bFW4CInFtMu5Yk2fY3
	IW/i3VF5W1NM/dwWTnM0TyIEd8sm6JDBc28cjbzLhKlawN1O+JEglZYkXRV6bkIc
	He2ShxziCCnx3LIB7SNrxmDUifugAjI890xVpNUFpv+e8g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t8jp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 08:43:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c7f385887bso62048795ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783413821; x=1784018621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tz2heZwqcXE9G3TtPQ+L0V6oPZSaui8/wbpBIExE0eU=;
        b=E1cJ074xYwHV1nAy8FrwCsb/UnIk8EXm3i7IQbwIbfNrJNGOkvouUt+Vuu5MHEM26i
         qLGHgj2z0toCN6uu8Ek4kdr8KpOOX6FIvIrkDgYveim/7bTfmUVuh0AhLfG4/MWvCYIo
         VfpIIjaULD57fvUUVAVzhyUnhJWzf0u6vHKs+xLmwYqPH0AbdhtPCkL+P0m5imB1jsNn
         bWQ7lbDDpanVi8PV3LazLr6f7EEVRdfgSBdwWVcmYKYYC/qtwQoaZcb2TF1Z25uIwswi
         WOqXw6Khei1fxWQyA2+uVCtUcG5cnQmmjyHlj5Gnjt6b+jRlbL1tsYbipQJKoGxKoo/z
         EtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783413821; x=1784018621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tz2heZwqcXE9G3TtPQ+L0V6oPZSaui8/wbpBIExE0eU=;
        b=VbP7F23tX2ovNV1+lWOOEAOrKUYldjP1qmp+kNMu3l04K6q7KfUka8UKXio/VmWIci
         l8AYF1NzEO86IaWFs1xVLg0Ja3RSYQVURjabdtZ+0NWVKRtOiFT/mc9aYHDmntKNljDi
         g5HHCdHg5KcNk2DJXb1EvaRxaCFffM2HBBSuAajQ/4ZD4jD78dcuKSYKWBJ05ewI29CV
         Ft4ZnS9OyDo5EiFlTiwWayvzMZtbNRm6Bo/gO0cTL2WClZi7gx5YDXZrugwJFVHEhHlv
         Zlv1S8YrQMHblGpfBDq9aj5dT2gQ/F5rAAJ/ux6QJEFYyN/IyYm7vVnJ3//IAK+r2u4d
         sqcg==
X-Forwarded-Encrypted: i=1; AHgh+RqvLyneg3wUDSRAF2s6ltWD12Sq9uwAqDNYIcdHqP3DrYwHvPsQ66OEHRBQOA1cv2/9KYgs9aZL1fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQBCzt6AubQe60dCROGLFL7l5Vr6iXa6nDCzgwx7YS3UJMoKG
	yWD1+SCHOoz3rBbPyjE3ik98PG/URiS3LujKwNw1y1KTMuneycCfFE4TYkV2pQUvhXiFnTylW1p
	8itoXV4hJuAqpugg1HTjJ1bWs1cgP7+4ABr7MH1bVxR6qvDDceFckbbr+xFgFFKo=
X-Gm-Gg: AfdE7clf1Es3uko6y5qjdNK33CPvDFh5PgrOo7FZTQwXxE5eI4co22OmRc6CUZ5tO2u
	dv9FxLg2d35RKpBEp0usuMmVUqnD02pEE4P7fLOQavP4GFnhhHiDm17WFLU3R6u8DVYoSMFjBzJ
	MIKkA6ghfFYW4KILCFoVZOU7dERMIr3+92T5N4F038oIg4wIljDCXJUakur6gU8lSsP9l4SrFkX
	n4CBqZB1Jetzoh6q/1GQTNbsfqx7oMlX9iCD29G8X1xxVonFd7Ijk8Vb0tRt7cfDteII5o/4SCz
	WBQFTL3IkiFWQkUQGrXZPaTYhwfoEPEp0Tpqoin68Ufok3ADPtKn6E6S41T/1vacrvePEH/orbQ
	UHRbQa8Onptkt7wF2I5nIeVsJ+kG3jBhlL+x17SjcT+QqqkFD2c6ROg==
X-Received: by 2002:a17:902:f611:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2ccbf087932mr43714725ad.38.1783413820757;
        Tue, 07 Jul 2026 01:43:40 -0700 (PDT)
X-Received: by 2002:a17:902:f611:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2ccbf087932mr43714455ad.38.1783413820227;
        Tue, 07 Jul 2026 01:43:40 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm7935935ad.15.2026.07.07.01.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:43:39 -0700 (PDT)
Date: Tue, 7 Jul 2026 16:43:34 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: i2c: Describe SA8255p"
Message-ID: <aky8NoA3r7WsjLXw@QCOM-aGQu4IUr3Y>
References: <20260707080229.3795971-1-shengchao.guo@oss.qualcomm.com>
 <5926f59b-e0c6-46fe-a839-620a2648c335@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5926f59b-e0c6-46fe-a839-620a2648c335@kernel.org>
X-Proofpoint-GUID: Bd8GltXnHrAv0HRpSMkwouguL1x_eoDt
X-Proofpoint-ORIG-GUID: Bd8GltXnHrAv0HRpSMkwouguL1x_eoDt
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4cbc3d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=OBtQoVzB7WAZLZHqdN8A:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX5AJOtsLK7gdG
 YtDJIv8cOrjTMv8/mZK6oViMURtYMdHyaIiMMrETo47Cda+A4+YzcA6liL7oIxr945koi4eDFP2
 10eufMpiX6+olP2xhlR+70VdOUn5LEN9//O7x8FhRxQq10RCi5nmPm5NpWjIFKJY9mZPRI+9GfR
 sL8DbQj/Wkk2gvywYlMbAT61juaHUgWWPEyZvyyOvUinfwY5UOlT2npJXCt1YS21GLul2JkK79n
 AdslFdWPQAJWFW2LYF0/KQ69m2ZURz1woQe8Ltl7mTSZ/sTYLlfKJSWUqjnrDwueKiund8wCmRE
 CVaKTS0rPybHdqqzFClNpcjmEQXroHwkz3jIEkw2jBn3RPQmR7l4JxZvTGWhf2Rdse8IXfcLeq9
 i0Aiy5zBuWmyTZwslVdJeSpw1X23W+R4VjHqxyIaJ5rSFBcTmNeVNSX8g1875HYplhdmBiZ5Ow8
 N/r2bO9SXKygm86yfSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX6wEovUqiZDKs
 ygdIJ9iTmNHmeaoy/HdprV1Pa+wgdOjBaD3XrwK4wFRNrA9YQG4bPNj+6VMZwzoxsJexYK6KKWp
 VXMedA6KuPx8aPlXxbPhIv2xK/zSbJw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

On Tue, Jul 07, 2026 at 10:08:09AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2026 10:02, Shawn Guo wrote:
> > This reverts commit fd359c0272bb4078f3a7ef34c1d53ee0deb59900.
> > 
> > Compatible "qcom,sa8255p-geni-i2c" had already been defined by
> > soc/qcom/qcom,sa8255p-geni-se-qup.yaml. Revert the change to avoid the
> > same compatible being defined by two bindings.
> 
> This makes no sense and to prove it: are you going to revert all such
> bindings, like 100 of them?

Nord compatible "qcom,sa8797p-geni-i2c" was added to
soc/qcom/qcom,sa8255p-geni-se-qup.yaml, as that's where Lemans compatible
"qcom,sa8255p-geni-i2c" is defined. CHECK_DTBS has been working fine by
matching geni-se-qup yaml.

  make CHECK_DTBS=y qcom/sa8797p-ride.dtb

Now with this geni-i2c yaml comes in play, CHECK_DTBS finds it instead
and starts complaining about Nord compatible missing there.

  DTC [C] arch/arm64/boot/dts/qcom/sa8797p-ride.dtb
arch/arm64/boot/dts/qcom/sa8797p-ride.dtb: i2c@880000 (qcom,sa8797p-geni-i2c): compatible:0: 'qcom,sa8255p-geni-i2c' was expected
        from schema $id: http://devicetree.org/schemas/i2c/qcom,sa8255p-geni-i2c.yaml
arch/arm64/boot/dts/qcom/sa8797p-ride.dtb: i2c@880000 (qcom,sa8797p-geni-i2c): compatible: ['qcom,sa8797p-geni-i2c', 'qcom,sa8255p-geni-i2c'] is too long
        from schema $id: http://devicetree.org/schemas/i2c/qcom,sa8255p-geni-i2c.yaml

What's your suggestion to fix the problem, add Nord compatible to
geni-se-qup yaml as well?

Shawn
