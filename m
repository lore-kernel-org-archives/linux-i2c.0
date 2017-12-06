From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH 2/2] i2c-tools: README: adding documentation for BUILD_DYNAMIC_LIB
Date: Wed,  6 Dec 2017 11:45:57 +0100
Message-ID: <1512557157-17467-2-git-send-email-angelo@amarulasolutions.com>
References: <1512557157-17467-1-git-send-email-angelo@amarulasolutions.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34589 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754986AbdLFKqO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 05:46:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id y82so22546355wmg.1
        for <linux-i2c@vger.kernel.org>; Wed, 06 Dec 2017 02:46:14 -0800 (PST)
In-Reply-To: <1512557157-17467-1-git-send-email-angelo@amarulasolutions.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de, Angelo Compagnucci <angelo@amarulasolutions.com>

This patch adds the documentation for the newly introduced
BUILD_DYNAMIC_LIB flag and clarify the use of the other
variables USE_STATIC_LIB and BUILD_STATIC_LIB.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 README | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/README b/README
index 4ccdf5b..d127f25 100644
--- a/README
+++ b/README
@@ -66,6 +66,15 @@ setting prefix to wherever you want. You may change the C compiler and the
 compilation flags as well, and also decide whether to build the static
 library or not.
 
+In cases where you need to compile only the static or dynamic variant of
+the library, you can use BUILD_STATIC_LIB and BUILD_DYNAMIC_LIB at compile time:
+  $ make BUILD_DYNAMIC_LIB=1 BUILD_STATIC_LIB=0
+If you disable both, the compilation will abort with an error message.
+
+If you want to compile against the static version of the library
+you can do:
+  $ make USE_STATIC_LIB=1
+
 Optionally, you can run "make strip" prior to "make install" if you want
 smaller binaries. However, be aware that this will prevent any further
 attempt to debug the library and tools.
-- 
2.7.4
