From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH 01/12] i2c-core: Storage class should be before const qualifier
Date: Wed, 23 Dec 2009 13:56:11 +0100
Message-ID: <1261572971-8537-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0ac2f90..d610e99 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -248,7 +248,7 @@ static const struct attribute_group *i2c_dev_attr_groups[] = {
 	NULL
 };
 
-const static struct dev_pm_ops i2c_device_pm_ops = {
+static const struct dev_pm_ops i2c_device_pm_ops = {
 	.suspend = i2c_device_pm_suspend,
 	.resume = i2c_device_pm_resume,
 };
-- 
1.6.3.3
