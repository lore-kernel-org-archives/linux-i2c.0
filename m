Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E33BBFC4;
	Tue, 14 Jul 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036863; cv=fail; b=iPP9GDDj4Rfy6feSMAIwNS2i7jUTiyYYwKO+SJJIB4vzDxzeg9FLBtHq5PNbDmq5DTZaoPj6O440J8eXxlEm5n5SuHIP6q7i4A67JcNzUdUixDLCAXm/fnX6LTPIZu0sCK3M/UwZvk2+m4VHEJ7R7pEYV/kjAnkjluaJ9PLXVXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036863; c=relaxed/simple;
	bh=0zILi71AR92xViQJiWMbLMlJNurn70s6oW8aPA6ddpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lFsBP+oY9X+mJZt4NkPU5qkp2IM2lE/cbgHm2n2Ow/NZudJdLPZMIm4uQ7tu6oQxwPIZZoMf7fiUeO7NfFALRXfycZN8uokGEeb4Sq4ACWL+AWv6ALjY63gUtvwtaVqGc5bJnlT2rAUoCE1tbvjWNFPtP/ZOKd4YDHR82SHITk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mPOwtJNJ; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mPOwtJNJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsfpAXcW7+QMAf2r76h8aoialE+dT6JmuVEO2EYYNKjFBojlpnJc+eqxrcmbIy+Y2/TAZRK9TFiZu5GnH0bMrtfkMGxuDELSrsRIHRHCzDb8lM1E57NhlSnWcmol5Cd3/eLxiNvQ/dsZSkNGO9ZK929Lm5V3O5cVRJ2EOvI/yxjMtGKbjxPty6WQDsPOf5fQBJUEmVIgGnx3saWgklAdwqX+cLXKwTnZYsDg7tKhE6hEbSb5lOIXTN2WCmuFSh3ge59Q0kqI66XchmcYdoXRfPqiFy1PJPfYgkQiGO/EUs/9NXZWi6zogv/JBDaMX8FLG883R+cDTDl6Cv2Uvz4/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MOxh//RkZTfkt5mjGodqikk2GgSwhpt9tGq6aZgJcQ=;
 b=W93Bg5n18dyFmi7oQdVYw+UgPLBDCQPRpPYTt7uoy9dQz4MQf5b2p/7cWvDlaLYQQ22G/fizqIr942QEGsBzRT21OKAanQ05+krEL4dPlN0GD9LKrP0tox1s0iZllEN6UBO6BVZGFE2VR/F0uJhXZC8PVioVYkoTQ9XAS+PuMkN1FDapTXxi9ZTdU4eAfKEKvHZ8io/98r2cti4pyR3/HFrZpiAEW9DCIBxsuNO5YylOSl/ZZCVo+pi+Fp5HP4KkFeaEol76xFkQnWDSsAjamfts02Fz7MdTnA68JXVx8Mbq7PdHKSvEC5en3bUPcnEGEq87YFz96fIPwlzm6HJH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MOxh//RkZTfkt5mjGodqikk2GgSwhpt9tGq6aZgJcQ=;
 b=mPOwtJNJXZO4MGY/VKX1TBzCd3Uon1T2BXlgK7Ud/61uP8h/TZPgldFFynpKmnCRJjveK4sjceZtFV7QXZMu1JKDx+0TYnO0gp2Q5PlvhmGbcwqLu+x7/c3cOpbgeBHp4dwg9IW5le1AyTqDWuvSeROELuTlWnaOAKMjKz3mfi+AJGMrDxZeZj7aDGpUcfRxyGHHQHVNjZUhKgrAg13VPTBIT3cUs69tQ41RVe01VSPDQxQ0Yzq36H57mVEMtAbc62xRwzIqB/kTwRqVfnEipiJBXhr0VF4ntOsdgqP2l4HpFPCtrgCbXpQV6QaOu+qbS19C5hc96QmHRG7QzxF+3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12124.eurprd04.prod.outlook.com (2603:10a6:20b:744::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:47:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:47:38 +0000
Date: Tue, 14 Jul 2026 09:47:30 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: carlos.song@oss.nxp.com
Cc: Frank.Li@nxp.com, aisheng.dong@nxp.com, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v5 1/2] i2c: imx-lpi2c: properly unwind resources on
 probe failure
Message-ID: <alY98otRtcOdjiac@lizhi-Precision-Tower-5810>
References: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
 <20260630105223.3687516-2-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105223.3687516-2-carlos.song@oss.nxp.com>
X-ClientProxiedBy: PH8PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12124:EE_
X-MS-Office365-Filtering-Correlation-Id: aab34ee8-e5cc-4be5-b037-08dee1ae7785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|1800799024|6133799003|4143699003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p7GRyA7qo7tVBuruCfVGOrdqb2bevWdQY9rA26p8DfDNWVObjH8CD5q5el+sVGkUJNKLyTbyaM648v+xNjxdUvEUbe+tD1vnGVD0iXUYCdwYxB5IyfWQBzFG67omVEmgKThtdB0J21RKT5N1sIPjV+8/8iLvwCqcpyHWIFR3agEyQNaSRUze6R8vBacn7BfJmS6pBNg6zB8SWdJM18v38fSKWjqU6Ivb/EGi7AJl3pFDdcUH+9Xg5U0bx4S3Wl/Zn4wsZ0blsmyezqi+U9VZXyhY2ELnrnLzIgUrA3vW5u8V5z2mDlW5kX7KKu5+bluJnpkDDk/E75z+nfBYIRaedw15B+5TldTCjLnJ5sQ7qhPB77KaZf1Li834jaIyBg8LN+c0qZFF8uc241AuBvyZxD4JnvDrCCQkbVaelxomom2FeFwGNnFXKhgzl8wUfK36bkliyI8zeCyXkkYua/yesF652Q3uAMvg7Zka9YoWGstiuwCVrj9jYJFYcoaxq35UBRIyeIpiHtsUaw6lR0TLsD/QLggmQcXR8K52t8Zeu2A6iS0tCexYQsBtU2Xj4JWDlJzLgam+qfzGMTqW6p0p5wABw9WXnyXYlaVsp7SmyUlw9JRPxUwxlWW1yp5Pu/G1HLWlrCyd37sAg0D9THt/eiF2o+aMliUqPJQTg3CpO88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(6133799003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Klq2uELY9rqrPjDvjABsTohA5StXD7VJr4YVbSylFIElKbO4N8wDfldWkW3v?=
 =?us-ascii?Q?bk5Gwf7ej7BjMMyxNWmFr0jxsTTJarZCKspSZN3Q41dYrsCZLdZnzwXq1YGZ?=
 =?us-ascii?Q?rlmtTJfV6PVtU4R0w7zmQ5Ug9sEKRD3dDQ6tOb7y+y8QqkvpH2/1NLe0Sofh?=
 =?us-ascii?Q?triw3kYmLLwDYOpbwYRPufFsFJl3yNFNmzWbPlWnwTzoXR1VC8KR0dzAutkP?=
 =?us-ascii?Q?5btlt4PVbMP6zCbZ+bmM5tlajjv0qRnupPGocMYvwkZ+BkOfNFVGOrvKzDA5?=
 =?us-ascii?Q?GkLcUGD4LdIssKt/F1le5wA8eLefGB0d6eJYJqL73pqYx003DZQpCHb4IkQr?=
 =?us-ascii?Q?38AE20jripyq8ZsGRJl97RujiRrRfkbmnRfeAB9vwg8mRhm4tfLrvEQCvDkq?=
 =?us-ascii?Q?LXYOozbv79+rbsIDU00HEPHWGBtFPVxi9T20AXT9/9B/SQ3FGQIydu7i45h1?=
 =?us-ascii?Q?A9HxRBWbsJcF2a8EZwSJaK0pJ+Hljhjv/mRvQIcFXrMg8fv/F5YP5mwF64ql?=
 =?us-ascii?Q?sW6vFfQPlNcALcSxNhI3nIt2pgFQ5YrvUzEsy7mdOU6fJoR6am3BxKTL8pm+?=
 =?us-ascii?Q?0UoHYQWlANQIXgEVcSoBdT7KD1iJ552tDr3XS1P18SY0W2nLEXPbxi5u8vNZ?=
 =?us-ascii?Q?U+rbbhj7rjDFA+xHZwn75S3B4E74sCfYE66ETRxq4bhk2JrwH5LU7c7TgDAQ?=
 =?us-ascii?Q?hLa+/bnPd2F4bpCatwvubY7m3DoLYWJfCogCJjKlKDoH2A2kxPGU6PMaDH0g?=
 =?us-ascii?Q?UdGm0xPHODw65WBrtKP77OKBPWYL/vB8N6wzPEp/mAOzxmLdTI9B5fuArssW?=
 =?us-ascii?Q?HrhugF1JSGeMcPpnmkPMWQhxrHFrAlGl49Xq+EFhKc0at2wDTCVnO/v6S4Dm?=
 =?us-ascii?Q?1esSYr2MWMlvy7l1cM1Zbt5I6zmQV5XGta73ITFoGfJad8htJ6j345CLZ+gv?=
 =?us-ascii?Q?OB9EIDtO7qj90OjFw6sfKJv2IaF4pa476RZTHoTTBGCqk3yJxqHOEt8Z9ZLe?=
 =?us-ascii?Q?aHLYDIaUPAnNhEMo+dq1op5SEus0C5l1G9fBOb3at7AVtnA0bIbdTamRWKv1?=
 =?us-ascii?Q?6F6sJmcm5Xt3TKfb281ZAQM7+Q8uPEj9c73s0DAAoawLdkqmSyJ1UCjdOXDp?=
 =?us-ascii?Q?tvxJvrSCy35HIj/+2HMm/41k/EVb9mrdYNgZ//q6EZHYV4U+LOrfzFaSdM9t?=
 =?us-ascii?Q?UIUqDeIuLDn4xMQ9wr+DLQHX18WXV54NeTcb3fw0ytJ3qK2ZCe0p7jZUpBGO?=
 =?us-ascii?Q?T1WqEb5QwxBSeH+Dn7rmMJn073zpAoGR+jRiTdY9/YQ4RdcOBxm2DcwthlKN?=
 =?us-ascii?Q?2M6pyPDo6x3iHEiSSLyw4rYjUmW1r2rYCMY5NPdV6QRg+z8+xeFEaV+s6+Ln?=
 =?us-ascii?Q?tW/CFGqFffjuH4TL/nsZ8Nu34d/kqnz0KNeZVnaN0Mycq03KD3lt0CReAb9u?=
 =?us-ascii?Q?8AglYgDHF7IHYX7+XLAqoO1elHoUCBWC5gD3Y7sCO6DdlDWfpwpIkV1RXky+?=
 =?us-ascii?Q?bRH/8vgT1GuzK+6hlYd535nOWG0ooFuGJjSRtAREjDj00FEKRW1o+tvh2pGs?=
 =?us-ascii?Q?/KZ85poiRIc42JY6ncv5p637AHMfwv3RuUDeVJgFj6TE7LAVeaoa2dUBmMS7?=
 =?us-ascii?Q?T2pcpxLN/zJrsYdUso0q9pAFBB7F6HDT+7ygKPuSYi7adxOu+jdLDS7ht966?=
 =?us-ascii?Q?gQpHRsd3Ofla1jtDxveb+wHnFONm9H//eDAtLE8+43Ldo22dsCRPDmx+XKjn?=
 =?us-ascii?Q?Z5NJQZoYmpqUdYZSw5m5LoKcTKFKxGnzWcOV3OKxthAgm5VWICiE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab34ee8-e5cc-4be5-b037-08dee1ae7785
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:47:38.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6bHOlBNdCZQb0Oad348eHvG5tXUNVGlKAc3ovzmwVQ4y7NoGGw0cWCjV02wyBk29WhEH8B3OYyPfFgsJ+2pL/7mK2/dDGF2Aktqn4oKvU+ssGF1CMDNIQwhSqfijqAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12124

On Tue, Jun 30, 2026 at 06:52:22PM +0800, carlos.song@oss.nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> When probe fails at devm_clk_rate_exclusive_get() or clk_get_rate(),
> which occur before runtime PM is initialized, the clocks enabled by
> clk_bulk_prepare_enable() are never disabled.
>
> When probe fails after runtime PM is initialized, the previous error
> path called pm_runtime_put_sync(), which triggers the runtime suspend
> callback. However, due to different clock management strategies on
> different SoCs[1] (to avoid deadlocks between the global prepare_lock
> and runtime PM), the callback may only disable clocks without
> unpreparing them, causing an incomplete unwind.
>
> Introduce a new error label 'clk_disable' to explicitly invoke
> clk_bulk_disable_unprepare(). Replace pm_runtime_put_sync() with the
> sequence of pm_runtime_disable(), pm_runtime_set_suspended() and
> pm_runtime_put_noidle() to bypass the runtime suspend callback during
> error recovery. During the LPI2C driver probe phase, clock APIs are
> used exclusively to manage clocks. Once probing succeeds, clock
> management is handed over to the runtime PM core.
>
> [1] https://lore.kernel.org/all/20251125084718.2156168-1-carlos.song@nxp.com/
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

In future, we need work with community to fix clock framework global lock
problem. Any this one is good for now.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i2c/busses/i2c-imx-lpi2c.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index e6c24a9d934d..2dc4331ed796 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -1527,14 +1527,19 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>  	 * each transfer
>  	 */
>  	ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "can't lock I2C peripheral clock rate\n");
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "can't lock I2C peripheral clock rate\n");
> +		goto clk_disable;
> +	}
>
>  	lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
> -	if (!lpi2c_imx->rate_per)
> -		return dev_err_probe(&pdev->dev, -EINVAL,
> -				     "can't get I2C peripheral clock rate\n");
> +	if (!lpi2c_imx->rate_per) {
> +		ret = -EINVAL;
> +		dev_err_probe(&pdev->dev, ret,
> +			      "can't get I2C peripheral clock rate\n");
> +		goto clk_disable;
> +	}
>
>  	if (lpi2c_imx->hwdata->need_prepare_unprepare_clk)
>  		pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_LONG_TIMEOUT_MS);
> @@ -1576,8 +1581,11 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>
>  rpm_disable:
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> -	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +clk_disable:
> +	clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
>
>  	return ret;
>  }
> --
> 2.43.0
>
