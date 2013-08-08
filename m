From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/1 resend] i2c: rcar: modify I2C driver
Date: Thu, 8 Aug 2013 10:12:00 +0200
Message-ID: <20130808080819.GA6070@the-dreams.de>
References: <1375687174-577-1-git-send-email-nv-dung@jinso.co.jp>
 <1375687174-577-2-git-send-email-nv-dung@jinso.co.jp>
 <20130807151234.GH2978@katana>
 <5202F0AC.4070609@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5202F0AC.4070609-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 08, 2013 at 10:13:16AM +0900, Nguyen Viet Dung wrote:

> Difference between H2 and H1 in hardware is only CDF bit of ICCCR register.

No IP version register? Sigh...

> If this method is not a common method, please tell me about common method.

Use a new platform_device_id and populate the driver_data with the info
needed to distinguish between the revisions. Check i2c-imx.c for an
example.
