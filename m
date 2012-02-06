From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c/gpio-i2c add: add DT support
Date: Mon, 6 Feb 2012 20:15:52 +0100
Message-ID: <20120206201552.153eba5d@endymion.delvare>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
	<4F301E25.5060507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F301E25.5060507-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 06 Feb 2012 19:38:29 +0100, Karol Lewandowski wrote:
> On 05.02.2012 11:38, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> Hi!
> 
> > +Device-Tree bindings for i2c gpio driver
> > +
> > +Required properties:
> > +	- compatible = "gpio-i2c";
> 
> Driver name is "i2c-gpio" in file i2c-gpio.c. Previous version of patch 
> adding DT-support (prepared by Thomas Chou[1]) used i2c-gpio - could we 
> stick to that name?
> 
> [1] https://lkml.org/lkml/2011/2/23/584

Yes, please. The gpio subsystem normalized its driver names to gpio-*,
so we shouldn't use that anywhere else to avoid confusion.

-- 
Jean Delvare
