Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF202220698
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526095; cv=none; b=mYsiqGahfVrhVA7aCjLeIdmzvHI4l36oaRC8nigmiCvYq20ZstKEWY2aQ+BKw+Vk5thMCx9g8wLF0sQ8eOsi38MkCo0qrbYUDaTNVY9GUyqGvOp3RaBqI7FmiCkfKc0amMn+3W/AUKzYKmM+9Cqi4WWp+ZrGlJ4jOE6+G13CiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526095; c=relaxed/simple;
	bh=ZN5/tB29cTUOpqDTROS8I1CDTLMgxm+dR4Ni8/jXzhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j/ylZz+AKYq6GUny2hp/V8t9eHOAl4SAL6QYP+81cei8Nsp0b7SH+WJzXNOJnDKs6XvBy735l8ocH0X9bWgYjBU0AyWYc/B29ZowHe5FrvETmkl/LwqQMYSHhQ9nR9O01UfWyzf1lnhMwqqGdFYniJ8n3fOo5CsFZ9SA3WvJD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMlj1c2d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMlj1c2d"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47fe89fb333so361306f8f.3
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526092; x=1787130892; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mWJFKMTgKvak/eVpuZLedyc9l+eHdYII/tsgAVzj1hw=;
        b=FMlj1c2doRqLnAJdja/a+gMB51NUgRdqxOIFYXILSm5M+qIwCPbKW/XJkIbSYbMYUQ
         IRmVeDxZxEo4qmquUc1v+CBdemlKGVNk1p+qjw8XwzNV6wc7luVwG80cJ8uY8XkkjfI4
         M2Jlw0KEy8cAKQOgS1o4zLGAwLOi7OFxaoDaQ15vQ+ea/Sntjv+MFJ9iRX0gttWSDxmB
         3PRsqZ4EnnzY7Hsw4OsXr3UKl0PJO2m0YJqGrLO/p66JYoyeaL3tL6TCnK5w5MSeqzO9
         WM4tZejLE/AAjtqVr+un+VylcGIprC+1kqSll+TdMykIYYCfzJH0hn/fykibBPrJBEWB
         H8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526092; x=1787130892;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mWJFKMTgKvak/eVpuZLedyc9l+eHdYII/tsgAVzj1hw=;
        b=QM/WhSt2dSWBA+6EOzU52dVQAcpz9pZEwjnzz34PI0JoA2TAnQcUbh/yHTB5yxVReD
         yyNLstu83I0+tyi5xagQRtiuu238zI8xcD4+edmkESypkoJUheRVJ1hiHQqZA90kFCme
         7ImhuyXAMqF88Ha8/z9msCtuDnoSPJoxbBlHypHJyT7VxpG/aOiD0luDVJfF9BIgoFA4
         yG4E/VNGlXROUqc39JbPjwy2YeEASxSHF7H7tf2jBSi5tuGTOzW2Nyi9XjhSlKFik6S5
         BPxjup1k5tGeVWlS4cy/VJQLKOMWOeX7yuI1QCAuXqzExmAt2oDpBPHGfxqm40Jb8aEy
         RZDw==
X-Gm-Message-State: AOJu0YySh7NsTagGHy5CW7WEdkWiwlh80KdbtbENSeJKW4KD+v7Oy1zy
	+fFQupZ+QIqYElmO59Ajhw5Niz8dbmfQ73O5QlGRvCXh9WdqrP8wk/kYIFClGV6p
X-Gm-Gg: AR+sD112EmrY+ptPjWq7fsecbgE66XuippWBaxx4xXJvVBqCbXPn2BvWp98OFAq9VRD
	hGkPlT3O32v4viD4rt43vkQCJwBYq6fUqNiW+l3AMV8tgTq7m9YTulB6aM6ags89NpAnDn/TO7G
	ZUs9gUnj8GyZgmYpS9AId9BmtJ+Lnik4KWbtk/feE+yKoyjk2mQHMRbwOi0nQrMeQX3HyGihwee
	WdFLR8PjdkPsGGX9ZIC4FlhcWQJSGlePQl/hbfNvh7Ai/O4Bnn2XSe8ZdZ8PTSBO1S4/iPx1h+U
	W5aJPjiP4QeAjIQvBFNp8WI0jRkCHBGCEWGRXhZ2MsO7j/ztoDO2xQN89hYMNCpLcCmd0jdVP2f
	rI/u/9hzat4chDfd4FRHBGtMznXT4FuWeP4MbVaVuZ+32TDnbszuCSLQDrb7W0ec7mMu5AqHzly
	1dil4sFAh/JbXF7aPgEBOo2mn+YV4XiLXOhXp5YllFq7OW6oi8hKjxrXGLmoEcVGihOrJfxKbIi
	ra1Jphb0xoULfDPwzeaIm51QQtGI+bOA0VDExpquRaZyO0cIhUsgjhscwn+rpPY
X-Received: by 2002:a05:6000:41c6:b0:47f:f20d:8d4f with SMTP id ffacd0b85a97d-481528d739emr4384574f8f.18.1786526091775;
        Wed, 12 Aug 2026 02:14:51 -0700 (PDT)
Received: from valmpani.valmpani (cgn-195-14-219-6.nc.de. [195.14.219.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d5ecbasm5629789f8f.28.2026.08.12.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:14:51 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Date: Wed, 12 Aug 2026 11:14:48 +0200
Subject: [PATCH v2] i2c: core: fix debugfs UAF on adapter removal
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-i2c-v2-1-5efaab4c3334@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIc5fGoC/0XMQQ7CIBCF4as0s5ZmoBTUlfcwLhChnQRKw5jGp
 OndJW5cfsn/3g4cKgWGa7dDDRsxlaVBnTrws1umIOjVDAqVwTNKQcqL+By0ttajRAOtXGuI9Pm
 93B/NsZYs3nMN7r+1A0qjRo29usjRopBic0yJ2KW8uoX4NmVHqfclw3F8AZIshMaZAAAA
X-Change-ID: 20260801-i2c-fb34477c0106
To: Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com, 
 Vasileios Almpanis <vasilisalmpanis@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786526090; l=2061;
 i=vasilisalmpanis@gmail.com; s=20260731; h=from:subject:message-id;
 bh=ZN5/tB29cTUOpqDTROS8I1CDTLMgxm+dR4Ni8/jXzhI=;
 b=v6KTTxSIYKu6/ShNUq8nnpai7RvM8uIwk3OnIMLGUPGct9GO+HhRg91jwdsNWh/gkR1a+V3kN
 46mMkKOuiixDLf+fKJ+dGM8kqQPJ2dsOa9YXYaI32Clu9K65ZOvlhLd
X-Developer-Key: i=vasilisalmpanis@gmail.com; a=ed25519;
 pk=gn5Uo6yL8Tlpq5uATxA3nqoq+U8eWLRbjD+bOk0qSpU=

i2c_del_adapter() frees the adapter's debugfs directory before it
unregisters the adapter device, but the new_device sysfs attribute
stays writable until device_del(). A write racing with removal still
reaches i2c_device_probe(), which passes the freed adap->debugfs to
debugfs_create_dir() as the new client's parent:

  BUG: KASAN: slab-use-after-free in lookup_noperm_common+0x407/0x430
  Read of size 4 at addr ffff88803ef87810 by task syz.0.61/6090
   lookup_noperm_common+0x407/0x430
   simple_start_creating+0x9c/0x110
   debugfs_start_creating+0xdb/0x1a0
   debugfs_create_dir+0x24/0x350
   i2c_device_probe+0x814/0xbf0

Its technically possible to create a client after i2c_deregister_clients
has run. That client will never be unregistered and making
wait_for_completion hang.

Close the window by removing the new_device attribute at the start of
i2c_del_adapter(). device_remove_file() will drain any clients left.

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Reported-by: syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=23ad911c819b923238b7
Tested-by: syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a737..17cf3d225268 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1815,6 +1815,12 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 		return;
 	}
 
+	/*
+	 * This drains any in-flight writers, so all
+	 * clients will be caught by i2c_deregister_clients().
+	 */
+	device_remove_file(&adap->dev, &dev_attr_new_device);
+
 	i2c_acpi_remove_space_handler(adap);
 
 	i2c_deregister_clients(adap);

---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260801-i2c-fb34477c0106

Best regards,
--  
Vasileios Almpanis <vasilisalmpanis@gmail.com>

