Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7C433E82
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790236; cv=none; b=dGIjhZQ3VdGb2mRbHIF3LmI7GeXVaWd12iBtwKN+0RqWZ4WWkylIFxgTREzyg61XNpzMMUUITdCpLevMuCSF9nTtMUYPPhkhh2gGstxfUfP4vGrL9QnoA2WdwOpeNXbZbabshzn/Xu3ZYL3IAx792rIC0ecPm0a+SKo2nF1S1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790236; c=relaxed/simple;
	bh=PuTxehw/+oG0R+AUeP1S0jJfWF/Fu/L6ssD+zcOM2zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqxFgmgCQGusmwvlsvQcgsRB5rFracGwlQIOTZkhysjLSH10AotYi0KNwQFYOUjCLmSQ/6iJLwCCLby6gwJnvt01aKtv83wsNBIZWLUj/egqr+Aue+r5YKaj1la9fCeuhFLwhTVeoMzaxx0SVmqUaKrDiknWTJWgm3mY4iFC0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VblUMTIK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VblUMTIK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc61541f8cso3856525ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790233; x=1786395033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcnfcYJ16OlC/FCeHSIUYdGv8WlSuwcbHtR9yqY3EXk=;
        b=VblUMTIKXDgt/FYOzdKV8CxFYreBf1imFvjbTciNdXpEVoYT6evIVDoFVcVa8TxNLb
         Os8VC7HNGV1zToIQuTx38zg3bOGGdUhbdKsMYiNdGYbRVnRDq/nzrVieSr4WAhB5a62j
         WGUBH9SnpdQRu2JTsrIK0oKeqb+uC6im13PGHNusT1nuDdvF6KOi/Hx4aZmTc9uJHGjF
         wWNXpBTWY2OtEnigx80RLf4xXLV56ZHuIhgWKiY/v7RXoLlhuxj1yiKuMrxF289M5gEs
         P/qWGkkxnVh8BNrMWlwHUrfNy4+4Z+nkfbKvCh6NTv7J6gbvtGh3KzKhscZluPuKuDmA
         Wc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790233; x=1786395033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcnfcYJ16OlC/FCeHSIUYdGv8WlSuwcbHtR9yqY3EXk=;
        b=mIkFhwUmGz10gmB4tDTVWwIW8u/+pjZz0MilBjvXl/QBSUpl5Gml+WxEoB98yA0hAI
         U+sEDftLqnmYRWs+zOivnOw1qTeyyV9RhTc//EtvaWz57L5gzxhyq1NZlrCC4V5ikVRF
         BsUn0U5FcEay1LxP0brru7AkWRbYPKucaaejLPg0ytzQZ4UE6owr9jqIlZKhKpxBjsij
         yGLv6rVndMWGcymodk1LF97NUQKkZZpllYjNVDZlyVsc5PGuIFoqzJP4PVADzV3b3Epf
         ycF/X2Un6J/x65SAfR/DylIS1R3Kpk++IGBzaqM/PdGmLhS+pvIuSd0T8ZGNuqnkdTUS
         a9Gg==
X-Forwarded-Encrypted: i=1; AHgh+RrPfucdtAIhQ+MJDukgojFVN5Go5qk+u8dKTF/srMmSopSgnzmazAk+DHDJcAOm0vK3BLmgJ95N+Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVVsrPM2y2V+jYRR1kyK+wxY3MgC361NovJ5gywvB8QcIXUWw
	hR2DxMegJxbdgVQX2bov/Q1iZB4aFEuKIhHTxvOhfyIImvwKtMjfAJhh
X-Gm-Gg: AR+sD13r7TbmgP2LpMTdBgTN5lb9wKj1HOR1ZfT2S2gSs4uOyx5IYKX4pUV5qPQTNIU
	uVww6RQ0dnCLRPNotUVd/fd4vJOuRI4sj/Aw3oDZosIxoWv7BgEzCgKJgIYtROg7VRSt6orOKDv
	At0O9LBmfi+g4LgTAKqqdt8/GW4GyCmXevS1pG4quigVcUn/OyC8IxzXxnfXlmYi7U2AthkZeA9
	mHwsDLZgKMGZcA5C6Ggcb8mez4XZwIOVy6KtdnPEV46eExWsCZ8cSk2CvAQ4qIy5cuFrCF0KMzH
	Ro4JJiMlzS9iXaxupNscd4roYcjfgQl8HkphXmVe2PXP7F4rkS3T439yGJ6l1hAjiDplIXZTALp
	Fc7heX6shizLfertuDsvyCFVI8xTtxbgoWzzytsNOzkgWhBit3vDexXAEphuoZqboY3G8oX8oY/
	axgges2hn5Gt9kDOcay7HtAC948JLN3sfJrSfyl1rLgIMh6CKz4cq2CuItuh+E3PZI9js=
X-Received: by 2002:a17:90a:d885:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-38febf7117amr885915a91.1.1785790233222;
        Mon, 03 Aug 2026 13:50:33 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:32 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC net-next v2 4/6] ptp: ocp: Validate EEPROM board IDs
Date: Mon,  3 Aug 2026 13:50:09 -0700
Message-ID: <20260803205011.1249-5-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803205011.1249-1-ahmadexp@gmail.com>
References: <20260803205011.1249-1-ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EEPROM board ID is a fixed 13-byte field. It is stored without room
for a terminator and passed to devlink as a C string. An erased EEPROM
therefore exposes 0xff bytes and can make devlink read beyond the field
while formatting board.id.

Reserve a trailing byte, classify erased and malformed contents, and
publish board.id only when the field contains printable text with valid
padding. Continue reporting the serial number when the board ID is
absent.

Fixes: 0cfcdd1ebcfe1a9b262f6ad8419580720dc843c4 ("ptp: ocp: add nvmem interface for accessing eeprom")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1a..cec936bd1 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -347,6 +347,13 @@ struct ptp_ocp_serial_port {
 #define OCP_SIGNAL_NUM			4
 #define OCP_FREQ_NUM			4
 
+enum ptp_ocp_board_id_state {
+	OCP_BOARD_ID_UNREAD,
+	OCP_BOARD_ID_VALID,
+	OCP_BOARD_ID_ERASED,
+	OCP_BOARD_ID_INVALID,
+};
+
 enum {
 	PORT_GNSS,
 	PORT_GNSS2,
@@ -401,8 +408,9 @@ struct ptp_ocp {
 	bool			fw_loader;
 	u8			fw_tag;
 	u16			fw_version;
-	u8			board_id[OCP_BOARD_ID_LEN];
+	char			board_id[OCP_BOARD_ID_LEN + 1];
 	u8			serial[OCP_SERIAL_LEN];
+	enum ptp_ocp_board_id_state board_id_state;
 	bool			has_eeprom_data;
 	u32			pps_req_map;
 	int			flash_start;
@@ -472,18 +480,23 @@ struct ptp_ocp_eeprom_map {
 	.len = sizeof_field(struct ptp_ocp, member),		\
 	.bp_offset = offsetof(struct ptp_ocp, member)
 
+#define EEPROM_ENTRY_LEN(addr, member, entry_len)		\
+	.off = addr,						\
+	.len = entry_len,					\
+	.bp_offset = offsetof(struct ptp_ocp, member)
+
 #define BP_MAP_ENTRY_ADDR(bp, map) ({				\
 	(void *)((uintptr_t)(bp) + (map)->bp_offset);		\
 })
 
 static struct ptp_ocp_eeprom_map fb_eeprom_map[] = {
-	{ EEPROM_ENTRY(0x43, board_id) },
+	{ EEPROM_ENTRY_LEN(0x43, board_id, OCP_BOARD_ID_LEN) },
 	{ EEPROM_ENTRY(0x00, serial), .tag = "mac" },
 	{ }
 };
 
 static struct ptp_ocp_eeprom_map art_eeprom_map[] = {
-	{ EEPROM_ENTRY(0x200 + 0x43, board_id) },
+	{ EEPROM_ENTRY_LEN(0x200 + 0x43, board_id, OCP_BOARD_ID_LEN) },
 	{ EEPROM_ENTRY(0x200 + 0x63, serial) },
 	{ }
 };
@@ -1969,6 +1982,52 @@ ptp_ocp_nvmem_device_put(struct nvmem_device **nvmemp)
 	*nvmemp = NULL;
 }
 
+static enum ptp_ocp_board_id_state
+ptp_ocp_classify_board_id(char *board_id)
+{
+	bool all_zero = true;
+	bool all_ones = true;
+	bool terminated = false;
+	unsigned int i;
+
+	board_id[OCP_BOARD_ID_LEN] = '\0';
+	for (i = 0; i < OCP_BOARD_ID_LEN; i++) {
+		u8 value = board_id[i];
+
+		all_zero &= value == 0;
+		all_ones &= value == 0xff;
+	}
+
+	if (all_zero || all_ones) {
+		board_id[0] = '\0';
+		return OCP_BOARD_ID_ERASED;
+	}
+
+	for (i = 0; i < OCP_BOARD_ID_LEN; i++) {
+		u8 value = board_id[i];
+
+		if (terminated) {
+			if (value)
+				goto invalid;
+			continue;
+		}
+
+		if (!value) {
+			terminated = true;
+			continue;
+		}
+		if (value < 0x20 || value > 0x7e)
+			goto invalid;
+	}
+
+	if (board_id[0])
+		return OCP_BOARD_ID_VALID;
+
+invalid:
+	board_id[0] = '\0';
+	return OCP_BOARD_ID_INVALID;
+}
+
 static void
 ptp_ocp_read_eeprom(struct ptp_ocp *bp)
 {
@@ -2001,6 +2060,7 @@ ptp_ocp_read_eeprom(struct ptp_ocp *bp)
 			goto fail;
 	}
 
+	bp->board_id_state = ptp_ocp_classify_board_id(bp->board_id);
 	bp->has_eeprom_data = true;
 
 out:
@@ -2177,6 +2237,9 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
+	if (bp->board_id_state != OCP_BOARD_ID_VALID)
+		return 0;
+
 	err = devlink_info_version_fixed_put(req,
 			DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
 			bp->board_id);
-- 
2.50.1 (Apple Git-155)

