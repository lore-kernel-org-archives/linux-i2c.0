From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: i2c-topology: fix minor whitespace nit
Date: Thu, 10 Nov 2016 15:03:21 +0100
Message-ID: <1478786601-12895-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0137.outbound.protection.outlook.com ([104.47.2.137]:52965
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932845AbcKJOS7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Nov 2016 09:18:59 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/i2c/i2c-topology | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/i2c-topology b/Documentation/i2c/i2c-topology
index e0aefeece551..1a014fede0b7 100644
--- a/Documentation/i2c/i2c-topology
+++ b/Documentation/i2c/i2c-topology
@@ -326,7 +326,7 @@ Two parent-locked sibling muxes
 
 This is a good topology.
 
-                                   .--------.
+                                    .--------.
                    .----------.  .--| dev D1 |
                    |  parent- |--'  '--------'
                 .--|  locked  |     .--------.
@@ -350,7 +350,7 @@ Mux-locked and parent-locked sibling muxes
 
 This is a good topology.
 
-                                   .--------.
+                                    .--------.
                    .----------.  .--| dev D1 |
                    |   mux-   |--'  '--------'
                 .--|  locked  |     .--------.
-- 
2.1.4
