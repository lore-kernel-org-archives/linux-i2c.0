Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E841D5AC2
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274360; cv=pass; b=meYynrZ6yiWUwoAML0/hOYuC0UI2722djiQgYWytea7kPoGBqyUNOQ/I46l43cZMGgjo0dTpue2Jz71HohKSmTD9QaYzTwaQci6nqdKkqCluQ1esezrC7k07BWfKfETKFrn4pNQlPlctljBHaOFP9bU8WbBpHiqniVGaiuHBaBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274360; c=relaxed/simple;
	bh=qozaO2bHyNLi2Ew+/sQ5VkqX8j+gIZZl+6ZwDMrfD1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFPjvTl+taochfB9CB8g00gu2rAcdJu7k35QkihKKOzvL0YAOyksL7aXcwwVoiBUEj4OLeT3vJw6XKbN8Za4O9KMx8cfIdJgFikj9VG5r/gjDHAMJmI3RM+jGaxU4h+6Sun5SmYadD4dtIact59ntIkEuOYe/uSlZVprbq3MNe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pkC/omtm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OHhJNwEs; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pkC/omtm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OHhJNwEs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8ttw3914100
	for <linux-i2c@vger.kernel.org>; Tue, 1 Sep 2026 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1vfuwHFmujlvznbArz1IOwxTplKAy4SM93AJJ89i1FI=; b=pkC/omtmbkdNhGX/
	azz1NEHTywdet0R76I0A4S4i1q0AkyhpzV+ZbYugZ6NJE7lZhpxZ7zXdo2MeZb5y
	MurBZT9c1/N1cNJUc8I1hAIwXSfAgwgDd5+L0mENzZnGgB0JxxYZpwnekCzl0fdl
	veQv70YvjRATek+eowD7FJIrNeDF3aTkW+TLWrbsmi6FHkhQDKy2jY6LaN1Z9f3B
	Lyuo5VvsBL/lXHU3QI1+5OrN1zfdsSoi5yDAmPQ3Fz9hSW1xH6D8+6V85sS2cGRD
	NrB0R7c1uer9jG5XT3aqwAgcb1Jl8ulNqw03QJbbDTt060JK+XIwso5IpIvGdRQL
	S4RmhA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu26ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 14:52:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso6688833a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 07:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788274357; cv=none;
        d=google.com; s=arc-20260327;
        b=J1z071KXL/eZeSnd8cVhh72Y/LktQ0OaMSVNbRKyLg4bUpZjJcAmBegBgKDoVLX+sU
         zfeddLWn0iHXJQnwnS4dnOFwqRER67sfzRLoS21BGwHmei1x+jQEjqLN/EE1DJl3Xqbr
         WNlwo3WiNjcvF/LRfxOYjIBDm1FS0Io9y4A0B9kGoZUTTPxxrPfjMZjIQvVUvq/sZ0a8
         QByr2Nh9DyQK/gC8C6dDOjkq8r919qwvL73w18rqDsM47ypQo1peM/L+MwI8pY3+LN2U
         7GvxqVcfBv9/aTDj51UwsYHcMf0QNK7KhVute+aWiFshGpFqMLFRKsd/8jGo6cBCqHZP
         Uu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1vfuwHFmujlvznbArz1IOwxTplKAy4SM93AJJ89i1FI=;
        fh=OqKp9ctx7xlClIUL3f20D8i295jH4aSEwnka7Iauk4s=;
        b=KLvh+gsw+t5cTninMA9HEnAmNkPGuhC5SrbhljKMd6RlD4du933tRFOtqgb5CM8/Ce
         wT8xu8z4C1oYNKk5lfoT6Ee+g2EOIfLmrndl3IctQz889EvHb02opvls2lwH0zp1jIAZ
         KOnHUijWUmZY2Lc6m4Y3Bd9VAdEtMj5fSKVNDti/UuENQdA+0aLR6tk4VM9W1bmroYhN
         26BEBMQqS1EcnUcP/vo3Mk5NOeRHUOf9YE/WemTypchud59yQK9QxwhfHsqwwQrjeO+H
         qDg+q4ZNUcCCWwdlWBvKpLJL9yuhcaMvsbj3VW0nw++Znv7zws5xjl1JP1CU5jgT0NVS
         yHFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788274357; x=1788879157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1vfuwHFmujlvznbArz1IOwxTplKAy4SM93AJJ89i1FI=;
        b=OHhJNwEsXzBZ/PqltH+NYcAl0XcE5CvRjlXViT1zDBjP6Q5+7CXo94cnf2ITr/VKUa
         gr2gwsDkGWeOHgMvxwBuL+dxYJapOtdT0r+z64hMC3vMFJbfQUHMy/gJAnvqWZ0wMID7
         uBDjB/U1DbTIjRvwGzHSghZL1n0ZYfCz4g0CyrpnjyiIqIW7ZyBbpLAJFGW8owbfVlIO
         IxkXskMq4GqpHSfwgkE5L39jxsvFcCe4rZP7MLzgMSO0HTxh/romMTD9SjqHRv+ZDGWX
         bbDk8zcvSubYq1vUeqDO0kPSxHHXTaEg+zET+StDYoyoxbWT9/eEYxVBrwmt3coR58AV
         lWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274357; x=1788879157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vfuwHFmujlvznbArz1IOwxTplKAy4SM93AJJ89i1FI=;
        b=bDzKwXd7wpppF2liHAkAubp3nQ/Ju4zJZSLkT/wV8jERatb2ho53oZQEt8yxhCt3n1
         w6UB4khCrAFm31U4KGizfc3V4JCIpZt9B9K5G7cuzdgANBas9GyAPi0AKHo+TPMt8mLQ
         cLWO+eHwzIBg+wqZ57CWr8nQ0+PISmEhojPZIK+hMY5yE9D1GTuiKj1oIhMqwevtuv5O
         bBN+88ZpylhNPO+rNm4ExnqCWsKM32DsOb2RVNzxXpoGR1LWyZ9LIXaH6s9jL+D0/Kyx
         ZvS3Z5fPBBhkHSIvvk9ljcNhRzK8B8OWNhk+dV2QV8zJyEwnIT4Ws/j6mOAtYsvSPcij
         Bk9A==
X-Forwarded-Encrypted: i=1; AKwUvByFVvnXfBHA8jEKg+TiINQYXK2tvNANWFbEpUfDYozkCHKecVSJXRziWGiT8bUM1s75g4Zn7QFfEIo=@vger.kernel.org
X-Gm-Message-State: AFuF++nblfFuP0gEDUVuJh870IMieEXUWJfk+8Jeo5J+K+AkxVEH3HqC
	9A1ld2eV2DP/UcILcHtX6N24ed0d6NX8DAL4Gf44ONjNuJr/N1dvlRmlQzpxgCo8um9pajmgqGP
	pJh+CmsmRhyRnnj+enCVTZ3RkN3SnOjDC0n3menSYRt0ATRFua3NNpbLFp0pbqQWKWfsTuK8LyR
	4bhWfGBnPKVqJKmdZMNSg/mUMR66kKco5RP/IsKA==
X-Gm-Gg: AYBFou3SIuP82raNT3mip/fmNPMoVEqgoaw5NekUiJlqksTCTA7K2skp3wSp5lgJUv6
	81rCrc4s/rBsNh3eXF//q2p9wD65TnMZhDlN6xbIOclEO8Lms10lfF5S34IR+u5Zr6kCelTS2GG
	z6P1YMw80FHayuhShKVIxnaEWoeMw1zt2ONosHDA1kR33XZTAG/2tj+6CKpA==
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id 98e67ed59e1d1-396d0e5bbc0mr57212362a91.2.1788274356779;
        Tue, 01 Sep 2026 07:52:36 -0700 (PDT)
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id
 98e67ed59e1d1-396d0e5bbc0mr57212254a91.2.1788274356218; Tue, 01 Sep 2026
 07:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:52:25 +0200
X-Gm-Features: AcwNN1UC04dwwquCOb-ua7jDN7d85m-55EBER85AH0RMtxh0hIHGSX1Ky0hJw5M
Message-ID: <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzMiBTYWx0ZWRfX8WfET0TOXdDQ
 A2VJiQu+5LgoPQTe4wwXe1HvBh92+9cl6SbTgSnAc3s1i8XxXs3Dax7MsN7Fzyi7lKI5W8dWpCL
 2OMeOJn69l6SXyrc0IKY8tEPO6IP9B8oyQAiYvuBkL6If+TJXBlZMIGQLWDdbVySEsq7klIjR1v
 WMMusDUpLPGsd7/04J0eKEXH45dnsV2ruAwIeyG2aeDlN0loWr9mdq+YqYee8madRxplRVsQfEm
 nUvblYhE7R4QqEwH7+oKj8nvw/8CRRk7dM6WGHoduXZjXPdwSachjymLq7QY6+aLMzhFDrrkNDY
 OCtgEU093OP/yCMJs9EQHYQEa4seqUxnEAGVif09hJ5bAbwdWv6W/mIdH6vKVTuWO0IMTd4Gi+C
 dUoByoD0YNzc+Y0J0SR9++SNiyTKxwfrMHgtrl3Q9gbMtDO/mNamsI38EP3AXpomDzxYe79f7/u
 IM7ZYA/A/rWwyaRKl3w==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a96e6b5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=jU46xtICLe5dyPpNWKMA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzMiBTYWx0ZWRfX6HfnxnqVi+pi
 RcJUDTtKQGE7Io/wg2PeamjVs8iCMR48dTTE6JzSSz/zUv80TCGGOXAvUV0KXcapH2j9G7+WSks
 6cepBrRSdbHSghkfd80ormnfXm0FUa4=
X-Proofpoint-ORIG-GUID: 1Ffrwi8xMOKPaiIR5QRZCBnCoo2Djw5c
X-Proofpoint-GUID: 1Ffrwi8xMOKPaiIR5QRZCBnCoo2Djw5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010132

On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> On firmware-managed platforms such as SA8255P, there is no Linux clock
> handler available to determine the appropriate SE source clock, source
> clock index, and divider values for a requested protocol frequency.
> However, these parameters are required when programming GSI TREs, where
> the hardware expects an explicit clock source selection and divider
> configuration for the serial engine.
>
> In contrast, platforms using Linux-managed clocks derive these
> parameters through geni_se_clk_freq_match() using the source clock
> information stored in clk_perf_tbl. Since the firmware-managed path
> lacks equivalent clock information, protocol drivers cannot reuse the
> existing frequency matching logic and instead rely on a direct mapping
> between protocol-requested frequencies and performance levels. This
> creates a separate clock configuration flow and prevents
> firmware-managed platforms from deriving the actual SE clock parameters
> required for GSI TRE programming.

Hmm, this sounds like moving backwards when it comes to keeping
drivers as portable as possible.

I understand geni_se_clk_freq_match() has been around for a while, but
fortunately its use seems limited to only a few qcom specific drivers.

Rather than continue down this path, would it not be possible to find
a more generic solution for "geni_se_clk_freq_match()"? Can we replace
it with a common clock/OPP API? In this way, we would not need to
sprinkle drivers with calls to platform specific  code.

>
> To address this limitation, the performance-domain OPP table is treated
> as the representation of SE-supported source clock frequencies. During
> geni_se_domain_attach(), the OPP entries are used to populate
> clk_perf_tbl and related clock performance data, allowing
> firmware-managed platforms to leverage the same clock frequency matching
> infrastructure used by Linux-managed platforms.
>
> With this change, protocol drivers can use geni_se_clk_freq_match() to
> select the closest supported source clock frequency for a requested
> protocol rate, derive the corresponding source clock index and divider
> values required for GSI TRE programming, and apply the matched clock
> through the OPP framework. This removes the dependency on direct
> protocol-frequency-to-performance-level mappings and provides a common
> clock selection and configuration mechanism across both firmware-managed
> and Linux-managed GENI deployments.

Rather than adding yet another platform specific method, would it be
possible to extend the generic OPP library with the pieces that are
missing to make this work in a generic way?

>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Kind regards
Uffe

> ---
> Changes in v2:
> - Add new patch to remove OPP rate reset from resource deactivation
> - Add new patch to vote source frequency via OPP for I2C
> - Compress the SPI, I2C and serial commit messages per review feedback
> - Drop a stray blank line before trace_geni_i2c_bus_setup() in the
>   I2C resource-initialization helper commit.
> - Link to v1: https://patch.msgid.link/20260805-derive_clk_perf_tbl_from_=
perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com
>
> ---
> Praveen Talari (9):
>       pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0
>       soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock freq=
uencies from perf OPP table
>       soc: qcom: geni-se: Add helper to set SE clock rate via OPP
>       soc: qcom: geni-se: Remove OPP rate reset from resource deactivatio=
n
>       serial: qcom-geni: Use geni_se_set_rate() for source clock configur=
ation
>       spi: qcom-geni: Use geni_se_set_rate() for setting source clock fre=
quency
>       i2c: qcom-geni: Vote for SE clock rate using OPP
>       i2c: qcom-geni: Use common GENI resource initialization helper
>       i2c: qcom-geni: Use geni_se_set_rate() for setting source clock fre=
quency
>
>  drivers/i2c/busses/i2c-qcom-geni.c      | 72 +++++++++++++++++----------=
------
>  drivers/pmdomain/arm/scmi_perf_domain.c |  2 +-
>  drivers/soc/qcom/qcom-geni-se.c         | 62 +++++++++++++++++++++++++--=
-
>  drivers/spi/spi-geni-qcom.c             | 24 +++++------
>  drivers/tty/serial/qcom_geni_serial.c   | 26 ++++++------
>  include/linux/soc/qcom/geni-se.h        |  2 +
>  6 files changed, 122 insertions(+), 66 deletions(-)
> ---
> base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
> change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad=
32226a
>
> Best regards,
> --
> Praveen Talari <praveen.talari@oss.qualcomm.com>
>
