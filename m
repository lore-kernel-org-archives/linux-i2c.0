Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794244775;
	b=ygOBPGwOSgcVaKSebPony5utTd/X2R+2ztWq8rVCnnEr5Mp4f7aLXmf3yjGOiUq4K7PG
	 wS+b0WkdZjBjZJl3Fjsr3VvXWRdz381HxTf5wJd3ZSBGtdXJkZBGndAzLa9vfZkNjEl0K
	 OOZT0A+v9Sz24O+nr+5E6fK+ISaT2jprVJO5P84L4k5u0lVifN3QLUe5vB0WxwLm1j7uU
	 gvOX79Zu2oo6RQR0q+sZF095FQrJNYwgyw9h31T3mCfVmvWRZtwQeD95BZgkZx8NsrO4v
	 SMJjfm4OZF9fNJDQaqbBvFpZv8p6zj5wpcVJxuUYf3duz0iFyYA6+FTNyWzr8qp7vZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244775;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MMqSTPwyM7+G562MwDgalvr5hNwoPGS/N0h3xKBXGc0=;
	b=bDy89QfMNgk9vAnm1vccoPX171B5Yg7rZ8o1/HvRdQkcbg2GG11bIJsABRSw6YnbNkEe
	 tXn7+iGVeXv/vT4+9h8wCtwAteE4yYEumzR5YWoC4eqtLZEAo3kmY/UMSz6l3vEkQdSWi
	 Sq9Q/XuxG1f/YKDlxGXFbExLr4Hl0pQZAcxT4sWnme1oa0kVDR6uT74Mw99eKTzLwjTLT
	 M40ZFPpsTarHHa50FG9FPed8T/Xuv1ZdSyhN/QDgbqKFIqHL7sqhmZeQ8v/NOJZXxSnPe
	 yQt321O7KM10vCyH89NiRdbGoWlt/8hfuWZopHDR1SeDJqUkPzfYglh8CY5qFltMMSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HSyBbWY8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C1606A321;
	Mon,  9 Nov 2026 17:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F8C1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HSyBbWY8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5AicsPwFcoY3X5HkrljABk4I5lvAIEpuF5YlN/yA8V1AoKMn8kvEEOtlF0Md367JD0EKtD8ZrI+1q0xRvGBdDbBQjlpdio22kwWykHxk/TVuldg+vIzzh/xI9Vr21AOpVAvU/7m2MQrquC2RpuVttDaagyfGshstFgl/njhE3BZEiFXXQIb0nmlkG+3pe8e9Mvkk1dps+L/2KMhxbjlHNDRS1rmUHdRO15goHWVQRcwfcdL4Cc+OsLIiL7pUgXUSuo9jsYEYUk9Fo6LHLpMw8LnmCpq+gTHoUWtG5/eeQhKWwoAD/+cCLhd0gzU1e8JoYmlW3lnQoZJINIWZQld+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMqSTPwyM7+G562MwDgalvr5hNwoPGS/N0h3xKBXGc0=;
 b=T+56Y83qXC3hOUIYQxPJ0uSBbqp8LAInPxoTJItF5dCnRwk0vhM29dufimDheIeSusvvJFF9jb32mG6UYVystM9+Ii0eOlJ8MvM5s9GUMftP7FS58dvTZOYQq3H5vprmZBryRSNMbyB8YMHTXhaIciU64rUZgT9KYVsDY4/VFLZzi84PUR6UyANm7Vu3kc2q7jF6GYey6vyqtXZAxvw8rMxcax+r5DtQWKXzXpj5nmvRKDsluG/WcYrLZububRJUOZ/fGtDUFoPBoOd1vuKNkp8k05mVHdWETNOupo0NUp7CtrNAB0JW1SWtD5U6/BH5Vnl+5bZ3wY753p63yWPB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMqSTPwyM7+G562MwDgalvr5hNwoPGS/N0h3xKBXGc0=;
 b=HSyBbWY8XVEN6/e9ZqN9IMaSI4kCMjOjjWP7QojVATDFar3e0LqgdXZ884wAK3JkuxL0xOO+o6CyXfhpBErvity+sijiJXYv2JZ/OVfs+6B5PPVa7N6e37z56WZvfpZphMLBTACJyEG6PTHkkDWqfqTZn/k3yGY3dP435b21Bvg=
Received: from CH0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:33::8)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 9 Nov 2026
 17:19:30 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:610:33:cafe::4c) by CH0PR08CA0003.outlook.office365.com
 (2603:10b6:610:33::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 17:19:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:19:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 11:19:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 11:19:28 -0600
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 11:19:27 -0600
From: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
To: <linux-i2c@vger.kernel.org>
CC: <andi.shyti@kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Vasantha Likitha T
	<vasanthalikitha.tandra@amd.com>
Subject: [PATCH v2] i2c-tools: i2cdetect: Set I2C adapter timeout and retries using ioctl
Date: Mon, 9 Nov 2026 22:49:24 +0530
Message-ID: <20261109171924.3632557-1-vasanthalikitha.tandra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: eaea7e39-be71-439d-4561-08df3e859d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|56012099006|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4P89PABUpWdKtgsPTGWJ+5Eoe3+SIg3R7wDP6FK+vwfPRWhzQ2FneoVHT7FMNqg0vb8ghLd0Lgt492V0gbxvy2jLKysNAOfXBl94SNpi687lUTlJhHwHBXSoPaVGj3gdig/5qxAKIfKDvULPNeJgb4qYJYvTSlkw0guGfSMxY5bsOfyiZXaQv6F7GJc3Wrmdd0cANijWsWitsmeXJpSUxBccpZpVG92fi7+N1oKIiaDOR0wWmxgvhuh49FmS29kSMDJ0eLb6nhUFPLZPaj2cZ7cKgZV/weVJDHb5NUou998Fro3u14+f3wzSSRCeAvFO15+nSB5B211eO10AFZ7WEECpGZeA88IDSD+nuBQ4xLbSa+kzNqV45epb0kClXmGtYY95vbBL4RWha0UzW7hFntl/ECCRs0Ns3U7LxDoOl5mTtbY049vrgjHo1ihHhcxEXaNaTsWV18qRwiy1GR6Rn2+n+fdmsP5Hf5NmN5JRxrTKEMjqaSvnHlSqeiVbIhbdUoaMHUvRLJDdVCNsbQ++g6kWnyQWPfMJr1GyNTW1i7HRqVhc7P+Uknnr9G5f1kMDxru6X3tCVWiqZkkVU2IlQlWgfVpso2YDUgUZbcllKOl25VAlBBI3oRbaYogfPw0JVNDwb/7fvZGozQDsDF/i8NIioxtrEAJofHKISnNQg77xOnbVEzDDADuT1LucOUZcH38mWdCn/l/wAU7Qg9XhPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(56012099006)(261026140227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u/PKHyo+xJh8oQLW/cOgWQCS+AxaupUZajIVaKv3DMxsjo4Y+r2n5pM5YuSZ1auolW05dPKpcGXTbIamqpzF7SL2sZQBpDTOBqs/kaeu2TGTgww+ltuM29qZEJFcXJTk6Jbry4CNE1dmQTKjqoRgwUc5dW8qVsBL3NJV34y3rd4fzqrHMA+O+R2FhFtAaXTQN82TeBy1++FvKjkvTzDtIBrxZfCzsK54z3kM2OLGkKCoLRlCWChz/gN4Upf2Hm/rxIHU25S1/9/YT1d83PdCeKc1ILNVoArPFfr5u/I+e1Y0h/QAe8de4QrI4pgNt0uEk9jru5QN4ZZHldtpkHCw1RfJ2mrq0sCpeCAxtmz2MFC4F6x007JMwKnhK0yPlSniP4huM9Cox/dUZGlrEoFCaB+1KlE+/+oSXYFejkKU2NvRI/7zCHLWv7x/XpvH3Dd8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:19:30.1236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaea7e39-be71-439d-4561-08df3e859d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

Add -T TIMEOUT and -R RETRIES to i2cdetect to set the adapter
timeout and retry count through the I2C_TIMEOUT and I2C_RETRIES
ioctls before probing the bus.

TIMEOUT is given in units of 10 ms, as the I2C_TIMEOUT ioctl expects.
Both values are applied only when the option is given, so the default
behaviour is unchanged. Non-numeric or negative values are rejected
with an error.

Signed-off-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
---
Changes in v2:
- Move the change from i2ctransfer to i2cdetect and add -T and -R options,
as suggested in review.
---
 tools/i2cdetect.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/i2cdetect.c b/tools/i2cdetect.c
index 3c22f17..8b08e55 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -35,11 +35,14 @@
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]\n"
+		"Usage: i2cdetect [-y] [-a] [-q|-r] [-T TIMEOUT] [-R RETRIES]\n"
+		"                 I2CBUS [FIRST LAST]\n"
 		"       i2cdetect -F I2CBUS\n"
 		"       i2cdetect -l\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
-		"  If provided, FIRST and LAST limit the probing range.\n");
+		"  If provided, FIRST and LAST limit the probing range.\n"
+		"  TIMEOUT sets the adapter timeout (unit: 10 ms)\n"
+		"  RETRIES sets the adapter retry count\n");
 }
 
 static int scan_i2c_bus(int file, int mode, unsigned long funcs,
@@ -220,9 +223,10 @@ int main(int argc, char *argv[])
 	int first = 0x08, last = 0x77;
 	int opt;
 	int yes = 0, version = 0, list = 0;
+	long timeout = -1, retries = -1;
 
 	/* handle (optional) flags first */
-	while ((opt = getopt(argc, argv, "FVahlqry")) != -1) {
+	while ((opt = getopt(argc, argv, "FR:T:Vahlqry")) != -1) {
 		switch (opt) {
 		case 'V': version = 1; break;
 		case 'y': yes = 1; break;
@@ -235,6 +239,23 @@ int main(int argc, char *argv[])
 			}
 			mode = MODE_FUNC;
 			break;
+		case 'R':
+			retries = strtol(optarg, &end, 0);
+			if (*end || !*optarg || retries < 0) {
+				fprintf(stderr, "Error: Invalid number of "
+					"retries!\n");
+				help();
+				exit(1);
+			}
+			break;
+		case 'T':
+			timeout = strtol(optarg, &end, 0);
+			if (*end || !*optarg || timeout < 0) {
+				fprintf(stderr, "Error: Invalid timeout!\n");
+				help();
+				exit(1);
+			}
+			break;
 		case 'r':
 			if (mode == MODE_QUICK) {
 				fprintf(stderr, "Error: Different modes "
@@ -326,6 +347,20 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (timeout >= 0 && ioctl(file, I2C_TIMEOUT, timeout) < 0) {
+		fprintf(stderr, "Error: Could not set the adapter timeout: %s\n",
+			strerror(errno));
+		close(file);
+		exit(1);
+	}
+
+	if (retries >= 0 && ioctl(file, I2C_RETRIES, retries) < 0) {
+		fprintf(stderr, "Error: Could not set the adapter retry count: %s\n",
+			strerror(errno));
+		close(file);
+		exit(1);
+	}
+
 	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
 		fprintf(stderr, "Error: Could not get the adapter "
 			"functionality matrix: %s\n", strerror(errno));
-- 
2.43.0

