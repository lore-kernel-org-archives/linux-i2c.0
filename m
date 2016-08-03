From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-tools: add .gitignore
Date: Wed, 3 Aug 2016 12:02:19 +0200
Message-ID: <20160803120219.2cbec11d@endymion>
References: <1470214547-3113-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50061 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757558AbcHCKNo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 3 Aug 2016 06:13:44 -0400
In-Reply-To: <1470214547-3113-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed,  3 Aug 2016 10:55:47 +0200, Wolfram Sang wrote:
> Don't display generated files, so 'git status' becomes useful again.

Good idea. One suggestion below.

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  .gitignore       | 8 ++++++++
>  tools/.gitignore | 4 ++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 .gitignore
>  create mode 100644 tools/.gitignore
> 
> diff --git a/.gitignore b/.gitignore
> new file mode 100644
> index 0000000..0d86cb6
> --- /dev/null
> +++ b/.gitignore
> @@ -0,0 +1,8 @@
> +.*
> +*.o
> +*.o.*
> +*.a
> +*.so
> +*.so.*
> +*.so.dbg
> +*.ao
> diff --git a/tools/.gitignore b/tools/.gitignore
> new file mode 100644
> index 0000000..18c268a
> --- /dev/null
> +++ b/tools/.gitignore
> @@ -0,0 +1,4 @@
> +i2cdump
> +i2cset
> +i2cget
> +i2cdetect

You could also add eeprog to eeprog/.gitignore and eeprom and eepromer
to eepromer/.gitignore.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Also a similar patch would be welcome for the 3.1 branch.

You should have write access to the repository, so I let you commit the
patches yourself?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
