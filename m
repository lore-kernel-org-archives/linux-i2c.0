From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c/scx200_*: replace printks with pr_<level>s
Date: Fri, 14 Sep 2012 22:34:17 -0700
Message-ID: <1347687257.2072.4.camel@joe2Laptop>
References: <1347679318-6834-1-git-send-email-jim.cromie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347679318-6834-1-git-send-email-jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2012-09-14 at 21:21 -0600, Jim Cromie wrote:
> Replace printks with pr_<level>s, add pr_fmt()s to replace NAMEs

Hi Jim.

When you do these, please maximally fill to 80 columns the printk
arguments and coalesce formats without regard to 80 columns.

> diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
> @@ -406,7 +408,7 @@ static __devinit int scx200_acb_probe(struct scx200_acb_iface *iface)
>  
>  	val = inb(ACBCTL1);
>  	if (val) {
> -		pr_debug(NAME ": disabled, but ACBCTL1=0x%02x\n",
> +		pr_debug("disabled, but ACBCTL1=0x%02x\n",
>  			val);

		pr_debug("disabled, but ACBCTL1=0x%02x\n", val);

> @@ -417,7 +419,7 @@ static __devinit int scx200_acb_probe(struct scx200_acb_iface *iface)
>  
>  	val = inb(ACBCTL1);
>  	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
> -		pr_debug(NAME ": enabled, but NMINTE won't be set, "
> +		pr_debug("enabled, but NMINTE won't be set, "
>  			 "ACBCTL1=0x%02x\n", val);

		pr_debug("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n",
			  val);
etc...
