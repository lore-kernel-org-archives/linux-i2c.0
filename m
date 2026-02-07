Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF5352F9E;
	Sat,  7 Feb 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477025; cv=none; b=KI5qN5l94pJPZIqU1+/IrrEzXHGV/D2OTUH0KhFMDDQycjQpUET+deU4mtLDpr1sipy5yQ1XmTrp7hdlF31v3vQTc0ESSCMttPXBTRbdxdR0+1GlluucrjLe89D6sPbiVrpnwve1L0No5NhWM6dYrqQpaGJgSCfK5OO1faBCqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477025; c=relaxed/simple;
	bh=ylEBIBc5vQ8/oAeziTgq3le2QlT3BoI4NTRFIJnpYSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ALV4hgRTPFZIVo6qO9FGwQ7ev9AqBb6+Wth85QB13CnW+SegJ0CyYxiPL/YaCRw9sUBwf/r3Sm1zu+5XQ3Wnxk80+ErKfrECh1jAWlThPqYVF2qLJJid/5zGUPw8cmea63NqWl15o23F+KzK8Es+YKzCKAwfzjLYw3yHTe8woK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=mrnVchsn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="mrnVchsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770476908;
	bh=bYRxxyP/zLKU+q+qdZ7pw9ok6nL6LrXMBxbVr5QHVqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=mrnVchsnHgqrFwPQrhAVeldlJZVhX64KDnslm2Rc+Bmr8HsH4ZX/E/nJ1VcTv9dHD
	 p1DHxawm1HFJtIT/So5YdMOFMdBGhu6yImotKsxOX4wuL+vSn/XT/bQLO2vwjnc7tA
	 tY8wn1ZldDPuKkFMh1yWP1CVQpGCdJe7QMk7mcY8=
X-QQ-mid: zesmtpip2t1770476905tfb0debbf
X-QQ-Originating-IP: Uu9OsHp7+mhRwZVznA6YPCsG53vqq8H6CLvoIhU3lMI=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Feb 2026 23:08:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13363079978593066317
EX-QQ-RecipientCnt: 9
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v7 0/2] i2c: spacemit: introduce pio for k1
Date: Sat, 07 Feb 2026 23:08:20 +0800
Message-Id: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvQMVK6SrRIm2oIMhQiCO+et
 HyL/1/InIQzDM0LiW/JEs8K2zYQ9vncGGWpBlLUK1IWfYeHQaGAl0Q02inngvbGW6jNlXiV5/+
 NUykfYI1a+l8AAAA=
X-Change-ID: 20260207-b4-k3-i2c-pio-318088c1b3b7
To: Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770476904; l=607;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=ylEBIBc5vQ8/oAeziTgq3le2QlT3BoI4NTRFIJnpYSk=;
 b=H30sb6GLQFfEEZw0wbbDhgH833FM73XlJbJPuye3oKHNcCiWZTXwgFjHSfiqxTocR/PW1suSs
 NHy6bH0DiKCBzCLroxiiVxeQF0mQei9UGgZxYHgm0W2axeFvIMhIqLf
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OXP041Q9YQXuzVXwUy9ItD8mizGVUZ64XbwVeDVaONh5yk9TN/3NQ7gH
	H7fi3HH01kuhtvN/dhVNChYYIUvZJ2oeXUSchto0nuhsn+qkiTBp2nWhUlfIQx9oy4XQqCv
	ojU2haQ1674612nafiea2cT6GPvD1nJp77KqyZgKU38Mn+dBnsjC4tnzXE4WLTe4cznBR+h
	9Oxne920qpH+9fpbwO7QUBr6nnV2EIXpiBbmt/o6xl+pnvrTriP7WzIzp/SB1G7pUETrQaK
	jqoihaawXSUWqy2ZdMSXTpK2Pb1jGjRhMLtxr8+CjBLGy8yR/P92BMe/EyyhuBdMyBp1lgq
	zo55wDVdFTjlWAb9CxbBnwMO/oR8DEH6Pl+0/bmdjYsUSJTLx6gRG/j4SqYoKVCLz0umpfY
	hX6mxUZ3xkcGFkDG15WeqBo2ZYXfK3Sl4AoooA5pijNhPTcbwTO6+SsWZjw1B6tT4VO5U+o
	e9w82o4z/4RZnE9SxqvtwnciK94jMNlpune3soRN30U5xnT9KJannNAuwlB3VXGze2r7+8M
	I+JflNeDrTHpyJvRpmw24ZDh7haZuVgslqRZnCUATbQqZnMQhU4lsLSsnvp6RXM6tRlqcZb
	VVIERSfg8VmsksqDgGcDiMpsNJEL7GlafaQHjdqtAThfBGLsRolBTt0iHhzzDFkIRMsHyCu
	jUs8H51PWKR4fuKcrR174hEyS4t+VEb6CjDDxeSYlhcJmezq7lqccTwhOqmVtKW1MMpYTej
	3mJ/j7IR3lYKiBBiN64R6Fz/Doe50U3cHTUWMikdQFb6Tro+T9cp3hUJaZoe0soaKeh7k/G
	0+RHxjp0S8eixacwRQQgsa+uIBD2Pi/2JhRhzM0XswWlRArWUp58M4rvl6+7s+8ms+oa+hr
	hdqDvw+pnhMwAP96O/LOPDFpbFv7tLefsIiUYD1pq/easen3Q/Q5VzhzOI38WydYGJBAQbJ
	0UX4j3bjG1KY9jWqrCM30LlWEGzYjD4yfYY8aFVkkVTt7HwXf3AaokGekUG4uLPLy3rJU1B
	+2xv1RwiynJc0qP7yOWvRoenvEeBs4EjapQ3zurAIS9qQH8FgOSVHl5rVn0f5rOlNwVxUAt
	6yLkV9FKhS3V/HRf+nvLYXEyL62D1SQ3PrCHey1C1KWNzOFtFDo17Mor5zFHyPm8T3+8NI9
	85uuQYfsQ9qDbcQ=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
enabling the use of I2C in atomic context.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Troy Mitchell (2):
      i2c: spacemit: move i2c_xfer_msg()
      i2c: spacemit: introduce pio for k1

 drivers/i2c/busses/i2c-k1.c | 316 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 236 insertions(+), 80 deletions(-)
---
base-commit: 2fe0719258a48c204270366ef574066122e81924
change-id: 20260207-b4-k3-i2c-pio-318088c1b3b7

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>

