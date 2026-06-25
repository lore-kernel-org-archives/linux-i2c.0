Received: from 5.mo583.mail-out.ovh.net (5.mo583.mail-out.ovh.net [87.98.173.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DE1684B0
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.173.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405158; cv=none; b=ND/MV42qRAzqi2xP3O3cWl96x4hqfck6uvKTI6yiEOg1gmAWSTezGYo/0BCvVFAxhIm+a3fU6BFV9xydUGd5FOx/X+FlmQFNnLgQ2lL8SR0zIYJhUcPCTy63Ewd7w/Dcgz1zDdu9EK0CzCACv7Ok+B6TCWV0qbRGOPjj8aGR7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405158; c=relaxed/simple;
	bh=8M+og/cgsmQeo9pr30XZIiCQraEwBpFZzSelbIy4p7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYe1dLT6MJbOug1S1QMEcS6v693FMBBGkVTV040d0hvo1EFHa1a4KgZI9nF5svjHywn6zHI4b7WjTrTFKZ+M3LwUkZmFz84dFsyB8QtuRNkc3zECk1sdciCZRyTTV+kwADvt4633pRhnuN+fxxz6ArXAn9/069oYSAqTCtJCw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=87.98.173.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director7.ghost.mail-out.ovh.net (unknown [10.110.37.5])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4gmPV43Yn4z5wg1
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 16:32:28 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-74qgp (unknown [10.111.174.16])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 011CAC00EF;
	Thu, 25 Jun 2026 16:32:27 +0000 (UTC)
Received: from etezian.org ([37.59.142.111])
	by ghost-submission-7d8d68f679-74qgp with ESMTPSA
	id b0bzJxtYPWp9WAAAssge1Q
	(envelope-from <andi@etezian.org>); Thu, 25 Jun 2026 16:32:27 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-111S0056f049c59-1a58-4b94-aa7a-5d26a5d791c8,
                    20FD450D999EB22A6E066B2D596748FFE04DB42B) smtp.auth=andi@etezian.org
X-OVh-ClientIp:178.82.31.9
From: Andi Shyti <andi.shyti@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] CREDITS: Add Wolfram Sang
Date: Thu, 25 Jun 2026 18:32:21 +0200
Message-ID: <20260625163221.183414-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6348949575952929910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGBun99XHRXkzzNlF/YK/HPjuFiov8SrlfuVda0JT18xy3rlRd0ZWaK+uOC5l4tCDoV3PvdLvGcwzt0evzfxCUUbpUaOBxxknqPVf3tljweoeSHRtcDbGCaVgJNusytvVngw5HKfCI1dFYQLI4U4p+HARJZE3rackX+/nOvdKquk0kljyH5+B6V7TU4hN3fpt6++KKx8FHX0mYPoWJtY1eY+qyiJ7RllnuQXZj9KGIMUdClJv+VXzn5N+hXPiPmJmYh07MoaH8wFo4KvrDc1QnZDcr8CBFrB9Obj3f9jQwpcKRNAEQ/RAiRXuzjlxAfPYqqb1jZCkL2P6VI6oVU8DJheGH97JvpS8DTyauxYDovYAy41XyNRCGBXobHcSArWYMSv3D8knjrbPQSxoQuL8zUtpFn9ojXh4qbD/rzVQC9zVqBPZeUFkCEPNyLNiL9sY9fKvOiXxQU3NAmzVdSm5Wv77cdUilZX0xtGTofphtWAd5TYQ5Dj/RUWSRXUr2ELH7bEUG6F+TpmWMy3AM9nqJsODWNJbSKHFvRZhxBdBxi8Dxu67ZEzJX+39cEEoRLRfSQ5mtVQzX4quxJAzqNuCssdlwuIE+OQhNMBnyk6L/YlW08MJRHJ1Z5kE/fI62iTvcw/QgxHz2r107qMBdzPF8uE9IyLYnWaEG6REzfs0DXxw

Wolfram Sang has decided that a decade-plus of I2C was enough and
is moving on to new things.

Thank you, Wolfram, for your years of dedication and for keeping
the bus in line. Your legacy is now officially cemented in the
CREDITS file.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>
---
 CREDITS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/CREDITS b/CREDITS
index 84793a967a0b..91c51c14e993 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3626,6 +3626,13 @@ S: 69 rue Dunois
 S: 75013 Paris
 S: France
 
+N: Wolfram Sang
+E: wsa@kernel.org
+W: sang-engineering.com
+P: rsa4096/140DE4CC14A029B6 3991 B1EA B9E2 6751 A4F7 645D 140D E4CC 14A0 29B6
+D: I2C Maintainer 2012 - 2026
+S: Berlin, Germany
+
 N: Aleksa Sarai
 E: cyphar@cyphar.com
 W: https://www.cyphar.com/
-- 
2.53.0

