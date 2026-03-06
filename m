Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65238346E47;
	Fri,  6 Mar 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790121; cv=none; b=DROA7QmeTOoOPQNqtSjq1OB98RhmIjZGKQQp3Okee1KTSTw7fOh/AlNTp6LV1h3el6th/uvAqN1F72U8wj0HsOuhbj5uFyosR7Z+oE2bctRYiU5M4wmmIs44WXICNIFqK5t73LG0f2VJCCasRT8Rc9eW30LzRZ9Bzg7lrtpZSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790121; c=relaxed/simple;
	bh=WCQ0e4cXgOiEHCyhevTk80M2vXjw0+WTHxGW1f67+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZqS2rGdwfKDrNQBcbyak9KPk4BERvHTMAe0FkTJvtywp9vWU9RtDC6FlHhhaxJUCmIqAJFaDAKXwPaESY8AHBGDy5UieN5Hi8Pq0UaAC8CIm7H14G7/b/g7w8Sfir/ydPT6pt3z+YjPeso3BHKpOctuo1MnbVjGitTBzuFigJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klf9w4W2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klf9w4W2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9915C4CEF7;
	Fri,  6 Mar 2026 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772790121;
	bh=WCQ0e4cXgOiEHCyhevTk80M2vXjw0+WTHxGW1f67+AU=;
	h=From:To:Cc:Subject:Date:From;
	b=klf9w4W2SVLsAuxXO+LOSHp2tm2cogbJ0/jfS47t+voFDtt37HWIwlsSalun0sG7z
	 aYqmp24VGrLv1wwpTATUVUcAJItUYjaMqsaiP3VD1FC60+X4MPE28bcvq3FuedX2Zf
	 dQn/GVgNmi+3uivibxz7bQgSl0yEL13uayaONSb+cPmUgR5XUG+8Ucm0EOGT5dETgO
	 11TeOx0iHpKivjKFBVLWfqJ+anB/+20se1juPhYp+diuGRh7Ma7U+TpgP2vpolVftg
	 ICGsucLjEKOpvE57LpwvmvQZ4TAJ8kpmNYXh2IC662ByT6J/1whD7azCb9kbrk4RDs
	 dENrRA1ESLkdA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyRh0-0000000064r-2bEE;
	Fri, 06 Mar 2026 10:41:58 +0100
From: Johan Hovold <johan@kernel.org>
To: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] i2c: cp2615: rename disconnect callback
Date: Fri,  6 Mar 2026 10:41:14 +0100
Message-ID: <20260306094114.23315-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the driver disconnect function so that it reflects the callback
name for consistency with the rest of the kernel (e.g. makes it easier
to grep for).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/busses/i2c-cp2615.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index e2d7cd2390fc..c1dbf7961a02 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -270,8 +270,7 @@ static struct i2c_adapter_quirks cp2615_i2c_quirks = {
 	.max_comb_2nd_msg_len = MAX_I2C_SIZE
 };
 
-static void
-cp2615_i2c_remove(struct usb_interface *usbif)
+static void cp2615_i2c_disconnect(struct usb_interface *usbif)
 {
 	struct i2c_adapter *adap = usb_get_intfdata(usbif);
 
@@ -325,7 +324,7 @@ MODULE_DEVICE_TABLE(usb, id_table);
 static struct usb_driver cp2615_i2c_driver = {
 	.name = "i2c-cp2615",
 	.probe = cp2615_i2c_probe,
-	.disconnect = cp2615_i2c_remove,
+	.disconnect = cp2615_i2c_disconnect,
 	.id_table = id_table,
 };
 
-- 
2.52.0

