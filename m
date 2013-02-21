From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: ocores: Fix pointer to integer cast warning
Date: Thu, 21 Feb 2013 10:37:09 +0100
Message-ID: <20130221093709.GB22806@the-dreams.de>
References: <1361259199-24709-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1361259199-24709-1-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 19, 2013 at 01:03:19PM +0530, Jayachandran C wrote:
> After commit a000b8c1 [i2c: ocores: Add support for the GRLIB port of the
> controller and use function pointers for getreg and setreg function],
> compiling i2c-ocores.c for 64-bit gives the following warning:
> 
>   drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_of_probe':
>   drivers/i2c/busses/i2c-ocores.c:334:15: warning: cast from pointer to integer of different size
> 
> Fix it by casting the pointer to long.
> 
> Signed-off-by: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Applied, thanks!
