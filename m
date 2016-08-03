From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c-tools: add .gitignore
Date: Wed, 3 Aug 2016 17:22:16 +0200
Message-ID: <20160803152216.GB17874@pengutronix.de>
References: <1470214547-3113-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59022 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653AbcHCPoK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 3 Aug 2016 11:44:10 -0400
Content-Disposition: inline
In-Reply-To: <1470214547-3113-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

On Wed, Aug 03, 2016 at 10:55:47AM +0200, Wolfram Sang wrote:
> Don't display generated files, so 'git status' becomes useful again.
> 
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

better anchor these patterns and write

	/i2cdump
	...

. Currently it doesn't matter much, but usually that's what you really
want.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
