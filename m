Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="b7lwmwBJ"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB3109
	for <linux-i2c@vger.kernel.org>; Wed, 13 Dec 2023 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=S56C6/etkE5Dil
	9FeOPVPcU3W2R+6vc6EhGV0L1qNYk=; b=b7lwmwBJ2f99vI6zdDBUIIv9QoczwR
	yltCsmW3JVNpZOVW+d5H4zgDCSCSTlFndgInrLDUc6guVfao+lQtCNxxTJRufpl3
	3VQW+di3sJAe1q9jZP7LSSQ4sNKwySLNYQsfh+aQszcxI3sSlt6aI8LogR8A37yu
	g4DTowLda65vNymzAb7ho2QMJwBjRoDHHzRWA5NNTbsSHcd9XnFlnijRWJrGYa8Y
	tcsrWYS4b7oH68kVDVAZSBNwZKVmyHbczt8lMcPg87C5YYLCSQuKQ3ZspUjwHDEf
	NCiOjV7OHak4MIebqSsvDKxSaAdN6mtqmcWZrdx0VcSZWHX26ChP2UgA==
Received: (qmail 826951 invoked from network); 14 Dec 2023 08:44:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Dec 2023 08:44:12 +0100
X-UD-Smtp-Session: l3s3148p1@yOjUcnMMytoujnuR
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] i2c: rcar: add support for Gen4 devices
Date: Thu, 14 Dec 2023 08:43:56 +0100
Message-Id: <20231214074358.8711-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newest generation of Renesas R-Car SoCs support FastMode+. This
series enables the driver to use it. Changes since v1 are annotated in
the patches.

Looking forward to comments and test reports etc.

Happy hacking!


Wolfram Sang (2):
  i2c: rcar: introduce Gen4 devices
  i2c: rcar: add FastMode+ support for Gen4

 drivers/i2c/busses/i2c-rcar.c | 51 +++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.35.1

