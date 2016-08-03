From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-tools: fix feature test macros for glibc >= 2.20
Date: Wed, 3 Aug 2016 13:23:11 +0200
Message-ID: <20160803132311.59d53ad7@endymion>
References: <1470213836-2848-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54708 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbcHCLXN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 3 Aug 2016 07:23:13 -0400
In-Reply-To: <1470213836-2848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed,  3 Aug 2016 10:43:56 +0200, Wolfram Sang wrote:
> Since glibc 2.20, the usage of _BSD_SOURCE is deprecated. Fix it like
> described here:
> 
> https://sourceware.org/glibc/wiki/Release/2.20#Deprecation_of__BSD_SOURCE_and__SVID_SOURCE_feature_macros
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  tools/i2cbusses.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
> index b3093aa..28e3682 100644
> --- a/tools/i2cbusses.c
> +++ b/tools/i2cbusses.c
> @@ -23,7 +23,8 @@
>  */
>  
>  /* For strdup and snprintf */
> -#define _BSD_SOURCE 1
> +#define _BSD_SOURCE 1 /* for glibc < 2.19 */
> +#define _DEFAULT_SOURCE 1 /* for glibc >= 2.20 */

Actually >= 2.19 if I read the web page you mentioned (which has the
same "bug") correctly.

Other than that,

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Again the 3.1 branch would need the same fix.

>  
>  #include <sys/types.h>
>  #include <sys/stat.h>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
