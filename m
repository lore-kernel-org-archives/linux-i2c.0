From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/1] ACPI enumeration support for i2c mux clients
Date: Thu,  9 Apr 2015 12:15:41 -0700
Message-ID: <cover.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Added ACPI enumeration support for i2c mux clients.

Please let me know your review comments.

Kuppuswamy Sathyanarayanan (1):
  i2c: Add acpi support to enumerate i2c mux clients

 drivers/i2c/i2c-core.c |  3 ++-
 drivers/i2c/i2c-mux.c  | 26 ++++++++++++++++++++++++++
 include/linux/i2c.h    |  5 +++++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
1.9.1
