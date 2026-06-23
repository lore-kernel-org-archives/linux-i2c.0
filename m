Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42D31B828
	for <linux-i2c@vger.kernel.org>; Tue, 23 Jun 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234824; cv=none; b=SiF2BgLpIz2aGbPn0aIsXl8/yl5KmL83xuU4EhP76V2p9ZtfBDdHyQU3wUDwvgoGXkbIlqKOWLisDEK+AUYfAKRb+3dYAb602LMAfR7MOz38iB8cC1pcDiTvpeoQhC7a0qMA5ZqQhFqANDv616guQ5Xb4fGrvpVEtjWVPp9yhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234824; c=relaxed/simple;
	bh=5NwS+f8gO0PXvhQ+QdnJvHbAstdebWoslSkAWyi65dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fs7BuxbNSGmNt3DDKmSUm42wx4omg8edznQznXifsfI77flfuzXTD63pQmXd5QlBITiBBd85uqyMJUhpeA5y5F4hpgFqiOldpM0pBHoffoTCUc9Lvmy6mhqBls4EzmWJedr6aHbUtvW6HclTWnl856w8UdMzXQLM1ArEr2Z1hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=h4gBFOwP reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="h4gBFOwP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782234824; x=1813770824;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=5NwS+f8gO0PXvhQ+QdnJvHbAstdebWoslSkAWyi65dE=;
  b=h4gBFOwPKBfdpdj6e6mwZcFkNNEL7IBoK/frOhbQC3H954zEAliO9S7u
   mhle3gmTbTE5o+GPNmwgB4IfiWMZsRzk22+tO8KAPZAQ+8uxJve5g2PdC
   ALjZqnSUw6cxFuogxjPZk91LjGIQ2pI1gYBTw7rimClZe1HBMlN0uU6mO
   qZ5GEQFMkz/vqajE+94HQ5E/aPhd4pGHaVJ0VBrUP7DdQ1lfckxRbS5AU
   zZnLthJjRwr+pjoFidETpX9Bb/k9qCJ1+Kk7dogUPqkCEm4cjb33eegsA
   pbVCe/T2XmjrMjBVK4P/2qWi41XP4aR+lz7JK79rSuUUHbRfD/y5EAAjq
   w==;
X-CSE-ConnectionGUID: 8budAKfQSkikUgCdGiN7vA==
X-CSE-MsgGUID: c2jgL6VhSDmAyh5XJQ0JKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:05:55 +0300
X-CSE-ConnectionGUID: idmJbleLSvKA2OlYTt3JeQ==
X-CSE-MsgGUID: 3l9xvnUmR6qT2KIjph14Ew==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 23 Jun 2026 20:11:03 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 20:05:52 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 20:05:30 +0300
Subject: [PATCH i2c-tools] i2ctransfer: add support for detailed fault
 reporting
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c_detailed_report-v1-1-b67259a31a9d@mobileye.com>
X-B4-Tracking: v=1; b=H4sIANm8OmoC/x3MQQqAIBBA0avErBNsDImuEhGRYw2IxigRRHdPW
 v7F+w9kEqYMY/OA0MWZU6zRtQ1sxxp3UuxqA2q02qJRjNviqKwcyC1CZ5KijBmc7TzqfvBQ5Sn
 k+f6vE1SgSkohw/y+H018UMlwAAAA
X-Change-ID: 20260623-i2c_detailed_report-338d61f2048f
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, 
 Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.14.2

New ioctl `I2C_RDWR_V2` allows get detailed report in case of a fault:
it reports how many messages in the series was transferred successfully,
which message caused the fault, how many bytes in the last message was
transferred, and also returns the data read before fault.

This commit introduces support of this new feature in `i2ctransfer`
tool. `I2C_RDWR_V2` ioctl is used if `-r` command line parameter is
specified, for example:

/ # i2ctransfer -r -y 0 w1@0x50 0 r1 r1@0x55
Error: No such device or address at message 2
2 out of 3 messages sent successfully
0x32
/ #

For backward compatibility, all references to new API are inside
`#ifdef I2C_RDWR_V2` guards.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
This patch adds support for detailed fault reporting feature in I2C
added by the following patchset:

https://lore.kernel.org/linux-i2c/20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com/
---
 tools/i2ctransfer.8 |  4 ++++
 tools/i2ctransfer.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index de03c7d91cb3b2620039d029d52ba49d382341a8..a90538023fc8587965f5ff7864bc49185dfd341f 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -7,6 +7,7 @@ i2ctransfer \- send user-defined I2C messages in one transfer
 .RB [ -a ]
 .RB [ -b ]
 .RB [ -f ]
+.RB [ -r ]
 .RB [ -v ]
 .RB [ -y ]
 .I i2cbus desc
@@ -65,6 +66,9 @@ So use at your own risk and only if you know what you're doing.
 .B -h
 Display the help and exit.
 .TP
+.B -r
+Get detailed fault report (if supported).
+.TP
 .B -v
 Enable verbose output.
 It will print infos about all messages sent, i.e. not only for read messages but also for write messages.
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index a49b734a937743fd6e3d3d7f2534583c098a12ff..27701548f14a717ddcededcfc988e46bc38a96e8 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -56,6 +56,9 @@ static void help(void)
 		"           -b print read data as binary, disables -v\n"
 		"           -f force access even if address is marked used\n"
 		"           -h this help text\n"
+#ifdef I2C_RDWR_V2
+		"           -r detailed fault report\n"
+#endif
 		"           -v verbose mode\n"
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
@@ -264,15 +267,24 @@ int main(int argc, char *argv[])
 	enum parse_state state = PARSE_GET_DESC;
 	unsigned int buf_idx = 0;
 	unsigned long funcs;
+	int detailed_report = 0;
 
 	memset(msgs, 0, sizeof(msgs));
 
 	/* handle (optional) flags first */
-	while ((opt = getopt(argc, argv, "abfhvVy")) != -1) {
+	while ((opt = getopt(argc, argv, "abfhrvVy")) != -1) {
 		switch (opt) {
 		case 'a': all_addrs = 1; break;
 		case 'b': binary = 1; break;
 		case 'f': force = 1; break;
+		case 'r':
+#if defined(I2C_RDWR_V2)
+			detailed_report = 1;
+#else
+			fprintf(stderr, "Option -r is not supported\n");
+			exit(EXIT_FAILURE);
+#endif
+		break;
 		case 'v': verbose = 1; break;
 		case 'V': version = 1; break;
 		case 'y': yes = 1; break;
@@ -448,17 +460,51 @@ int main(int argc, char *argv[])
 	}
 
 	if (yes || confirm(filename, msgs, nmsgs)) {
-		struct i2c_rdwr_ioctl_data rdwr;
+		struct i2c_rdwr_ioctl_data *rdwr;
 		unsigned int print_flags = PRINT_READ_BUF;
+#ifdef I2C_RDWR_V2
+		struct i2c_rdwr_v2_ioctl_data rdwr_v2;
 
-		memset(&rdwr, 0, sizeof(rdwr));
-		rdwr.msgs = msgs;
-		rdwr.nmsgs = nmsgs;
-		nmsgs_sent = ioctl(file, I2C_RDWR, &rdwr);
+		rdwr = &rdwr_v2.rdwr_data;
+#else
+		struct i2c_rdwr_ioctl_data rdwr_data;
+
+		rdwr = &rdwr_data;
+#endif
+		memset(rdwr, 0, sizeof(*rdwr));
+		rdwr->msgs = msgs;
+		rdwr->nmsgs = nmsgs;
+#ifdef I2C_RDWR_V2
+		if (detailed_report) {
+			rdwr_v2.report.fault_msg_idx = -1;
+			rdwr_v2.report.msgs_cplt = -1;
+			rdwr_v2.report.bytes_cplt = 0;
+			nmsgs_sent = ioctl(file, I2C_RDWR_V2, &rdwr_v2);
+			if (nmsgs_sent < 0 && rdwr_v2.report.fault_msg_idx >= 0)
+				fprintf(stderr, "Error: %s at message %i\n", strerror(errno),
+					rdwr_v2.report.fault_msg_idx);
+			if (nmsgs_sent < 0 && rdwr_v2.report.msgs_cplt >= 0) {
+				fprintf(stderr, "%i out of %i messages sent\n",
+					rdwr_v2.report.msgs_cplt, nmsgs);
+				nmsgs_sent = rdwr_v2.report.msgs_cplt;
+				if (rdwr_v2.report.bytes_cplt > 0) {
+					fprintf(stderr, "Message %i: %i out of %i bytes sent\n",
+						nmsgs_sent, rdwr_v2.report.bytes_cplt,
+						rdwr->msgs[nmsgs_sent].len);
+					rdwr->msgs[nmsgs_sent].len = rdwr_v2.report.bytes_cplt;
+					nmsgs_sent++;
+				}
+			}
+		} else {
+			nmsgs_sent = ioctl(file, I2C_RDWR, rdwr);
+		}
+#else
+		nmsgs_sent = ioctl(file, I2C_RDWR, rdwr);
+#endif
 		if (nmsgs_sent < 0) {
 			fprintf(stderr, "Error: Sending messages failed: %s\n", strerror(errno));
 			goto err_out;
-		} else if (nmsgs_sent < nmsgs) {
+		} else if (nmsgs_sent < nmsgs && !detailed_report) {
 			fprintf(stderr, "Warning: only %d/%d messages were sent\n", nmsgs_sent, nmsgs);
 		}
 

---
base-commit: 5852f5375eea6ca9dabf31f4772cb8b8ecc905d8
change-id: 20260623-i2c_detailed_report-338d61f2048f

Best regards,
-- 
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

