From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] cocci: Provide script to find i2c_tables missing exports
Date: Wed, 11 May 2016 16:07:19 -0400
Message-ID: <65c31271-9ab9-161b-cfe7-4186274da951@osg.samsung.com>
References: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
 <1462892843-32409-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:48080 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcEKUHf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 16:07:35 -0400
In-Reply-To: <1462892843-32409-1-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, lee.jones@linaro.org
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Hello Kieran,

Thanks for the patch, it would be great to automate this to avoid new
drivers to introduce new issues!

On 05/10/2016 11:07 AM, Kieran Bingham wrote:
> Adds MODULE_DEVICE_TABLE(i2c, ...) to correctly export tables in i2c drivers
> ---
> Ahem, My appologies, I wrongly sent the patch I was working on for OF tables,
>

No worries and in fact we need to identify both (I2C && OF tables not exported).

There are currently 3 issues that have to be fixed on I2C drivers w.r.t to device
and driver match and module auto-loading:

1) Drivers with I2C table but not exported (match will work but autoload no).

2) Drivers with OF table but not exported (match will work but autoload no).

3) Drivers with an I2C table but with no OF table even when the I2C devices
   are registered via OF. Match and autoload works because the core always
   reports a MODALIAS=i2c:* for both but once we change it to reports the
   corret modalias, things will break since now will be MODALIAS=of:N*fT*C
   and the module won't have a modalias of that form.

1) and 2) are somehow easy and your semantic patches can be used to find
and fix them.

Now 3) is more tricky since is hard to say if a DT is relying on the fact
that the I2C core strips the manufacture from the compatible string and
just matches using the model part.

I think the best we can do is to check if there are such a users in the
in-tree DTS or documented compatible in the DT bindings documents. But if
someone is using with a DT that's not in mainline, then things will break. 

So if you can think of a way to automatize 3) using coccinelle, that will
be great. My coccinelle knowledge is near to non-existent but one issue I
see is that coccinelle context seems to be restricted to just the current
file so it can't check in external files like DTS or DT bindings docs.

> Of course this is the correct patch for adding the i2c_device_id exports,
> which I think is what you are currently looking at
> --
> Kieran
> 

[snip]

> +
> +// A1: Export it!
> +
> +@ add_mod_dev_table depends on !i2c_dev_table @
> +identifier dev_id.arr;
> +@@
> +struct i2c_device_id arr[] = { ... };
> ++ MODULE_DEVICE_TABLE(i2c, arr);
> 

A problem with this semantic patch is that is going to give a lot of
false positives. Not always a MODULE_DEVICE_TABLE(i2c,...) is needed
after a i2c_device_id array, drivers that can't be build as a module
(i.e: whose Kconfig is not tristate) or board files are two examples.

One way I think we can minimize this is by checking if the driver is
including the module.h header file or not. This still will give some
false positives, since many drivers that can't be build as module
wrongly include module.h but in any case that's something that needs
to be fixed in those drivers.

So I think you need something like the following change to squash with
your patch:

diff --git a/scripts/coccinelle/i2c/i2c_table_missing_export.cocci b/scripts/coccinelle/i2c/i2c_table_missing_export.cocci
index 58c06856e4d4..df98279e326d 100644
--- a/scripts/coccinelle/i2c/i2c_table_missing_export.cocci
+++ b/scripts/coccinelle/i2c/i2c_table_missing_export.cocci
@@ -4,9 +4,16 @@
 // Usage:
 // spatch --sp-file scripts/coccinelle/i2c/i2c_table_missing_export.cocci . --in-place
 
+// C0 : Check if module.h is included
+
+@ includes_module @
+@@
+
+# include <linux/module.h>
+
 // C1 : Identify the i2c_device_id array
 
-@ dev_id @
+@ dev_id depends on includes_module @
 identifier arr;
 @@
 struct i2c_device_id arr[] = { ... };

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
