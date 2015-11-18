From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH v3 0/1] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Wed, 18 Nov 2015 13:55:55 +0100
Message-ID: <1447851356-6248-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36138 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbbKRM43 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Nov 2015 07:56:29 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello

Changes since v2
- removed err variable
- fix a spelling issue

Changes since v1
- drop the return code of kstrtou8 and return -EPROTO
  as suggested by Jean Delvare
- Added a comment on the return code drop

Regards

LABBE Corentin (1):
  i2c: taos-evm: replace simple_strtoul by kstrtou8

 drivers/i2c/busses/i2c-taos-evm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.4.10
