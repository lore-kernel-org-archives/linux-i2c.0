From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c writing-clients document: mention
 module_i2c_driver()
Date: Mon, 18 Jun 2012 17:02:36 +0200
Message-ID: <20120618170236.21b04fd5@endymion.delvare>
References: <1326891629-8495-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326891629-8495-1-git-send-email-pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Sorry for the late reply.

On Wed, 18 Jan 2012 14:00:29 +0100, Peter Meerwald wrote:
> From: Peter Meerwald <p.meerwald-12LT5diAjoA8TDmHOjzjNtBPR1lH4CV8@public.gmane.org>

Where's your Signed-off-by?

> 
> ---
>  Documentation/i2c/writing-clients |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
> index 5aa5337..71248b2 100644
> --- a/Documentation/i2c/writing-clients
> +++ b/Documentation/i2c/writing-clients
> @@ -266,6 +266,14 @@ be removed after kernel booting (or module loading) is completed.
>  Likewise, functions marked by `__exit' are dropped by the compiler when
>  the code is built into the kernel, as they would never be called.
>  
> +The module_i2c_driver() macro can be used to reduce above code.
> +
> +MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>"
> +MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
> +MODULE_LICENSE("GPL");
> +
> +module_i2c_driver(foo_driver);
> +
>  
>  Power Management
>  ================

I agree this should be documented, but I would like to see it done
without repeating the MODULE_* macros. This can be done by moving these
to a separate section. What do you think?

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/writing-clients |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- linux-3.5-rc3.orig/Documentation/i2c/writing-clients	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.5-rc3/Documentation/i2c/writing-clients	2012-06-18 16:57:52.546924533 +0200
@@ -245,21 +245,17 @@ static int __init foo_init(void)
 {
 	return i2c_add_driver(&foo_driver);
 }
+module_init(foo_init);
 
 static void __exit foo_cleanup(void)
 {
 	i2c_del_driver(&foo_driver);
 }
+module_exit(foo_cleanup);
 
-/* Substitute your own name and email address */
-MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>"
-MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
-
-/* a few non-GPL license types are also allowed */
-MODULE_LICENSE("GPL");
+The module_i2c_driver() macro can be used to reduce above code.
 
-module_init(foo_init);
-module_exit(foo_cleanup);
+module_i2c_driver(foo_driver);
 
 Note that some functions are marked by `__init'.  These functions can
 be removed after kernel booting (or module loading) is completed.
@@ -267,6 +263,17 @@ Likewise, functions marked by `__exit' a
 the code is built into the kernel, as they would never be called.
 
 
+Driver Information
+==================
+
+/* Substitute your own name and email address */
+MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>"
+MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
+
+/* a few non-GPL license types are also allowed */
+MODULE_LICENSE("GPL");
+
+
 Power Management
 ================
 



-- 
Jean Delvare
