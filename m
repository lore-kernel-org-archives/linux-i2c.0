From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
Date: Mon, 15 Oct 2012 08:49:20 +0200
Message-ID: <20121015084920.75d4aa53@endymion.delvare>
References: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
	<50588A8F.30203@wwwdotorg.org>
	<50591C9C.2080809@atmel.com>
	<5059E484.6090708@wwwdotorg.org>
	<20120919175433.3841a954@endymion.delvare>
	<5074E349.30605@atmel.com>
	<507B7C07.3070702@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <507B7C07.3070702-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 15 Oct 2012 10:59:19 +0800, Bo Shen wrote:
> On 10/10/2012 10:54, Bo Shen wrote:
> > On 9/19/2012 23:54, Jean Delvare wrote:
> >> On Wed, 19 Sep 2012 09:28:04 -0600, Stephen Warren wrote:
> >>> The problematic code appears to be:
> >>>
> >>> snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
> >>>
> >>> Instead, I think that should be something more like:
> >>>
> >>> adap->name = dev_name(&pdev->dev);
> >>
> >> strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name))
>  >> if anything, as adap->name is a buffer, not a pointer.
> >
> > I am sorry for late. I have tested with DT, it works.
> >
> > Please send this patch to fix the issue.
> > Thanks.
> 
> Ping?
> 
> Will you send this patch?

Which patch, please? On September 18th, you sent a first version.
Stephen Warren asked you for a change, but you never sent version two
of the patch including the requested change. So don't be surprised if
your patch never got applied.

> Or, I send this patch and add your S.O.B, which do you prefer?

I prefer that you send patch v2 and let the interested parties review
and apply it. Do not add S-o-B for anyone else, ever.

Note that i2c-gpio is normally handled by Wolfram Sang, not me.

-- 
Jean Delvare
