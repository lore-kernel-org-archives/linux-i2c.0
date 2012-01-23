From: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
Date: Mon, 23 Jan 2012 21:35:12 +0100
Message-ID: <4F1DC480.4010603@gmail.com>
References: <1327308967-8092-1-git-send-email-hs@denx.de> <1327308967-8092-6-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1327308967-8092-6-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On 01/23/2012 09:56 AM, Heiko Schocher wrote:
> add of support for the davinci i2c driver.
> 
> Signed-off-by: Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>
> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Wolfgang Denk<wd-ynQEQJNshbs@public.gmane.org>
> ---
>   .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>   drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>   2 files changed, 82 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
> new file mode 100644
> index 0000000..94ec670
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
> @@ -0,0 +1,39 @@
> +* Texas Instruments Davinci I2C
> +
> +This file provides information, what the device node for the
> +davinci i2c interface contain.
> +
> +Required properties:
> +- compatible: "ti,davinci-i2c";
> +- reg : Offset and length of the register set for the device
> +- id: id of the controller

I was wondering whether we're supposed to use "cell-index" property name
for such a device instance index? or doesn't it really matter and "id" is 
fine? Such an IP instance index seems quite common so I thought it could
be easier to follow to use standard name.

--
Regards,
Sylwester
