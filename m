From: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c:at91: Add device tree property to set clock-frequency
Date: Fri, 7 Mar 2014 00:30:37 -0500
Message-ID: <CAJjB1qJwa-x6yTAyEK8ByU4MNHnRgRpM4oYOFZFDm5Mi1wPHtw@mail.gmail.com>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
 <20140228110506.GF11192@ldesroches-Latitude-E6320> <CAJjB1qLXnO-Zkte3vg_X5ktXmj1=tG+p5BcLX9vbCgzyfg_rWA@mail.gmail.com>
 <4A1E236E-E048-4E37-AFE8-C0AC283B73D0@jcrosoft.com> <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
 <05EF9B59-7009-49D2-B57F-5612C39F1FF0@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <05EF9B59-7009-49D2-B57F-5612C39F1FF0-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org> mailing list" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ah, you are talking about the individual slave devices within an
device tree i2c bus like the i2c eeproms? Yea, it would be nicer if
one could define it as such to deal with having slave devices that
can't handle certain speeds such as I have. This patch does work
though nicely for my needs with an SAMA5 with three i2c buses running
at 50kHz, 100kHz and 400kHz separately.
