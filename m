From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 6/6] MAINTAINERS: maintain parport
Date: Wed, 20 May 2015 20:57:02 +0530
Message-ID: <1432135622-8288-7-git-send-email-sudipm.mukherjee@gmail.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Lets give the parport subsystem a proper name and start
maintaining the files.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86d9398..0eb5ce2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7476,13 +7476,16 @@ S:	Maintained
 F:	Documentation/mn10300/
 F:	arch/mn10300/
 
-PARALLEL PORT SUPPORT
+PARALLEL PORT SUBSYSTEM
+M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+M:	Sudip Mukherjee <sudip@vectorindia.org>
 L:	linux-parport@lists.infradead.org (subscribers-only)
-S:	Orphan
+S:	Maintained
 F:	drivers/parport/
 F:	include/linux/parport*.h
 F:	drivers/char/ppdev.c
 F:	include/uapi/linux/ppdev.h
+F:	Documentation/parport*.txt
 
 PARAVIRT_OPS INTERFACE
 M:	Jeremy Fitzhardinge <jeremy@goop.org>
-- 
1.8.1.2
