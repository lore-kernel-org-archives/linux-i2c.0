Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657541;
	b=CnVNJtHL16ZUWgPZOE5QeCml41iH1ve1FQfuG2BWBYuTQMnnsnLERmUFuKxegmTDwuJT
	 208RE0FhK/qIgEnHl8XDMepnh1CaorGvEhz6LesLV9aGdPjDmceWsTrAEAPB4FiCpGaVo
	 rr406R110xwnJfb7bpYKQTHfU0ln5wjcdTQbNN1I/Jxrd5Ba59qDtdwNtLb/4ud0xamkf
	 PngfxLQC20HLsDXi2m+fW836AsSibIRNQwD1kM/WYGT7X0q93FIduEjYeCBd8PiR1Kzpo
	 XZBzmTrQ+vpXAlfeZLhvjPt37jDOXE9vDpQc1uV8tHVSRK2B6LV8diHkijhprbGzP5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657541;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score:x-atlnz-ls;
	bh=yMtNNzSVQVOw52jIp+BzqT1acze71/RLeuWWPpIUaSQ=;
	b=iWvqJ84a1xY9O7DGcZA9CU+Q7fZZI52N0ELt8spUB+m9b/e1/n44zdULs2E9134Yen8B
	 FvIGTCjs8htqXiS47U8SVVFEBySB71A6WAX1t27XiBBIO21dHmSJMcNNkA7mt9nskOLqQ
	 0KQmu9//Gb8dZkrXaJ9+OzzuZYL0s+UBBkZNSCpZN2Xtf26wkAl4TMu32meJR3lhNCs/y
	 dOHHkl3Pwuk1588qOaZf0HNqUZsrx4XU/7HaZNu9l6/naB741b+lUU+oC+6+g+kqOyLn7
	 bPeAcPsgSMWZACCxhGLeOgvgPiwkPeDwpXmqwdJgSb2HhxQMN+tLRjjGppmEbeLCOCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=GdHXnTbo;
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A69606A31E
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 01:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=GdHXnTbo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1795657532;
	bh=yMtNNzSVQVOw52jIp+BzqT1acze71/RLeuWWPpIUaSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GdHXnTboG8M3mS6UHYMgW9ZECOhI6dtvH607iWvoD7IpbhlN23V0elt2FdqVazjIO
	 q+157Lp7lZepsfRJ57Sc6k4pl/lI57LmBY+lIFQz87eECoSeV7YgnQKbCNFK61ghLc
	 9nHkxNfy19CkEDSAJz6lsJcpUCFqe52yTxJJ6R81weYHj1gjg6QmXam8KFJmknioRT
	 OqWt0WZbdUfxkkwsiM9Vf+mCuOyaZsOIyHlWcyN6PD7mYhmb7d0Xi4N9LPhHVFbOh9
	 0rA0Zw1eYOdoFr1hHwgvfPWGwYTgKxm7tPP5wTJ054MuSklLjzyKAKVnzBvgGbwGgD
	 aZw28asrV6UTQ==
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 158F82C056D;
	Thu, 26 Nov 2026 14:45:32 +1300 (NZDT)
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6b078f3b0000>; Thu, 26 Nov 2026 14:45:31 +1300
Received: from maxj-dl.ws.atlnz.lc (maxj-dl.ws.atlnz.lc [10.33.22.26])
	by pat.atlnz.lc (Postfix) with ESMTP id 3832E13EE41;
	Thu, 26 Nov 2026 14:45:31 +1300 (NZDT)
Received: by maxj-dl.ws.atlnz.lc (Postfix, from userid 1960)
	id 34844100067; Thu, 26 Nov 2026 14:45:31 +1300 (NZDT)
From: Max Johnstone <max.johnstone@alliedtelesis.co.nz>
To: gregory.clement@bootlin.com
Cc: Max Johnstone <max.johnstone@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: mv64xxx: Recover the bus before resetting the controller
Date: Thu, 26 Nov 2026 14:44:52 +1300
Message-ID: <20261126014452.2418337-1-max.johnstone@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Hs/VGFTS c=1 sm=1 tr=0 ts=6b078f3b a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=zJRp6_cAMcgA:10 a=ZqmY1e1VBb7WEFIpSSkA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

When a transfer times out, mv64xxx_i2c_wait_for_completion() resets the
controller with mv64xxx_i2c_hw_init() and then clocks the bus free with
i2c_recover_bus(). On a 98DX3336, issuing that reset while the
transaction generator still has a transaction outstanding has been
observed to hang both CPUs.

Run i2c_recover_bus() first and reset the controller only when recovery
fails, so the reset is not issued in the state that hangs. On a stuck
bus the recovery clocks are enough on their own.

Recovery alone still leaves the transfer that hit the timeout failed, so
a device being probed at the time does not come up. Retry once from
mv64xxx_i2c_xfer_core() when recovery reports success.

Fixes: 9c7cae242771 ("i2c: mv64xxx: Add bus error recovery")
Signed-off-by: Max Johnstone <max.johnstone@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 37 ++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
index 06780dc1f1a4..ef4b3773752f 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -122,6 +122,8 @@ struct mv64xxx_i2c_data {
 	u32			state;
 	u32			action;
 	u32			aborting;
+	/* Set when bus recovery restored a bus the transfer timed out on */
+	bool			bus_recovered;
 	u32			cntl_bits;
 	void __iomem		*reg_base;
 	struct mv64xxx_i2c_regs	reg_offsets;
@@ -578,8 +580,11 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_d=
ata *drv_data)
 				"mv64xxx: I2C bus locked, block: %d, "
 				"time_left: %d\n", drv_data->block,
 				(int)time_left);
-			mv64xxx_i2c_hw_init(drv_data);
-			i2c_recover_bus(&drv_data->adapter);
+
+			if (i2c_recover_bus(&drv_data->adapter) =3D=3D 0)
+				drv_data->bus_recovered =3D true;
+			else
+				mv64xxx_i2c_hw_init(drv_data);
 		}
 	} else
 		spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -745,20 +750,34 @@ static int
 mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], i=
nt num)
 {
 	struct mv64xxx_i2c_data *drv_data =3D i2c_get_adapdata(adap);
-	int rc, ret =3D num;
+	int rc, ret =3D num, try;
=20
 	rc =3D pm_runtime_resume_and_get(&adap->dev);
 	if (rc)
 		return rc;
=20
 	BUG_ON(drv_data->msgs !=3D NULL);
-	drv_data->msgs =3D msgs;
-	drv_data->num_msgs =3D num;
=20
-	if (mv64xxx_i2c_can_offload(drv_data) && !drv_data->atomic)
-		rc =3D mv64xxx_i2c_offload_xfer(drv_data);
-	else
-		rc =3D mv64xxx_i2c_execute_msg(drv_data, &msgs[0], num =3D=3D 1);
+	/*
+	 * If the transfer timed out but was rescued by i2c bus recovery,
+	 * retry the transfer.
+	 */
+	for (try =3D 0; try <=3D 1; try++) {
+		drv_data->msgs =3D msgs;
+		drv_data->num_msgs =3D num;
+		drv_data->aborting =3D 0;
+		drv_data->rc =3D 0;
+		drv_data->bus_recovered =3D false;
+
+		if (mv64xxx_i2c_can_offload(drv_data) && !drv_data->atomic)
+			rc =3D mv64xxx_i2c_offload_xfer(drv_data);
+		else
+			rc =3D mv64xxx_i2c_execute_msg(drv_data, &msgs[0],
+						     num =3D=3D 1);
+
+		if (rc >=3D 0 || !drv_data->bus_recovered)
+			break;
+	}
=20
 	if (rc < 0)
 		ret =3D rc;

base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
--=20
2.56.1

