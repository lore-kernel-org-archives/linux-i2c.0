From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c/gpio-i2c add: add DT support
Date: Mon, 6 Feb 2012 16:09:07 +0000
Message-ID: <20120206160907.GG10173@sirena.org.uk>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328438337-21185-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 05, 2012 at 11:38:53AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> +	- udelay: half clock cycle time in us (may depend on each platform)

> +	udelay = <2>;		/* ~100 kHz */

Why not specify this in kHz and do the conversion in the driver?  It
seems a more intuitive thing to be specifying.  I appreciate that the
platform data used udelay but it seems an entirely unintuitive thing
from a user point of view even if it's what the implementation wants.
