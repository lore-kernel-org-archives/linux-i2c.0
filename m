From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] dt: Update I2C trivial devices list
Date: Tue, 17 Dec 2013 09:14:40 -0700
Message-ID: <52B07870.6070809@wwwdotorg.org>
References: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387239151-19226-1-git-send-email-bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12/16/2013 05:12 PM, Ben Gamari wrote:

> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt

>  This is a list of trivial i2c devices that have simple device tree
>  bindings, consisting only of a compatible field, an address and
> -possibly an interrupt line.
> +possibly an interrupt line. The compatible field is used to lookup the
> +modalias of the driver which will handle the device. The compatible
> +string may begin with a manufacturer prefix (separated from the
> +modalias by a comma) which will be stripped off during lookup.

This part of the patch described Linux-specific behaviour, whereas DT
bindings should be OS-agnostic.

BTW, you didn't CC the DT binding maintainers.
