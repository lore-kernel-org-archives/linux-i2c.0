From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] scripts/checkpatch.pl: Add strict test of logical test
 continuations at beginning of line
Date: Sun, 11 Jul 2010 11:57:12 -0700
Message-ID: <1278874632.1501.68.camel@Joe-Laptop.home>
References: <1278859984-22593-1-git-send-email-guenter.roeck@ericsson.com>
	 <1278862266.1501.59.camel@Joe-Laptop.home>
	 <20100711161658.GA23927@ericsson.com>
	 <20100711182138.132815e4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100711182138.132815e4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 2010-07-11 at 18:21 +0200, Jean Delvare wrote:
> On Sun, 11 Jul 2010 09:16:58 -0700, Guenter Roeck wrote:
> > On Sun, Jul 11, 2010 at 11:31:06AM -0400, Joe Perches wrote:
> > > Kernel style seems to prefer having logical tests at
> > > end of line rather than start of line.
> > Ok. Would be nice to have checkpatch.pl complain about it, though,
> > if it is a to-be-enforced rule.
> Please, not again. This has been discussed before, with the conclusion
> that nobody really cares and we don't want to add pointless warnings to
> checkpatch.pl, which in the end will just dissuade people from running
> the script and/or contributing to the kernel at all.

I don't remember that discussion.  Link?

Here's a patch that makes it a "--strict" option
for those who really want to get all the style
checking options.

It also corrects a spelling typo.

Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd88f11..f0a4c25 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2180,6 +2180,11 @@ sub process {
 			ERROR("space required before the open parenthesis '('\n" . $herecurr);
 		}
 
+# Strict only - logical tests should be at EOL, not beginning of new lines
+		if ($line=~/^.\s*(\&\&|\|\|)/) {
+			CHK("logical test continuations should be on the previous line\n" . $hereprev);
+		}
+
 # Check for illegal assignment in if conditional -- and check for trailing
 # statements after the conditional.
 		if ($line =~ /do\s*(?!{)/) {
@@ -2299,7 +2304,7 @@ sub process {
 
 #no spaces allowed after \ in define
 		if ($line=~/\#\s*define.*\\\s$/) {
-			WARN("Whitepspace after \\ makes next lines useless\n" . $herecurr);
+			WARN("Whitespace after \\ makes next lines useless\n" . $herecurr);
 		}
 
 #warn if <asm/foo.h> is #included and <linux/foo.h> is available (uses RAW line)
