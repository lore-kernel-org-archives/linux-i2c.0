Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7EB353A6E
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583506; cv=none; b=BTJuEvBgU+OeJQt16qL26V+WTmwzTtENPhyW79GOdNYKcXRq54gckmItXD3AN9yk0JRfJkbBg80+C88s9Y4BI9ES6z45GVzOsaT9huC5neubiOpit4ai0T56mZ7AH5PvfDGXQG9xcN0ex10jy6uUZJSwKqbBvq9CitX77oEs9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583506; c=relaxed/simple;
	bh=sV7LRWxxlIj9O5J0NrZ/m+X+w/pYcNHRDRmxMkRNZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvese/2FwE1ORHJTaAuTTX9kfsdR1EPrQ+RLwiYwTckF+GnSdaeoLnJatpq1u8TM0C6g+HfvBiP/d7lRIX7uZdKgKZ3PpDjEfhwuRDcbEKH/k/mUIZjXXHr1P3YnFpkklcrpvCePdORpQSuB0KaRAWcZj/5e9lxjC4mED17/xdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhYN+khC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGAOayD3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhYN+khC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGAOayD3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCvXtv2579762
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=; b=hhYN+khCexrhNx7F
	hcjOxeBDx6yzO9fGZ2FoohKEcthI95fq4Qfj/0meUoSBcsYJQ8kdxKUoOMPAcgQp
	tkh8rhNwNMplykSjFvQ3CjvhnCyosVt/rHHmJfL7rApeP1bdrikr5jJi/N8NZUIc
	iAZb5/SocjoG1uIKO6q1M1lgfcp9ItNFV2F2MZE9nbXWvRBqwz0QJSnZ4cEv+zjs
	RhrHR1nNozoUOVlYXvcI92TzJBqLWt2W8ogBbLl6SGUMPLzX3FkEWSrZ8EsA2IdO
	BdQ8np/5F1WammAerUy6VS87ItnPfp0mvD7QbqDWDA0tbvdVwKdDYFgcMf96Zme1
	e9LH2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdsj8d0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 14:58:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934a8cd3a8bso10673885a.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583503; x=1788188303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=XGAOayD32RmGqN9lsYGe2/H7Em5eu5roo8cna8WrAgs9Tkt36sWXUFMUZ4rqg2UjG1
         JU6dfQoWc+G8prjFmapRFt3Hl8mV25nfe1uapfdcRcfW7Q6zIaKRusQoOv1KZ8jAsqGB
         q+xjYADNay+fw6VgCZDsZ/2dUWLqM6EiVlDzMvYvsJGgpGdBzvGKECjonSWYZYIHG5qa
         7ojWysWK0hLID6b/iCvC3uHCVPF4sti5XzElJdPBU7MEtxQu02I+6M2slBUAgkLIM5hZ
         w+x3K1EHBYtK39RpGfwkqiqivOr+0Fk72FQJCxGRKgndMdwRBA5n9sXpMkMGKG28wKtr
         pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583503; x=1788188303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=ruJihOENIen/8XD1YWGObcbVcPRoM3EYufl+mxQRA/Bd8/Koq/XG8dSzTlra8rSAR+
         LHkQC2aScOEzWjmnTbPhZ+yWozzRPmwHKAOECiFTLTR824zdQ2DiqoQKcMn1BmcjzLyC
         m3xsY5tEtSkd8avdYpIJI7AvlxHszHNRQ9QM9WayrSuJ5veGeEDHKj4kv824NJCsJuz5
         nvAi19xi6vYLpoRhop2dM3rYngdhrLuDFjilgDM8qKBK2fyfzqVwHsXkkaWD4h6gwtzN
         aqu0tHabQqW8iTKuUn+FGR01/M6S/vHynkGa+khKbFC52oSRtHwCXiU1wdPv4cTEvG1G
         Ix/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq+5gcveBkA8YrAGcPG8iNvRdFBudM5lNV/bIOGHfbVIhDiSqXOnWPDEGS36hIZt2PgSn3vFDutYL0=@vger.kernel.org
X-Gm-Message-State: AFuF++n/ROhpdf/cB7R/uVK6TU5my9fBfVscXKHC/bdalazdQcBxgquy
	edbK8KDOUhZ5CKivG/JGlbowlHndNlXou2HarxewuyDkRxIYxMaJFqJxmDh67+k+q5YocZ+qIZW
	PaHQy16orSKtTDpfvjepbSU/3F02AOHpe/DQduvhZ8Juz6QL2T4supKO1I8a4DQI=
X-Gm-Gg: AR+sD116uQLPE7uB+wuZm2/WuvHqcFbPJPOzejEmpAOV5bpfqO8RY35gSqIgF9yedqv
	d6RnFVL1Kqf4hDQGAsPaNYdfTTHblw1np4+455sAiMkc3sg9/l0kkEvkMfrDCcebKENKRm7KlAh
	a4J+iNOtDQHA7VU0usLw9faRsSlmd7b50d/GNJhnim4PApqP6HBvei1PkBI30IxMeAfoRJIHo2T
	dtvVotxTMbQun85jhT/kG4Y93QX1uF65mlhvdo9/sFLXhDj7opSm3h67OG7vW9I2aCqOmiOU5Zf
	uDjj6xBFOpn6WmWxF6FjU7Fs3P3pMyHIY9oLabT76X5egsJr69jIEOK76oa4+vEtubL1NG3R9+Y
	Qwt359guptP3yBpQFwrtv9acs
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211834371cf.3.1787583503276;
        Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211833791cf.3.1787583502825;
        Mon, 24 Aug 2026 07:58:22 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1453437466b.25.2026.08.24.07.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:58:21 -0700 (PDT)
Message-ID: <5d2504be-0691-4174-9d98-7759205718cd@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: s93faC4kW5qMsJM5vidt7F9SS_OknqE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXz9kzYJWVVmCY
 exQEFZm771s4GcylSJKujjMyv4j3GrkS0kxIh1mF+pq97RPpod8pD/vivyjn6r2rB45JHBsj3g4
 88u27tnDnR847YE1tn6CBCnzOduFfXOAASXUnFGY4kydFrh6qa8eWFIXcONxNUUXdsvisFVtbtN
 SFR+0y/kwDyF2V6KGKrao10shkMf/Bfj4hQtUltHLKUoPhcRTIQuf5bLCL7ZKOzqbx7CcpAzwGz
 DZYdRGWbA0kG5sWKRr4fej9PMxl1JXr39PQQEz6Xy1J2PUqlgaR4IAjPPtUR7fvTDYV1FNqwj2G
 k5UVr0MJ8FxBO+jJhoPfjLDAQ6NHBOnG6+yLJWba2a5hYGEUmRYvLBrYW8hwc7N1wSQSv67iF0W
 EDz/19gx55XR4kb5ZFO7os5FXHNskV7G588fYJzKhcKmjHPUeF6esMKVIRTCsfjHxxkme4KejMT
 uxL53sm0qdo0BCnSWfA==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c5c0f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ieDA_EM_2LYBYmKFcIMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: s93faC4kW5qMsJM5vidt7F9SS_OknqE8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX8RIFiIalvLWL
 gAWWeQwaUCKLfY3ARYZIks70fimBwP4eNx7y6JzGkOdeQx4hEzOOI9Ts/lGd8IRS+JchY1QcBTm
 uJaOkdb9EEo0A6WFdSFUCKIUpuNJeNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126

On 8/4/26 9:57 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]

> +/**
> + * geni_se_set_rate() - Set the SE source clock rate via the OPP framework.
> + * @se: Pointer to the struct geni_se instance.
> + * @freq: The source clock frequency to set.
> + *
> + * Applies the given frequency through dev_pm_opp_set_rate(), targeting the
> + * perf domain device when the SE has power domains attached (firmware
> + * managed path), or se->dev otherwise (Linux clock managed path).
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])

The latter will always be true if the former is

Konrad

> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;
