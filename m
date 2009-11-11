From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 1/4] i2c : Made buf type unsigned to prevent sign extension
Date: Thu, 12 Nov 2009 00:23:00 +0100
Message-ID: <083DF309106F364B939360100EC290F804F53CC641@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F5343706@eu1rdcrdc1wx030.exi.nxp.com>
 <20091111212152.GK13398@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091111212152.GK13398-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Made buf type unsigned to prevent sign extension

Signed-off-by: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
---
i2c-pnx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- include/linux/i2c-pnx.h.orig	2009-11-11 14:47:28.000000000 -0800
+++ include/linux/i2c-pnx.h	2009-11-10 14:16:55.000000000 -0800
@@ -21,7 +21,7 @@ struct i2c_pnx_mif {
 	int			mode;		/* Interface mode */
 	struct completion	complete;	/* I/O completion */
 	struct timer_list	timer;		/* Timeout */
-	char *			buf;		/* Data buffer */
+	u8 *			buf;		/* Data buffer */
 	int			len;		/* Length of data buffer */
 };
