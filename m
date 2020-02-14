From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 495/542] docs: i2c: writing-clients: properly name the stop condition
Date: Fri, 14 Feb 2020 10:48:07 -0500
Message-ID: <20200214154854.6746-495-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387741AbgBNP71 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:27 -0500
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

[ Upstream commit 4fcb445ec688a62da9c864ab05a4bd39b0307cdc ]

In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
condition".

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reported-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/i2c/writing-clients.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
index ced309b5e0cc8..3869efdf84cae 100644
--- a/Documentation/i2c/writing-clients.rst
+++ b/Documentation/i2c/writing-clients.rst
@@ -357,9 +357,9 @@ read/written.
 
 This sends a series of messages. Each message can be a read or write,
 and they can be mixed in any way. The transactions are combined: no
-stop bit is sent between transaction. The i2c_msg structure contains
-for each message the client address, the number of bytes of the message
-and the message data itself.
+stop condition is issued between transaction. The i2c_msg structure
+contains for each message the client address, the number of bytes of the
+message and the message data itself.
 
 You can read the file ``i2c-protocol`` for more information about the
 actual I2C protocol.
-- 
2.20.1
