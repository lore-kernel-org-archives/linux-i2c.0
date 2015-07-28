From: Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Subject: Re: [PATCH 2/5] i2c: i801: Create iTCO device on newer Intel PCHs
Date: Tue, 28 Jul 2015 10:34:49 +0100
Message-ID: <20150728093449.GE2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-3-git-send-email-matt@codeblueprint.co.uk>
 <55B63B48.2040603@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B63B48.2040603-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Fleming <matt.fleming-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 27 Jul, at 07:08:08AM, Guenter Roeck wrote:
> >@@ -113,6 +114,16 @@
> >  #define SMBPCICTL	0x004
> >  #define SMBPCISTS	0x006
> >  #define SMBHSTCFG	0x040
> >+#define TCOBASE		0x050
> >+#define TCOCTL		0x054
> >+
> >+#define ACPIBASE		0x040
> >+#define ACPIBASE_SMI_OFF	0x030
> >+#define ACPICTRL		0x044
> >+#define ACPICTRL_EN		BIT(7)
> 
> If you use BIT, you should include bitops.h.
> Not sure if that makes too much sense here, though, without converting
> the rest of the driver to use BIT as well.
 
OK, I'll just switch to the existing notation used throughout the
driver rather than using bitops.

> >+static void i801_del_tco(struct i801_priv *priv)
> >+{
> >+	if (priv->tco_pdev) {
> 
> platform_device_unregister() handles NULL pointers, so this if statement
> is strictly speaking unnecessary.
 
Good point, I'll remove this check since it makes the code simpler too.

> >+		platform_device_unregister(priv->tco_pdev);
> >+		priv->tco_pdev = NULL;
> 
> Unnecessary; priv is going to be freed right afterwards.
 
I'll drop this.

-- 
Matt Fleming, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
