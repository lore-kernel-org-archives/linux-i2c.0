Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793822185;
	b=hwQyz6cFvaOriY7RErG+9RagkqqnqFkSrVTpthJ+7CrgMeN8TawdwkUbpAoUWQM74bb3
	 RbodlzcaWX05U9RoS/IAsfTGc3J6C+wpXzEwj/TwlIK5VSEtlnfYKWPH5YyKpSmoJxD3x
	 wdRiXQ8w+EVRTfeEGiICndxDMB76HvTVabgA/+kYjIQID0g5oyTJCubedTdFGKlHBZrCi
	 QVw8AjwAzYBD2KUEZx9tM389Ti/GGSAbTLn1w8+5QSIB0zP/WvO11qZAMGIH2J5E+wjSa
	 aAPhltzVnccloRN2aJVnfeg/Wiko8llA3raAbhnxpeZhpSs3cEJ10h+0hWxZYQwRNkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822185;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XQLFdhGEl+gprzPQzW/vHtrpFsz2rxGpuBF5QN++ENo=;
	b=Hcg/BzWeDzBSOLQsFYSJb/wFecWNo9A8TD08iF75HyIRN9Go4+aIL0SZ7GP6oJA/d/pO
	 rKpuON8TMGURVBiDYjzuOIBtvrHVJ1ai0Lwb4exeKtbBXhJKa9kIIC0aAAydDeKxeRmDv
	 QEIUVzDdu1WLuHAo+IPcOWWR4lHWbnNt947F2GMAf0ixWTTZyfMSf5kL5DB0MSEqKCuMV
	 wNoULJxrDZFGtxo3uGwdkrooxfp5fVYT5ybBVTcVNejJ7whgi52OHeJ2GolTQ6NuXpT07
	 LgF+wkD+Bf/d87/p1wHT50yqgA4S0G+chboyYlMu8pWm9NdSa5vXTfEdNhn2G88QTjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c135YuXN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YH7OPnga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3F609C5B1
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 19:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB3F609C5B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c135YuXN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YH7OPnga
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FjDm92244230
	for <linux-i2c@vger.kernel.org>; Wed, 4 Nov 2026 19:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQLFdhGEl+gprzPQzW/vHtrpFsz2rxGpuBF5QN++ENo=; b=c135YuXNvYw5b7BG
	fVpcjq7l4pnnMIm1qG2GHUJgCNnlfn8jgwbzvgnRYJPp2KAFBemfPZxq2QR18xkT
	0ty13cOiwNnHBANVNz+7DFgKWTNu6waSuk3O+FRzPab8LVWh9uJB092CYHSObM6f
	O9fh+BI4vQ/HGdk4IEr5EwS/pQ9e2D/RdFqG/w8pVdW8sXvMR5PivO5aKBxvUWMa
	qVnau7cRVYvhT2zQOaZMsQCrnGvMgkBiRLeCYvYexLRKu6tx4XMO1t40H46DhCgf
	9fs+ZxOvTPSV1gDMXEF9HY+NLzQIn8htO8rh8DpFQCZrRnNy4hQH3sXhszpcY2Iq
	/wjQvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3pyj5rw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 19:56:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9440b27c1feso234056685a.2
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 11:56:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793822183; cv=none;
        d=google.com; s=arc-20260327;
        b=idCefBeWDHuwLE2cEYTiNa1ynj8N6kA6GdFbk+ywwJ0Ef4j6Zuc28EdWVEkT/ERZyK
         TmkW/4oJLyU/WnOQaK+/1igvLkXQTofzO4ZCj/tKqDo+o03gZNpzGvntn60Z1MHHUDtd
         bsj2LS9EocoCQJ3IDVAchvUfMeuCMdlh+fm3Ycxx3Wd6VH8mDNJpLmkviqnvQIIWYSmJ
         Dldt9PP1runmuK8zp39k5wFl++TwQwGLJjj+Nf7AEas3BxjcY/Atcirn4ijVuGtMPE5f
         aSvGuG4uYdYp8roDjkqwrIDCLqH14/soJSMngxUwi1fnx7GZvUWmQ01PjLFe5LntZWZH
         RKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XQLFdhGEl+gprzPQzW/vHtrpFsz2rxGpuBF5QN++ENo=;
        fh=/s1zxacZhzTnnr/hPeShMgL935oqWjIS7oKQyRAvEMc=;
        b=NWR+VHxPuXuOy1uhNF/WKrhCbirXMPq5BK3XZIfDwk5zN7C+BUgVj/FrOAHZHu21D2
         KtvdpeU2owULD1kOREl/A7qJ9rydNWoypxkKJpX2dAEyDelxyGE3DO9B2u9CHkfxWLhW
         lhdId6BL24i7DpyD9C7gLv8b+VvKfqdMiQPcz8htLFQb+lX7C03HcD/I3+bbop3pg9ro
         OnZCEX8v9MonC4bn6P/ZWt2weG/SR9EYeKwG36h2gHSONuWN0OZQUeF3QwbcmKubxp/g
         b2zmC6HhqnHWK4WEXIa7lBCCpxqdxBziY/4PhOdmhhNQwL9STEOdFeksdIgQt3e3yckE
         NRCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793822183; x=1794426983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XQLFdhGEl+gprzPQzW/vHtrpFsz2rxGpuBF5QN++ENo=;
        b=YH7OPngaVk6SQmUypSZsy8cTcsBVcv6/0F+Y1qOggD6P7sDKHaQwmYHcpJsSLS6B+S
         /x6iwZQ6WJPLvVdV1K5nmjzSy59o4l6Z+fSn4ctP+LE5zMhnta+Gk4J8MZekBFPfpgET
         pKKVdnIckpIKIth/Ai/BEEWr1yjREbVVFh/r/DTxJ2shro5RJshKgCQ58n7m3usBxW4g
         xXSVCuss8z17vtVTPQdpJvD6oxNrnIuiKxyK0iC2DYD4mNqu8otXbOkrqje/iCG4pZTT
         m++NNVYfPGtiqLw1ST9eP10WZUtQCozTYApJHwXP65nZ3d1zYHW1PPnZLTCx/No5xU3y
         EYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822183; x=1794426983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQLFdhGEl+gprzPQzW/vHtrpFsz2rxGpuBF5QN++ENo=;
        b=CcdHptMh5dK9+geRfKJEzPWhhQADsPX7GHyAQ6/aMHQ370fCTl5fgx+fGdOlaeGf8b
         fvMImyNiuKvgrCC4D65n5FkrUv2JAbRjNdcXfuHI9K0En4QhGQWEKFH6wNHuukllYQGY
         vRkztbcxb9I+3vuYrpYC5E5+VkHQ3s3b97yBgg9acZreTdGP0hLPAJd9r0qLa5NzgMMO
         zJni5PNPaVpQNVzdl5zGkJMuxH2HbDFAiHX5Wxt+M4FQ3TJHYPuPqLJX+x833zPk8+pX
         BQS2hv4ItNQvueA7EXgxDTqF7+d1y/KYgE7RC5t+j4Agifhn4+6Wa8pwDAKDdPgT/1t9
         ImUg==
X-Forwarded-Encrypted: i=1; AKwUvBxyKb9Ee/PAjlPJ6Gn5MNM4K+oGud4dJjeAZgL6NHWZzBh8A3LySYp58Pfh8CgK3PoU3K/u5XTs7Og=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DkHdctYsdD5vqfF19ZUZgrOKyfNiSshhkseOfa2keKDYStbTP
	qSWf6b/s8gM+nGkafd8l/bkWDxgmYihiVe7jHjarNz5dCAi9lXgfbETD4I76+ULmy8nPxopr4tg
	3VY3qhUVhloOSEKxmwbqIti6wfZ/4esJGquO80Q4X3lfuNwygGn6MdWnPqBSJViHnAYi0Y3nj7F
	+kB886Xo4DFcxeaS3rFV3TIEgCN0xB2d4mlcasE5k6Z3eMFw==
X-Gm-Gg: AYBFou1ZQSmJmPjN7zXwh6/Z+d5bNcS5oLvHcO4C/B5trdZYiq3S5LVEUfYvPh/04SF
	V35+sLYuuPK2/Y5HegLI4YqfQEVxPgjQfVz5fe6l2fpRz5yGfE9IAvtu1Kcw6SaC2lkw2UQV4mN
	2PKkTGSNVb9z3fpivj0enDbV6csZV3lihNKLFtwNLAllRyr2per5aoODi7x0UFH7vGfRXGEPztr
	/kcXRkdy7ivJ3CItkFwT4oQHIwH8MZ6NWNhmXPHySPBbycYmEP+QvHYKGRSt3roXYjeUqvQg2pE
	v1kt6OAFXcvoDcll9vdtWG6ciUNn
X-Received: by 2002:a05:620a:468a:b0:93f:17e6:6ee2 with SMTP id af79cd13be357-94421585e5bmr2998715685a.6.1793822182597;
        Wed, 04 Nov 2026 11:56:22 -0800 (PST)
X-Received: by 2002:a05:620a:468a:b0:93f:17e6:6ee2 with SMTP id
 af79cd13be357-94421585e5bmr2998710085a.6.1793822182093; Wed, 04 Nov 2026
 11:56:22 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org> <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
 <fac8cd6d-c3f7-4ed3-b0d4-7cb8a7a6f451@linaro.org> <d92a8aaa-5cef-4416-b1c9-46ecfc6b2745@oss.qualcomm.com>
 <CAFEp6-3ka3ZKzCoLQ5BNv0YR+yhYXVRwV6G6rM8Lx_9hZ0RqVw@mail.gmail.com> <7acf1f64-a2ac-411d-a235-69ea52231623@linaro.org>
In-Reply-To: <7acf1f64-a2ac-411d-a235-69ea52231623@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 20:56:10 +0100
X-Gm-Features: AclHuK9iS-SlJNui77YNFKE0lYus5bUHSbzooakg4b1KhZgza0So8ebhpAkDmh8
Message-ID: <CAFEp6-0O3PyyytNvAUdvMRaMR3Q1Acb7KZmJmDT2J-gVfjYbsA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] media: qcom: camss: Add support for Hawi
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZbmIpcVA c=1 sm=1 tr=0 ts=6aeb8de7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=oDkJ1FRbrV4SKMjXgYUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3OSBTYWx0ZWRfX9z+bs0DPY1uw
 So+nAhIgqKTcPsXHBh6TUO+pUauePuD0Q5LLa5B3Je3mcY1b2lk+s2aiHr/UR85CbiW2R9ZW5Kn
 KMKPjkwMRdRUjm/Qor0dZTgINnauPF2AY6aEXC7mepWEQVfyx21MekvHEVAefg9t5gaDXv29OsT
 H2YKriF0o1GcJ+HjM9vQCn5L8cZ/pjZk69sJF9Hn4MneYONlQBzmzk18shcTOsDvdRMSGyDy3/p
 Q58Elel1mVK4AVtuRkOaKttC3e0sA4P2oAJXk4ljSegcgvnwjALfmHXtGcSTgHhjYjdei8yEYFu
 jSmsz5EFcNboSRdYQvAeSgrslo28+6V07B9Y+ytoeteFHHltaX4gxcD+xqs+ytsuZUdyfnk20AF
 vHFzyGz4fHNsMW0HN5+GftWT8Lmt7u0UpM8jtbDpCvdabKalyiycLJbB31uSu1RKyEy9IVDswgF
 bGYETPcp3WjoOhSJShw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3OSBTYWx0ZWRfX7Pgss0OlNF4M
 naHlg3VwM1CqT++lqS3D/Big8JMF0iDP8ecmMiTSeyrXowIC1jcOaskIfQsGPBQ3RfNptQSlAMF
 DSZEat2yImmd4hE2+NSzthVc3rPEJgM=
X-Proofpoint-ORIG-GUID: UslAGYEWP_pLUTYsDae3WqgNKbRigi-4
X-Proofpoint-GUID: UslAGYEWP_pLUTYsDae3WqgNKbRigi-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040079

On Wed, Nov 4, 2026 at 5:17=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 04/11/2026 16:11, Loic Poulain wrote:
> >>> We have a series from Antans to address this though.
> >>>
> >>> We should list the clocks the SoC supports not constrain that list fo=
r
> >>> one specific sensor on a test-case.
> >>>
> >>> ---
> >>> bod
> >> Good to know that Antans has a series addressing this. I agree that we
> >> should list all the clock rates supported by the SoC rather than
> >> constraining them for a specific sensor.
> >>
> >> One additional concern: if the clock selection logic still always pick=
s
> >> freq[0], listing a lower rate first could leave CAMSS unable to work
> >> properly with sensors that need higher bandwidth.
> >>
> >> Could you please share the link to the series? I'll rebase the next
> >> revision on top of it.
> > I don't think Atanas' series targets the CSID clocks, only the VFE
> > clocks. Ideally, we should make similar changes for the CSID clocks as
> > well, but for now they are not being considered here.
> >
> > Perhaps add a few comments documenting the supported rates and use a
> > single rate for the time being. Once the CSID clock changes land, we
> > should be able to revisit and adapt this accordingly?
>
> Its the same principle though.
>
> I don't think there's a valid case to exclude clock-rates purely because
> one sensor requires the higher rate and we aren't willing to do the work
> to make the clocks smarter.

Ok, fair enough.

Nihal, feel free to test & pick the following CSID clock scaling
support in your series, and add all the supported rates:
https://github.com/loicpoulain/linux/commit/a02dad23d219de1daa53e4095eb5289=
e5b5a6a15

Regards,
Loic
