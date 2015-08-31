From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: reg: simplify register size checking
Date: Mon, 31 Aug 2015 17:07:34 -0500
Message-ID: <55E4D026.9000202@freescale.com>
References: <1440106846-4484-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440106846-4484-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 08/20/2015 04:40 PM, Wolfram Sang wrote:
> Checking was done at three different locations, just do it once and
> properly at probing time.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> 
> York Sun: Can you test this patch? I can only build test.

Patch is OK. Verified on hardware with good and intentional bad values.

Acked-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
