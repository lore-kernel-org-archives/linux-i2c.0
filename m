Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADC34D4C9;
	Wed, 15 Jul 2026 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083956; cv=fail; b=ATE0jrOi6qfWe7TYQlvmcjDpVUasyx79KPa9uTBwRHq1L2BmNBzygTqQmF1KOG0H9W2ljBU+Q3TWMPWB4cykmXgbkzScCFsUAXxGHenp6LyVL20iso2xTsu4Aoll7n6pxwjndI5PoThZU+WIutTX1B0qpGOQifMhgg/LtVnG6bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083956; c=relaxed/simple;
	bh=V4Co/bodCSsmooDMrNtly2v0Db6UPMQ8WjxJVStB/Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpxohySYtVibe0VKXLGV1iu8VdMQYy7nw1oSfstOIyaKUsl12IHwoBqM+CyCfrkBXHIz2mz9q1QK8yzkLDp0TgjiiFufLO5H0kt2GWnstkb8n09Gd1juA0kFnuhRqObIWNHVOywoynnQPF4gri00CYpi8pQ2YX9YWYvK7GSZQcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZQ69EiKR; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZQ69EiKR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKfoQwOmunoENA0fErQ8sVpXJ4AFGSP8uc8rb2s/gNfjyChulgKjbqyidF2B607RnGx9JQDS7P/s1UvRNc5jvbOJOgEEgkieVWUx6whFMZH5VXctsQqYz7PT1a7iE4UzS45PKxVdnCesVWFs3GnamfWLpDRCTMAFk8DUoznnWFLtgc8RLLlnCZ71idH9MvPBNJYTqV7qxlQvcXE5QhSPf/Vc5rUcWbT5C7F49FBnMXqjsmMDh+5HxaTS579TyZpWflDkrqRbZIJM6pjxahePEa35pPCVDpHgEy0o+CvpgBz6UPvnmyqffsghlQ9TaAdIYTUErlV5mXiAfcds6BDnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBaHrm0DZrYULwDF8Q3yBCiR3gUUI1Ti16lOV9jg2qY=;
 b=eWb7Nyac0DMN3cQ9ol+yQLF+vkoOr7r5jiHo8grW+bNxv/jl/oHrvwtJLIbt0Nj8cOZ4lBPBuLYE5ziJZMQ4Dw9gQpPWz8tgFa1zOhx0LZrU67MmjuDIYDVl4fjuKF0BnoFIUufxzLog6EwcPlJpsyQFXIgjdk24iecPSKM6hUFCfZKGfRnCmHvlFFN2dB5mP1TNqWTvV49Pa/2RCV4+yvGCYALFE5j8/ZNTu9hWE1JuvG5LsogD/3NCE14iP95PdjlwJLQQ3wKf2ZEJPswLhnuT44xgFB50J5Io2XAGXx28LpT2XPJSvVC5KjOYQud62gpG02F3tRiBu6q9QkRTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBaHrm0DZrYULwDF8Q3yBCiR3gUUI1Ti16lOV9jg2qY=;
 b=ZQ69EiKRdaoVuxh+twpIiUAHkE7A1eehy7BKpDsfhQDJ6dhZpLB+qBtNB9D0AudSqY/FLhq/yFV6wg1Oqyj2dX7UnaaM5jZCWvIVqth2kG17ug9dr98BEK7gJmrpXaDYvLZLWHALJmkgq/1lQmLREg5Zn6klPPxzICrIx8LcEmZWvgKUNHOW+Dx3nzb0oN/0VLJIqxBzEITRSRJK2YeSmMYfMZG1rbATIl8JuIRPGxJXzwgWys+cs+6pGvvyNIou2weLUnDkeSkv6mMWfMkX3xcyRbpDORsH5lnQc/8h2nvzfeCbHdkjOYRN7OX4p59390Ux6US6yvSDaU+Ud6ppnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by PA1PR04MB11310.eurprd04.prod.outlook.com (2603:10a6:102:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 02:52:32 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 02:52:31 +0000
Date: Wed, 15 Jul 2026 10:54:40 +0800
From: Carlos Song <carlos.song@oss.nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Carlos Song <carlos.song@nxp.com>, imx@lists.linux.de, 
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 
	Andi Shyti <andi.shyti@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] i2c: imx-lpi2c: properly unwind resources on
 probe failure
Message-ID: <5fp45u3yuwz73nk6eeofx5fp5drvaqxp435mithslttb73zylb@t2s3se5a4qux>
References: <20260630105223.3687516-2-carlos.song@oss.nxp.com>
 <f6284d81-75fa-4418-b4f6-531163bd02cb@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6284d81-75fa-4418-b4f6-531163bd02cb@web.de>
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|PA1PR04MB11310:EE_
X-MS-Office365-Filtering-Correlation-Id: 023ecf28-a4d0-45e9-315f-08dee21c1d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	glAd+hAskQ+UyB7besWo+IqKwf73jHlJ2XcQPdyOIr8CAu4zas8Tc/gcz5rHk9FnpY6X4n5mJ0f7nz9RKy32mApi/dQKQzYtdmZvS8SJZ9H1oLG1zGEYMWNL+qidwBVaYEo1ODisK8jM0ZJQDP4S4W8uMXbJnF54no1ApF818Cp18aenmNQwDwyZQihOlLQGWbMeTjSoCcrQ5AUsYSN0pz48TnytkeI9785QMmiYFnYPaYDNnq5OPdWYT9tz8KG11lQ+BBD3NzSev7qFhpMdY8PuC9bJZ11lDk3xCpcI4iMdFizWWG0plZOuzwLFsO7lJJKgdDqNs6iCVVz4QpGvaFFn/5Z0/eX/2w0Rl511P2IQrla52Q7HqyWBA07HjIoFre6Hf0AgkP3cbfgvQzAG25GLpNSLOFllCwKoFRS8TGRVUJ6Yx15QuyxYOFTsj4q/FjZ5bnEfuosFLlWv1/dLiqZNQdczqXDd0+GuTeCPwN3t/stiQ7GWkOy+kVEERLyiwXJo1100yk/PBGV7nkmDicdre8zEbVymWXh24238ZUlOw+0R/DAB5z6/44SGm7JOeYGjzyTBXB3jpk1uJasicr7vttIO0XKYsgoaAP+kwJzjda6F8H4jVPYRsfQ9dRInrOce5fXxwhLPz/pcYC5s2jVSlSKrr6hWPjwXzP3KceI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjVXcjhJK1hzSUZlV05OM2o0S0c4WTVNeFhDa1d1emp3clEvcXkwUjUrQzJk?=
 =?utf-8?B?eklZUDVtMDBEdFhvZjd6b3lBa2tSSi8wcGZxUHNHKzNjODJOL00vUHNmYktT?=
 =?utf-8?B?ckdrN0lCMWtUQ1I5dXoxV0M3blBRMVdVSTNLODl4bSsvZjRwTFJDTVdOWnB4?=
 =?utf-8?B?c1FaTVREU0J4SHNPNFhOcnN0NXhTTDVKeUlyY0h2MVZENmZIcU9ZL0REaXdn?=
 =?utf-8?B?UzB3dFhmTVZSb3dqRC9FeklXVFdWQjN3ZTByTXFWMUZicWlCeHBFTjJWaHBx?=
 =?utf-8?B?V09LTFNCeCtYNkYyS2xKenNrWEN2VktBU1A1UDRDeVZjVW9KY05EdzIraHg2?=
 =?utf-8?B?VHFGcC9LYXJ1WVJPQUJpMFRHcU1DVGlDQW03bEUyNXc3QlJOM2RCSk5FWGpy?=
 =?utf-8?B?SE81eW82U1cwdkY0dkYzK29qaEF5MWZFOEk4MEw1T3NJZ0NWVE5xM2ZLYS9J?=
 =?utf-8?B?VG1qeFVOdmRvc0hrS0R6d1hmdEFDSkU1L0ovQWwxQ1VXUnpxNUQ4Y0NhdmVW?=
 =?utf-8?B?S2E1MnM1elBIK1JaeDllaVU1U1ZYN0lFZGprbnNGVU9XZVIwK0YyQ0ZsQk1u?=
 =?utf-8?B?ZkdGM1F6azRMWjBwOTBWWGFpV2lwRFJDY21oZE1EVGlqNm1xNDMvdUt5dlhs?=
 =?utf-8?B?YkJoYVYzVUNIRlFWSTBTbzdUbDhtOUFEcWZSOSt3TnFwaVhyT3FGSzRhWDFq?=
 =?utf-8?B?OU5yQ2xzbW1oUFdxbCtZVGZMN0ZBOUg5cWhKc1ZSbnY1RnpLK2lrRnBBUXFK?=
 =?utf-8?B?NlowK2hMVFJhQ3NxcysxcFhNZzFtSVUwUXpFTWN6YTV0T0lUeTF5UFFOMzgr?=
 =?utf-8?B?VjMzMnBlOXN4QUZhcHBLRlk3Qzk0SGdnVkVXSzVQRG9UV1N0ZzNMYmNNRHVn?=
 =?utf-8?B?NDlRbGpoeSswR0MraTg2ZjlyclhSU0NYa0tpNkVJc1lsMlQ1aDNmQkEvT0J1?=
 =?utf-8?B?MHl4ZXdRZ2hGdXBmZ21mM1N3ei8zemRzd3VIVzk1b20zZ1BpZDU1UzA1UzBG?=
 =?utf-8?B?SG4rTnQ4MkZxY0FRT1JqRzZteEdvMFhES0JVSmFPV1EzWE5WaVZwaDhMQS9j?=
 =?utf-8?B?NVcyczR3bU9PQys1QU81YzBvOG1OcThNc0NXTSs3bXYrQVpCZG1uc003M002?=
 =?utf-8?B?YTFieDBtSXI4T0dzSG5OajFtblgySVZUQXNZSnpGd3NncEk0bjR3VUVObmpY?=
 =?utf-8?B?VCtlanBzSUJmWUt6WE1KeEhxemVHRkU4MzFsOU1VOGlCSmhSK1JRVXkwaW40?=
 =?utf-8?B?ZncrVFFja2doaUhrS1hyVGM5dW9vK2lUL2ljbExTMVRPM3JzZDlRUWlYaTd6?=
 =?utf-8?B?TGxRb2E0Tm5DV2JDTFEwSzdSSWRqVDc2SDFkSjlGcFN2aEtienE5WEEzZFpB?=
 =?utf-8?B?UnBEOXQrTnpnSXphVzR3ZDFHTllNVkpxRkR5b2dkeW5NSVd1WE9UL2VDQWpa?=
 =?utf-8?B?N2ZMVXc5Tjg5ZUk4WGdBd2dYSEh6Rldjc25aekczWi95ZlljV2xIemw2bS9s?=
 =?utf-8?B?VWl6dkIxazFVWnArTnFROXRRNFRhV3VJWFVQc3p5MmlNeU0xNWs5dk9Sa0d0?=
 =?utf-8?B?RGFjR0t0djJDWHRNc1orR3BEcCs3WEJNR3dEYmR0V00vR0NpWkE1RW50ZzQx?=
 =?utf-8?B?Tk1sVG8rb1lOaVdYcG9wUk0xR3pCTzFsdE84N1J6MGJyeDJaUnZQSTJzTmQy?=
 =?utf-8?B?Vi9tMWdzOUoxcFFhYVRDM1ZTUnZpOThOQkFvdEg2MWNLYkhhQ1hYaUtCR1dl?=
 =?utf-8?B?bEVJZmplVHUyYzI0Z3p2SWd3TFFhalIyLzA2VVpMcnUySFFzWjVYOHFFQndZ?=
 =?utf-8?B?TXBsU08zS1lmWHFpWHhtK3phQXlFQWczVU9OZ3lJNVlReWhTMjRUcnlZeVZZ?=
 =?utf-8?B?a1c0Yi9iVkJtbE1QTGdFcHNzUG5ObmF2dDRuLzhheTF0VHljTnIwaFBBckxP?=
 =?utf-8?B?TXlFeHN4WVQvbW1iRDUvQ0JQa2k2VktvRkRWNkNlbnp3ekxkeDQxNUR2Qnh5?=
 =?utf-8?B?MG5tMUQ1VHYrTHRvS1hrdER5VjBMY2ZVci9Gam83M3k2VEV6VFpwL2dhamxj?=
 =?utf-8?B?MHNXclV0b2hiTGt4cVZzRlltRHM5Wmk5Zm5Ca25JTG5LdHQrQzU3aHBjU1gr?=
 =?utf-8?B?bW5mK241OXdYRklrUCtvNVlTamUranpFWTZ2Nmk1QWF4N1k3d3ZiQWIyZldy?=
 =?utf-8?B?SzhYbmpXUTdGUXhacGpidHhJeFFxMVBWd3lHL2JwbVI1TzYwalBHaXpEYldN?=
 =?utf-8?B?NkxqbVJBZGVxYUlBUTlLT3ZWL2IwV094MHBudXJyUnRvbEJGcEo4SnBmWVhp?=
 =?utf-8?B?OVp5aXR6TnVaMVhYdnE5eElnREJwY1JHNHlseFZQdXg1bmdyY1lPbWYrMVRS?=
 =?utf-8?Q?C2Ffr5bBes4sUnWu3yeIG2vwWi6CiGM9bNe3e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ecf28-a4d0-45e9-315f-08dee21c1d39
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 02:52:31.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Dt8ZpSjlrehoTy6D9PmGm8tuuW8FoFi4kuajBMNVOP7C/XenDa1YwoMtBp0fO/YTjn3gt/FxdQszu4ohU8s34ar70QDGYA5ctHh0iscaU2vKzB6viaKSagPJHHE1ahB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11310

On Tue, Jul 14, 2026 at 04:10:20PM +0200, Markus Elfring wrote:
> …
> > Introduce a new error label 'clk_disable' …
> 
> Can another bit of duplicate source code be avoided in any if branches?
>
> Regards,
> Markus
>

Thank you! I plan to change the code like this:
'''
        ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
        if (ret) {
                ret = dev_err_probe(&pdev->dev, ret,
                                    "can't lock I2C peripheral clock rate\n");
                goto clk_disable;
        }

        lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
        if (!lpi2c_imx->rate_per) {
                ret = dev_err_probe(&pdev->dev, -EINVAL,
                                    "can't get I2C peripheral clock rate\n");
                goto clk_disable;
        }
'''
Does it look better?

Carlos Song
