Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023136.outbound.protection.outlook.com [40.107.44.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AE33987E;
	Tue, 29 Sep 2026 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661209; cv=fail; b=iSD3Y+N/qja8phn6uO2EoLb1ib9xZvdm3yRhgRItL43iZbZo2v32MKWO040nH04wwlxDfUaHiOZSm648IQvzmuPz0N2HnrmF97FeQ/tsRSwR9hUXaYFYRarDCj9VOhcQxgvnnRMDzhVwOxTWR5SHz1XMShR+/3dh+KE4eny8UKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661209; c=relaxed/simple;
	bh=PbQxFyFjNAgxfCavoLnjdLFfU4OEdTYT69TLOKuvNrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pJF+a2eI4+ZQivn064zI1VF1XkHMBXJwmVuNjKeMZL55+ShuM+wdkzEVFJHDKLcBnbm1e0or0H2uh32r6PPEDCXRXt5saeaF/LcoDmTmPfsyXZ+rSEPRYQIalt5LxvKu2DV87TX7DpA6HEtTzPERNB2p2SGV9bNjx7oq5Qs1XqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=miATmlRr; arc=fail smtp.client-ip=40.107.44.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="miATmlRr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKg3EkuWq9SmRrKceevsKaqaY1I1y/pqo6YVISJjOaEAvLl7F6VZ6pdUynAsR9l8KXCGMcNHV1RsNafVhkemM7S8Tjy/PIYlFt3jRHLtyTUSaV97HY5rxBqzWHBYsEE28gJ4L6pgtwl2EQau19f3fFwZvZ0miFbMmnW9HtleYaWOPbtcwJIBOH3vF6NF9Sd6b1cFdqxc7oVcoEGFJr3fRjhOmJxJzcRlLDXvHooE4QeBn3NSwtJ+CEegcNbYBw05DPZWtgd8LwdL90LHfZdHDJCDCQ5uJ/dCvZYRg6r0QZOVy+jdiHJZ9/kwhaiuy+vzxuO06RZm+TtQHVy6fjs9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7j0/j1e7X3CQy7rV1yknlax+O6WtlyjHuvNG2kQoXI=;
 b=ZtRbknLLAe3Y7oSAPJF+MJdM9rfTVH7Xi8CRok+FVW21OPmfx6jakAZSXR0IvTabGrjeAkJOdK7qcYgT1CeN9ZoS8GbtrZnJQEW+Yg7/xMU5/MXbE6iY2iLBJbTIOLcyl35kbIOYsUndKUVVxOxIPnc62X8Bb5inD+qLSW3tnYTD9t/ViBKkUs1gqlNzpN6dea8qWvnAnPzcmqNEDnMrVrRLAuJcilGsc+jiYIf2DheHLPMkJ80oBS8Po4h80QHq7gCgclGZ6d/AfcSp/YrYFvsw08tF6fBCR0fe8O5VAt3yn48bMjpddRpflEp/hzAR1Xkv6aWRRTSLGxqEDoOlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7j0/j1e7X3CQy7rV1yknlax+O6WtlyjHuvNG2kQoXI=;
 b=miATmlRr4ewgsUN9KlEk28ZZ6g33u+cIHQr7mhJ+25AAYUZel7f4qXFMGboXH1LihLkikIxx+FGSgmksa6NkciA9IhsAfPMyx1X0F8j2P75Mbqs8YcHSPPBdGRraGqdaV5uYECFL1OQPB0H8/QwORpw7JY/JA4CCru4JUrK9201TOPcr0unyOwWnuz8uaFG3rnrQa8s6gQycKnTeJ6dXerx3b2D+eVvtN7vehHIjOxqF6vnKcSsjszDnXj9jIUDdvWFW2XI4NzMtN+9c3IGHQIDgLpF4+RHT83Q3hGD+PVvFOLGwGIelUbr6o/RMVENWnQggJvZoTQ+vIk1SdgbQrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by SG2PR03MB6635.apcprd03.prod.outlook.com (2603:1096:4:1df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 05:53:24 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 05:53:23 +0000
Message-ID: <7beed446-3312-460f-b68a-9983328696c3@amlogic.com>
Date: Tue, 29 Sep 2026 13:53:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Junyi Zhao <junyi.zhao@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Xianwei Zhao <xianwei.zhaol@amlogic.com>,
 Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
 <20260924-a9-i2c-v1-2-b8ad9b46f4a8@amlogic.com>
 <arkDNC8st4Nsqu1C@zenone.zhora.eu>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <arkDNC8st4Nsqu1C@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|SG2PR03MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 610fb7c1-3708-47f5-16bb-08df1dedf8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	AMdcd5bnFhfOW5n7/lo8+eRF2sx88HZaEZ7s44PTGjq+AKZaIaQnpjIf6T+0+9FMqdqClEyUqP1EJE01xr2vHwbTHXzbaKSyDZMr8iyix9ORTKFN7yT5FVFNtuX9mKz1R8imKiqvt+7Z1nCfBP/8EN5iHjMZhzOGoC9sohJ3Z2C9Z688oZxy6lQD2j49CZKCHxbb0JMwYoUWLFY3zoG2R5VzEQVHUO586KZPfn3bipH5Aambgqu6ZDveG4rpadxdBncz6ixTpkxAdPrJ2YpFIzgEXJhsCkSUOG41fDgrUcuvWReyKP5Hs9ZqWiylXQoQk5nnJ9GgLZdFu0XKWZThodto7+KjiDHB0UTMSnphAtNAdv4qK/wWkyZSsj+rwQlLsOLZy8/o6ScOASVGbnzpp2cJi0nNFCZPVFBtgDg8kPstfjZFJ3nCiaTgdtyvKR4+nFO8DqJOjSDvXqHd5K7N4Gmf61BTFMekK9qqcYE4zJQvO/bOT9AMfWUz/KPVNQNjNujF3UkfqqgWL01U8RtJ51BTeIVij2FDEZ0NcBmJ1OOB75sZu2ciSm8KF0GiCCrInZ7+68UH0JyDFg8qjvlhBgY8vqc9Sgg7ZIqKQmm4W5aYEv6ohivPJ0JtTIQe1Nf2p7lk5sWF8uuHNtikfi1ob3diuqpvHDo7L6n1Kqkhwi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0tiY1dzdTJkRG9lcXYwSmlTc2hDQi9DOHJzbStKQXMrNTB6bGJuRjRJeTMr?=
 =?utf-8?B?Y0JGS2FxNWJPdU5UYjZoaFFNWWtpcjBzNlFFcFZqamtCM2ZhUVZuVnJjUitM?=
 =?utf-8?B?OVNFejJ3YW9VQms3UjJxUDZiQlp6cm11ZVJTbllLRXBCS3RicTEzdXY4dUVq?=
 =?utf-8?B?MkhiQjMvbUh2TVVHUHpLaEczYTJ0Q2NkOVAyclBtM0NRb1htdGs3SDNDZ2U2?=
 =?utf-8?B?K2t6WndYcDhpSGx2K3F1K3JaRFFGRDFPNXArSFY2VDE3TVJwU1dBajVhdmR4?=
 =?utf-8?B?NFhHR2pFTTdVbTY2VDFvNXZJMDhxOVpGNGFFdFkvZXVpVjdrTk93MjFnaWF4?=
 =?utf-8?B?UHJ1ZTF3QlNqS200T1JCUGxmdDF2cHhTMjd6NGZLN3JORGFqanJmd2xPU1Z4?=
 =?utf-8?B?SzlZNE9sVy9WZitMNnY0Z0NtaEg2V0M0YnJ5czJ6YlZjcEk3NkhLSDhWVGZE?=
 =?utf-8?B?ZGd4eGVUNk5KeU1TVEVFVGM4cjJBSmFYRE1MZlMzZUZwK1l5RHBUZ3BLZjIz?=
 =?utf-8?B?aGlmNE04Y0VOa3BoZXJmdjF3a3N5YnZucFp5V0VqbGdNbEVPVjdhOFkvU29U?=
 =?utf-8?B?WTFXeURNczhvWDB1RS9pOWZLK3Zlalg1dDd4MGNLaVNLcXZYendSN0pmckRi?=
 =?utf-8?B?SzBuanF1eWo2bmVpUWJSY2ZBR0pIN2ZlNlZjckQ2cUVsWGlINWxmTVZ2aHZT?=
 =?utf-8?B?NVd5T0RXQU9pcGw4b2ZwUUhMTGxsUi9LT1daUmtxWG5NdG9Da24wOXBOU2dv?=
 =?utf-8?B?VlQrSi85aUk0TkFLd2dTL1pOUGgvV0ViMVBRN3pWY1l0Z1JWU0ZYcVVrdlcy?=
 =?utf-8?B?dm8zUXE1a1kwaHR6aisreG9udTA4bFVYaVJKSmZlVVRwZkI1N1pmOTM4KzBw?=
 =?utf-8?B?Z0tFTkMzRHRmbkNkSHNkdCs2eGFBak9aL2oxK1hBTFE2M2JKb09obUhwRjBv?=
 =?utf-8?B?c3pkZkpnc09SL1MwWUNDZFJsTDRrckNtODVUSHYzQ0VYNU1WTHRDV3htUU9B?=
 =?utf-8?B?QjZPemJmUG5UUFcvbkFZbm1tNnYzZk1YSHlwN05FZENGT1NlNWlJcWJDc0R3?=
 =?utf-8?B?ZFN0R0N5dFhQcVExeFIxRG42aVdqQkZXVEV2VFdWZVV5ekRKWHlQb1BDVHFn?=
 =?utf-8?B?TnB6MjBYN2krVHBNT3pQSCt6WkYxd2xZNkE3ZU1zTkpIR0hOWFFERnhFc1hi?=
 =?utf-8?B?a1ZzR1NjczRMUmx2aHhFOTlNNnZlYTh5bjVlZHkzbWcwaEE3VU5vSjhJS2N1?=
 =?utf-8?B?dW00OUxla1JJZmFGNjJwc0F1cFB1V05wM3d4aTdkK2drUVU4Tk9VY05UY1Yv?=
 =?utf-8?B?ZkVwNmFVME5rMHMyKzhha2E2RE1PUEV2cFBOaC9wYVE4M1lmWmdETlJlbnNu?=
 =?utf-8?B?WG5QdjI2MVB5ZkFZRXhvQXVUUFFRdTFFL21NeXh0TTJaQ0tsR24xY1BWV0tq?=
 =?utf-8?B?VWpGNkZkaUVHQVlCa3A4VCtSV29JRmRXc2pjb3dJWmFsYkZQdDNJN25VUU1r?=
 =?utf-8?B?MitTYXROek84bHJBRXI0WUJDL2ZVblAxM084Lzg2RGhYSmJCTnRQM1BvVGRP?=
 =?utf-8?B?QldKOGI4ZENRNkhZaUhUR1dYVUhVVm1kWWk5Z29DbmZBUjZWUVAvNVlCSlNO?=
 =?utf-8?B?Ym1EMVR3Qk5RdjluN3JHTzVXSGJ1Vlc2WldNYUR5ZzFjNHYvV3cwOUlaRjM5?=
 =?utf-8?B?V1RVNzdmVERSaHBiSVlPR050bVNYdllZS0pDLy9ZYlFGTklEaWsyUUIxdWho?=
 =?utf-8?B?U0NYVGpXNzhGaXFieEpJOHVWdGh1VGhKdVI3Q1lValQyZi9XKzBrbEpUSWNW?=
 =?utf-8?B?QWV4K0YxbXcvS2dOcWFMU0pRNU5hWlkxNVFkaFhjSzJHNHJtaXV1THU2L3pi?=
 =?utf-8?B?bnM3SHVTVmdpVnJSYXFxNTBINVJ4amVTbnNqMVRaQ3ptSHViNk9BRk1iUEVz?=
 =?utf-8?B?aGtyY0FVY0VJcjVtVHVFTjcrNHdZRjVIMlF6WC9wNks3b1BwdnBVQlpDYkln?=
 =?utf-8?B?V1haSEVWRExtdEhhTVJrN1RzWWx2bXd6dzRRblNtbkZrNmhSTk5ROVNQL2JN?=
 =?utf-8?B?NVZBblA1Y3hibmE5UGJiM2ZZSlA0NS9ZMTNCRFJabkg2Y0J3YjZkOEZIUTVY?=
 =?utf-8?B?d1czeGJlSkJtQXhMZ1hwYWxsWi82UnlzQ3BvNDJQbnVCQ1FPWUFQclVxeEJ0?=
 =?utf-8?B?MDJEQWU2bGZ3aUFuR3FIS085NDNlQnhGT1Y3RkF4SzRoZVBUQ0JEZWcvT0pv?=
 =?utf-8?B?eWhweld3blBnTHlvQTFXUzMrWkh0Uk1IQ2lWOUx6bzFrNTRIclh2bG5udkla?=
 =?utf-8?B?d2hpaTJad0xma0xzcmpQdVZEdm1XR0dvUXYxZS8wWWpGSkhTV1RtUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610fb7c1-3708-47f5-16bb-08df1dedf8e2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 05:53:23.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NFsNPUgjRCkz76nkIAauWiT16h0+GUMNMFbXhAuL1RtC415dYl5mdPAJmDo9pyz8P2BvEroAaGnA7A4ZTOg4Vv/ExzB/FuxqTlJZgUnhr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6635

Hi Andi,
    Thanks for your review.

On 2026/9/27 20:08, Andi Shyti wrote:
> Hi Xianwei,
> 
> ...
> 
>> +config I2C_AMLOGIC_A9
>> +     tristate "Amlogic new I2C controller"
>> +     depends on ARCH_MESON || COMPILE_TEST
>> +     depends on COMMON_CLK
>> +     help
>> +       If you say yes to this option, support will be included for the
>> +       I2C interface on the new Amlogic family of SoCs.
>> +
>> +
> Please, remove this extra line
>

Will do.

>>   config I2C_MICROCHIP_CORE
>>        tristate "Microchip FPGA I2C controller"
>>        depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
> ...
> 
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/delay.h>
> Please sort the above in alphabetic order.
> 

Will do.

>> +/* Amlogic I2C register map */
>> +#define REG_CFG_RDY          0x00
>> +#define REG_CFG_I2C          0x04
>> +#define REG_CFG_START                0x08
>> +#define REG_CFG_BUS          0x0c
>> +#define REG_TX_RD_ADDR               0x10
>> +#define REG_TX_WR_ADDR               0x14
>> +#define REG_RX_RD_ADDR               0x18
>> +#define REG_RX_WR_ADDR               0x1c
>> +#define REG_CGF_TX           0x20
>> +#define REG_CGF_RX           0x24
>> +#define REG_CGF_IRQ_STATE    0x30
>> +#define REG_CGF_IRQ_ENABLE   0x34
>> +#define REG_SHAKE_BLK_CNT    0x38
>> +
>> +/* CFG RDY fields */
>> +#define RDY_TEE_ONLY         BIT(1)
>> +#define RDY_IF                       BIT(0)
>> +
>> +/* CFG I2C fields */
>> +#define I2C_RX_THR           GENMASK(23, 16)
>> +#define I2C_TX_THR           GENMASK(15, 8)
>> +
>> +/* CFG BUS fields */
>> +#define BUS_NO_STOP          BIT(18)
>> +#define BUS_SPEED_MODE               BIT(17)
>> +#define BUS_SLAVE_MODE               BIT(16)
>> +#define BUS_FILTER_MASK              GENMASK(15, 12)
>> +/* SCL = clk/b_ratio if b_ratio<=8, SCL = clk/8 */
>> +#define BUS_RATIO_MASK               GENMASK(11, 0)
>> +
>> +/* CFG START fields */
>> +#define START_START          BIT(31)
>> +#define START_LEN            GENMASK(23, 12)
>> +#define START_LEN_SHIFT              12
>> +#define START_SLAVE_ADDR     GENMASK(10, 1)
>> +#define START_READ           BIT(0)
>> +
>> +/* CFG TX_RX fields */
>> +#define TX_RX_EMPTY          BIT(9)
>> +#define TX_RX_FULL           BIT(8)
>> +#define TX_RX_DATA           GENMASK(7, 0)
>> +
>> +/*CGF IRQ fields */
>> +#define IRQ_ALL_MASK         0xffff
>> +#define A9_NCK_ERROR         BIT(0)
>> +#define A9_RX_EMPTY          BIT(1)
>> +#define A9_RX_FULL           BIT(2)
>> +#define A9_TX_EMPTY          BIT(3)
>> +#define A9_TX_FULL           BIT(4)
>> +#define A9_RX_THRESH_READ    BIT(5)
>> +#define A9_TX_THRESH_WRITE   BIT(6)
>> +#define A9_PHY_DONE          BIT(7)
>> +#define A9_TASK_DONE         BIT(8)
>> +#define A9_ALL_DONE          BIT(9)
>> +
>> +#define A9_TRANS_DONE                (A9_PHY_DONE | A9_NCK_ERROR)
>> +#define A9_TRANS_ERROR               (A9_NCK_ERROR)
>> +#define A9_ENABLE_IRQ_BIT    (A9_NCK_ERROR | A9_PHY_DONE)
>> +#define THRESH_MODE          (A9_RX_THRESH_READ | A9_TX_THRESH_WRITE)
>> +
>> +#define A9_I2C_FIFO_DEPTH    32
>> +#define A9_I2C_HALF_FIFO     (A9_I2C_FIFO_DEPTH >> 1)
>> +
>> +#define I2C_TIMEOUT_MS               500
>> +
>> +enum {
>> +     STATE_IDLE,
>> +     STATE_READ,
>> +     STATE_WRITE,
>> +};
>> +
>> +enum fifo_fill_mode {
>> +     FIFO_FILL_FULL,
>> +     FIFO_FILL_HALF,
>> +};
> For all the enums and defines above, please use the prefix of the
> driver name, A9, I guess.
> 

Will add prefix A9

> ...
> 
>> +static void aml_i2c_put_data(struct aml_i2c *i2c, char *buf, int len)
>> +{
>> +     int i;
>> +
>> +     /* this i2c module when trans 0 byte, must put at least 1.
>> +      */
> Please use the kernel style commenting format, I think checkpatch
> would have had raised this.

Will do.

> 
>> +     if (!i2c->msg->len) {
>> +             writel(0x00, i2c->regs + REG_CGF_TX);
>> +             return;
>> +     }
>> +
>> +     for (i = 0; i < len; i++, buf++)
>> +             writel(*buf, i2c->regs + REG_CGF_TX);
>> +}
>> +
>> +static void aml_i2c_prepare_xfer(struct aml_i2c *i2c, enum fifo_fill_mode mode)
>> +{
>> +     bool write = !(i2c->msg->flags & I2C_M_RD);
>> +
>> +     if (write) {
> you can revert the logic here with if (!write) return; to save a
> level of indentation.
> 

Will do.

>> +             if (mode == FIFO_FILL_FULL)
>> +                     i2c->count = min(i2c->msg->len - i2c->pos, A9_I2C_FIFO_DEPTH);
>> +             else
>> +                     i2c->count = min(i2c->msg->len - i2c->pos, A9_I2C_HALF_FIFO);
>> +             aml_i2c_put_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
>> +     }
>> +}
> ...
> 
>> +static int aml_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>> +{
>> +     struct aml_i2c *i2c = adap->algo_data;
>> +     int i, ret = 0;
>> +
>> +     for (i = 0; i < num; i++) {
>> +             ret = aml_i2c_xfer_msg(i2c, msgs + i, i == num - 1);
>> +             if (ret)
>> +                     break;
> you can save some code here by doing
> 
>          for (...) {
>                  int ret;
> 
>                  ret = aml_i2c_xfer_msg(...);
>                  if (ret)
>                          return ret;
>          }
> 
>          return i;
> 
Will do.
>> +     }
>> +
>> +     return ret ?: i;
>> +}
> ...
> 
>> +static int aml_i2c_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct aml_i2c *i2c;
> ...
> 
>> +     i2c->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(i2c->clk)) {
>> +             dev_err(&pdev->dev, "can't get device clock\n");
>> +             return PTR_ERR(i2c->clk);
>> +     }
> Please use return dev_err_probe(...);
> 
Will do.
> Andi
