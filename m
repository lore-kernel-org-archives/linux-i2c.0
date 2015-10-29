From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: i2c: mark also subdirectories as maintained
Date: Thu, 29 Oct 2015 07:11:43 -0700
Message-ID: <1446127903.2757.163.camel@perches.com>
References: <1446103548-2217-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446103548-2217-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2015-10-29 at 08:25 +0100, Wolfram Sang wrote:
> Otherwise get_maintainer.pl will fall back to git history and CC
> more people than needed.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f23aab10398bb..c3f01dc36b26b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5090,6 +5090,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/i2c/
>  F:	Documentation/i2c/
>  F:	drivers/i2c/
> +F:	drivers/i2c/*/
>  F:	include/linux/i2c.h
>  F:	include/linux/i2c-*.h
>  F:	include/uapi/linux/i2c.h

Maybe something like this too:

diff --git a/MAINTAINERS b/MAINTAINERS
index a2d50fe..ff0ca88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -93,6 +93,14 @@ Descriptions of section entries:
 	   F:	drivers/net/*	all files in drivers/net, but not below
 	   F:	*/net/*		all files in "any top level directory"/net
 	   One pattern per line.  Multiple F: lines acceptable.
+	   The scripts/get_maintainer.pl tool has a quirk about subdirectories.
+	   If the file pattern is for a directory, then any subdirectories of
+	   the parent directory should also be specified.  For instance:
+		F:	drivers/i2c/
+		F:	drivers/i2c/*/
+	   Otherwise, the scripts/get_maintainer.pl tool by default will use
+	   git history to add additional people that have "Signed-off-by:"
+	   style signatures on commits to files in those subdirectories.
 	N: Files and directories with regex patterns.
 	   N:	[^a-z]tegra	all files whose path contains the word tegra
 	   One pattern per line.  Multiple N: lines acceptable.
