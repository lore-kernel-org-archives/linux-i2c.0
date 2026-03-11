Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D5285CA2
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229682; cv=none; b=Q8r3YCCNRLcv6GErfPypmsWlESHCIYMYZSUb6Lma8kjR0k/5kcDrYCATwrnxJU/Bcqw4sKmqTfMbjePavRx/LWM9ZX3O9grCrS1pKIuqI+0QM58WtkgF3zRqK3AQtcBxuWXE4C6LtuYLwFQc96taNZNtxa4tFgKutcm2Yx24AbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229682; c=relaxed/simple;
	bh=AGwHhWByJI2Ulk/BJdMl7Vr3SrlvDzIRbrmITlOYusc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ql+VFG6LtPl0+My8VivmSZZ0TDv26cp3oROE3gBRSzIeshNNqUmyFpgtjz7DnCZtZH0FwZr5BNNC8rTH49X0Tkj8+G68FYbzREWo0lJ8y48ATfJPSYWoiiZIws3irvbg0FzbDQhP0BIACWTUdfzTljzfYMmhpR/S/kii7sQlApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TBshuUdR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TBshuUdR"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CAF5D4B3;
	Wed, 11 Mar 2026 12:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773229610;
	bh=AGwHhWByJI2Ulk/BJdMl7Vr3SrlvDzIRbrmITlOYusc=;
	h=From:Subject:Date:To:Cc:From;
	b=TBshuUdRr0YCSDav09H5qwbLbXW/UQV6GvGsCH4zsEM6AYn4QP+iUxXuk5iysXKxu
	 U3DKi8OPFuXhs9YaOHcPghxjk25gAvN0XEVbOWgGHEPtxkPk/sBiaminzKK9F0rqCM
	 AN48OvTaJbcTRZSe9lHLToWSV9Tk14X3FAYq0frw=
From: Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH 0/2] Minor changes for i2c-imx driver
Date: Wed, 11 Mar 2026 11:47:42 +0000
Message-Id: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5WsWkC/x3LTQqAIBBA4avIrBvwJ0S6SrQQG2sWWSiEIN49a
 fnxeA0KZaYCi2iQ6eXCdxpQk4Bw+nQQ8j4MWmorjVLIOiBfFSNXKmhIG2Vn77yLMJ4n0x/Gsm6
 9fxPap6hfAAAA
X-Change-ID: 20260311-i2c-imx-fixes-3e23164a8a8f
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Daniel Scally <dan.scally@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=AGwHhWByJI2Ulk/BJdMl7Vr3SrlvDzIRbrmITlOYusc=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpsVZmrWuzyiYgnxjrK3GT9VAsgeXRMfTsY5ISt
 drx/c6eUgSJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCabFWZgAKCRDISVd6bEV1
 Mjg6D/9Xq1HeCY1wqZ8n+UDcYSJoSgQ72XO+2Qq7HH8szHnqmLWKxz7KqtSH1W92pe6k7axV43o
 4c+OdXN354yMheWs2CLAnURbeAWmkChT1TdFA3SqR/O8vBeC0XMq/mrMzKch+P3J62aJqoGSVWy
 QcGy8n7llUSyc6bdZUj5AOmlR4IwXuyiUHQroxPZsPlekCKVGLu0+In8VSmWv9L882MusO91ApO
 Tl96O/Ljsjly1mJhpJ1klTAm41aFWorBwJ8Ey3dHRMGLbpxFcPmUkLl627F6HWq2uZ6/bdz4Ork
 dRv4n84f5cPOx5PAS+i/Kxn0GcWoWFzHpQquWyPPJTgY25E1u6wDSNm0Z3hm1Kl78BKxBR/pHUe
 bDpvQQ7PF0ZsJCltEtuKvW97sOeuL7ogQojpcpuGV4MDnwuM0vzPiCQ2NudPus2lsQNkCSBC2Yi
 bVo/qRxnVAEV14KpNp+tHPjZtp3uzZJZgE2c/1MJ5VAW3fHib1Q05dRA8LzTidsVe+9NjrNtJDX
 APuAVX4Y9VumrVehdnGqPfLXxws/TSxVEvj5wf7KCdobzmZhjsj20khovv2Rfut7xnKbtclW8+0
 oXUe/aDEDgL45+fdLqzMrt3ifJ9Uce7nv9VHihYGXVGMVteobb1Urc8noUSPOZ7ESPGVclBd3Zt
 q0gZ3aB2lmy3p3w==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Hello all

These small changes helped resolve issues we experienced using the
i2c-imx driver on a multi-master bus. The device was losing
arbitration which triggered the driver to attempt to recover the bus
rather than retry the transfer. The set stops the bus recovery
attempts on lost arbitration and instructs the driver to retry
transfers 3 times, which seems sufficient for our setup.

I had intended to make a larger change that added a new devicetree
property for i2c-controller.yaml that held the number of retries an
adapter should use, and then parse that to set adap->retries. I found
a relatively old discussion on the list though in which a similar
idea was discussed and rejected so I dropped that, but I thought I'd
mention it in case things had changed.

Thanks
Dan

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
Daniel Scally (2):
      i2c: imx: Don't recover bus when arbitration lost
      i2c: imx: Retry failed transfers 3 times

 drivers/i2c/busses/i2c-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: b82316862bea929265725c077dffcec42e3dc20b
change-id: 20260311-i2c-imx-fixes-3e23164a8a8f

Best regards,
-- 
Daniel Scally <dan.scally@ideasonboard.com>

