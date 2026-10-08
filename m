Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016094D5995
	for <linux-i2c@vger.kernel.org>; Thu,  8 Oct 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474120; cv=pass; b=J/AMtDMgPzLxOJ54Oel7UbcCoMLZZTSnveqPwtSbt2AfI0HAjHu4RJ8QcojSHO5BoGFs3XczjUJfyiklFpVLrzMmNHwqhy90ZB3SnwDwVGRd2JIuzK8q1Z6rOPmuGSxa5ti3eQxc9jX/zIacbve3yOT+/LOddlAKppo0qy+GMFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474120; c=relaxed/simple;
	bh=t20Ga3x8bXqC2bOb7ons2kgZbLzv9IG8A7SxB1EW40M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3PFxZOOkncmJZ9dnwMtna2EQkfNwkMpggydRrW0FrMYdtesFoZ0f4lYeQ45FJtUTTd23mXNQnA/ym1k+UPx0cnqp1I5E500ENOFJePteJV42Esez3eLNfi4IH9DV3WlXhsFhqHAz6KL9VjcOZ8WMG/RSOQZvsLybWYGSLcmzTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OEgbYTy7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PD3/xvz1; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OEgbYTy7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PD3/xvz1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVQ5j3121551
	for <linux-i2c@vger.kernel.org>; Thu, 8 Oct 2026 15:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BjM/nY2k93xH8zJGRXcEc24X+zL/pJP08AQxr27mCe8=; b=OEgbYTy710WUPuNO
	RjKY3GPUnKrdQ4I1jXmsmAx1LqtadDZ/Nx6f2EgiEfWEkq3cgpv2/VuROLQiQXJk
	M/6lnZdnw5bG5aX8GyMSWjQtQ7tRPQ8A5tDg30a5gus4fUrwMR38IlBC/WZy6FW7
	3rZYVfCJfmgKB2kAR2VLS253RERTM3jWFTgr83vnvGMpUNrGPMgfzOFWqXo8uXuJ
	TJWlctt4JyOKzbTfu/fcjd4UbVEEsFLCcuytkWiN8u8yktcBcqg3zm5xKmimTU7p
	Z0Shlg4TvAS53Bp2U63xEuo4qjs62+85idT0rSGYWuZY5OFXamARyox3NiKh2YcO
	MP4ZTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2upcw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 08 Oct 2026 15:41:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e834ff4d0so1016292685a.3
        for <linux-i2c@vger.kernel.org>; Thu, 08 Oct 2026 08:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791474117; cv=none;
        d=google.com; s=arc-20260327;
        b=FRRi/UOuQGu8/d+E/tGrURGdJfyL+tH7YzhfogUo5AEOBRi2gNXFOJVrK2AUCvnAVq
         Io812itSn/LBFQPLdrQ6wsCT1qYoTmtq4NngTMIztgClk4Fro0dlw4CrWKvUniolHcsc
         eiYxFJChxtgOaL80wRelcjgdeHPHL8P2it2E9MT9++4GXZNITTl5+amPRIsjoaxrYE4u
         08dyEZzand/ONTxik1yeJ5mfq6oeRHtXEGiPjHT0gjGPLaIluKbfpzqL+2dEmcUZqgot
         UQQJcbp7yCI4hHm5HdTdkkVXo5YOdlHHB2Q1KT2FVcmOFlDEi8BEd5wPpdcfsChPeAZr
         DeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BjM/nY2k93xH8zJGRXcEc24X+zL/pJP08AQxr27mCe8=;
        fh=kG1UsQvcKVC7Ln0Vji+6xpnECpUkceGUrOToC01orS0=;
        b=IrXjeBaMhlVVodnB9feAqFZykC8bG19XE7ArENT7rlP/eiSLCt54J+VS6sJvr89HK3
         E3l3/j3epcNVT49th7BN4YyM3zzu16cUPnikzwpTw10WLjPOEyWJfMke545k/IIZeOiV
         4hwNDU9TH02EYg+nuilgTDR6gx4moykFczQ62jibXLrleQRFCGlW25UwhAOqxxf+zJGd
         57pI3GsrcyryNHHterU4qw3wT2mb8+lL5AKjvseRNZ+Z3hBXvbUFq157cbD/qopdyEiR
         6A9HHpz7RoaMreLDCmTmi+nj7O9h555y8hcoNgpkcnRGZEsGlCULAa2T2bUKjcMCZ76F
         77xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791474117; x=1792078917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BjM/nY2k93xH8zJGRXcEc24X+zL/pJP08AQxr27mCe8=;
        b=PD3/xvz1aEbo8gCg2sl5Jb3RFNNDHAs2UgbBv3RPnfQqYqG+BlyTeRRiKvfwATAPRg
         Cks1lg3AoZpJwfvXbiv38dpODLe1Xr7IuPRn+difZ8BZKCtH6L+IjOWdvBQNb5gO0mz+
         LCmb8p415lEOKza5EJ8OTJTrFdSGguFwNDF2oMYg4Rn7hvgZHEUevDr5Yi7wdF925D3z
         +7ODgZpke/bqF2GEYbNPOpIbRAEckdqYhy15KW2CytqSK2zsoT21a4B/K1NEloPlQBP+
         K2hi4V21EN1fvUoGf9rO0faBwwGZVPfSuD/5RJv/+oWkLZVPm9uJ6y6eddis15QpuQEy
         bvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474117; x=1792078917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BjM/nY2k93xH8zJGRXcEc24X+zL/pJP08AQxr27mCe8=;
        b=usN/ZanibxdhpxdQoKWNBkvoVDDwaRhdA7iNo/4HoFMGo+YFqpSapqeZZMCBgvEnec
         PoBgYQySXzEFx+YVECYj0w19gLBEDSsB2x/u/1/Nf7pk+pxI7tb8+p7gi+Xbn3ETApzX
         tDJwhbMO93ot+f3mpigLR4rgaorVEquYzsACqh77DYnviJB/S2dh3Ff2PU4JIsx2rWOb
         a+THM3JvQb0uLXZ9X2Ru9HtdA8giMkMsp75rgog56vMvK0Qyfv5xKpIFu5eWtAatSZDa
         obhQ95Bx1FspDSd5DFdyaiJ+VbEoB4bDxuRzn1q4/lWlH6pNsda1tct2a8MxA0MQAqri
         dLbA==
X-Forwarded-Encrypted: i=1; AKwUvBygu1DyYyGJMpBq2scTTMDThzaz3xwKSGknv9cy4zFCPGsRrJZo1m5gCa4shbUsl/+hFlDYZvOfeNA=@vger.kernel.org
X-Gm-Message-State: AFuF++kCfuABId7Miu0D8yxUYuX3b3mtaVpDlaMuZaZw/qGl+nQFB+ed
	nDochCdg1NYBwflTiApYZ32MV6gn6Keat+et1iOUNI1fdhQmuxpVZvty3M94fm8tqTMXhnq474Y
	LiZ07DMmpOe8wj8RUgsSq4LG/l55QEp+4LuSDpxnsiYVV0cOSZPzfjHDgtLjdlpeGxKJ4EphYxv
	9bRyR8FdOmnQSNzIoHYbXxI9Cq2Z6C9MGDN4hlqw==
X-Gm-Gg: AYBFou25+AL+DQER+3yk470Kicx0jDFNxZgFRHj26Fpy+VQD1bzwujEH9c3hMlrWWs5
	uBKXjesHw9MBBEjmts9lYBiTKyNz2xMVv/e0/OA15FjEeE2eFKzVd57RTXXNHadDDUU0vx/KsQg
	BqQudTRWgEWw6YGQjccpOXpf6Xe0OmEj3CpZsKmB8mqGELUJtCPqBzQGCkLkUbG4wdGRlgKxDF8
	do1YYd4on6RcSUfs3rs/+DmFR5ft3E/pa0ae1HAUKhgzibnpn92wUGgA/Vs/yGumuIc46FMo+8=
X-Received: by 2002:a05:620a:470b:b0:93c:c96c:a592 with SMTP id af79cd13be357-93e9b7753ebmr1062737785a.36.1791474117023;
        Thu, 08 Oct 2026 08:41:57 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:93c:c96c:a592 with SMTP id
 af79cd13be357-93e9b7753ebmr1062733885a.36.1791474116529; Thu, 08 Oct 2026
 08:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
 <20261004-cci-imp-v1-2-227d12cb4829@oss.qualcomm.com> <asS-ppSQ3zHjjVBs@zenone.zhora.eu>
In-Reply-To: <asS-ppSQ3zHjjVBs@zenone.zhora.eu>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:41:45 +0200
X-Gm-Features: AclHuK9ctZbMWTN3PEzNG4CbIi1vmDGf5VZHwy1UaF8tqiYzoG87hLMVrDUMXo8
Message-ID: <CAFEp6-0nLqJ2BxzALKoGzTYw+dgzrvAB9BgvRVtNMZ10yXsXnQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] i2c: qcom-cci: Handle and report queue
 overflow/underflow interrupts
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac7b9c5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=eS36LTtrxdnvZwTP-pUA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: EwaWSlvJ5Q7ss1oTQKMTtqnwhv9SCpYa
X-Proofpoint-ORIG-GUID: EwaWSlvJ5Q7ss1oTQKMTtqnwhv9SCpYa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX782MjdwMT51V
 tKACGZ9SiILyGnJUbpAnE767VwFmO+//PoV9EfLEHpm5TGqlqCIxJAm9sGz9OH4PcfzzvHaVtFy
 AmInUk070gQpxMi4ozamPLsdwGN8mzk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX7s6el4iIJvfD
 MtTtaO5Z4hA5MwM2UsKxLdup/E3Yck5PkN3oBlEUkviUMoTh4T2tJRa/c+gWCfxCaRVRjZzfT37
 kv9vgCzeg2DzHZzsJtWQiskfBJHYIsgCgBFoMzqJhPmKuGq4T0fGBiYzDuStx978La6j99OJLaQ
 YfYrD9Ht+1+UfLE5IqRx8zuQYKtaiB36D6TY/VxR1xwCvnxZ4cl/mDqm3I7Kj83QqXujnMNrc0B
 j2GbxMD8gRNHRWGTHb61ynNwCBYBdqhVEeXtIOqNqkPeXjELyBb6jsIGzZndP8eIj6QlrHOAXYo
 ojg+ollV558YgaMbQFN3McqoOKmzeSqa2nL6c3+Gk9/RbKMPfY2O9wo/D0Jewcfi12DUjhSKftY
 GQngSG9HMPHyXQPcWDal52WoKaVYh+MvsX4QdInV8dOaQL1K4urGEDjrrB/gd/TnKwKk7pJJ5fN
 awlMR4APkWxVCOdE/PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080062

On Tue, Oct 6, 2026 at 11:28=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Loic,
>
> ...
>
> >       if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK)) {
> > -             reset =3D CCI_RESET_CMD_M0_MASK;
> > +             reset |=3D CCI_RESET_CMD_M0_MASK;
> >               ret =3D IRQ_HANDLED;
> >       }
> >
> >       if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK)) {
> > -             reset =3D CCI_RESET_CMD_M1_MASK;
> > +             reset |=3D CCI_RESET_CMD_M1_MASK;
>
> these changes are independent from the patch you sent. Can you
> move them to another patch? Probably this part can also be
> considered as a fix and if so it can be sent separately. Right?

Indeed, I've just been lazy on that point. I will submit it as a separate f=
ix.

Thanks,
Loic
