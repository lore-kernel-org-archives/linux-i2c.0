From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v6 1/3] i2c: mux: Add i2c-arb-gpio-challenge 'mux' driver
Date: Tue, 16 Apr 2013 09:45:12 -0700
Message-ID: <20130416164512.GB27488@roeck-us.net>
References: <1365543270-10736-1-git-send-email-dianders@chromium.org>
 <1366129742-16048-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1366129742-16048-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 16, 2013 at 09:29:00AM -0700, Doug Anderson wrote:
> The i2c-arb-gpio-challenge driver implements an I2C arbitration scheme
> where masters need to claim the bus with a GPIO before they can start
> a transcation.  This should generally only be used when standard I2C

I am having fun with spelling today :)

s/transcation/transaction/
