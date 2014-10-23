From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c:at91: add bound checking on SMBus block length
 bytes
Date: Thu, 23 Oct 2014 15:49:28 +0200
Message-ID: <20141023134927.GQ7443@ldesroches-Latitude-E6320>
References: <1408585181-10131-1-git-send-email-mark.roszko@gmail.com>
 <20141021071434.GI7443@ldesroches-Latitude-E6320>
 <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org> mailing list" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, Oct 23, 2014 at 09:28:55AM -0400, Mark Roszko wrote:
> Hi Ludovic,
> 
> Wolfram took in the patch quietly awhile back. It's in the 3.17 kernel
> and backported to some of the older trees.
> https://github.com/torvalds/linux/commit/75b81f339c6af43f6f4a1b3eabe0603321dade65

Great, sorry for the noise so. It seems I have checked it from a wrong
branch.

Ludovic

> 
> Regards,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
