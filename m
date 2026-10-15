Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F4384CDF;
	Thu, 15 Oct 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081296; cv=fail; b=iWfinIRDZBcI4R2iXXVMQE3Rlx+eHJ4lfd7wux75WI/MOlmlVdhOakLZhnObaCMhsIw5AOPAZ3hlbXYlVc7E5tSkYFhcjk9xW+TMDhkX7Plba+r6/bhyuYCCuem6FU1qW542WSWq7s51p1ggQkRdUcg67xrNK+ljsJIOY0ZvvlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081296; c=relaxed/simple;
	bh=1xcQmRqSjbX7EgrsJc/f6dQOI51EuRRYYRtcQcslfeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiWVZ4H931LRXLPRMKRupFFZHkCt4Z7yGcXgb+n/hN5w2DjTbtlF2JUh7fS73vOf76/tYKve+3NYBDaBS2w4YfiAN/CNy7V+49/1CpD6I+vm6lVuvSzGvDpY1gDeMUX+Szbv+Gp3TREfgnPNtW8iXuUpgtqiOHoYMyXJPcxGnGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmVojH3U; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmVojH3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzrYQNI5SSoW2M5xQIYxGFLaJPqeU25C95TPsADTUbj5nx4CkY8bjjJfgUfNP1rZgh2lspWndNULOJTYoXgSl1zxt8s6lcQtQvDVd4rIA7e/ANj2iEJBzy4Mjm3CAzKMteSL6EdbZU4rkxqlF9jVF7PBOh067qZdXBFQuLtO+A1dSd6u3NhW4YTGtgajb66vznK+k7Avv/Ya//MKF7uiC6iCorSJr9xspPImPshjy6/VaTQcdrcJTvbCl3DEuSVbYkD9RVKlhr0H8kXlz0PG/f4v3YAogVX9mwdJNGk6izSmWzawjGOb7k1s6L+aFfN5PTlSZS1fu4yA0ufpKKDl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xcQmRqSjbX7EgrsJc/f6dQOI51EuRRYYRtcQcslfeE=;
 b=GahTgSlMJ3RbnW/U1i1Nw2b6GdgUuiCNt1eIBbKOIYjKn6V8iXjSzpzCmizNK35DUC02ITqsKWugMxV6R4r3sIWBIyuoEjQ2H4KIltf0OxgnY+f+TKGxQXvs1CqL/Cc0gJvpGafllRP3ZV9/xHeLv76ndOo7h65H4tdQuwzb2E7+kaMnAEkburgQO3drlWMi4QhEWmUrAtvDKStYVL/xdeM6UqrYt0gfS6JpGPKLbXqCRKp5rglDjvaNPPltAKe+jN3Xz+siTkDZaLlG+itBdNwRYPIg0TbLtmM4CypLOyf3oMcJFbXC6kQH6v4La7quEKBWL00J6+DycwMOyVE8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xcQmRqSjbX7EgrsJc/f6dQOI51EuRRYYRtcQcslfeE=;
 b=NmVojH3UuekE2J/3XJG0mmRKhzg4b1kec0JI5gSUpV9MpbcqIxBxYNDFKvW2IVQQQmyM8m9ZTM7D6FSkAkzMBF57szOh5IT5XPDJwra2MUDT43niSFfwNsASYm61oJKrv0Bl8tXlg4Vmd+/6CRm7HbAs7po4udRCJApmu93EN25rh5gB4yJIZ/cBId7pEP7HEgTXLMHvOmCDWxDh2JinOUD8uq1p9tRVA/1e7YuohOv+UuuBFbVImQLnvAfM1/lmyU0xbfnkpWafIV3lQAgPSOS7rQ4aF9NzzDaFHcvQnPtiR1eqIfteztBEOyTiO1jvjTSp1LeUHAhu1lgOEJVjMw==
Received: from CH2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:610:54::39)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 16:21:20 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::9e) by CH2PR11CA0029.outlook.office365.com
 (2603:10b6:610:54::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 16:21:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 16:21:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 09:20:51 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 09:20:50 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andi.shyti@kernel.org>
CC: <cbabroski@nvidia.com>, <davthompson@nvidia.com>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] i2c: mlxbf: Fix master GW corruption
Date: Thu, 15 Oct 2026 12:19:38 -0400
Message-ID: <20261015161938.143879-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903192001.114263-1-cbabroski@nvidia.com>
References: <20260903192001.114263-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: afcbe087-c69f-4e71-5127-08df2ad85890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	drlGlazHrKARPjWWPk+yYl3h+8wbHWOJIQMjcyUBHYAeWcgVW/lM4bCnhxFmQ9MO8reMub0nDWKWq8E5FT+OWPnCqsGrdqtBFil9/fWvCe9dHAi4lbQFn4QDzLqXwGCmeT3m47o6fRfrkvpSnuLOgcqOSNOgvn3GSqs5C6bPVqHkTvJP2mDIygRPnQqqjMWRnmAul5jVITKcGh47OmmkvcMlL3F8gfTyZTW+Kijhvnc3hsdpXMjIiUiO63bRhcxdSnySsxPKWq4C2jQ+9rKWgteD4+ptUK4Lq6en/AeZiG2+TMyDyY1OTgflc8/oUL8AJLC5t41FuFy1dvuGvceBTFgpRa/nyWegz2SPHQb/h0ZoJpICQG2RFdjBI8AhPVlAlDouuIY5H0eGrJWt4AWiSBvW7p8tuD2xhpg/Ug15cHBXMTissS0UKgcFyJpUkHUrBEQ/Pc3M+nqziWLlFdJI4fzECFwswJsPgZc849dyjK/ezdME4elDCKIql+rv9h+uOqVFYmG+yyHXbTDGB6jThzQGwILoHkd0OcWvHJrugQqaRHexbtuOAqw3BgF/yOvY3aFBd3ZkSNsIsyA3NJ4BmI9NsBBYkVTeJ3R1tVxVptcy3nztmUNKr89uxbzGe++QXC3wu+USTZQuuyhXrTQ/APFmzc+Robis4LtMaST4fslLhcdyWy7fuEmH6XgRGlLN5sky7Rw9mFFIbBrRGoR0gw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tf4TrscjC7kj1QGXWmY9FYg4iw0m5Z1k6nyE/kjS+Hwji75nc/ZmhF7h/7sLmeFjtLNpwcEaQETImzI0LGNzq97LSCMTEGvPildsd1r5yZcFeLPGC0G5048+gjym9ma1RUoc52lOOeprlVzJFrXHo5xQSgixJTYbjHgISNjag1riN4XV8CiDX8eTHN0HvPdCeYJO8P+GK8NBBYOlI3hXiT5cYcNY6usaBpdqiw3WRO1PucprIemBaykhU5GP6/0XsYr3E0e+WWtl9l55Y7wIj7BEAQDbCj1u1IhuJRx0ixpdoj/35gN1gbOT6xGUP48J3eiCFYvwDGG4fNhkwYWFX+HPgY1lSzUQZcC0osqKTF9UFa8UYOm09NWtzT86WrZKu5Z+JDa6w7eXvNVcr1kCQxXSlqusRV+R4T7Ecro+9+EmXif8nkN/aozZeTsXz3LW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:21:19.4172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afcbe087-c69f-4e71-5127-08df2ad85890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

Hi Andi,

Have you had a chance to look at these patches? It's been a few weeks
with no reply so I just want to make sure that they were sent to the
right place.

Thanks,
Chris
