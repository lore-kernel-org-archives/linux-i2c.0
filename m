From: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c:at91: add bound checking on SMBus block length bytes
Date: Thu, 23 Oct 2014 09:28:55 -0400
Message-ID: <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
References: <1408585181-10131-1-git-send-email-mark.roszko@gmail.com> <20141021071434.GI7443@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141021071434.GI7443@ldesroches-Latitude-E6320>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org> mailing list" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ludovic,

Wolfram took in the patch quietly awhile back. It's in the 3.17 kernel
and backported to some of the older trees.
https://github.com/torvalds/linux/commit/75b81f339c6af43f6f4a1b3eabe0603321dade65

Regards,
Mark
