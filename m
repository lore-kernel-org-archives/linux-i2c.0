From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2] i2c-tools: enable static use of libi2c
Date: Wed, 17 Jun 2015 22:28:27 +0200
Message-ID: <20150617222827.0babca36@endymion.delvare>
References: <1434569205-30635-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434569205-30635-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 17 Jun 2015 21:26:45 +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> 
> When debugging embedded systems, it is often nice to simply TFTP the
> desired i2ctool to the target without the hazzle of dealing with shared
> libs. Using -static is overkill, too, so let's add a switch which will
> only link functions from libi2c statically.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> ---
>  Makefile        | 4 ++++
>  tools/Module.mk | 4 ++++
>  2 files changed, 8 insertions(+)
> (...)

Applied, thanks!

-- 
Jean Delvare
SUSE L3 Support
