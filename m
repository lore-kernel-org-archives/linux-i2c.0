From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 5/6] Documentation: i2c: Add APM X-Gene platform SLIMpro I2C driver documentation
Date: Tue, 11 Nov 2014 22:40:01 +0100
Message-ID: <3205278.6fp3VTYkMI@wuerfel>
References: <1412726809-7525-1-git-send-email-fkan@apm.com> <1412726809-7525-6-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412726809-7525-6-git-send-email-fkan-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org, jassisingbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, =devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 07 October 2014 17:06:48 Feng Kan wrote:
> Add APM X-Gene platform SLIMpro I2C driver documentation.
> 

Don't just repeat the subject line, explain what this is for.

> Signed-off-by: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
> Signed-off-by: Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-xgene-slimpro.txt    | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt b/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
> new file mode 100644
> index 0000000..1a79d53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
> @@ -0,0 +1,20 @@
> +APM X-Gene SLIMpro Mailbox I2C Driver
> +
> +This is a I2C driver that access the I2C bus through the mailbox mechanism.
> +There is documentation of the mailbox driver in the
> +Documentation/devicetree/binding/mailbox/xgene-slimpro-mbox.txt
> +
> +Required properties :
> +
> + - compatible : should be "apm,xgene-slimpro-i2c"
> + - mbox : ptr to the mailbox dts node, use the name of the mailbox as the
> +	  first parameter. The second parameter is the channel number.
> +	  The APM X-Gene SLIMpro mailbox has 8 channels.
> + - mbox-names : the name of the mailbox channel.

The current form of the mailbox interface no longer uses mbox-names, so
just drop that. In the old form, the binding would have been incomplete
because you don't list the required name.

	Arnd
