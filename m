Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376543E093
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565260; cv=fail; b=DY53N1fGzUp1z2hAuMgrjWjRnRpn0MqCJKHjtoQfDGMM1++Ta1q+o7zT7jKaYs/+8s2pV8alJQxIfFT4hcUBBVjEbyELG441FxHa7gdj3h7zwDjFzl7gtznPxW8VueeSNju7lyxq31NnKhK9S4D0rAC0DEeoZLeDZzDsQxbQbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565260; c=relaxed/simple;
	bh=bOPTxlJUehZ/lTDA0DtQCVwoYkjpBakSUISRboCe0Ls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IdN2HXYFexW23qp0/+SBYUNlc3yllB+MnKs4noE9JJwPBVGHxmblu+ipLkYuBdVkeKZCXWDEGQDo+yfr+1JNWoy7gCObJQXUY99zOF105nDDhP1sLMjuJZlT1ba4xfec2KD2gsZc49UyuLopi0Mwri5uj1rvnpfWdIpQuvD++Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2zEcqg8j; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2zEcqg8j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU7geKlvata2xvTRJm/74cyZd0JBqsaUcfNWqWrhAfK6BfPS7gHQyagF5GMmuWD55JO6NjE9J+gzW7Wu36X5ehBoSQp6WWXrsLIWfot4ZaKDcGebiZy7ZTlJMlbtBVt/Ty5X5n8b19HxbmH2GwjqJwJYEUEwNHt+WhMJP9anEy76sozetw+OUD791AXBzkCWc2qlXH1WTVFMxb7mXABvPekWsmMRq7CW7XEbZw2O7TTjvlQ7vs/hMPzm6ov8GCYYdhdkc1l3+Kv4G+jirvl4RnbC9DmySrliXo3SBrsT3HLqYStKscyQ5FlW94488C7rPad9nVp5XZarHRRV3wTykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tcJ+vJlPsuqBmJfkMwkH9sItDU1hRjOPgWuWiw6eY8=;
 b=lQnscNzHIko7EpM5HF/yWmU1gnaKii8n4p3ZXwG3ESOCM9Gv/lzVIwSnWMeYxPBSidvI72GHSaWL90hqfAS2Fjaju/nJStDFktSrbxG1WtqLPH4ouUKRR8ojInOur1416DLYaU7Tot8z2sbnuroofz+uPyqUfS89eNfw7E3xtYoIjqh5fznv+knQuckEg2HuQN5Yh517ZENE96UxQem2UD+fGs50ud1AcGQQ0Q2FpLc3LFZqDnck7IAJmIvXIUBxjtsqxfJw7LkuUnqfLlVyvXFoS21sqB1HqjD4JPcq6AUf168vMDxOVPj/KA8GGvARCCKna45J62gA333pRbZNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tcJ+vJlPsuqBmJfkMwkH9sItDU1hRjOPgWuWiw6eY8=;
 b=2zEcqg8jjQuG873Qa9NnkIS2voDMvfcnZwik59bSL4fZRa26/pxieOsUV4JJaKf1PN5chN6S9Z9NVLPq6nLn6qvXzbB8degzdEm5uiIjmhgIqyLwhOY2NVOXITcivL93ObheYo4BAs6PQi56V/QcMredd86sAxLp2DNqFVBof/k=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:34:12 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::77) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend
 Transport; Mon, 20 Jul 2026 16:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 16:34:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 11:34:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 09:34:06 -0700
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 11:34:05 -0500
From: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
To: <linux-i2c@vger.kernel.org>
CC: <jdelvare@suse.de>, <git@amd.com>, Vasantha Likitha T
	<vasanthalikitha.tandra@amd.com>
Subject: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using I2C_TIMEOUT ioctl
Date: Mon, 20 Jul 2026 22:04:01 +0530
Message-ID: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5afcb1-1474-49ce-3635-08dee67cbafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FdNW29pomDMYYJXJJfijjuc1Pd4idP2W519jF0r+j9WJJIf/2hwMWseqxiUR66As2mZNnpN4rOtD9izBjwVvWJiJCBiXCpyqLtjCtGH9RP9Jej1+LpyMMAROsot0btQvr7RWjPiQBzHdBwrZfHH1cy2mEU1E1/J1TQrAArRw/OifhEO+ftz1bZyANFSzMqrBJ524ZmxSFcwQpjW8xFYwXciooUmR72qBFaNLHAWC/LvZSpKW+XNWMvuzi1kAk9emKjvbkOJ6XNC0aDw0XQr7IRLyXbVETasGVbfVahbh6ELEPeH0rlXhC1e3u9fIG5tC4R93Tyd5Jwx2J5I7wY6JArAzvZRbZXZ8vWOhGm9rrP3cDb55+V3Fobx4ABVkD1ki6mK9EBZuYoyLF+lvOhp1a692w2zAzMkjvfKwgcc2aVWXZsKTjbQitN4/ntLRgFpiW+joVYWKTEtbQTQiqtxAZI5oABPvP22qSwVREqFPbkZgkC9X6fa/IifIk8Zqf5uYmfv/u5zZt5s3aZ7Z8Tp5AT5BcLcg2qLePOmyztFEXnxr/JHI0TtK7q1M4Qw6JDEnRAkAPqlB4xbzG70USbbk7c0BW8WqobxlPGmtxT98Gw00Pdb1OQv/fQ9FbXCmng1dJdUyGFPgV9OlCGVXcjlJ/dtVMIJD4msjtTlocramUFXHns62gdt+KYs7gg/zLOo2JmxyUyaeDkjc3t0LQyjWNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lN5v2OEoO+IuB4zeTqYkGeZ1zhVKX72WdAHVjIYglnKiGgUhPuPEn5sH2jpp8dgOzV9ys8WlO62+nzHir3nvLDuSTppAatC0A/yqEU0VzdUTjioWxuVldkSF903gNaLcCFrdxJbDokjLUjxyakBQx6WwPrr5T4jgE84CWIZMjdxjhHbCWre+1iN3ijXVnC3iYRlKXKZueXzN33NsMhJfwoMykYEfzunynlzWQDoM91qzbBd1A2by/+ASrCaprLGXlufLAQvGZF3iEQt17+20mVSMhKFsvmTqwWELIMN6DDq9LeS1+yuy7+7EmBkmdWyrZJiHDbmDGYsmz2k1zOPKqwzBabRdfmiHYkrl9nr1zLN823ZFy5WZ48PB4CdUHNMwHdLiLGi90K0VbObvytOWvs9zif3NfBVWCOszKZBeS0JlCC4i4hB/n33IOIfs9xZm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:34:11.9984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5afcb1-1474-49ce-3635-08dee67cbafb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288

Add a -t TIMEOUT option that calls ioctl(I2C_TIMEOUT) before the
I2C_RDWR transfer. This allows the adapter timeout to be set from
user space at runtime, controlling how long the I2C core waits for
a transfer to complete before returning an error. Drivers that rely
on the adapter timeout will use the value set by this ioctl.

The timeout value is specified in units of 10 ms, as this is the unit
the Linux kernel expects for the I2C_TIMEOUT ioctl: i2c-dev converts it
with adapter->timeout = msecs_to_jiffies(arg * 10). Omitting -t leaves
the driver default unchanged.

Signed-off-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
---
 tools/i2ctransfer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index 5fe44fa..f2c9929 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -59,6 +59,7 @@ static void help(void)
 		"           -v verbose mode\n"
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
+		"           -t TIMEOUT set adapter timeout via I2C_TIMEOUT ioctl (unit: 10 ms)\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
 		"  DESC describes the transfer in the form: [inpst]{r|w}LENGTH[@address]\n"
 		"    1) optional message modifier flags, if supported\n"
@@ -281,6 +282,8 @@ int main(int argc, char *argv[])
 	char filename[20];
 	int i2cbus, address = -1, file, opt, nmsgs = 0, nmsgs_sent, i;
 	int force = 0, yes = 0, version = 0, verbose = 0, all_addrs = 0, binary = 0;
+	/* Adapter timeout requested via -t, in I2C_TIMEOUT units (10 ms). 0 = keep the driver default. */
+	unsigned long timeout_10ms = 0;
 	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
 	enum parse_state state = PARSE_GET_DESC;
 	unsigned int buf_idx = 0;
@@ -289,7 +292,7 @@ int main(int argc, char *argv[])
 	memset(msgs, 0, sizeof(msgs));
 
 	/* handle (optional) flags first */
-	while ((opt = getopt(argc, argv, "abfhvVy")) != -1) {
+	while ((opt = getopt(argc, argv, "abfhvVyt:")) != -1) {
 		switch (opt) {
 		case 'a': all_addrs = 1; break;
 		case 'b': binary = 1; break;
@@ -297,6 +300,8 @@ int main(int argc, char *argv[])
 		case 'v': verbose = 1; break;
 		case 'V': version = 1; break;
 		case 'y': yes = 1; break;
+		/* -t TIMEOUT: adapter timeout in units of 10 ms */
+		case 't': timeout_10ms = strtoul(optarg, NULL, 0); break;
 		case '?':
 		case 'h':
 			help();
@@ -475,6 +480,20 @@ int main(int argc, char *argv[])
 		memset(&rdwr, 0, sizeof(rdwr));
 		rdwr.msgs = msgs;
 		rdwr.nmsgs = nmsgs;
+		/*
+		 * If the user passed -t, set the adapter timeout before the
+		 * transfer. This lets the timeout be controlled from user space
+		 * so its effect on mux arbitration (e.g. pca9541) can be observed.
+		 * Without -t the timeout is left at the driver default.
+		 */
+		if (timeout_10ms) {
+			if (ioctl(file, I2C_TIMEOUT, timeout_10ms) < 0)
+				fprintf(stderr, "Warning: I2C_TIMEOUT ioctl failed: %s\n",
+					strerror(errno));
+			else
+				fprintf(stderr, "I2C_TIMEOUT set to %lu (x10 ms)\n",
+					timeout_10ms);
+		}
 		nmsgs_sent = ioctl(file, I2C_RDWR, &rdwr);
 		if (nmsgs_sent < 0) {
 			fprintf(stderr, "Error: Sending messages failed: %s\n", strerror(errno));
-- 
2.34.1

