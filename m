Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D4352007;
	Wed, 17 Jun 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684237; cv=fail; b=VUg5LHl7GBOSYpfuUtYBW2Q5v2bprtPKtMlkStb6juShnCwc3UA2SMTABY/2Dn/5IobLPQDrlYb8LjCvPeqHMOrTjzvxIHOqcyih2Y1vfx2XoEREEezSeUG78SW39Qb83LchkYxjB7SYCARS5lI5tLWMy3nfYe8XYNoJt1o4wKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684237; c=relaxed/simple;
	bh=0yFdzDHNGBdMUXLyS3MQD3vc3ClK3/ZvQ8VNrIc8C78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cK7cONR7LdyEDRD7Yh+LmAIjg0J76R91ZIyHmi5vjrjcWPsc0RTU13s9v07hVnSbldnFf0mEsmHRHjbDqzFt6dDp+thPdIGjaJJw7/2XDlanTgd8eB8KIeccaLecTQ/eKO9ihsrHN54mkimUNWOyWLV2oxM1EavwjUMJqdmPfFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nibwvKlG; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nibwvKlG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqiokRLFzLe4uoXu31YTLQef0Zk/WIve2Xk5Dsb5IOf4XLSYQtYSDHD3sxDr84iVg1ven8DhWFQG7bjEA0yQMNcyuY7t8pzo20aBf3EMUfSf4+wZSEFRaHnahY6GZnqvKEl9PZyeXHKBO5lEqi2p4pdP0c0EPnpxf0jmrUhMe8ildskIo2X4QSNA16uQt+fpgjeQH8IYREZZEt8Nd3Y+EK1OerTMVFo+ht2n5UaBlfAX2uWBrEcTnIBdyP4PqEuu1wDFrEYJgCTGGiVWJ7lniITDm/pDLbZw9I9ImqfErJPc7IEWeLkOC2b1kqUWs1GPEpP+1234QjcSI6M5WYDiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBTKYwGxxl/jM+RXNLO33CzMPL8Fj3pA2Ytc8fhml8c=;
 b=It2ly8+ULMATefgtof154etO5R//V528J8+KqgPB5wSsT2lYWW1Ospw+2ztCEqZycoDg4Qom4tABYNMXzo/hkFVHUvlavFY4whAG44iW8z1pcv4ifU5Y7wuawMK4AyzU41JQNfym8qgyN3u+d0aPDz9X70jWDJMkeaGCLmVIbTpuVCvN8PIWg7P3iQNQmMRjd3qtoTkZFJH/7LVNs6tVej/H7T9Z+5mqXDAsdIxKca8aoOFUb0T0U/ktF2lRsVb73J8fg62HdvKzYPQXevHy4jfFQp30JUnXYqsFtIo/HnD7S3qimcPSAWJareOYYCPjRXYekNXdVzPFnsQAjgXrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBTKYwGxxl/jM+RXNLO33CzMPL8Fj3pA2Ytc8fhml8c=;
 b=nibwvKlGwJLkx8nQ9SY0Zjs7sBok+m3/Vhzr13H7ZfQhU5tVVGcTx9QVHu+Sejp64wj0uaRzUwstyfK9FUgeFdcW0ujCqMI0EYrHb1qxYpylaNCrXXSFqZ4cOR5/FQZlG1EUlOeo4giL6qFY4EomAyaPcZy41wCR95FZKsukw/c1w/IAVA+qCTU1H3LxEzM+v+WPoIc3cl/SoXvfrmzRsr5bNImcEVo4b/3arJfYxcyeKi/KNxUbSbBimYjOjNshpekdJDKaaD8e8B9sn47rr36Qpa2cGYNuTIacc9yViSlTWK6NMwX/rJsi1PtjjpySnCIAvTpFY1uSYm8EfCsj7A==
Received: from DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) by FRWPR10MB9255.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:d10:16f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:17:12 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::7) by DUZPR01CA0115.outlook.office365.com
 (2603:10a6:10:4bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 08:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 08:17:12 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 17 Jun
 2026 10:21:16 +0200
Received: from [10.48.87.176] (10.48.87.176) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 17 Jun
 2026 10:17:11 +0200
Message-ID: <ca964566-597c-4675-8e41-33382bcb63b8@foss.st.com>
Date: Wed, 17 Jun 2026 10:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: stm32f7: truncate clock period instead of rounding
 it
To: Alain Volmat <alain.volmat@foss.st.com>,
	=?UTF-8?Q?Guillermo_Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	M'boumba Cedric Madianga <cedric.madianga@gmail.com>, Wolfram Sang
	<wsa@kernel.org>, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
	<linux-i2c@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260611104857.242153-1-guille.rodriguez@gmail.com>
 <ajJVct1fcVrUSuLE@gnbcxd0016.gnb.st.com>
Content-Language: en-US
From: Pierre Yves MORDRET <pierre-yves.mordret@foss.st.com>
In-Reply-To: <ajJVct1fcVrUSuLE@gnbcxd0016.gnb.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|FRWPR10MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6a34b8-8673-4ec5-a2b6-08decc48d5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	raP/PKNKoYHmWq9gzQtl4a9eBTbwShqwmfLa6bPQTAHeJ5JI0awCSvkmPDa3v4YfKfbwPXpji2WtTIXpRfgzSDYAXwtF1XFJ0i236KZMAI7tHcCsVB0r9a9ckdo79qtGBxUcLjd2gbOY4Hg7vgW8p+HP+GBbuDf9iszkDg52gmb2GvrpIiKDYEX4N15K0HQ26pFZfzsFg4qiGqU2Y92QC4i8c82vwGfoz0hUw0dFpkqdtlWoYiTajt5j1WIoiyPHRde4UtIvwaBskeiCyxOsG56jjNZ6ChMw+FZkG/9JpDrvu2XNfqyOV2lyi2A7aqCOV+US4fL7Wl5qoWGlmo6qKCEoGsuzosMeJxC22uqeH5LJI1XgjrRQcVBC6noYpC7cKPDgyYuwd9JNhSaeSTRqMSChUUqsohrsOTV+zPSi91ZtAnIfR62SYXW2LMBn5loxtbBsD+tY0VBHNwnRBORUY9FdsL3uByBmo6s6XxJS6Cdq8GQ7slVupEA3ruvuscL6XnHYQuFFbIGS/IjedmJfUSZuA4AAo3znrYRreATQqcpHHrwOIN29pNIRm90NCnzqXbsiIRH+yEIWdtDC8a+izTMFpEF0MYrARNmAkFQ5mmnF+WH5Y+7mgZyUcJswaO92t6WAf6xYsSrj+oc0f1NxBG39t8/dyl1oXAZXI82kK5Sf0L93fMImab0lvypwIfPaSv+UxIvXVUur6+IJ7DyEtdrekwKAHNO4RuOJY47nHxE=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4MRQ4fVuz41PihA79cTpm8ixhM+J6pmFImZMTECFqrehdArugBtqkVd4enllbOYHz+iomgMq7Ux/fQXgzn1AWoWL9BP4HpZpk0zolYznsGnKRiLa5suuPznqGDLrboiVtl4taAUw4DhijWkXB6qQBtVcFIryZ9Y349zEUB/MidVmpOW3Lf6cJPu0LcYhtZSuOFowqM+YPAc3Z0Hssctd6WdLOl1v+igeJ/hXfVzS+PmbXvQ3f8Fy9YGH2JKoaUSQIG9ThU65jQaQYH0yVQnF3ODwrIGJTkaUWtImFJAVB0AmaFVy7I0M3aWsW7+wwWp03ljr8qFnWU6L2CE87xlbvj4Wia8D9MV8P7iT3GA0qvTYPxvRBwR68aWY2xrbigsNU98ey4uuHMpmNL4q+6RQJDGAk3/fvlVdLrbhTdEEeoSxuJyqwgjKJFnWFhoP6sjt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:17:12.5984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a34b8-8673-4ec5-a2b6-08decc48d5a3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9255

Hi all,

Look good to me.

Best Regards

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>

On 6/17/26 10:06, Alain Volmat wrote:
> Hi Guillermo,
> 
> make sense indeed. Thanks a lot for this patch.
> 
> On Thu, Jun 11, 2026 at 12:48:56PM +0200, Guillermo Rodríguez wrote:
>> stm32f7_i2c_compute_timing() derives the I2C clock source period
>> (i2cclk) with DIV_ROUND_CLOSEST, which may round it up. When the
>> period is overestimated, all timings computed from it (SCLDEL,
>> SDADEL, SCLL, SCLH) come out shorter on the wire than calculated,
>> and the resulting bus rate can exceed the requested speed, violating
>> the I2C specification minimums for tLOW and tHIGH.
>>
>> For example, with a 104.45 MHz clock source (e.g. PCLK1, the
>> reset-default I2C clock source on STM32MP1), i2cclk is rounded from
>> 9.574 ns up to 10 ns. Requesting a 400 kHz fast mode bus with
>> 72/27 ns rise/fall times and no analog/digital filters then produces
>> an actual bus rate of 415.6 kHz with tLOW = 1254 ns, violating both
>> the 400 kHz maximum rate and the 1300 ns tLOW minimum of the
>> specification.
>>
>> Truncate the period instead, so that it can only be underestimated.
>> The error then falls on the safe side: the programmed timings come
>> out slightly longer than computed and the bus runs marginally below
>> the target rate (375.3 kHz in the example above) while meeting the
>> specification.
>>
>> i2cbus is left rounded-to-closest: it is only used as the target of
>> the clk_error comparison and is never multiplied into the programmed
>> timings, so nearest rounding remains accurate there.
>>
>> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guillermo Rodríguez <guille.rodriguez@gmail.com>
>> ---
>>  drivers/i2c/busses/i2c-stm32f7.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
>> index 53d9df70ebe4..6439620d6bed 100644
>> --- a/drivers/i2c/busses/i2c-stm32f7.c
>> +++ b/drivers/i2c/busses/i2c-stm32f7.c
>> @@ -464,8 +464,13 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
>>  {
>>  	struct stm32f7_i2c_spec *specs;
>>  	u32 p_prev = STM32F7_PRESC_MAX;
>> -	u32 i2cclk = DIV_ROUND_CLOSEST(NSEC_PER_SEC,
>> -				       setup->clock_src);
>> +	/*
>> +	 * Truncate instead of rounding to closest: if the clock period is
>> +	 * overestimated, the computed SCL timings will come out shorter on
>> +	 * the wire, which can push the bus above the target rate and below
>> +	 * the spec's tLOW/tHIGH minimums.
>> +	 */
>> +	u32 i2cclk = NSEC_PER_SEC / setup->clock_src;
>>  	u32 i2cbus = DIV_ROUND_CLOSEST(NSEC_PER_SEC,
>>  				       setup->speed_freq);
>>  	u32 clk_error_prev = i2cbus;
>> -- 
>> 2.25.1
>>
> 
> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
> 
> Regards,
> Alain

-- 
--
~ Py MORDRET
--

