From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
Date: Wed, 19 Sep 2012 17:54:33 +0200
Message-ID: <20120919175433.3841a954@endymion.delvare>
References: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
	<50588A8F.30203@wwwdotorg.org>
	<50591C9C.2080809@atmel.com>
	<5059E484.6090708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5059E484.6090708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 19 Sep 2012 09:28:04 -0600, Stephen Warren wrote:
> On 09/18/2012 07:15 PM, Bo Shen wrote:
> > I add the debug info, and it give the following error without this patch.
> > 
> > --<8----------------------------------
> > adap->name = i2c-gpio-1
> > i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> > adap->name = i2c-gpio-1
> > i2c-gpio: probe of i2c.3 failed with error -16
> > -->8----------------------------------
> > 
> > With this patch, it successfully registered.
> > --<8----------------------------------
> > adap->name = i2c-gpio0
> > i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> > adap->name = i2c-gpio1
> > i2c-gpio i2c.3: using pins 90 (SDA) and 91 (SCL)
> > -->8----------------------------------
> 
> Yes, that explains why the registration fails, but not why this patch is
> the correct solution to the problem.
> 
> The problematic code appears to be:
> 
> snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
> 
> Instead, I think that should be something more like:
> 
> adap->name = dev_name(&pdev->dev);

strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name))

if anything, as adap->name is a buffer, not a pointer.

> or perhaps:
> 
> if (pdev->dev.of_node)
>   /* named will be based on DT node name */
>   adap->name = dev_name(&pdev->dev);
> else
>   snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
> 
> ?

-- 
Jean Delvare
