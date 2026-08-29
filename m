Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010019.outbound.protection.outlook.com [52.103.23.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE11A267
	for <linux-i2c@vger.kernel.org>; Sat, 29 Aug 2026 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974235; cv=fail; b=hOqopCb43D1tVhdUXVj/ZMKDlWa7/zBsE51LU1tvQ9SXU9WgBme7jkvq2SbWliB5a3GxXHYcJswbPFpxue8SNTfyTFtpMO8bHkmzRSl5i56vbhplqRWFfmPHr9GKRsCqcZCblnWml4W0VzFjSnICJhvbFo/LSDT+52/s7t9Cy/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974235; c=relaxed/simple;
	bh=/1ck0RziGRe1xN7HCj9qdjCnmMDZY7QEQ04zThwjUDk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G97PP8kPbHptNm4hjgQHNWL3SC2r1VCEKJT2tz7agGYzFPFOxHedTvnfNg8O40b34OiF3p91k3EqoM2Rb++ezOZ6aQTDxVK+rixS7o7Ys2uf0jL8dpNxBwfCaDUvZaWd+Tn/920rh/CvhBgGMOM0l4Jmdq3RF7gzA+yeULySYos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qHh4EOA8; arc=fail smtp.client-ip=52.103.23.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qHh4EOA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5eXkWUX4TL1FcWBNS0fMW9OvYkkPYweplx14otNBF2v5UNoBf0ThwkCEhQtvPczQhvCRUy2z8b9ZNvomncQBTeelgbu7kvYh78+BRoynQFsztTLLwhva/mEv3VITtGA68ct70zwYgycoiiOW5YQjguC3r2a/BnQsWqhXdbq0TcfFfS3SD6zQKKxzGVE9HX0p9A5tKOqBQo42gvzGYl1yPIYoFcY9j4DQXbtWKVZkXbSy5R7NGg/3dzYSXxcbJRikpuch40ONYDh1BjgNuFvjz7/zDubRTnuStyVBau8Kbfbvqc127smA4LGdzfKuL0gHg6CwCkphwiFpSPB6qsibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txI4/8Zy0Z8h06lvGRNfRMTtKdDPifflrPKQyl2PbdQ=;
 b=rY/5EhZpJ8HA4Neq2f3gssedebYvKhtG5K2e8U306XGiesUfZebbLBvSz6XW8L1GnVDqijXZ8McgBuP9z0sP7yXXIo6Hlz0CLu79CbcLmMBoSd8VYLk5tewJAwTwvSovxEb+kmLva9q4BnKZrWk88Ywf+0Ifio0MtZd59bWCTL5g14+hRlzMioCRtN61Sb6/+8ZflXeE63b1YvLjg2ZZdvKuq7M5dMe5vBGhqVb3nRgGXZgezCnaf7wiCIfGZX8Ep12rvvWr3BKduHFr0kGM2BCjw4LxDMlf/zPn711yCMvg6lOBUUtQcbvOjv6wj2Y31yqkXvTV9jZ6fnoMGfVn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txI4/8Zy0Z8h06lvGRNfRMTtKdDPifflrPKQyl2PbdQ=;
 b=qHh4EOA8lK2lANJtM1Qwlcil3N7x1QGo2EaPVBB4FhioLUQ2q3JYcOEjJjQ8Do8HvbNtOhv9tnzn0xiqE95lprR4MrqGCo2R89vHKp56/NWU/996dy7p/z31uV+hYC50ZKacr1ZNRIj4kDaPyPWsHeYjNV0Elwqm9AO4AukP+I5T38g5ogqPpAx7I7Cw0q6EepW49/CLdKAVgUJI2YOYFkODfb7+e1I2boinnRebMJ8cP0QyWlUFqO4/neTfOIj1cAuQexDT5xr5dzZocPhHG5eqAcT7PDkjC7KgybnlLTXX/954jj9EO0YMW+gl7yN77clqJffayHuygu7RBCErig==
Received: from SN4PR0801MB7774.namprd08.prod.outlook.com
 (2603:10b6:806:205::13) by BY5PR08MB6341.namprd08.prod.outlook.com
 (2603:10b6:a03:1e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:30:32 +0000
Received: from SN4PR0801MB7774.namprd08.prod.outlook.com
 ([fe80::d03a:3b81:3c4:bee9]) by SN4PR0801MB7774.namprd08.prod.outlook.com
 ([fe80::d03a:3b81:3c4:bee9%2]) with mapi id 15.21.0315.016; Sat, 29 Aug 2026
 03:30:32 +0000
From: Frank Ng <frankcng@outlook.com>
To: linux-i2c@vger.kernel.org
Cc: andi.shyti@kernel.org
Subject: [PATCH] i2c: Force ELAN0672 touchpad I2C bus freq to 100KHz
Date: Fri, 28 Aug 2026 23:30:24 -0400
Message-ID:
 <SN4PR0801MB77740BF9D34C2ED8B89CAA75C6AB2@SN4PR0801MB7774.namprd08.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:52d::13) To SN4PR0801MB7774.namprd08.prod.outlook.com
 (2603:10b6:806:205::13)
X-Microsoft-Original-Message-ID:
 <20260829033024.775932-1-frankcng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB7774:EE_|BY5PR08MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ad228d-fe3a-4a9f-76de-08df057de13f
X-MS-Exchange-SLBlob-MailProps:
	suo+AMQROd7awkY+uqD1IG9kXGqTcr3cPT/c8oQizp3kw7nrPzFzF6tEikrEfIMIQZsQR/+Ca6f8mbkjPo5aba8sn15qgA17B+2rv/VF2Ch+zT01SlWZMg2uj4tFsirZ255N4CiD059NNxUWQCrUXjVjfZE03LH1yngQrsJhQo1M2LRik3Y/y6ljvQsICQJY42CqP4Mg2IgGTYMck8qLxxD+89xFmFlY2Is3k5iUKpiZb0ha3iFZLPh6zVoJKmmaM4CDtP/8WttasPQKSazt3XcXFeNWleBPcMKxqZ9GqmWC6OE8TDsEKIfUweWm4Gcoiff+Nezt2SvfmFqg0BqYfRTyDl9apw0HgyKtbdE0XnP6SkQOJheedSLTrCjr/36/sNLiP8B5WwqDhiiE3G5a138i/lEhIAsyMQD8n9roahRsJrso4p7lsrmvszoyRpIZvrb/L6BjuXJlaW+bShMgX/NZJkpdYjIYnaVqtSAPHa0RFqzwcWWpOQMmFxxqWtz/LDesEM54YGiDqh+hONzZnGSGyLgPm/aEDQydp/4waMUr7cAJFUWDrCoOj4ET36GSqU1dzcSyql7cMnnish5zdXNdTL7KqVX4Fn0RNxpG29F+7gChowZ0WyfIUaEJQcBXheRtsExuBmeY7tdFsfFS8/DWDrSWT1C6pDX5ZsNqmFJHvElaqYzhO6GJ8y6DmClsKYzj431W6RyBHFyLFDSHusAwzF66fETC2fSAcCmDganhpSzfTm7IMvkU72FWzk2365ymNdTmBgTY51Dq5v5qCj9qTI122qCa43TX5aQOOJGqZTVHkE37f0JrUPLxrtHEu+KvOW4uRgZvxA2QiTDekA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|5072599009|23021999003|37011999003|6050399003|19110799012|4140399003|8060799015|5062599005|39105399006|24021099003|15080799012|20031999006|3412199025|440099028|4302099013|1602099012|40105399003|23121099006|3430499035|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?At3kGd8tiph3j81An42nw+29ixPfOOjp5O8BtotRZW7Y+I2Jhdu3iGA8E7J2?=
 =?us-ascii?Q?/6DaAlE8fAgbC6AewXCEI73yX+hjmhaoZ60dlD7KZ6pAZoGNUIj86mSJnvVh?=
 =?us-ascii?Q?tLE1HTDqOSnoalp1IAphjb+B6ZCrtsfDDkqtCSTTeKZ+tMgd3xW+y2H7SuFu?=
 =?us-ascii?Q?GG8DkYUuchuHug35YaXX0ZyoMmd4mjC3YRyO9Wm5GGx/S6+dCxnVvU09bQ76?=
 =?us-ascii?Q?vufHptMhESeC92OxyCu6TjdSsaybDmsNQAGcTS0HG2IAgjcC8eZ5HfYOLTnd?=
 =?us-ascii?Q?Ra7EcKEX6OVQJpdae3JXAMRO2z5coBcVJi1tH2qURPZeg7IMjoNR39hNy8w2?=
 =?us-ascii?Q?/FQLv6yRjZiGKmj+x0rBKT0Qng1rppBYXXSFQqXkQJ/+u37McjgCQMZsPgGj?=
 =?us-ascii?Q?r78IXgCIPxndVUTX3z1O35m9K9x+6QsXCHJWwjQHPM96/FKFsxvODkmREr6c?=
 =?us-ascii?Q?7Fk+W76rSjSsoIksEmY1X7zlFSX8XxEG4FiIXk9BDNlLbarOJREP9cn5sorT?=
 =?us-ascii?Q?J9Evc3d/zGRt7+0w7EEyC6i7BuiQfppcv6fyv0z0T8WEWD2Uf2y3ip3sfb3p?=
 =?us-ascii?Q?co2XfdgH+HJVl0u9DdkXZ9RxGVb5Y03FPklArSiInvjaH9FQ6JBrkhSnX7TA?=
 =?us-ascii?Q?MbnlMFR6pTgO4TSSmZQZCxrGk5fIDxX3TMsUwNPhSHqssy/R0RwEWvXqinVn?=
 =?us-ascii?Q?5khRvMMqzui4jQfoxj6PBirtpO6aTEtxDq3X4IY6piDDy5nEoCm1vy6cMfJc?=
 =?us-ascii?Q?oAaLKXaB1U3xfpbTphMvp1deQFe0Uj3poor2F4oSZahmgRzBgjEmFELFXbYP?=
 =?us-ascii?Q?R6sL2YQ4Na9SvTA9Md/+50UvCLyjkD1gf+nwW7CapbS/hkHk46c5KcZ+tNbw?=
 =?us-ascii?Q?/evKk4cRWK2EHwZTgxDOgTGCxQffIVRnPUXZNdmSCTFf8GNp1iKniIvOYGb+?=
 =?us-ascii?Q?57jK9p3+qfHkFdPRGnZ625l/VjD1UXu4A/7W+gk2N8lxYRChK/y60IxZj4gI?=
 =?us-ascii?Q?CWYSkROHdQURpJhcEMVCiDw2hA+2jyVu3S7netGXB2t9nkq5RJzrTsp50QHd?=
 =?us-ascii?Q?Y2SPUan4MNvGuOEQzeKYUmBwxXNsJ6tXLasMx/dpzksO5PQYk7bhB6hPX588?=
 =?us-ascii?Q?e63/WIZPapOh84IMVee0VMAYcKvhgo7mUpXy0YUxokYfkdd42drXAuYhNOVa?=
 =?us-ascii?Q?CpM3IjELoTjkAzgV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4G4feBKvuABMlimiOIbsYnA5Q7qs4P53VaGnuuTAiWFY59dEed+EU9y2KlIV?=
 =?us-ascii?Q?0g7gU8s9PvHqL13LLNsqTrvQUHIOC0NEiM6NwTCIxX5chCoYypvec4S89gWA?=
 =?us-ascii?Q?n72bTGjksvvgsoutpVwpa+o8i6GG52CAlsrmJg4TOfF/vMgLx7DH5SAL/67j?=
 =?us-ascii?Q?t3P4KAVBwfTq/NOFTt3bnFu45hpTZGuqxBvcf1eDfebmallM5pWvmT+LF1/N?=
 =?us-ascii?Q?iKTO7n1TiCv/fVi4eEZb/bNDclsuQVdsRkVOdg4qp9LFqCqI464F6ldn+e7l?=
 =?us-ascii?Q?3ktCSYHBTM2RNH/5TDtG4cTXLrN50fc6JsqRBAmWwjYYDKuHozyvFFpUttZH?=
 =?us-ascii?Q?OX7ojV1DmjnkrL7wNfX0GegwY1IV3JtzEO2ih9uOV3Jy79Gi646CiteK+i46?=
 =?us-ascii?Q?cyHLHatkQsIosjoDksTlWSwTYMSiXn+PruzJXyTQJIJ5c3qddsB75iVAqbA/?=
 =?us-ascii?Q?Zde2Hpu5cE1uQNapRWG35mNzDesrFYqW2tGYyGYc062n7eLqMFghhsbyL/c1?=
 =?us-ascii?Q?r85kM6yV831PsTQh9RUzBjSheYPIHCZd6kGzdyggLy5TROJSrMoImS8G45XF?=
 =?us-ascii?Q?o2IK12ol81Om6QQcSMe50DJNF1mq+Fwq6vW7vHBbLcgMx7MlZGIK6EbZM37F?=
 =?us-ascii?Q?pOZW9jnUQqIbqbKvLM5043YWd/04KIbYj/el58Yt0ZFRqV8GWTEf2OUOlC0I?=
 =?us-ascii?Q?OEUznIvTVoCxB2z5ANVsfX2T5c0doqA89WUodT6b6iN70jrsnk4g/15/vx6Q?=
 =?us-ascii?Q?HE/ZuvUU/0SFzSdleSoTnouWuXEPJ9rahKXGpyHgglfX5LOTQ68rVxwbaXD5?=
 =?us-ascii?Q?YobwGYoRBWhFPna/oX58Vvol9ZT22tQcHNKnW4+prZxx8g0MJ+pRHYqxxd16?=
 =?us-ascii?Q?y/nGNW3PSlJJtBDLg5U5RbnEB5eQaZ05PkCBnOnKmDuWICpnwAxrReMdRAqP?=
 =?us-ascii?Q?qaHEalbQfRFEmm8R80zVJya33apZ6gv87YJohmzNsA/1IRyVzH5PjiUAsO7J?=
 =?us-ascii?Q?ffxZEUy0YbK5m0sjzHpSIkyJdV20YuGLNxFn+v61sFP7HQDk+SLOL+IaSv6p?=
 =?us-ascii?Q?EmIhpf+hV7k5LZGcP2bE7eJQd7V9rVL7jD6doyRpKJU8AxivF/eom36ltWic?=
 =?us-ascii?Q?p5UwyNhpQBXL+nLQnm9/rMwdabfwvoCAMwZi9SkQiT7n+lz7ixv7jx5EVYoU?=
 =?us-ascii?Q?UFqexFYCgImAZ/jfo7aSr0dvToEUxf29ku1iYwvGTTe2TS/maHSzsueIPtqx?=
 =?us-ascii?Q?2f+rZ30yNHkPGr7pXckWOQYCJgvwK5RmLbviEEcplSAiWAnqti5jAF4Xm+mu?=
 =?us-ascii?Q?2jRT32UF4CaNuJRGzxcUY2bOYI8ULK+22LM9v7E3WwBpAPAaUgUxe0AgbN8O?=
 =?us-ascii?Q?tMWY63/mAXQszI9FkTAnJUknDsWvYPmGLGw6OvSjSgisH1J/fSkliKQOYavb?=
 =?us-ascii?Q?+Hdb0xNGLmvPuks0EbTwVLeaUaFvBwIG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ad228d-fe3a-4a9f-76de-08df057de13f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB7774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:30:32.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6341

The ELAN0672 touchpad (04F3:3187) on the Lenovo ThinkPad X1 Yoga Gen 6
suffers from the same defect as ELAN06FA (kernel bugzilla 214597): at a
400KHz bus frequency the controller intermittently emits corrupt HID
data (phantom contacts / frozen tracking IDs), which shows up as cursor
lag and jumps on the touchpad and as lost palm rejection while typing.
Force the bus to 100KHz as a workaround, matching the existing
i2c_acpi_force_100khz_device_ids[] entries.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214597
Signed-off-by: Frank Ng <frankcng@outlook.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd50186e..03ac38a8e967 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -374,6 +374,7 @@
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
 	{ "ELAN1300", 0 },
+	{ "ELAN0672", 0 },
 	{}
 };
-- 
2.39.2
