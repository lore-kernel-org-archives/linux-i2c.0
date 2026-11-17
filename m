Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794906215;
	b=z68B2i8IE4vw/1JjwcZIiW4guT37BzhE+cjfdYtfIgG2etuAs5D7xoi03x/AqjlvJIuT
	 OFuGaR+cKGZTvid3oazmV3qwUbq2qpUOT89CYU/yx07OVpIrYmU5T74b5t+wMSAfSCyPT
	 8bp21u75AyFqdFKaEo0WFPSUBHboP/iG2RptJU1L2lSsuWDclCeOcssE92opxjyP0SsQt
	 ILx3Mi5HB5UYy5R6XDRAPWc8sWGea191ulbEaN4wVCZhh+EIULiyoyoCVNoxgvESMW7Yj
	 9cgP6GXxlp1kteQS9DTg/esK8+YbJllu6+Qf2nn0ykEYr7T0Hg4WH8v+OlXfVjwExfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906215;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Disclaimer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xWRZopVkJFPOfdZdb6dsUSJiNIlH3IWCafsQuDLgxfo=;
	b=u8IcNutkcGuGfWjVQ8nsINWauSSAI+CAhqNeLQNSoxtnvrJtgjcbpglHpC94BQBrokUD
	 rGSC4ZdOIh0KbeMGLq1FOCUm69XybBHU/SwOxrJooDqRdckevhOhCT8fMY8fkoXeEx1Sd
	 z50gflanl3v596BDko2aMyk98WqQRQws5CtcZmSVMoRxhjqmIJsMylWmnyry2dVKwlXCh
	 j/dVAUCDwkWaQDvCgWqDGAlA9B7aIIGpSrqZXVrcjCz4lHWnSPc3jOSmjEvApl0K4QECU
	 uj1An3diboBLQ2Qh8pG/ByelgiWCSUTm61qkdblDZD9yYAqAstN13vLs9vd3F1vctCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Xb+io7vT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.32
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AC606A31C;
	Tue, 17 Nov 2026 09:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Xb+io7vT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUyIvV0bx66K68lSh+JyaAPZMxdbAFZKP1b0CwOSzOFbhJyEs6owsqZtmK0ARPX3VHILJzZ6bdaQH4X2fWbcCsD/ZRLbJvTvC2USfvEv2+le1BaVy/NVFzJhBADxJfGHeott3G/3JQj6vI/IZaTbeoHon6NVmmVanqxpHJ1APuxAdM2TUu3qXcUiSSBT0GBiQi7jFOVRWofFFAFBs4LfbgwOgE/4JORIbC6Yc2RkVVdFx7VBG+pvIWOyLX+ABTF5v2SMNHxTtSDupoziwsLu32L8ujGONRK4YskWlHs4wuFTXGpfDCSHhM2OYozfmeznhfNsaj1wzUXC+t1Buw00dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWRZopVkJFPOfdZdb6dsUSJiNIlH3IWCafsQuDLgxfo=;
 b=WOQl5CLzOD0nRxFOet8xKkL4n2JlwBhe48SBiS/5R2oh8GyppPh96oV6dUU5e7X3FKW14j4a15922PBYD6TdfOI4Nk137JUnlEeZO2PZ3oc+N7Jm0LtIPVk/YOvTmWppCGXuREOzEbwqqWBcxzQCLi/mm10ToIQuuDcjzKu62dWeFREXITxOxMUfyfJZpzTg5F2Ax2CevfxhKLfFlydG4m0kDmQ4PgckQxWFga7digToY56jMjelRzWROz5ddljKg8RVgOIlI3I9AlLDtPU6Eg12ZeRL/XEv6uHQrgj/ggTllRFtJ7Fq1mvAeojI8ZjhwRdohN+pSzYA57hSCsY9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWRZopVkJFPOfdZdb6dsUSJiNIlH3IWCafsQuDLgxfo=;
 b=Xb+io7vTBLfUPPvSLga/sP6YFpXtIZn5L7em92QhP/0uN9fm/taW4PXEUaTikOQMn7ILPVgCcpeNHvRIq3vWdFrYXOUwG2dpQAZeEmvfX+zzJ2bziYBvHlArNrledVnNUNoasulnZEoxj/7SGij5ZQFhqHD1LGrgIiMtxJlqwkZgshmxeU3yq9v5lH8Ex+3QC0JAUuyvAeNj7Irht3BYWmBS/7AlEXqo1LYBR/YaO2gA36Gf+Zfk0Hz55kE1H6iwnVqLIE2bFAsj0fOClB2RmIjD8h4fO/+bTAcaRwj06lDtuXDsuAiM1t8ol1B2GhcJrQWcS7vuVx56SL3sWWFmmw==
Received: from AM6P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::24)
 by DB8PR10MB3516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 09:03:32 +0000
Received: from AM1PEPF000C1AD9.eurprd02.prod.outlook.com
 (2603:10a6:209:8b:cafe::a9) by AM6P191CA0021.outlook.office365.com
 (2603:10a6:209:8b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 09:03:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1AD9.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 09:03:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 10:04:15 +0100
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 10:03:27 +0100
Date: Tue, 17 Nov 2026 10:03:17 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Joshua Crofts <crofts@kernel.org>
CC: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Chris Brandt
	<chris.brandt@renesas.com>, Pierre-Yves MORDRET
	<pierre-yves.mordret@foss.st.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-renesas-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 5/6] i2c: stm32f7: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <avwYVXluZuM4vteb@gnbcxd0016.gnb.st.com>
References: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
 <20261109-i2c-remove-dont-use-autosuspend-v1-5-49a08b8daf36@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261109-i2c-remove-dont-use-autosuspend-v1-5-49a08b8daf36@kernel.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD9:EE_|DB8PR10MB3516:EE_
X-MS-Office365-Filtering-Correlation-Id: 16292574-1007-4a8b-defc-08df4489a753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|10067099003|4143699003|11063799006|56012099006|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003|261009221727099003|261009220027099003|261009221227099003|261009223027099003|261009223327099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wH2IhiGGtbu2hDMra96Zr2ha+777Hz1Tlk0gPteoprWkOtJRzHLwuo3W7GHX7gGoQgxvEOhQr1tAgSaPkVP870e3FRwRCYtq71mvib+376wEd4rSWGh/JoEw7FuQfcgt72AAqbrxptfXezEit3qvSP+8hf/EtstnOAv20+H+wF5GkMQL6Mx3utS2EKJh62U7z7HFwtMFdCzkX1fQqkFLkpIxdqc/v0U2gQR7bpMYk5HJseQx4I1eKk/Y2K2OMIj2LjhnZW39fGRG4b9jBL1tLvM4iCuPPdEM8yAh+ln+0qVvtjIyPZjPifThTI99rsPaDhkVneowZpRTiAW9iRg0uj4HZ3lrIk0UQSq/XJfOIagOUp26G4NWdjYhIhlt/n9Vxo3DuJvNeVcOyr4k2hYjLD5mqtJeMnqlljsoy6nzU4mOs4hhGXpie3FFCSltVo4I29O6z1n/Jm+MT/yReob44u1TjnQOYNlUR95EplUf8EzrqefZjHxmqc1mWVrAXcjt44uHsDePKntE4eTd3Yjyjad5mqmwoA4Y+hnv7g/QHhQjKT9xr6d8ROf5i7Q1QXnDwNl3VoW3++O65yeHiS4VxAiApTWVvJdrMV9Tp1Tho++NZUTzbvn/nibPkAKlOgOgznYMnMbjlcvIunxYBoxVq/niZULHaCF9KMJOGZmidn7NKvbojdtGvaM9S6IH83Pe29YarqM+M6YX34dZQskElg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009223327099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tS5TH5zbjf3jxUBZ5g0u28gTLm8ewH5tnPYsZesZebK7M5FrQZNFKfdfKi6Zhja8M9XyHwflEVSWsyODGWi7kqsVPz6G/Soe3TgGGVaNpSwp9yCjOaoa3DlzVp7dlzpSsID18zLX8AfHlY7w3llOked95rZB+CiSZh4wiwDPLryQqRMYItcGhB6C6U/PahcIgzFaBgVYBqH5cB+IiKsygeFlSMq0CfZ8RmIxLAIj6Cgxi58cxHUioeyyPrlr5h5WwjxqwRCQZ0FMZemblNnhtKsXY2hSDME+/RPB5tAvn2ObAYjDxmydnvrEzAZ3NHpX0qVAhNzP709xHrtajS8MLiV2w9EaxbT0daAP2BGsD/SbkxLPBaEFHO6YOYPjqqrHi8QMzuHDO/gS86Fy1iDTVcaXowZzuf7SWj7VOAFErNzFufbBATqE/2ZDz5iYdytZ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:03:31.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16292574-1007-4a8b-defc-08df4489a753
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3516

Hi,

On Mon, Nov 09, 2026 at 09:50:06PM +0100, Joshua Crofts wrote:
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
> 
> Remove the redundant function calls.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 2e1cc6a92b81..7904d888550c 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -2325,7 +2325,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  	pm_runtime_put_noidle(i2c_dev->dev);
>  	pm_runtime_disable(i2c_dev->dev);
>  	pm_runtime_set_suspended(i2c_dev->dev);
> -	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
>  
>  	if (i2c_dev->wakeup_src)
>  		dev_pm_clear_wake_irq(i2c_dev->dev);
> @@ -2367,7 +2366,6 @@ static void stm32f7_i2c_remove(struct platform_device *pdev)
>  	pm_runtime_put_noidle(i2c_dev->dev);
>  	pm_runtime_disable(i2c_dev->dev);
>  	pm_runtime_set_suspended(i2c_dev->dev);
> -	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
>  
>  	if (i2c_dev->dma) {
>  		stm32_i2c_dma_free(i2c_dev->dma);
> 

Reviewed-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain
> -- 
> 2.56.0
> 
