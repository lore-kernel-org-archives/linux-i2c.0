Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023089.outbound.protection.outlook.com [40.107.162.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4183ACA62;
	Mon, 23 Mar 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273999; cv=fail; b=anyvZduQIflvnl5lRsCcDxl9cVghKY4nhmeCChxyPupSxsHO5csuBzMX9FrPtJfJ1K4xDc4zYttwlPdA76cfiMe+VZzUOrfWql2cpCDbotRbf5oHnwG1J8DORdIFwpXcdVfUC+dT8A/DCrEDGDVKxhnJWLQ7rIsRCYmGLZKH1v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273999; c=relaxed/simple;
	bh=3j96NCvKJok1QXS4XbhNXK+wHL/X115nj/WNVLdnJ+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QB5SA8KZP7FgAAma0XMGZ3PmYei6/CJo67RhMD1ocwAgl8NaIu/tPsKeuNNp0Ivoio5hbJM+TGqnxHl2urjYl/M8hk7Bu2EtCQzUTLXZGhEqZAcyh/e6jJUTy1QFv0KW3uuCsKhoCQecsxhrW7Mv2Wus2lt+7XHAj8euoJvaPuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=KjFMNvba; arc=fail smtp.client-ip=40.107.162.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="KjFMNvba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM/37hEnKVigoo23coI06RetnpDOAJBW/AKaaZjAv+dHYIZEInvJe+KFe8K1VD168JZvlwBfpfpUDwPGMOru1Ld+m9H1UlqTHkFs3TR+SvAa+fGBlPrl9c7dbJZMhRE4T2oL3oyM4DZB5YfCEUK8N3Zez9dlq9gXCX4oa2H1E8QWc7LnAw9tTOArljBAS5eb4y/hrnopDb3w/VwIEkPwHhbhuhmtViVF3rHc6eD3YbiVTESV81eDlsvQGWhMvkqUBf8StrkuQ2I7BW6NN8mMC5bRAa1Ac8kZ9+Kt0n9MVfXFSE0tktd0Hih040zc+K1t0ArflMtjcJkFaEPu7TDhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G4/fptXQoKzJz2eILYuhLPx53KQV3SdGHr1Frv2fKk=;
 b=SZeUrehha86eT4Ay21fyHtzg+3yNVotzMrkcYsfc6GL2W4T7LB2dr94nKEJhcGpe2jg90GpmGUc4w4j30phYU5MBk0COjhh0nzZQ4zaAniFH6gGzeJHl0hdyl2Spi+f+UWMeVRirptvwWZ2G0h6Ru6JS9EfwH7lUeSLag+Km7lPjBJ0tDVuqc8CWbrAH0e7tKuS7JZUqM5Uqk/aiXcMn2AUeaITYMmyrOwlNDPzabF7Cm3iCl/owmBawFZnxPVNc7E9p/mnrWpNB8GAGyFb8OJLTcyibtFmm/oeTd4Xf1GVd0yKDcDT4CprNk+z/t0KGMV7T/1zPDoRqFk9eB6cDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 185.67.228.71) smtp.rcpttodomain=korsgaard.com
 smtp.mailfrom=bachmann.info; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=bachmann.info; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G4/fptXQoKzJz2eILYuhLPx53KQV3SdGHr1Frv2fKk=;
 b=KjFMNvbaqmvNxziVjRb0YomqbzS13t2VE/+uiiDGJHIWPcQ2woLNiNbud+iwnCr8We4BWdLAcf2E7odvLGHvfCsQ13co2oeom0tgtj9vRVemphlfkJwnovrA9kUYwQ5bqBUJoEGWYbyZz97csFgmj3trGqsdU9CVvnRPW1NUrTE=
Received: from DU7P194CA0018.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::9) by
 DB8PR05MB6714.eurprd05.prod.outlook.com (2603:10a6:10:13f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 13:53:12 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::e0) by DU7P194CA0018.outlook.office365.com
 (2603:10a6:10:553::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 13:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 185.67.228.71) smtp.mailfrom=bachmann.info; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=bachmann.info;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 bachmann.info discourages use of 185.67.228.71 as permitted sender)
Received: from webmail.bachmann.info (185.67.228.71) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 13:53:12 +0000
Received: from ATFKPCLXMAAB.bachmann.at (10.204.120.2) by atfkex03.bachmann.at
 (10.10.10.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 14:53:11 +0100
From: Martin Aberer <martin.aberer@bachmann.info>
To: <peter@korsgaard.com>, <andrew@lunn.ch>
CC: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Aberer <martin.aberer@bachmann.info>
Subject: [PATCH] i2c: ocores: re-check status after poll timeout to avoid false errors
Date: Mon, 23 Mar 2026 14:52:49 +0100
Message-ID: <20260323135249.550925-1-martin.aberer@bachmann.info>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: atfkex03.bachmann.at (10.10.10.31) To atfkex03.bachmann.at
 (10.10.10.31)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|DB8PR05MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 3664aeeb-ee78-4fbd-6d21-08de88e38613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5GhBo9XZYmI3FlYfDyu3hy+U9KYdx56d8CzMdLrNLNRWCIK/e9soFa4GYIBT1rrEnKLXKwddgsNz1Avhl9lncaolMFh7afg4K3C+xSovzXWkdNu7uhPx1vX/3JB1Qy+VP8AP3KFRNOXWAZnRh2mDMWZ9ojh1jJJgw6XkX1t0BwzYrSomcq37f40VAGBp8/J6BkAP61BfHJxMHHc3R2NTJWg8L/4JL68XsqWTntkYQ4MsI6biFsuTj1t3HVfCh3TfBqmGwu9ALnDNP8XxUcHtpXpjv0u5snib5AKdMVAiwuxsuLYAwzUYkA3ttPUG6JHooftFtGYIt3pJhh+w7+10r4XlmtF+5lSUj4vReQYXb6V8hg9WiflVxuE+Cy4HC3Bq1azDI20n/zlugoNvkkiQVwDWcudVoy4YVHV9c4rJ6B88mMcE7qMrxgjg1fcjrMTmiCvCO3VC5ReEypNJNSEU3l58fEmV1SmL8p21XSzeWXgXG3UmtTYSAw/Ou3f1Gg3eLNbOzdYlhpvC+pBad1NtkbUg/z001A0IQmJ6wHDTTIVQJWQKgSNcj/yZKZ+D2tQY1KBw8gH+4XEN/QNS/Qe+vI49kCjAtqpaT+P+smvhqae7B0GeUfOlitJCrlDsjWfRG5WIIItViuS2JrCV9g7ATWoQdoXdlJLY9yGBLHdPRwoeB/I1lXAQepLLbCWyvOfgVNlUC66mj5D5NaUEtp6a0808iNqRmU0B2Ktd8+1ZU1VFUHCTfo8/w6c070A441EGvo6nVCa9leMJGNVZ5fTtiQ==
X-Forefront-Antispam-Report:
	CIP:185.67.228.71;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.bachmann.info;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fyeN0T9pF93ov1Ny/xPlKJQ6YMggtjNO2ZRZ3VpQmy/Gk1MNf7aofeJGR+5wwWWyd5m3VkWo9209QhGSKxdCoF36ygXPP1tKXHMKr2tf5B7KUz6/HsjMpn8gINQuwO0ut4eE28qqA+pzuYTp8H52s2OEqnKPpITx2Cu5sptKtBXQrCTTpRzP4cp7KWmyF4YqSR6YSdtuJz608vlRdSOUfHxQmHzsr4aYBdqrlXvoC0+lah2j0mb0HKgAHNyUcj4n2zbPHMn8l0budNj4nQFCqK3xPi0ONQAVAxYP+Qmw0/dNWyXZImP2UF6DzrsR+nEwb7rafKBAK5+za51Sf+OA6fwIHkeHWcwNmbiKVRcvzvP3d7oKty93b2XXQ0CxIXQMuGxW4KXTVS9eSHXRUmxoYCKl78QCx+kdPesTlvuwiQxoRath6Nw1VceeoXlJHfvW
X-OriginatorOrg: bachmann.info
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:53:12.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3664aeeb-ee78-4fbd-6d21-08de88e38613
X-MS-Exchange-CrossTenant-Id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e3bace4d-d2e7-4d8f-afb8-152509ee3f1a;Ip=[185.67.228.71];Helo=[webmail.bachmann.info]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6714

The polling task can be preempted at any point inside ocores_wait(),
including just before the time_after() check. If the scheduler does
not resume the task until after the 1ms deadline, ocores_wait()
returns -ETIMEDOUT even though the hardware already cleared the
status bit.

Re-read the status register after a timeout before declaring failure.
This avoids spurious timeout warnings under high CPU load.

Signed-off-by: Martin Aberer <martin.aberer@bachmann.info>
---
 drivers/i2c/busses/i2c-ocores.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0f67e57cdeff..6f5aece94d57 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -313,12 +313,24 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
 	/*
 	 * once we are here we expect to get the expected result immediately
 	 * so if after 1ms we timeout then something is broken.
+	 *
+	 * The polling task can be preempted at any point inside ocores_wait(),
+	 * including just before the time_after() check. If the scheduler does
+	 * not resume the task until after the 1ms deadline, ocores_wait()
+	 * returns -ETIMEDOUT even though the hardware already cleared the
+	 * status bit.
+
+	 * Re-read the status register after a timeout before declaring failure.
+	 * This avoids spurious timeout warnings under high CPU load.
 	 */
 	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
-	if (err)
+	if (err) {
+		if ((oc_getreg(i2c, OCI2C_STATUS) & mask) == 0)
+			return 0;
 		dev_warn(i2c->adap.dev.parent,
 			 "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
 			 __func__, mask);
+	}
 	return err;
 }
 
-- 
2.43.0

